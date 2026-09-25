import sys
import os
from PyQt5.QtWidgets import (
    QApplication, QLabel, QMainWindow, QInputDialog, QVBoxLayout, QWidget,
    QPushButton, QComboBox, QFileDialog, QDialog,
    QLineEdit, QMessageBox, QHBoxLayout, QSpacerItem, QSizePolicy,
    QScrollArea
)
from matplotlib.backends.backend_qt5agg import FigureCanvasQTAgg as FigureCanvas
from matplotlib.figure import Figure
import numpy as np
from pyfmi.fmi import load_fmu
from pyfmi import Master
import pandas as pd
import traceback
import xml.etree.ElementTree as ET

class MplCanvas(FigureCanvas):
    """
    A custom FigureCanvas class for plotting simulation results.
    """
    def __init__(self, parent=None, width=5, height=4, dpi=100):
        fig = Figure(figsize=(width, height), dpi=dpi)
        self.axes = fig.add_subplot(111)
        super().__init__(fig)
        self.setParent(parent)

    def plot(self, time, data, variable_name):
        """Plot simulation data against time."""
        self.axes.clear()
        self.axes.plot(time, data, 'b-', label=variable_name)
        self.axes.set_ylabel(variable_name)
        self.axes.set_xlabel('Time (s)')
        self.axes.legend(loc="best")
        self.axes.grid(True)
        self.figure.tight_layout()
        self.draw()

class ConnectionDialog(QDialog):
    """Dialog for manually connecting FMU components."""
    def __init__(self, parent, connections, fmu_names):
        super().__init__(parent)
        self.setWindowTitle("FMU Connection")
        self.layout = QVBoxLayout()
        self.connections = connections
        self.fmu_names = fmu_names
        self.setup_ui()
        self.setLayout(self.layout)
    
    def setup_ui(self):
        """Set up the UI elements for FMU connections."""
        self.label1 = QLabel("Select Source FMU:")
        self.source_combo = QComboBox()
        self.source_combo.addItems(self.fmu_names)

        self.label2 = QLabel("Enter Source Variable:")
        self.source_variable_lineedit = QLineEdit()

        self.label3 = QLabel("Select Target FMU:")
        self.target_combo = QComboBox()
        self.target_combo.addItems(self.fmu_names)

        self.label4 = QLabel("Enter Target Variable:")
        self.target_variable_lineedit = QLineEdit()

        self.connect_button = QPushButton("Connect")
        self.connect_button.clicked.connect(self.connect_fmus)

        self.ready_button = QPushButton("Connections Ready")
        self.ready_button.clicked.connect(self.accept)

        # Add UI elements to layout
        for widget in [self.label1, self.source_combo, self.label2, 
                      self.source_variable_lineedit, self.label3, self.target_combo,
                      self.label4, self.target_variable_lineedit, self.connect_button,
                      self.ready_button]:
            self.layout.addWidget(widget)

    def connect_fmus(self):
        """Create and store FMU connections."""
        source_name = self.source_combo.currentText()
        source_variable = self.source_variable_lineedit.text()
        target_name = self.target_combo.currentText()
        target_variable = self.target_variable_lineedit.text()

        source_fmu = self.parent().fmus[source_name]
        target_fmu = self.parent().fmus[target_name]

        connection = (source_fmu, source_variable, target_fmu, target_variable)
        self.connections.append(connection)
        QMessageBox.information(self, "FMU Connection", "Connection added successfully.")

        self.source_variable_lineedit.clear()
        self.target_variable_lineedit.clear()

def parse_ssd_connections(ssd_file):
    """Parse an SSD file to extract model connections."""
    tree = ET.parse(ssd_file)
    root = tree.getroot()
    connections = []
    for connection in root.iter('{http://ssp-standard.org/SSP1/SystemStructureDescription}Connection'):
        start_element = connection.get('startElement', '')
        start_connector = connection.get('startConnector', '')
        end_element = connection.get('endElement', '')
        end_connector = connection.get('endConnector', '')
        connections.append((start_element, start_connector, end_element, end_connector))
    return connections

