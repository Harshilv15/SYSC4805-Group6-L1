# Folder containing robot models 
Robot naming convention: robotbodyX_Y <br />
  * Where: 
    * X = Lab number
    * Y = Iteration number
## Model Notes
### [robotbody5_5](robotbody5_5.ttm)
Added basic plow structure. robot body was extended (in z direction) to allow for room to add revolute joints on the left and right sides. The revolute joints currently have the motor disabled. The arms are attached to the revolute joints. At the end of the arms there are force sensors that attach to the "shovels". 

**TODO:** 
- Enable motor for revolute joints, add code so that the motors stay still when pushing snow. (We can also add code to lift the plow up/down, but is this needed??)

**Ideas for next steps**:
- Could extend the arms, but keep the shovels in the same place. This way it will trap more snow in front of the shovels, and the snow won't be able to disperse because it is being kept in between the arms.

### [robotbody5_6](robotbody5_6.ttm)
Fixed issue where robot would get stuck constantly uturing on boundary lines by changing the non-threaded child script to a threaded script. 

**TODO:** 
- Implement a case that allows the robot to do a uturn in the opposite direction than the previous uturn so it doesn't go around in circles.

**Ideas for next steps**:
- Add sensors to detect if there are boundary lines/obstacles parallel to the robots current path so it doesn't uturn out of the perimeter/collide with obstacles.
