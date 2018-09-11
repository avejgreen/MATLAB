function Chi= ChiCalculator(OldCrystal)

%{
Find Chi values for all planes.
1. Calculate the g vector from the surfdir
4. Calculate Chi.
%}

gSurf = double(OldCrystal.SurfDir)*OldCrystal.b;

Chi = (180/pi)*acos((OldCrystal.gVectors(:,1:3)*gSurf')./(sqrt(sum(OldCrystal.gVectors(:,1:3).^2,2))*norm(gSurf)));

test = 1;

end