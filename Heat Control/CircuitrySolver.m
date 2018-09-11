function CircuitrySolver

close all;
clear all;
clc;

Vt = 120;
syms Rs R2;

PVIRh = [30,NaN,NaN,288];
PVIRh = SolveComponent(PVIRh);

R2 = double(solve(Vt == PVIRh(2) + sqrt(0.1*R2)));
PVIR2 = [0.1,NaN,NaN,R2];
PVIR2 = SolveComponent(PVIR2);

solve(Vt*((2/PVIRh(4)+1/Rs)^-1+PVIR2(4))==2*PVIRh(3)+PVIRh(2)/Rs);
PVIRs = [0.1,PVIRh(2),NaN,NaN];
PVIRs = SolveComponent(PVIRs);

test = 1;

end

function PVIRout = SolveComponent(PVIRin)

PVIRin(2) = sqrt(PVIRin(1)*PVIRin(4));
PVIRin(3) = PVIRin(2)/PVIRin(4);
PVIRout = PVIRin;

end