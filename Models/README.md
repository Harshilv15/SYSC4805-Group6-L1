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
