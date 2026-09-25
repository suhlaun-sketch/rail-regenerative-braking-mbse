# SysMLV2_FMI_PyFMI_Integration

This repository contains the source code and examples related to SysML V2 and simulation integration project which has done in University of Oulu.

## Setting Up the Anaconda Environment

To ensure that you have all the necessary dependencies and the correct Python version, follow these steps to set up the Conda environment:

### 1. Install Anaconda/Miniconda

If you don't have Anaconda or Miniconda installed, download and install it from the official website:
https://www.anaconda.com/download or https://docs.anaconda.com/miniconda/

### 2. Clone the Repository

Clone this repository to your local machine:


### 3. Create a Conda Environment

Use the provided environment.yml file to create a new Conda environment. This file includes all necessary dependencies.

**conda env create -f environment.yml**

### 4. Activate the Conda Environment

After the environment is created, activate it with:

**conda activate sysml_fmi_env**

### 5. Verify the Environment

You can verify that the environment has been set up correctly by checking the installed packages:

**conda list**

## Running the Application

Now that the environment is set up, you can run the application or scripts within this repository.

### 1. Run the SSI transformer 
Open the source folder and run the "SSI_transformer.py" file from there. Locate the "interface_definition.sysml" and "system_definition.syml" files from either "sec3" or "sec4" folder.

NOTE: to successfully run the models and simulation, the name of the 'em' part should be changed to 'motor' in the SSI transformer GUI tab. This name difference is set intentionally to test and demonstrate the name change functionality of the code.
### 2. Run the SSI simulator with Manual or SSD Parsed Model Connections

To run the PyFMI simulation, you can either manually connect FMUs or use the already parsed connections from SSD file. The simulations and the their generated SSD files are stored in "P1_SSP" and "P2_SSP" folders. The simulator can be utilized for other FMU, and it is not limited to SSI transformer-generated SSD as long as the license for FMUs is available. 

Note: To run these simulations AVL license is required.

Note: A license-free, simple spring damper model is provided in "EXTRA/modelica". Due to the different methods used in FMU generation, the SSI_transformer in Modelica-based simulations is somewhat different. The suitable transformer can be found in "source/SSI_transformer_modelica.py"

## EXTRA folder

In the EXTRA folder, a jyputer notebook sysml model demonstrating a lack of proper port cross-check is stored. As explained in the article, a separate cross-checking logic has been added to the transformer. This file is provided as a reference to check this functionality, a separate .sysml file should be extracted from he given Jyputer file for cross-checking. 

In the modelica subfolder, SysML models and the needed simulation for a mass-spring-damper model are given. The simulations are made in Modelica, so no license is needed for running the simulations. The SysML models are made following SSI workflow.
