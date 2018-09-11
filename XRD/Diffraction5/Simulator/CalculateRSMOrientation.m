formsfunction [Phi,Chi] = CalculateRSMOrientation(RSMSelection,AllCrystals)

hkl1 = RSMSelection(1,1:3);
hkl2 = RSMSelection(2,1:3);

g1 = hkl1*AllCrystals(RSMSelection(1,4)).b;
g2 = hkl2*AllCrystals(RSMSelection(2,4)).b;

%Get the cross product of the selected g vectors
CP = cross(g1,g2);

%Project the CP vector to the XY plane
CPXY = [CP(1:2),0];

% Calculate the angle between the CPXY vector and the x-axis
XAxis = [1,0,0];

PhiCos = (180/pi)*acos(dot(XAxis,CPXY)/norm(CPXY));
PhiSin = (180/pi)*asin(dot(cross(XAxis,CPXY),[0,0,1])/norm(CPXY));

Phi = PhiCos;
Phi(PhiSin<0) = 360-Phi(PhiSin<0);

test = 1;



CP = [abs(CP(1)),0,CP(3)];

%The CP vector should be rotated into the XZ plane. Now want to align with
%the x-axis. Find the Chi angle.

Chi = (180/pi)*asin(dot(cross(XAxis,CP),[0,1,0])/norm(CP));

end