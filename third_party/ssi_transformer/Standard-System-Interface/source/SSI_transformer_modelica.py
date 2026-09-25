import xml.etree.ElementTree as ET
from datetime import datetime, timezone
from xml.dom import minidom
from PyQt5.QtWidgets import (
    QApplication, QFileDialog, QMessageBox, QDialog, QVBoxLayout,
    QLabel, QLineEdit, QPushButton, QHBoxLayout, QScrollArea, QWidget, QTabWidget, QGroupBox, QCheckBox
)
import sys
import re

# Function to determine the unit based on the port name.
def determine_unit(port_name):
    return '[-]'

# Function to parse interface definitions from a SysML V2 file
def parse_interface_definitions(lines):
    # Dictionary to store all interface definitions
    interface_definitions = {}
    current_interface = None
    inside_interface = False

    for line in lines:
        line = line.strip()

        # Skip comments
        if line.startswith('//'):
            continue

        # Check for the start of an interface definition
        if line.startswith("interface def"):
            # Extract interface name using regex
            match = re.match(r'interface def\s+(\w+)', line)
            if match:
                current_interface = match.group(1)
                # Initialize the interface with empty lists for ports and flows
                interface_definitions[current_interface] = {'ports': [], 'flows': []}
                inside_interface = True
                print(f"Parsing Interface: {current_interface}")
            continue

        # Check for the end of an interface definition
        if inside_interface and line.startswith("}"):
            print(f"Finished Parsing Interface: {current_interface}")
            current_interface = None
            inside_interface = False
            continue

        # Parse port definitions within an interface
        if inside_interface and line.startswith("end"):
            # Extract port name and type using regex
            # Example line: end supplierPort : ForcePort;
            match = re.match(r'end\s+(\w+)\s*:\s*([\w~]+);', line)
            if match:
                port_name = match.group(1)
                port_type = match.group(2)
                # Add port information to the current interface
                interface_definitions[current_interface]['ports'].append({'port_name': port_name, 'port_type': port_type})
                print(f"Added Port to Interface {current_interface}: {port_name} : {port_type}")
            continue

        # Parse flow definitions within an interface
        if inside_interface and line.startswith("flow of"):
            # Extract flow information using regex
            # Example line: flow of Force_dynamic from supplierPort.fy to consumerPort.fy;
            flow_match = re.match(r'flow of\s+([\w:]+)\s+from\s+([\w\.]+)\s+to\s+([\w\.]+);', line)
            if flow_match:
                flow_type = flow_match.group(1)
                flow_from = flow_match.group(2)
                flow_to = flow_match.group(3)
                # Add flow information to the current interface
                interface_definitions[current_interface]['flows'].append({
                    'flow_type': flow_type,
                    'from': flow_from,
                    'to': flow_to
                })
                print(f"Added Flow to Interface {current_interface}: {flow_type} from {flow_from} to {flow_to}")
            else:
                print(f"Warning: Could not parse flow line: {line}")
            continue

    return interface_definitions

