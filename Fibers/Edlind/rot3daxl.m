function [v]=rot3daxl(a,theta,u)

%{

Rotates the vector u theta radians around the axel a

INPUT:
a       - axel of rotation
theta   - angle of rotation
u       - vector to rotate

OUTPUT:
v       - rotated vector

%}

A=[0 a(3) -a(2);-a(3) 0 a(1);a(2) -a(1) 0];
R=eye(3)-sin(theta)*A+(1-cos(theta))*A^2;


% if nargin==3
    % v=R*u2';      -   u2 Error in code???
    v=R*u';
    v=v';
% elseif nargin==4
%   v2=R*u2';
%   v1=R*u1';
%   v=v2-v1;
%   v=v/sqrt(v'*v);
%   v=v?;
% end