function Phi = PhiCalculator(OldCrystal)

%{
Find Phi values for all planes.
1. Calculate the g vector from the surfdir
2. Project a plane vector onto gsurf
3. Subtract the projected vector from the plane vector
4. Calculate Phi.
%}

gSurf = double(OldCrystal.SurfDir)*OldCrystal.b;
gProj = (OldCrystal.gVectors(:,1:3)*gSurf')*gSurf/(dot(gSurf,gSurf));
gIP = OldCrystal.gVectors(:,1:3)-gProj;
gIP(abs(gIP)<1e-10)=0;

gNotch = double(OldCrystal.NotchDir)*OldCrystal.b;

PhiCos = (180/pi)*acos((gIP*gNotch')./(sqrt(dot(gIP,gIP,2).*dot(gNotch,gNotch,2))));
PhiSin = (180/pi)*asin(cross(gIP,ones(size(gIP,1),1)*gNotch,2)*(gSurf'/norm(gSurf))./(sqrt(dot(gIP,gIP,2).*dot(gNotch,gNotch,2))));

Phi = PhiCos;
Phi(PhiSin<0) = 360-Phi(PhiSin<0);

test = 1;

end