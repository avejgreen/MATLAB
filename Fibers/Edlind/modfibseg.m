function [segdatmod]=modfibseg(segdat,cutplanes,cut,bounds)

%{

Subroutine used in modfib
Modifies one fibre segment according to network boundaries

[segdatmod]=modfibseg(segdat,cutplanes,cut,bounds)

INPUT:
segdat      - vector containing radius of curvature,
              centre point, alfa1, alfa2, u and v
cutplanes   - matrix of planes to be controlled
              example: plane x=100 [1 0 0 100]
cut         - boolean vector: 1 if fibre is to be cut at actual plane
bounds      - network boundingbox widths [Lx Ly Lz]

OUTPUT:
segdatmod   - vector containing modified values for
              radius of curvature, centre point,
              alfa1, alfa2, u and v

%}

ind=2;
alfavect(1)=segdat(5);
alfavect(2)=segdat(6);

if cut==1
    for plane=1:size(cutplanes,1)
        [x1,x2,found]=cross_c_p3d(segdat,cutplanes(plane,1),cutplanes(plane,2),cutplanes(plane,3));
        if (found==1)
            [onarc,alfa]=isonarc(segdat,x1);
            if(onarc==1)
                ind=ind+1;
                alfavect(ind)=alfa;
            end
            [onarc,alfa]=isonarc(segdat,x2);
            if(onarc==1)
                ind=ind+1;
                alfavect(ind)=alfa;
            end
        end
    end
end

[alfavect]=asort3d(alfavect,ind);

for i=2:length(alfavect)
    shift=[0 0 0];
    
    if alfavect(i-1)>alfavect(i)
        alfac=alfavect(i-1)+.5*(2*pi-alfavect(i-1)+alfavect(i));
        if alfac>2*pi
            alfac=alfac-2*pi;
        end
    else
        alfac=alfavect(i-1)+.5*(alfavect(i)-alfavect(i-1));
    end
    
    p=segdat(2:4)+segdat(1)*(cos(alfac)*segdat(7:9)+sin(alfac)*segdat(10:12));
    shift(1)=bounds(1)*floor(p(1)/bounds(1));
    shift(2)=bounds(2)*floor(p(2)/bounds(2));
    shift(3)=bounds(3)*floor(p(3)/bounds(3));
    
    segdatmod(i-1,:)=segdat;
    segdatmod(i-1,2:4)=segdatmod(i-1,2:4)-shift;
    segdatmod(i-1,5)=alfavect(i-1);
    segdatmod(i-1,6)=alfavect(i);
end





