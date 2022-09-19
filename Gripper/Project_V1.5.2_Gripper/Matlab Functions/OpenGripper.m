function OpenGripper(id,vrep,Gripper,Xspeed) 
 vrep.simxSetJointForce(id,Gripper,150,vrep.simx_opmode_oneshot);
 vrep.simxSetJointTargetVelocity(id,Gripper,Xspeed,vrep.simx_opmode_oneshot);
 pause(2.5);
 vrep.simxSetJointTargetVelocity(id,Gripper,0,vrep.simx_opmode_oneshot);
end

