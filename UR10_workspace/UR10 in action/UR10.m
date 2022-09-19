% You can create the UR10_workspace.xyz file with the
% UR10_workspace.ttt file in CoppeliaSim
XYZ=load('UR10_conf_workspace.xyz');
x=XYZ(:,1);
z=XYZ(:,2);
y=XYZ(:,3);
shp=alphaShape(z,y);
shp.Alpha=0.09;
[bf,xz]=boundaryFacets(shp);
figure();
plot(xz(:,1),xz(:,2));
T = delaunay(xz(:,1),xz(:,2));
tri=triangulation(T,xz(:,1),xz(:,2));
stlwrite('workspace.stl',z',y',x');
fileID = fopen('UR10_ws_boundary.txt','w');
for i=1:size(xz,1)
    fprintf(fileID,'%f %f\n',xz(i,1),xz(i,2));
end
fclose(fileID);