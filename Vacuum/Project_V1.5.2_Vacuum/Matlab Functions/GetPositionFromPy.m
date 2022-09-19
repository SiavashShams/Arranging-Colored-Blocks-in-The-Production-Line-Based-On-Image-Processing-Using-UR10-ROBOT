function [x,y,rotation,color] = GetPositionFromPy(id,vrep,Camera,ConveyorSensor)
    %this function passes image to python (opencv) and gets cube position
    result = 0;
    while (result == 0)
        [~,result,~,~,~] = vrep.simxReadProximitySensor(id,ConveyorSensor,vrep.simx_opmode_buffer);
    end
    image = GetImage(id,vrep,Camera);
    imwrite(image,'image.png')
    py_out = py.GetPosition.callme(); % returns a python tuple
    while (py_out{1} == -10000 && py_out{2} == -10000 && py_out{4} == "-10000")
        image = GetImage(id,vrep,Camera);
        imwrite(image,'image.png')
        py_out = py.GetPosition.callme();
    end
    rotation = py_out{3};
    x = (-double(py_out{1}) * 0.59 / 256 + 0.59 / 2) * 0.85;
    y = double(py_out{2}) * 0.59 / 256 - 0.59/4 - 0.55 - 0.52;
    color = py_out{4};
    delete 'image.png'
end