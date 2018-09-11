function v=Rot3daxl(axor,axdir,theta,pts)

%pt has to be in COLUMN form

%{
1. Translate rotation center to 0
2. Rotate rot axis to x-z plane
3. Rotate rot axis to z-axis
4. Rotate pt around rot axis
5. Inverse 3
6. Inverse 2
7. Inverse 1
%}

d1 = zeros(3,size(pts,2));
d1(:,2:end) = pts(:,2:end)-pts(:,1:end-1);
d1 = sqrt(d1(1,:).^2+d1(2,:).^2+d1(3,:).^2);

axdir = axdir/norm(axdir);

C = cos(theta);
S = sin(theta);
U = [0,-axdir(3),axdir(2);...
    axdir(3),0,-axdir(1);...
    -axdir(2),axdir(1),0];

R = eye(4);
R(1:3,1:3) = C*eye(3)+S*U+(1-C)*kron(axdir,axdir');

T=eye(4);
T(1,4)=-axor(1);
T(2,4)=-axor(2);
T(3,4)=-axor(3);

pt1 = T\R*T*[pts;ones(1,size(pts,2))];
v = pt1(1:3,:);

d2 = zeros(3,size(v,2));
d2(:,2:end) = v(:,2:end)-v(:,1:end-1);
d2 = sqrt(d2(1,:).^2+d2(2,:).^2+d2(3,:).^2);

ds = [d1;d2];

test = 1;



% 
% axdir = axdir/norm(axdir);
% % a = axdir(1);
% % b = axdir(2);
% % c = axdir(3);
% % d = norm([0,b,c]);
% 
% a = axdir;
% b = cross(a,[a(1),0,0]);
% b = b/norm(b);
% c = cross(b,a);
% R = [c';b';a';[0,0,0]];
% R = [R,[0;0;0;1]];
% 
% % Rx = [1,0,0,0;
% %     0,c/d,-b/d,0;
% %     0,b/d,c/d,0;
% %     0,0,0,1];
% % 
% % Ry = [d,0,-a,0;
% %     0,1,0,0;
% %     a,0,d,0;
% %     0,0,0,1];
% % 
% Rz = [cos(theta),-sin(theta),0,0;
%     sin(theta),cos(theta),0,0;
%     0,0,1,0;
%     0,0,0,1];
% 
% % pt1 = inv(T)*inv(Rx)*inv(Ry)*Rz*Ry*Rx*[pt;ones(1,size(pt,2))];
% pt1 = inv(T)*inv(R)*Rz*R*[pt;ones(1,size(pt,2))];
% 
% 
% v = pt1(1:3,:);

