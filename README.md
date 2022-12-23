# Arranging-Colored-Blocks-in-The-Production-Line-Based-On-Image-Processing-Using-UR10-ROBOT
The project is about separating colored blocks in a production line using UR10 robot. The simulation environment is set up in CoppeliaSim. A camera is installed above a conveyor and records the frames. The color, coordination, and rotation of cubes are obtained using image processing with OpenCV. With that information about the cube, the angle of the joints of the robot is calculated by solving the inverse kinematics equations in MATLAB. Finally, these angles are sent to the CoppeliaSim environment. Using the PID controller, the robot's end effector goes to the desired position and performs the Pick and Place operation.
![t100](/Videos/operation.gif)

Contributors (alphabetic order):
Arman Barghi
Amirhossein Dabiri
Mohammadmehdi Rahimi
Siavash Shams
Mohammadreza Teymoorian

Main repo: https://github.com/ArmOn007/Arranging-Colored-Blocks-Using-UR10
