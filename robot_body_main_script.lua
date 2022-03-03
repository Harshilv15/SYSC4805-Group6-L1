function sysCall_init()
    corout=coroutine.create(coroutineMain)
    robot=sim.getObjectHandle(sim.handle_self)
    
    frontVisionSensor={-1,-1,-1}
    frontVisionSensor[1]=sim.getObjectHandle("Front_Left_Vision_Sensor")
    frontVisionSensor[2]=sim.getObjectHandle("Front_Middle_Vision_Sensor")
    frontVisionSensor[3]=sim.getObjectHandle("Front_Right_Vision_Sensor")
    backVisionSensor={-1,-1,-1}
    backVisionSensor[1]=sim.getObjectHandle("Back_Left_Vision_Sensor")
    backVisionSensor[2]=sim.getObjectHandle("Back_Middle_Vision_Sensor")
    backVisionSensor[3]=sim.getObjectHandle("Back_Right_Vision_Sensor")
    
    frontRightJoint=sim.getObjectHandle("FrontRightJoint")
    rearRightJoint=sim.getObjectHandle("RearRightJoint")
    frontLeftJoint=sim.getObjectHandle("FrontLeftJoint")
    rearLeftJoint=sim.getObjectHandle("RearLeftJoint")
    
    frontProximitySensor=sim.getObjectHandle("FrontProximitySensor")
    
    nominalLinearVelocity=2
    wheelRad=1
    --Used to check if the robot is currently doing a predetermined move where 
    --complexMove[1] determines if the move is in progress
    --and complexMove[2] determines if the sensor should be paused.
    complexMove = {0, 0}
    uturned = 0
    s=sim.getObjectSizeFactor(robot) -- Used if robot is scaled
end

function sysCall_actuation()
    if coroutine.status(corout)~='dead' then
        local ok,errorMsg=coroutine.resume(corout)
        if errorMsg then
            error(debug.traceback(corout,errorMsg),2)
        end
    end
end

function coroutineMain()
    -- Put some initialization code here
    while true do
        -- Logic for path detection
        backSensorReading={false,false,false}
        for i=1,3,1 do
        result,data=sim.readVisionSensor(backVisionSensor[i])
            if(result>=0) then
                backSensorReading[i]=(data[11]<0.3)
            end
        end
        RightV=nominalLinearVelocity*s
        LeftV=nominalLinearVelocity*s
        if backSensorReading[2] and complexMove[1] == 0 then
            originalPos = sim.getObjectOrientation(robot, -1)
            uturn(originalPos[2])
        elseif complexMove[1] == 1 then
            uturn(originalPos[2])
        elseif complexMove[2] == 1 then
            settingVelocity(LeftV,RightV)
            sim.wait(5, false)
            complexMove[2] = 0
        else
            settingVelocity(LeftV,RightV)
        end
        
        -- Logic for Obstacle Detection
        
        -- Check Front Sensor
        result=sim.readProximitySensor(frontProximitySensor)
        if(result==1)then
            print("Obstacle Detected")
            LeftV=6
            RightV=-2
            settingVelocity(LeftV,RightV)
            sim.wait(0.5, false)
        end
        --while (result==0)do
            --sim.wait(0.1, false)
            --result=sim.readProximitySensor(leftProximitySensor)
        --end
        --if (result==1)then
            --print("Obstacle Detected 1")
        --end
    end
end

-- See the user manual or the available code snippets for additional callback functions and details

function uturn(originalY)
    local newPos = sim.getObjectOrientation(robot, -1)
    --Removing extra decimal points in order to check if 180 is complete by adding
    --original y orientation with a its new orientation until it becomes 0 (y + (-y) = 0)
    if complexMove[1] == 0 or tonumber(string.format("%.1f",originalY)) + tonumber(string.format("%.1f",newPos[2])) ~= 0 then
        LeftV=6
        RightV=-2
        settingVelocity(LeftV,RightV)
        complexMove[1] = 1
    else
        complexMove = {0,1}
        print("180 done")
    end
end

function settingVelocity(left, right)
    sim.setJointTargetVelocity(frontRightJoint, RightV/(s*wheelRad))
    sim.setJointTargetVelocity(rearRightJoint, RightV/(s*wheelRad))
    sim.setJointTargetVelocity(frontLeftJoint, LeftV/(s*wheelRad))
    sim.setJointTargetVelocity(rearLeftJoint, LeftV/(s*wheelRad))
end
-- See the user manual or the available code snippets for additional callback functions and details