# Function to read System definitions from a SysML V2 file
def parse_system_definitions(lines):
    components = {}
    connections = []
    current_part = None
    current_attributes = {}

    for line in lines:
        line = line.strip()

        if line.startswith('//'):
            continue

        if line.startswith("part"):
            match = re.match(r'part\s+(\w+)\s*:\s*(\w+)\s*\{', line)
            if match:
                if current_part:
                    components[current_part]['attributes'] = current_attributes
                current_part = match.group(1)
                components[current_part] = {'ports': [], 'attributes': {}}
                current_attributes = {}
                print(f"Parsing Part: {current_part}")
            continue

        if current_part and line.startswith("attribute"):
            match = re.match(r'attribute\s+(\w+)\s*=\s*(.+);', line)
            if match:
                attr_name = match.group(1)
                attr_value = match.group(2)
                current_attributes[attr_name] = attr_value
                print(f"Added Attribute to Part {current_part}: {attr_name} = {attr_value}")
            continue

        if current_part and line.startswith("port"):
            match = re.match(r'port\s+(\w+)\s*:\s*([\w~]+);', line)
            if match:
                port_name = match.group(1)
                port_type = match.group(2)
                unit = determine_unit(port_name)  # Käytetään oletusyksikköä
                components[current_part]['ports'].append({
                    'port_name': port_name, 
                    'port_type': port_type,
                    'unit': unit
                })
                print(f"Added Port to Part {current_part}: {port_name} : {port_type} (Unit: {unit})")
            continue

        if "connect" in line and "to" in line:
            connect_match = re.match(r'interface\s+(\w+)(?:\s*:\s*(\w+))?\s+connect\s+(\w+)\.(\w+)\s+to\s+(\w+)\.(\w+);', line)
            if connect_match:
                interface_instance = connect_match.group(1)
                interface_type = connect_match.group(2)
                start_element = connect_match.group(3)
                start_connector = connect_match.group(4)
                end_element = connect_match.group(5)
                end_connector = connect_match.group(6)

                connections.append({
                    'interface_instance': interface_instance,
                    'interface_type': interface_type,
                    'start_element': start_element,
                    'start_connector': start_connector,
                    'end_element': end_element,
                    'end_connector': end_connector
                })
                print(f"Added Connection: {interface_type} connect {start_element}.{start_connector} to {end_element}.{end_connector}")
            else:
                print(f"Warning: Could not parse connection line: {line}")
            continue

    if current_part:
        components[current_part]['attributes'] = current_attributes

    return components, connections

# Function to compare port types, considering conjugate types (~)
def port_types_compatible(expected_type, actual_type):
    # Remove leading '~' from both types
    expected_base = expected_type.lstrip('~')
    actual_base = actual_type.lstrip('~')

    # If base types are different, not compatible
    if expected_base != actual_base:
        return False

    # Types are compatible if they are the same or one is the conjugate of the other
    return True

# Function to validate connections based on interface definitions
def validate_connections(components, connections, interface_definitions):
    errors = []

    for connection in connections:
        interface_type = connection.get('interface_type')
        start_element = connection['start_element']
        start_connector = connection['start_connector']
        end_element = connection['end_element']
        end_connector = connection['end_connector']

        if interface_type is None:
            print(f"Warning: Interface type not specified for connection {connection['interface_instance']}. Skipping validation for this connection.")
            continue

        if interface_type in interface_definitions:
            interface_ports = interface_definitions[interface_type]['ports']

            if len(interface_ports) < 2:
                errors.append({
                    'connection': connection,
                    'message': f"Interface {interface_type} does not have enough port definitions."
                })
                continue

            # Assume the first port is supplier and the second is consumer
            expected_start_port_type = interface_ports[0]['port_type']
            expected_end_port_type = interface_ports[1]['port_type']

            # Get actual port types from components
            start_component = components.get(start_element, {})
            end_component = components.get(end_element, {})

            start_ports = start_component.get('ports', [])
            end_ports = end_component.get('ports', [])

            start_port = next((p for p in start_ports if p['port_name'] == start_connector), None)
            end_port = next((p for p in end_ports if p['port_name'] == end_connector), None)

            if start_port is None:
                errors.append({
                    'connection': connection,
                    'message': f"Start port {start_element}.{start_connector} not found."
                })
                continue

            if end_port is None:
                errors.append({
                    'connection': connection,
                    'message': f"End port {end_element}.{end_connector} not found."
                })
                continue

            start_port_type = start_port['port_type']
            end_port_type = end_port['port_type']

            if not port_types_compatible(expected_start_port_type, start_port_type):
                errors.append({
                    'connection': connection,
                    'message': f"Start port type mismatch: {start_element}.{start_connector} is {start_port_type}, expected {expected_start_port_type} based on interface {interface_type}."
                })

            if not port_types_compatible(expected_end_port_type, end_port_type):
                errors.append({
                    'connection': connection,
                    'message': f"End port type mismatch: {end_element}.{end_connector} is {end_port_type}, expected {expected_end_port_type} based on interface {interface_type}."
                })
        else:
            # Interface type not defined
            errors.append({
                'connection': connection,
                'message': f"Interface type {interface_type} not defined."
            })

    return errors

