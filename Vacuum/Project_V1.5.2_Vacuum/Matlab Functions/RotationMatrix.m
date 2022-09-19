function R = RotationMatrix(alpha, beta, gamma, type, fixed)
    %returns rotation matrix based on convention specified by type
    alpha = deg2rad(alpha);
    beta = deg2rad(beta);
    gamma = deg2rad(gamma);
    type = upper(type);
    R_x = [1 0 0;0 cos(alpha) -sin(alpha);0 sin(alpha) cos(alpha)];
    R_y = [cos(beta) 0 sin(beta);0 1 0;-sin(beta) 0 cos(beta)];
    R_z = [cos(gamma) -sin(gamma) 0;sin(gamma) cos(gamma) 0;0 0 1];
    rotations = containers.Map({'X', 'Y', 'Z'}, {R_x, R_y, R_z});
    if (fixed)
       R = rotations(type(3)) * rotations(type(2)) * rotations(type(1)); 
    else
       R = rotations(type(1)) * rotations(type(2)) * rotations(type(3)); 
    end
end