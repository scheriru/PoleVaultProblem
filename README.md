# PoleVaultProblem

This MATLAB code is supplement to the problem studied in the paper published on ASME Journal of Applied Mechanics - 
"Kinetic to Potential Energy Transformation Using a Spring as an Intermediary: Application to the Pole Vault Problem"

This case is to solve the dynamics of the Point Mass and Elastica System without Applied Torque. Input variables are Initial angle: alpha, Non-dimensional weight: w, and Initial velocity: v


The main file is: Simulation_MassElastica

To study the energy changing for the duration, use Simulation_MassElastica_Energy

The files assoicated with the case with Applied Torque are uploaded: Simulation_MassElastica_Torque, odedynamicsAT, BVPElasticaPos

The main file is Simulation_MassElastica_Torque

Notes:

-To follow the convention of the general elastica problem, the coordinate system of the elastica problem is adjusted. Please see more details in the code.

-Pre-bending is added to avoid numerical issues.

Written By: Sheryl Chau