# Function to pretty-print XML structure
def pretty_print(element):
    rough_string = ET.tostring(element, 'utf-8')
    reparsed = minidom.parseString(rough_string)
    return '\n'.join(reparsed.toprettyxml(indent="    ").splitlines()[1:])

class ComponentInfoDialog(QDialog):
    def __init__(self, components, connections):
        super().__init__()
        self.setWindowTitle("SSI transformer")
        self.components_inputs = {}
        self.connections_inputs = []

        main_layout = QVBoxLayout()

        # Create a scroll area
        scroll_area = QScrollArea()
        scroll_area.setWidgetResizable(True)
        scroll_widget = QWidget()
        scroll_layout = QVBoxLayout(scroll_widget)

        # System-wide information
        system_group = QGroupBox("System Information")
        system_layout = QVBoxLayout()

        system_name_layout = QHBoxLayout()
        self.system_name_edit = QLineEdit("Example System")
        system_name_layout.addWidget(QLabel("System Name:"))
        system_name_layout.addWidget(self.system_name_edit)
        system_layout.addLayout(system_name_layout)

        generation_tool_layout = QHBoxLayout()
        self.generation_tool_edit = QLineEdit("Example Generation Tool")
        generation_tool_layout.addWidget(QLabel("Generation Tool:"))
        generation_tool_layout.addWidget(self.generation_tool_edit)
        system_layout.addLayout(generation_tool_layout)

        time_layout = QHBoxLayout()
        self.start_time_edit = QLineEdit("0.0")
        self.stop_time_edit = QLineEdit("10.0")
        time_layout.addWidget(QLabel("Start Time:"))
        time_layout.addWidget(self.start_time_edit)
        time_layout.addWidget(QLabel("Stop Time:"))
        time_layout.addWidget(self.stop_time_edit)
        system_layout.addLayout(time_layout)

        system_group.setLayout(system_layout)
        scroll_layout.addWidget(system_group)

        # Components
        components_group = QGroupBox("Components")
        components_layout = QVBoxLayout()
        
        

        for comp, details in components.items():
            comp_group = QGroupBox(comp)
            comp_layout = QVBoxLayout()

            name_layout = QHBoxLayout()
            name_edit = QLineEdit(comp)
            name_layout.addWidget(QLabel("New Name:"))
            name_layout.addWidget(name_edit)
            comp_layout.addLayout(name_layout)

            fmu_layout = QHBoxLayout()
            fmu_edit = QLineEdit(f"{comp}.fmu")
            fmu_layout.addWidget(QLabel("FMU Filename:"))
            fmu_layout.addWidget(fmu_edit)
            comp_layout.addLayout(fmu_layout)

            attr_inputs = {}
            for attr_name, attr_value in details['attributes'].items():
                attr_layout = QHBoxLayout()
                attr_label = QLabel(f'{attr_name}:')
                attr_edit = QLineEdit(str(attr_value))
                attr_layout.addWidget(attr_label)
                attr_layout.addWidget(attr_edit)
                comp_layout.addLayout(attr_layout)
                attr_inputs[attr_name] = attr_edit

            port_inputs = []
            for port in details['ports']:
                port_layout = QHBoxLayout()
                port_name_edit = QLineEdit(port['port_name'])
                port_type_edit = QLineEdit(port['port_type'])
                port_unit_edit = QLineEdit('[-]')  # Set default to 'unitless'
                port_layout.addWidget(QLabel('Port:'))
                port_layout.addWidget(port_name_edit)
                port_layout.addWidget(QLabel('Type:'))
                port_layout.addWidget(port_type_edit)
                port_layout.addWidget(QLabel('Unit:'))
                port_layout.addWidget(port_unit_edit)
                comp_layout.addLayout(port_layout)
                port_inputs.append({
                    'name': port_name_edit,
                    'type': port_type_edit,
                    'unit': port_unit_edit
                })

            attr_inputs['ports'] = port_inputs
            self.components_inputs[comp] = {'name_edit': name_edit, 'fmu_edit': fmu_edit, 'attributes': attr_inputs}

            

            comp_group.setLayout(comp_layout)
            components_layout.addWidget(comp_group)

        components_group.setLayout(components_layout)
        scroll_layout.addWidget(components_group)

        # Connections
        connections_group = QGroupBox("Connections")
        connections_layout = QVBoxLayout()
        
        for conn in connections:
            conn_layout = QHBoxLayout()
            start_element = QLineEdit(conn['start_element'])
            start_connector = QLineEdit(conn['start_connector'])
            end_element = QLineEdit(conn['end_element'])
            end_connector = QLineEdit(conn['end_connector'])
            
            conn_layout.addWidget(QLabel("From:"))
            conn_layout.addWidget(start_element)
            conn_layout.addWidget(QLabel("."))
            conn_layout.addWidget(start_connector)
            conn_layout.addWidget(QLabel("To:"))
            conn_layout.addWidget(end_element)
            conn_layout.addWidget(QLabel("."))
            conn_layout.addWidget(end_connector)
            
            connections_layout.addLayout(conn_layout)
            self.connections_inputs.append({
                'start_element': start_element,
                'start_connector': start_connector,
                'end_element': end_element,
                'end_connector': end_connector
            })

        connections_group.setLayout(connections_layout)
        scroll_layout.addWidget(connections_group)

        scroll_area.setWidget(scroll_widget)
        main_layout.addWidget(scroll_area)

        # Buttons
        button_layout = QHBoxLayout()
        save_button = QPushButton("Save")
        save_button.clicked.connect(self.accept)
        cancel_button = QPushButton("Cancel")
        cancel_button.clicked.connect(self.reject)
        button_layout.addWidget(save_button)
        button_layout.addWidget(cancel_button)
        main_layout.addLayout(button_layout)

        self.setLayout(main_layout)

    def accept(self):
        # Check if any text fields are empty
        if not self.system_name_edit.text().strip() or not self.generation_tool_edit.text().strip():
            QMessageBox.warning(self, 'Input Error', 'System Name and Generation Tool cannot be empty.')
            return  # Do not accept the dialog
        if not self.start_time_edit.text().strip() or not self.stop_time_edit.text().strip():
            QMessageBox.warning(self, 'Input Error', 'Start Time and Stop Time cannot be empty.')
            return  # Do not accept the dialog
        try:
            start_time = float(self.start_time_edit.text().strip())
            stop_time = float(self.stop_time_edit.text().strip())
            if start_time >= stop_time:
                QMessageBox.warning(self, 'Input Error', 'Start Time must be less than Stop Time.')
                return  # Do not accept the dialog
        except ValueError:
            QMessageBox.warning(self, 'Input Error', 'Start Time and Stop Time must be valid numbers.')
            return  # Do not accept the dialog
        for comp, edits in self.components_inputs.items():
            new_name = edits['name_edit'].text().strip()
            fmu_filename = edits['fmu_edit'].text().strip()
            if not new_name or not fmu_filename:
                QMessageBox.warning(self, 'Input Error', 'Component names and FMU filenames cannot be empty.')
                return  # Do not accept the dialog
        # If all fields are filled, accept the dialog
        super().accept()

    def get_component_info(self):
        info = {
            'system_name': self.system_name_edit.text().strip(),
            'generation_tool': self.generation_tool_edit.text().strip(),
            'start_time': self.start_time_edit.text().strip(),
            'stop_time': self.stop_time_edit.text().strip(),
            'components': {},
            'connections': []
        }
        for comp, edits in self.components_inputs.items():
            new_name = edits['name_edit'].text().strip()
            fmu_filename = edits['fmu_edit'].text().strip()
            attributes = {}
            ports = []
            
            for attr_name, attr_value in edits['attributes'].items():
                if attr_name == 'ports':
                    for port in attr_value:
                        ports.append({
                            'port_name': port['name'].text().strip(),
                            'port_type': port['type'].text().strip(),
                            'unit': port['unit'].text().strip()
                        })
                else:
                    attributes[attr_name] = attr_value.text().strip()
            
            
            
            info['components'][comp] = {
                'new_name': new_name, 
                'fmu_filename': fmu_filename, 
                
                'ports': ports,
                
            }
        
        for conn_inputs in self.connections_inputs:
            info['connections'].append({
                'start_element': conn_inputs['start_element'].text().strip(),
                'start_connector': conn_inputs['start_connector'].text().strip(),
                'end_element': conn_inputs['end_element'].text().strip(),
                'end_connector': conn_inputs['end_connector'].text().strip()
            })
        return info

