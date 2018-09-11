function [x1,x2,found]=cross_c_p3d(fibdat,A,B,C,D)

% Function used by modfib3d in program fibre3d.
% Calculate crossings of a plane and a circle in space. % Circle x(theta)=c+r*cos(theta)*u+r*sin(theta)*v
% Plane ax+by+cz+d=0
% u and v must be of length 1.
% Susanne Heyden 970911

r=fibdat(1);
c=fibdat(2:4);
u=fibdat(7:9);
v=fibdat(10:12);

found=1;
x1=-1;
x2=-1;

c1=A*r*u(1)+B*r*u(2)+C*r*u(3);
c2=A*r*v(1)+B*r*v(2)+C*r*v(3);
c3=A*c(1)+B*c(2)+C*c(3)+D;
c4=sqrt(c1^2+c2^2);


%If plane and plane of circle are parallel
if (abs(c4)<(r/20))
    found=0;
    %break
    return
end

if (c2/c4>0)
    phi=asin(c1/c4);
elseif (c1/c4>0)
    phi=acos(c2/c4);
else
    phi=acos(c2/c4)-2*asin(c1/c4);
end

theta1=asin(-c3/c4)-phi;
theta2=pi-asin(-c3/c4)-phi;


%If no crossings
if (abs(imag(theta1))>0)
    found=0;
    %break
    return
end

%If circle is tangent to plane
if (abs(theta1-theta2)<0.01)
    found=0;
    %break
    return
end

x1=zeros(3,1);
x1(1)=c(1)+r*cos(theta1)*u(1)+r*sin(theta1)*v(1);
x1(2)=c(2)+r*cos(theta1)*u(2)+r*sin(theta1)*v(2);
x1(3)=c(3)+r*cos(theta1)*u(3)+r*sin(theta1)*v(3);
diff1=A*x1(1)+B*x1(2)+C*x1(3)+D;

x2=zeros(3,1);
x2(1)=c(1)+r*cos(theta2)*u(1)+r*sin(theta2)*v(1);
x2(2)=c(2)+r*cos(theta2)*u(2)+r*sin(theta2)*v(2);
x2(3)=c(3)+r*cos(theta2)*u(3)+r*sin(theta2)*v(3);
diff2=A*x2(1)+B*x2(2)+C*x2(3)+D;







