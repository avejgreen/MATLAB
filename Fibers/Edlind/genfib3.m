function [fibdat,crl,l]=genfib3(nseg,rvect,thetavect,alfavect,thetak1vect,thetak2vect)

%{

Subroutine used in gennetbeta and gennetlib
Generates one fibre

[fibdat,crl,l]=genfib3(nseg,rvect,thetavect,alfavect,kinkprob)

INPUT:
nseg        - number of segments
rvect       - vector containing segment radii
thetavect   - vector containing segment orientation angles
alfavect    - vector containing segment opening angles
kinkprob    - probability of kink between segments

OUTPUT:
fibdat  - vector containing radius of curvature,
          centre point, alfa1, alfa2, u and v for
          all fibre segments
crl     - fibre curl value
l       - fibre length

%}

fibdat=zeros(nseg,12);
outdir=[1 0 0];
n=[0 1 0];
l=0;
ep=[0 0 0];
tec=[0 1 0];

%--- generering av fibern ---
for segnr=1:nseg
    [fibdat(segnr,:),outdir,ep,n,tec]=genfibseg(ep,rvect(segnr),alfavect(segnr)...
        ,thetavect(segnr),thetak1vect(segnr),thetak2vect(segnr),outdir,tec,n);
end

%--- fiberdata ---
if nargout==3
    [crl,l]=curl(fibdat,20);
end
spep=ep;

% %--- centrering av fibern --- newc=ep/2;
for segnr=1:nseg
    fibdat(segnr,2:4)=fibdat(segnr,2:4)-newc;
end

%-------------------------------
fibn=cross(spep,[1 0 0]);
fibn=fibn./(sqrt(fibn*fibn'));
spep=spep./sqrt(spep*spep');
alfa=acos([1 0 0]*spep');

for i=1:nseg
    
    r=fibdat(i,1);
    c=fibdat(i,2:4);
    alfa1=fibdat(i,5);
    alfa2=fibdat(i,6);
    u=fibdat(i,7:9);
    v=fibdat(i,10:12);
    
    %steg 3
    fibdat(i,2:4)=rot3daxl(fibn,alfa,c);
    fibdat(i,7:9)=rot3daxl(fibn,alfa,u+c);
    fibdat(i,10:12)=rot3daxl(fibn,alfa,v+c);
    fibdat(i,7:9)=fibdat(i,7:9)-fibdat(i,2:4);
    fibdat(i,10:12)=fibdat(i,10:12)-fibdat(i,2:4);
    
    if i==1
        sp=c+r*(cos(alfa1)*u+sin(alfa1)*v);
    end
end %------------------------------------------------------------------



















