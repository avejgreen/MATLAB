function [uvw,rVectors] = rCalculator(OldCrystal)

%Get allowed diffraction planes. First get list of measurable planes
%with lambda = 1.5406 A, braggmax = 50deg. use (dmin,gmax) = (1,1)
lambda = 1.5406;
braggmax = 50*pi/180;
dmin = lambda/(2*sin(braggmax));
gmax = 1/dmin;

uvw = OldCrystal.gVectors*OldCrystal.b';
uvw(abs(uvw)<1e-6)=0;

rVectors = uvw*OldCrystal.a;
rVectors(abs(rVectors)<1e-10)=0;

end