# Function to collect component information from user
def get_component_info(components, connections):
    app = QApplication.instance()
    if app is None:
        app = QApplication(sys.argv)
    dialog = ComponentInfoDialog(components, connections)
    if dialog.exec_():
        component_info = dialog.get_component_info()
    else:
        # User cancelled the dialog
        return None
    return component_info

# Function to create the SSP file
def create_ssp_file(output_file, components, connections, component_info, connector_kinds):
    # Get user input data
    system_name = component_info['system_name']
    generation_tool = component_info['generation_tool']
    start_time = component_info['start_time']
    stop_time = component_info['stop_time']
    component_details = component_info['components']

    # Create mapping from original component names to new names
    name_mapping = {}
    for original_name, info in component_details.items():
        name_mapping[original_name] = info['new_name']

    # Create SSP XML structure
    ssd = ET.Element('ssd:SystemStructureDescription', {
        'xmlns:ssc': 'http://ssp-standard.org/SSP1/SystemStructureCommon',
        'xmlns:ssd': 'http://ssp-standard.org/SSP1/SystemStructureDescription',
        'xmlns:ssb': 'http://ssp-standard.org/SSP1/SystemStructureSignalDictionary',
        'xmlns:ssv': 'http://ssp-standard.org/SSP1/SystemStructureParameterValues',
        'xmlns:xsi': 'http://www.w3.org/2001/XMLSchema-instance',
        'version': '1.0',
        'name': system_name,
        'generationTool': generation_tool,
        'generationDateAndTime': datetime.now(timezone.utc).isoformat(),
        'xsi:schemaLocation': 'http://ssp-standard.org/SSP1/SystemStructureDescription http://ssp-standard.org/SSP/1.0/SystemStructureDescription.xsd'
    })

    system = ET.SubElement(ssd, 'ssd:System', {'name': system_name})

    # Add components and ports to the SSP file
    elements_el = ET.SubElement(system, 'ssd:Elements')
    for original_name, details in components.items():
        if original_name not in component_details:
            print(f"Warning: No information for component {original_name}, skipping.")
            continue
        info = component_details[original_name]
        new_name = info['new_name']
        fmu_filename = info['fmu_filename']

        component = ET.SubElement(elements_el, 'ssd:Component', {
            'name': new_name,
            'type': 'application/x-fmu-sharedlibrary',
            'source': f'resources/{fmu_filename}'
        })

 

        connectors_el = ET.SubElement(component, 'ssd:Connectors')

        # Add ports
        for port in info['ports']:
            port_name = port['port_name']
            port_type = port['port_type']
            unit = port['unit']

            # Determine 'kind' based on connector role
            connector_key = f"{original_name}.{port_name}"
            kind = connector_kinds.get(connector_key, 'output') # the default port type set to be output

            # Add connector
            connector = ET.SubElement(connectors_el, 'ssd:Connector', {
                'name': port_name,
                'kind': kind
            })
            ET.SubElement(connector, 'ssc:Real', {'unit': unit})

    # Add connections to the SSP file
    connections_el = ET.SubElement(system, 'ssd:Connections')
    for conn in connections:
        interface_type = conn.get('interface_type')
        start_element = conn['start_element']
        start_connector = conn['start_connector']
        end_element = conn['end_element']
        end_connector = conn['end_connector']

        # Get new names
        start_element_new_name = name_mapping.get(start_element, start_element)
        end_element_new_name = name_mapping.get(end_element, end_element)

        # Update the startConnector and endConnector to include the new names as prefixes
        #start_connector_full = f"{start_element_new_name}.{start_connector}"
        start_connector_full = f"{start_connector}" #dedicated to modelica
        #end_connector_full = f"{end_element_new_name}.{end_connector}"
        end_connector_full = f"{end_connector}"#dedicated to modelica

        ET.SubElement(connections_el, 'ssd:Connection', {
            'startElement': start_element_new_name,
            'startConnector': start_connector_full,
            'endElement': end_element_new_name,
            'endConnector': end_connector_full
        })

    # Add DefaultExperiment to the SSP file
    ET.SubElement(ssd, 'ssd:DefaultExperiment', {
        'startTime': start_time,
        'stopTime': stop_time
    })

    # Write the SSP file
    with open(output_file, 'w', encoding='utf-8') as f:
        # Write XML declaration
        f.write('<?xml version="1.0" encoding="UTF-8"?>\n')
        # Write pretty-formatted XML
        f.write(pretty_print(ssd))

