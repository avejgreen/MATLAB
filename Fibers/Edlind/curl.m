function [curl,length]=curl(fibre,prec)

%{

Subroutine used in genfib3
Calculates the curl of a fibre

[curl,length]=curl(fibre,prec)

INPUT:
fibre   - vector containing radius of curvature,
          centre point, alfa1, alfa2, u and v
prec    - precision of calculation, specifies the number of points
          along each segment controlled

OUTPUT:
curl    - curl value of fibre
length  - length of fibre

%}

nseg=size(fibre,1);
length=0;

for i=1:nseg
    alfa=fibre(i,6)-fibre(i,5);
    if alfa<0
        alfa=2*pi+alfa;
    end
    
    l=alfa*fibre(i,1);
    length=length+l;
end

n=1;
points(1,:)=fibre(1,2:4)+fibre(1,1)*(cos(fibre(1,5))*fibre(1,7:9)+sin(fibre(1,5))*f
for i=1:nseg
    alfa1=fibre(i,5);
    alfa2=fibre(i,6);
    for j=1:prec
        n=n+1;
        if alfa1>alfa2
            a2=alfa1+j*(2*pi-alfa1+alfa2)/prec;
            if a2>2*pi
                a2=a2-2*pi;
            end
        else
            a2=alfa1+j*(alfa2-alfa1)/prec;
        end
        points(n,:)=fibre(i,2:4)+fibre(i,1)*(cos(a2)*fibre(i,7:9)+sin(a2)*fibre(i,1
    end
end

lmax=0;
for i=1:n
    for j=i+1:n
        v=points(i,:)-points(j,:);
        l=sqrt(v*v');
        lmax=max(l,lmax);
    end
end

curl=length/lmax-1;





