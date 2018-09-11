function [planes,cut]=cuttingplanes(segdat,bounds)

%{

Returns the planes that a fibre segment passes through

[planes, cut]=cuttingplanes(segdat,bounds)

INPUT:
segdat  - vector containing radius of curvature,
          centre point, alfa1, alfa2, u and v for the segment
bounds  - vector containing unit cell dimensions in x, y, and z

OUTPUT:
planes  - passed planes, in the form [1 0 0 100] (meaning the plane
          x=100)
cut     - vector of the same length as planes. Value 1 if the plane is to
          be cut, otherwise 0

%}

r=segdat(1);
c=segdat(2:4);
alfa1=segdat(5);
alfa2=segdat(6);
u=segdat(7:9);
v=segdat(10:12);

seg=20;
index=0;
index2=0;
index3=0;
cut=1;

for i=0:seg
    if alfa1>alfa2
        alfa=alfa1+i*(2*pi-alfa1+alfa2)/seg;
        if alfa>2*pi
            alfa=alfa-2*pi;
        end
    else
        alfa=alfa1+i*(alfa2-alfa1)/seg;
    end
    p=c+r*(cos(alfa)*u+sin(alfa)*v);
    for j=1:3
        boxtemp(j)=floor(p(j)/bounds(j));
    end
    if i==0
        index=index+1;
        box(index,:)=boxtemp;
    elseif sum(box(index,:)~=boxtemp)~=0
        index=index+1;
        box(index,:)=boxtemp;
    end
    for j=1:index-1
        a=box(j,1:3)~=box(j+1,1:3);
        if a(1)==1
            index3=index3+1;
            planetemp(index3,:)=[1 0 0 max(box(j,1),box(j+1,1))*bounds(1)];
        end
        if a(2)==1
            index3=index3+1;
            planetemp(index3,:)=[0 1 0 max(box(j,2),box(j+1,2))*bounds(2)];
        end
        if a(3)==1
            index3=index3+1;
            planetemp(index3,:)=[0 0 1 max(box(j,3),box(j+1,3))*bounds(3)];
        end
        for j=1:index3
            if exist('planes','var')==0
                index2=index2+1;
                planes(index2,:)=planetemp(index3,:);
            else
                add=0;
                for s=1:index2
                    if sum(planes(s,:)==planetemp(index3,:))==4
                        add=1;
                    end
                end
                if add==0
                    index2=index2+1;
                    planes(index2,:)=planetemp(index3,:);
                end
            end
        end
    end
end
if exist('planes','var')==0
    planes=0;
    cut=0;
end