# Function to select a file using GUI
def select_file(prompt="Please select a SysML file."):
    app = QApplication.instance()
    if app is None:
        app = QApplication(sys.argv)
    QMessageBox.information(None, "Select File", prompt)
    file_path, _ = QFileDialog.getOpenFileName(None, "Select SysML file", "", "SysML files (*.sysml);;All files (*.*)")
    return file_path

# Main function to run the process with validation
def main():
    print("Select Interface Definition SysML file.")
    interface_file = select_file("Select the Interface Definition SysML file.")
    if not interface_file:
        print("Interface Definition file not selected. Exiting.")
        return

    print("Select System Definition SysML file.")
    connection_file = select_file("Select the System Definition SysML file.")
    if not connection_file:
        print("System Definition file not selected. Exiting.")
        return

    # Parse the Interface Definition SysML file
    with open(interface_file, 'r') as f:
        interface_lines = f.readlines()
    interface_definitions = parse_interface_definitions(interface_lines)

    # Parse the System Definition SysML file
    with open(connection_file, 'r') as f:
        connection_lines = f.readlines()
    components, connections = parse_system_definitions(connection_lines)

    # Collect connector roles based on connections
    connector_kinds = {}
    for conn in connections:
        start_key = f"{conn['start_element']}.{conn['start_connector']}"
        end_key = f"{conn['end_element']}.{conn['end_connector']}"
        connector_kinds[start_key] = 'output'
        connector_kinds[end_key] = 'input'

    # Perform validation
    validation_errors = validate_connections(components, connections, interface_definitions)

    if validation_errors:
        print("Validation errors found:")
        for error in validation_errors:
            connection = error['connection']
            message = error['message']
            print(f"Error in connection {connection['start_element']}.{connection['start_connector']} -> {connection['end_element']}.{connection['end_connector']}: {message}")
        print("Please fix the validation errors and try again.")
        return
    else:
        print("No validation errors found.")

    # Collect component information from user
    component_info = get_component_info(components, connections)
    if component_info is None:
        print("Operation cancelled by the user.")
        return

    # Create SSP file
    output_file = 'generatedSSD.ssd'
    create_ssp_file(output_file, components, component_info['connections'], component_info, connector_kinds)

    print(f'Successfully created SSP file: {output_file}')

if __name__ == "__main__":
    main()