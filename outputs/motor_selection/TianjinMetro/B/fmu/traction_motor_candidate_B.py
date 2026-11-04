"""FMI 2.0 parameterized surrogate traction motor based on published nameplate data.

Candidate constants are injected into a generated copy before packaging.  The
model deliberately implements only a constant-torque / constant-power envelope;
it is not a manufacturer efficiency or thermal map.
"""
from math import pi

from pythonfmu import Fmi2Slave
from pythonfmu.enums import Fmi2Causality
from pythonfmu.variables import Real


MOTOR = {'rated_power_kw': 180, 'rated_speed_rpm': 2218, 'rated_voltage_v': 533, 'rated_current_a': 230, 'max_speed_rpm': 4368, 'starting_torque_nm': 1036, 'mass_kg': 486}


class TractionMotorSurrogateB(Fmi2Slave):
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.in_U_motor_ll_rms = 0.0
        self.in_f_motor_e = 0.0
        self.in_omega_shaft = 0.0
        self.out_I_motor_rms = 0.0
        self.out_T_shaft = 0.0
        self.out_motor_phase_voltage = 0.0
        self.out_motor_speed = 0.0
        self.out_motor_torque_actual = 0.0
        self.out_omega_motor = 0.0
        inputs = ("in_U_motor_ll_rms", "in_f_motor_e", "in_omega_shaft")
        outputs = (
            "out_I_motor_rms", "out_T_shaft", "out_motor_phase_voltage",
            "out_motor_speed", "out_motor_torque_actual", "out_omega_motor",
        )
        for name in inputs:
            self.register_variable(Real(name, causality=Fmi2Causality.input))
        for name in outputs:
            self.register_variable(Real(name, causality=Fmi2Causality.output))

    def do_step(self, current_time, step_size):
        omega = float(self.in_omega_shaft)
        rpm = abs(omega) * 60.0 / (2.0 * pi)
        command = max(-1.0, min(1.0, float(self.in_U_motor_ll_rms) / MOTOR["rated_voltage_v"]))
        if rpm >= MOTOR["max_speed_rpm"] or abs(command) < 1e-8:
            torque = 0.0
        else:
            omega_abs = max(abs(omega), 1.0)
            envelope = min(MOTOR["starting_torque_nm"], MOTOR["rated_power_kw"] * 1000.0 / omega_abs)
            torque = command * envelope
        rated_omega = MOTOR["rated_speed_rpm"] * 2.0 * pi / 60.0
        rated_torque = MOTOR["rated_power_kw"] * 1000.0 / rated_omega
        current_factor = min(2.2, abs(torque) / max(rated_torque, 1.0))
        self.out_I_motor_rms = MOTOR["rated_current_a"] * current_factor
        self.out_T_shaft = torque
        self.out_motor_phase_voltage = abs(float(self.in_U_motor_ll_rms))
        self.out_motor_speed = omega
        self.out_motor_torque_actual = torque
        self.out_omega_motor = omega
        return True
