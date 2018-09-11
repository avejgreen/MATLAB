function [onarc,alfa]=isonarc3d(fibdat,x)

% Function used by modfib3d.m in program fibre3d.
% Onarc is true if the point (xyz) which is on the circle is
% also on the circle arc defined by center x0, radius r, and
% situated between angles alfa1, alfa2. Alfa is the angle of
% point x.

r=fibdat(1);
x0=fibdat(2:4)';
alfa1=fibdat(5);
alfa2=fibdat(6);
u=fibdat(7:9)';
v=fibdat(10:12)';

cxv=sum((x-x0).*v);
alfa=acos(sum((x-x0).*u)/r);
if (sign(cxv)<0)
    alfa=2*pi-alfa;
end

if (alfa1<alfa2)
    if((alfa1<alfa)&&(alfa<alfa2))
        onarc=1;
    else
        onarc=0;
    end
else
    if ((alfa>alfa1)||(alfa<alfa2))
        onarc=1;
    else
        onarc=0;
    end
end