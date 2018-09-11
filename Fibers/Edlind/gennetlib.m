function [netdat]=gennetlib(bounds,nfib,fiblib,fibpart,fphi1,fphi2)

%{

Generates periodic fibre network

[netdat]=gennetlib(bounds,nfib,fiblib,fibpart,fphi1,fphi2)

INPUT:
bounds      - network boundingbox widths [Lx Ly Lz]
nfib        - number of fibres
fiblib      - library of fibres to be placed into the network
              dim: [number of fibretypes, 12]
fibpart     - part of network using fibretype (index)
              sum(fibpart)=1

Distribution inputs, for beta distribution [a b q] where
a and b are lower resp. upper limits and r=q (symmetric)

fphi1   - distribution of fibreorientation angle phi1
fphi2   - distribution of fibreorientation angle phi2

OUTPUT:
netdat  - 3d matrix containing radius of curvature,
          centre point, alfa1, alfa2, u and v for all
          fibres dim: [nfib nseg 12]

%}

fib=0;
n=1;
h=waitbar(0,'Generating Network. Please wait...');

for fibtypenr=1:size(fiblib,1)
    
    for fibnr=1:round(fibpart(fibtypenr)*nfib)
        fib=fib+1;
        waitbar(fib/nfib);
        mp=[rand*bounds(1) rand*bounds(2) rand*bounds(3)];
        phi1=betarnd(fphi1(2),fphi1(2))*fphi1(1);
        phi2=betarnd(fphi2(2),fphi2(2))*fphi2(1);
        fibdir=rot3daxl([0 1 0],phi1,[1 0 0]);
        fibdir=rot3daxl([0 0 1],phi2,fibdir);
        [fibdat]=place(squeeze(fiblib(fibtypenr,:,:)),fibdir,mp);
        [fibdatmod]=modfib(fibdat,bounds);
        
        for i=1:size(fibdatmod,1)
            netdat(n,:,:)=fibdatmod(i,:,:);
            n=n+1;
        end
    end
end

% rho=sum(length)/prod(bounds);
close(h);