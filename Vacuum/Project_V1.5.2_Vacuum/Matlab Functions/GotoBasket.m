function GotoBasket(id,vrep,Robot,Joints,color)
    if (color == "r")
        x = 0.9;
        y = 0;
        q0 = [0.17,-0.78,-0.81,-3.14,1.59,1.39];
    elseif (color == "b")
        x = 1e-3;
        y = 0.9;
        q0 = [1.75,-0.78,-0.81,-3.13,1.59,-0.19];
    elseif (color == "g")
        x = -0.9;
        y = 0;
        q0 = [0 0 0 0 0 0];
    end
    z = 0.65;
    p = [x,y,z];
    T = transl(p);
    %q0 is an initial guess
    TargetPos = Robot.ikunc(T,q0);
    RotateJoints(id, vrep, Joints, TargetPos);
end