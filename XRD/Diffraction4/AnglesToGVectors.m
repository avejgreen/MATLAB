function GVectors = AnglesToGVectors(Angles)

% close all;
% clear all;
% clc;

% Angles = DataFilesToAngles;

GVectors = ones(size(Angles,1), 4);

for i = 1:size(Angles,1)
    
    G0 = [0,0,1]*2*sin(Angles(i,1)*.5*pi/180)/1.5406;
    
    XRot = (Angles(i,1)/2 - Angles(i,2))*pi/180;
    XRot = [1,0,0;0,cos(XRot),-sin(XRot);0,sin(XRot),cos(XRot)];
    YRot = Angles(i,3)*pi/180;
    YRot = [cos(YRot),0,-sin(YRot);0,1,0;sin(YRot),0,cos(YRot)];
    ZRot = Angles(i,4)*pi/180;
    ZRot = [cos(ZRot),sin(ZRot),0;-sin(ZRot),cos(ZRot),0;0,0,1];
    
    GVectors(i,1:3) = G0*XRot*YRot*ZRot;
    
end

GVectors(:,4) = Angles(:,5);

test = 1;

end