function SF = SFCalculator(OldCrystal)

%Calculate structure factor for each plane, remove zeros. Take the
%form factor to be the atomic number squared.
%   SF(hkl(plane)) = sum_atoms(f(atom)*exp(i*(hkl(plane).uvw(atom))

SF = exp(2i*pi*OldCrystal.hkl*cell2mat(OldCrystal.Atoms(:,3:5)'))*(cell2mat(OldCrystal.Atoms(:,1)).^2);
SF = SF.*conj(SF);
SF(SF<10)=0;

test = 1;

end