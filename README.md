# LHI-module-finale-project
In this work, it is proposed a controller at acceleration level for a CyberCarpet platform. This platform is a type of
cyberwalk platform, which is used for virtual reality exploration. The user has to be fully immersed in the virtual reality,
free to move in any direction. To make this possible it is necessary a locomotion support, like a cyberwalk platform,
which keeps the user close to a desired position (e.g. center of the platform most likely) despite of its intentional motion.
Obviously, the user does not have to feel the action of the platform, this means that perceptual constraints have to be
taken in consideration.
The intentional motion of the walker, which is unknown and unpredictable, has to be estimated. It is possible to
estimate it through an observer and consider it as a disturbance to the system.
The controller proposed is a nonlinear model predictive control.

<img src="https://github.com/thoreauA/cybercarpet-walker-position-control/raw/main/pictures/SchemeNMPC.png" width="700" height="200">

## Platform kinematics
The CyberCarpet platform is a ball array platform. It can be considered as a nonholonomic mobile
platform, e.g. wheel mobile robot. It is composed by a treadmill belt mounted on a turntable which can move on the main axes and by an array of balls arranged in a grid whose position is almost fixed. The treadmill is bidirectional with AC motor driver, the same motors drive the turntable (with an higher transmission ratio).
In order to understand how this platform is working, it is important to point out how the forces are acting on the user and on the platform. When the treadmill moves, a force is applied to each sphere on the grid, an equivalent force is then applied on the top of the sphere with an opposite direction. In order to transmit this force, it is desirable to have an high friction between the sphere and the treadmill belt and a low friction between the sphere and the grid.

<img src="https://github.com/thoreauA/cybercarpet-walker-position-control/raw/main/pictures/PlatformScheme.png" width="300" height="200">

The kinematic equations are:

<img src="https://github.com/thoreauA/cybercarpet-walker-position-control/raw/main/pictures/equations.png" width="300" height="200">

Where (x,y,theta_w) are the position and orientation of the walker, (v, omega) the linear and angular velocities and (V_w_x, V_w_y) are the linear velocities of the walker that are estimated through an observer.

## Simulation
A simulation of the overall system has been implemented using Simulink software. This simulation is composed mainly by three blocks, which are the one for the kinematic system of the platform, the observer for the walker velocities and the nonlinear model predictive controller.

<img src="https://github.com/thoreauA/cybercarpet-walker-position-control/raw/main/pictures/SimulinkScheme.png" width="700" height="300">

In the walker velocity block it is possible to choose different walking patterns for the user (linear path, circular path, square path, defined in an absolute reference frame). 
The simulation is in the directory **code/MPC_walker_velocity**. To open it:
 
 	open in Matlab MPCdefinition.m
 	
The simulation will be opened automatically.





