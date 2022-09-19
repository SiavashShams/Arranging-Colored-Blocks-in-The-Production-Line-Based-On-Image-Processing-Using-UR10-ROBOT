function OpenVaccum(id,vrep,Cuboid) 
    vrep.simxSetObjectIntParameter(id,Cuboid,3004,1,vrep.simx_opmode_oneshot);
    vrep.simxSetObjectIntParameter(id,Cuboid,3003,0,vrep.simx_opmode_oneshot);
    vrep.simxSetObjectParent(id,Cuboid,-1,true,vrep.simx_opmode_oneshot);
end

