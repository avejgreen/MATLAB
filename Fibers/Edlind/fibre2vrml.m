function fibre2vrml(filename,fibdat,prec,t)

%{

Exports fibre network geometry to vrml file format

fibre2vrml(filename,fibdat,prec,t)

INPUT:
filename    - location and name of exported file
fibdat      - vector containing radius of curvature
              centre point, alfa1, alfa2, u and v for the network
prec        - number of straight lines to represent one fibre segment
t           - diameter of the fibres circular cross-section

%}

nfibs=size(fibdat,1);
narcs=size(fibdat,2);


%------------------------------
%---- VRML post processing ----
%------------------------------

options = [0]; % No global transform;

%-----------------------------------
%---- Create model for geometry ----
%-----------------------------------

fid=vrmlcreate(filename,options);

%---- Define geometry

vrmlbegin(fid,'Transform');
vrmlbeginarr(fid,'children');
%---- Define circular cross section

i=0;
for angle=0:pi/5:2*pi
    i=i+1;
    sec(i,1)=t*cos(angle);
    sec(i,2)=t*sin(angle);
end

for fib=1:nfibs
    n=0;
    for arc=1:narcs
        r=fibdat(fib,arc,1);
        c=fibdat(fib,arc,2:4);
        alfa1=fibdat(fib,arc,5);
        alfa2=fibdat(fib,arc,6);
        u=fibdat(fib,arc,7:9);
        v=fibdat(fib,arc,10:12);
        
        if r==0
            break
        end
        
        for i=1:prec
            n=n+1;
            if alfa1>alfa2
                a2=alfa1+i*(2*pi-alfa1+alfa2)/prec;
                if a2>2*pi
                    a2=a2-2*pi;
                end
            else
                a2=alfa1+i*(alfa2-alfa1)/prec;
            end
            points(n,:)=c+r*(cos(a2)*u+sin(a2)*v);
        end
    end
    
    vrmlextrusion(fid,points(1:n,:),sec);
end
vrmlendarr(fid);
vrmlend(fid);

vrmlclose(fid,options);






