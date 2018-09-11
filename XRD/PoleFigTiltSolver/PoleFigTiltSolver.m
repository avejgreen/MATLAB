function PoleFigTiltSolver

close all;
clear all;
clc;

syms d Theta0 Phi0 ThetaM1 PhiM1 ThetaM2 PhiM2 ThetaM3 PhiM3 q1 q2 q3;

V01 = d*[cos(Phi0)*sin(Theta0),sin(Phi0)*sin(Theta0),cos(Theta0)]';
V0 = [V01,R('z',2*pi/3)*V01,R('z',4*pi/3)*V01];

VM = d*[cos(PhiM1)*sin(ThetaM1),sin(PhiM1)*sin(ThetaM1),cos(ThetaM1);...
    cos(PhiM2)*sin(ThetaM2),sin(PhiM2)*sin(ThetaM2),cos(ThetaM2);...
    cos(PhiM3)*sin(ThetaM3),sin(PhiM3)*sin(ThetaM3),cos(ThetaM3)]';

[q1A,q2A,q3A] = solve(VM==R('z',q3)*R('y',q2)*R('z',q1)*V0,[q1,q2,q3]);

[q1A,q2A,q3A] = [S.x S.y];

function RotMat = R(Axis,Theta)

switch Axis
    case 'x'
        RotMat = [1,0,0;0,cos(Theta),-sin(Theta);0,sin(Theta),cos(Theta)];
    case 'y'
        RotMat = [cos(Theta),0,sin(Theta);0,1,0;-sin(Theta),0,cos(Theta)];
    case 'z'
        RotMat = [cos(Theta),-sin(Theta),0;sin(Theta),cos(Theta),0;0,0,1];
    otherwise
        RotMat = 'Error. Axis input must be x, y, or z';
end
