function ReloadPy()
    %reload python (opencv) module
    terminate(pyenv)  
    if (count(py.sys.path,'Python Functions') == 0)
        insert(py.sys.path,int32(0),'Python Functions');
    end
    warning('off','MATLAB:ClassInstanceExists')
    clear classes
    GetPosition = py.importlib.import_module('GetPosition');
    py.importlib.reload(GetPosition);
end