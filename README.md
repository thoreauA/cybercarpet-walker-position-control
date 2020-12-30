# LHI-module-finale-project
In this work, it is proposed a controller at acceleration level for a CyberCarpet platform. This platform is a type of
cyberwalk platform, which is used for virtual reality exploration. The user has to be fully immersed in the virtual reality,
free to move in any direction. To make this possible it is necessary a locomotion support, like a cyberwalk platform,
which keeps the user close to a desired position (e.g. center of the platform most likely) despite of its intentional motion.
Obviously, the user does not have to feel the action of the platform, this means that perceptual constraints have to be
taken in consideration.
For the CyberCarpet platform, it has been proposed a control law at velocity level based on input-output linearization
in [1]. This control law then has been extended to acceleration-level through a cascaded system (also backstepping
approach has been discussed). Controlling this platform at acceleration level has different advantages which will be
later discussed. The final control scheme is composed by two terms: feedback term and feedforward. This latter is
needed to contrast the intentional motion of the walker, which is unknown and has to be estimated. It is possible to
estimate it through an observer and then it is considered as a disturbance to the system.
A different controller is presented in this project, which is a nonlinear model predictive control. After an overview of
this method and a comparison with the cascaded one, it will be shown the results obtained from a simulation done in
Matlab and Simulink
![Immagine NMPC](https://github.com/thoreauA/cybercarpet-walker-position-control/raw/main/SchemeNMPC.png)