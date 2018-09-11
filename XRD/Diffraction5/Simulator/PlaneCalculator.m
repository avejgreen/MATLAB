function [hkl,gVectors] = PlaneCalculator(OldCrystal)

%Get allowed diffraction planes. First get list of measurable planes
%with lambda = 1.5406 A, braggmax = 50deg. use (dmin,gmax) = (1,1)
lambda = 1.5406;
braggmax = 50*pi/180;
dmin = lambda/(2*sin(braggmax));
gmax = 1/dmin;

hmax = ceil(gmax/norm(OldCrystal.b(1,:)));
kmax = ceil(gmax/norm(OldCrystal.b(2,:)));
lmax = ceil(gmax/norm(OldCrystal.b(3,:)));

h = linspace(-4*hmax,4*hmax,8*hmax+1)';
k = linspace(-4*kmax,4*kmax,8*kmax+1)';
l = linspace(-4*lmax,4*lmax,8*lmax+1)';

hkl = zeros(length(h)*length(k)*length(l),3);
for m = 1:length(h)
    for n = 1:length(k)
        hkl(length(k)*length(l)*(m-1)+length(l)*(n-1)+1:...
            length(k)*length(l)*(m-1)+length(l)*(n-1)+length(l),:) = ...
            [ones(length(l),1)*h(m),ones(length(l),1)*k(n),l];
    end
end

gVectors = hkl*OldCrystal.b;
gVectors(:,4) = sqrt(sum(gVectors.^2,2));
gVectors(abs(gVectors)<1e-10)=0;


hkl(gVectors(:,4)>gmax,:)=[];
gVectors(gVectors(:,4)>gmax,:)=[];

end