class PyFMIGUI(QMainWindow):
    """Main application window for the PyFMI simulation interface."""
    def __init__(self):
        super().__init__()
        self.setWindowTitle("SSI simulator GUI")
        self.fmus = {}
        self.fmus_loaded = False
        self.connections = []
        self.setup_ui()

    def setup_ui(self):
        """Set up the main UI layout."""
        self.central_widget = QWidget(self)
        self.setCentralWidget(self.central_widget)
        self.layout = QHBoxLayout(self.central_widget)

        # Left side: Buttons and plot
        left_widget = QWidget()
        left_layout = QVBoxLayout(left_widget)
        
        self.create_buttons(left_layout)
        self.add_simulation_time_input(left_layout)
        
        # Create scroll area for plot
        scroll_area = QScrollArea()
        scroll_area.setWidgetResizable(True)
        
        plot_container = QWidget()
        plot_container.setMinimumSize(400, 400)
        plot_layout = QVBoxLayout(plot_container)
        
        self.plot_canvas = MplCanvas(self, width=5, height=4)
        plot_layout.addWidget(self.plot_canvas)
        
        scroll_area.setWidget(plot_container)
        left_layout.addWidget(scroll_area)
        
        self.resize(800, 600)
        self.layout.addWidget(left_widget)
        
        self.add_instructions()

    def create_buttons(self, layout):
        """Create and configure the control buttons."""
        buttons = [
            ("Load FMUs", self.load_fmus),
            ("Load SSD File", self.load_ssd_file),
            ("Manually Connect FMUs", self.show_connection_dialog),
            ("Run PyFMI Simulation", self.run_simulation),
            ("Print Connections", self.print_connections)
        ]

        for text, callback in buttons:
            button = QPushButton(text, self)
            button.setFixedSize(250, 60)
            button.clicked.connect(callback)
            layout.addWidget(button)

    def add_simulation_time_input(self, layout):
        """Add input field for simulation time."""
        self.simulation_time_input = QLineEdit(self)
        self.simulation_time_input.setPlaceholderText("Enter simulation time (s)")
        layout.addWidget(self.simulation_time_input)

    def add_instructions(self):
        """Add instructions panel to the GUI."""
        instructions_layout = QVBoxLayout()
        instructions_layout.addSpacerItem(QSpacerItem(20, 20, QSizePolicy.Minimum, QSizePolicy.Minimum))
        
        instructions = (
            "Instructions:\n\n"
            "1. Load FMUs: Click 'Load FMUs' to load your FMU files.\n"
            "   - You will be prompted to name each FMU\n"
            "2. Either:\n"
            "   - Load SSD File: Load a system structure file\n"
            "   - Manually Connect FMUs: Define connections between FMUs\n"
            "3. Set Simulation time (s)\n"
            "4. Run PyFMI Simulation: Execute simulation and select variable to plot\n"
            "5. Print Connections (optional): View current connections"
        )
        
        self.instructions_label = QLabel(instructions, self)
        self.instructions_label.setWordWrap(True)
        
        font = self.instructions_label.font()
        font.setPointSize(12)
        self.instructions_label.setFont(font)
    
        instructions_layout.addWidget(self.instructions_label)
        instructions_layout.addSpacerItem(QSpacerItem(20, 40, QSizePolicy.Minimum, QSizePolicy.Expanding))
        self.layout.addLayout(instructions_layout)

    def load_fmus(self):
        """Load FMU files with user-defined names."""
        file_dialog = QFileDialog(self)
        file_dialog.setFileMode(QFileDialog.ExistingFiles)
        file_dialog.setNameFilter("FMU Files (*.fmu)")
        
        if file_dialog.exec_():
            fmu_files = file_dialog.selectedFiles()
            try:
                self.fmus.clear()
                
                for fmu_path in fmu_files:
                    name, ok = QInputDialog.getText(self, "FMU Name", 
                        f"Enter name for FMU: {os.path.basename(fmu_path)}")
                    if ok and name:
                        self.fmus[name] = load_fmu(fmu_path)

                self.fmus_loaded = bool(self.fmus)
                if self.fmus_loaded:
                    QMessageBox.information(self, "FMU Loading", 
                        f"Successfully loaded {len(self.fmus)} FMUs.")
                    
                    # Print available variables
                    for name, fmu in self.fmus.items():
                        print(f"\n{name} variables:")
                        for var in fmu.get_model_variables():
                            print(var)
                
            except Exception as e:
                QMessageBox.critical(self, "FMU Loading", f"Failed to load FMUs: {str(e)}")

    def load_ssd_file(self):
        """Load and process an SSD file for FMU connections."""
        if not self.fmus_loaded:
            QMessageBox.warning(self, "SSD Loading", "Please load FMUs first.")
            return

        file_dialog = QFileDialog(self)
        file_dialog.setFileMode(QFileDialog.ExistingFile)
        file_dialog.setNameFilter("SSD Files (*.ssd)")
        
        if file_dialog.exec_():
            ssd_file = file_dialog.selectedFiles()[0]
            try:
                ssd_connections = parse_ssd_connections(ssd_file)
                
                # Map SSD connections to loaded FMUs
                self.connections = []
                for start_element, start_var, end_element, end_var in ssd_connections:
                    # Let user map SSD elements to loaded FMUs
                    start_fmu, ok1 = QInputDialog.getItem(self, "Map FMU", 
                        f"Select FMU for {start_element}:", list(self.fmus.keys()), 0, False)
                    end_fmu, ok2 = QInputDialog.getItem(self, "Map FMU", 
                        f"Select FMU for {end_element}:", list(self.fmus.keys()), 0, False)
                    
                    if ok1 and ok2:
                        self.connections.append((
                            self.fmus[start_fmu],
                            start_var,
                            self.fmus[end_fmu],
                            end_var
                        ))

                QMessageBox.information(self, "SSD Loading", "Connections established successfully.")
            except Exception as e:
                QMessageBox.critical(self, "SSD Loading", f"Failed to load SSD file: {str(e)}")

    def show_connection_dialog(self):
        """Show dialog for manual FMU connections."""
        if not self.fmus_loaded:
            QMessageBox.warning(self, "Connection", "Please load FMUs first.")
            return
        dialog = ConnectionDialog(self, self.connections, list(self.fmus.keys()))
        dialog.exec_()

    def print_connections(self):
        """Display current FMU connections."""
        if not self.connections:
            QMessageBox.information(self, "Connections", "No connections defined yet.")
            return
            
        connections_text = "\nCurrent Connections:\n"
        for source_fmu, source_var, target_fmu, target_var in self.connections:
            connections_text += f"From: {source_var} -> To: {target_var}\n"
        
        print(connections_text)
        QMessageBox.information(self, "Connections", connections_text)

    def run_simulation(self):
        """Execute simulation with user-selected variable plotting."""
        if not self.fmus_loaded or not self.connections:
            QMessageBox.warning(self, "Simulation", 
                "Please load FMUs and create connections first.")
            return

        try:
            final_time = float(self.simulation_time_input.text())
            
            model = Master(list(self.fmus.values()), connections=self.connections)
            opts = model.simulate_options()
            opts['result_handling'] = 'file'
            
            res = model.simulate(final_time=final_time, options=opts)
            
            # Let user select variable to plot
            fmu_name, ok = QInputDialog.getItem(self, "Select FMU", 
                "Choose FMU for plotting:", list(self.fmus.keys()), 0, False)
            if ok and fmu_name:
                fmu = self.fmus[fmu_name]
                var_name, ok = QInputDialog.getItem(self, "Select Variable", 
                    "Choose variable to plot:", list(fmu.get_model_variables()), 0, False)
                if ok and var_name:
                    time = res[fmu]['time']
                    data = res[fmu][var_name]
                    
                    # Save results
                    result_df = pd.DataFrame({
                        'Time': time,
                        var_name: data
                    })
                    result_df.to_csv('simulation_results.csv', index=False)
                    
                    # Update plot
                    self.plot_canvas.plot(time, data, var_name)
            
            QMessageBox.information(self, "Simulation", "Simulation completed successfully.")
            
        except Exception as e:
            tb = traceback.format_exc()
            QMessageBox.critical(self, "Simulation Error", 
                f"Simulation failed: {str(e)}\n\n{tb}")

# Main for the application
if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = PyFMIGUI()
    window.show()
    sys.exit(app.exec_())