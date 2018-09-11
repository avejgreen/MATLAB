function [fibdat]=place(fibdat,fibdir,mp)

%{
Places one fibre into a network

[fibdat]=place(fibdat,fibdir,mp)

INPUT:
fibdat  - vector containing radius of curvature,
          centre point, alfa1, alfa2, u and v for the fibre
fibdir  - specified orientation of the fibre in the network
mp      - specified midpoint of fibre in network

OUTPUT:
fibdat  - modified fibre data

%}

nseg=size(fibdat,1);
fibdir=fibdir/sqrt(fibdir*fibdir');
fibn=cross(fibdir,[1 0 0]); %normal till planet som spa ?nns upp av fiberns o ?nskade
fibn=fibn/sqrt(fibn*fibn');
alfa=-acos(fibdir*[1 0 0]');
beta=rand*2*pi;

%steg 1
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
    
    %Tranposing of ceter points
    fibdat(i,2:4)=fibdat(i,2:4)+mp;
    
    %Random rotation around own axis
    fibdat(i,2:4)=rot3daxl(fibdir,beta,fibdat(i,2:4));
    fibdat(i,7:9)=rot3daxl(fibdir,beta,fibdat(i,7:9));
    fibdat(i,10:12)=rot3daxl(fibdir,beta,fibdat(i,10:12));
    
end