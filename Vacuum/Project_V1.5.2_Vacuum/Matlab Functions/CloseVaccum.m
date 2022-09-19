function CloseVaccum(id,vrep,Cuboid,EE)
    vrep.simxSetObjectIntParameter(id,Cuboid,3004,0,vrep.simx_opmode_oneshot);
    vrep.simxSetObjectIntParameter(id,Cuboid,3003,1,vrep.simx_opmode_oneshot);
    vrep.simxSetObjectParent(id,Cuboid,EE,true,vrep.simx_opmode_oneshot);
end