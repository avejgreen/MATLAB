function gVectors = AnglesToGVectors(AllData)

%USE 2THETA, OMEGA, CHI, PHI VALUES TO PLOT G-SPACE VECTORS
%g-Space magnitude is 1/d

nVectors = size(AllData,1);

gVectors = zeros(3,nVectors);
gVectors(3,:) = 2*sin(.5*AllData(:,7)*pi/180)/1.54056;

% x rotation around omega, corrected for 2theta
% y rotation around chi
% z rotation around phi

xRotAngles = .5*AllData(:,7)-AllData(:,6);
yRotAngles = AllData(:,1);
zRotAngles = AllData(:,2);

% Rotate around x, then y, then z

xRotMatrices = ...
    [ones(1,1,nVectors),zeros(1,1,nVectors),zeros(1,1,nVectors);...
    zeros(1,1,nVectors),permute(cos(xRotAngles(:)*pi/180),[2,3,1]),permute(-sin(xRotAngles(:)*pi/180),[2,3,1]);...
    zeros(1,1,nVectors),permute(sin(xRotAngles(:)*pi/180),[2,3,1]),permute(cos(xRotAngles(:)*pi/180),[2,3,1])];
yRotMatrices = ...
    [permute(cos(yRotAngles(:)*pi/180),[2,3,1]),zeros(1,1,nVectors),permute(sin(yRotAngles(:)*pi/180),[2,3,1]);...
    zeros(1,1,nVectors),ones(1,1,nVectors),zeros(1,1,nVectors);...
    permute(-sin(yRotAngles(:)*pi/180),[2,3,1]),zeros(1,1,nVectors),permute(cos(yRotAngles(:)*pi/180),[2,3,1])];
zRotMatrices = ...
    [permute(cos(zRotAngles(:)*pi/180),[2,3,1]),permute(-sin(zRotAngles(:)*pi/180),[2,3,1]),zeros(1,1,nVectors);...
    permute(sin(zRotAngles(:)*pi/180),[2,3,1]),permute(cos(zRotAngles(:)*pi/180),[2,3,1]),zeros(1,1,nVectors);...
    zeros(1,1,nVectors),zeros(1,1,nVectors),ones(1,1,nVectors)];

for i = 1:nVectors
   gVectors(:,i) = zRotMatrices(:,:,i)*yRotMatrices(:,:,i)*xRotMatrices(:,:,i)*gVectors(:,i);
   test = 1;
end

gVectors = gVectors';
test = 1;

end