function GoToXYZ(id,vrep,Robot,Joints,x,y,z)
    p = [x,y,z];
    T = transl(p);
    theta_x = 0;
    theta_y = 0;
    theta_z = 0;
    T(1:3,1:3) = RotationMatrix(theta_z,theta_y,theta_x,'ZYX',true);
    %initial guess
    q0 = [1.2807    0.6263    1.5280   -0.5836    1.5708    0.2901];
    TargetPos = Robot.ikunc(T,q0); %1*6 vector 
    RotateJoints(id, vrep, Joints, TargetPos);
end