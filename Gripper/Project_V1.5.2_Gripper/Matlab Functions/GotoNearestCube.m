function [p,rotation,color] = GotoNearestCube(id,vrep,Robot,Joints,Camera,ConveyorSensor)
    % goes to nearset cube in 2 steps
    [x,y,rotation,color] = GetPositionFromPy(id,vrep,Camera,ConveyorSensor);
    %step 1
    z = 0.7;
    p = [x,y,z];
    fprintf('coordinate: [%i,%i,%i] m\n',p(1),p(2),p(3));
    fprintf('rotation: %i degree\n',rotation*180/pi);
    fprintf('color: %s\n',color);
    T = transl(p);
    theta_x = 0;
    theta_y = pi;
    theta_z = pi/2;
    T(1:3,1:3) = RotationMatrix(theta_z,theta_y,theta_x,'ZYX',true);
    %initial guess
    q0 = [1.2807    0.6263    1.5280   -0.5836    1.5708    0.2901];
    TargetPos = Robot.ikunc(T,q0); %1*6 vector
    TargetPos(6) = TargetPos(6) + rotation;
    RotateJoints(id, vrep, Joints, TargetPos, 1);
    %step 2
    z = 0.6;
    p = [x,y,z];
    fprintf('coordinate: [%i,%i,%i] m\n',p(1),p(2),p(3));
    fprintf('rotation: %i degree\n',rotation*180/pi);
    fprintf('color: %s\n',color);
    T = transl(p);
    theta_x = 0;
    theta_y = pi;
    theta_z = pi/2;
    T(1:3,1:3) = RotationMatrix(theta_z,theta_y,theta_x,'ZYX',true);
    q0 = [1.2807    0.6263    1.5280   -0.5836    1.5708    0.2901];
    TargetPos = Robot.ikunc(T,q0); %1*6 vector
    TargetPos(6) = TargetPos(6) + rotation;
    RotateJoints(id, vrep, Joints, TargetPos, 1);
end