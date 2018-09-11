function fib = Genfib

% Generate a fiber from segments

% Initial beta parameters for nseg are 3.4
% Max segments = 10

% Initial beta parameters for kinks are [1,11]

% Initial beta parameters for rotation are 3.4

close all;
clear all;
clc;

% Plot fibers
% h=axes;
% axis equal;
% hold all;
% grid on;
% view(3);
% xlabel('x');
% ylabel('y');
% zlabel('z');
% cameratoolbar('NoReset');


%{
Test beta pdf for kink distribution

x = 0:.01:1;
A = betapdf(x,1,1);
B = betapdf(x,1,3);
C = betapdf(x,1,5);
D = betapdf(x,1,7);
E = betapdf(x,1,9);
F = betapdf(x,1,11);

plot(x,A,x,B,x,C,x,D,x,E,x,F);
%}


nsegbetaq = 5;
nsegbetar = 11;
maxseg = 50;

kink1betaq = 1;
kink1betar = 11;
kink2betaq = kink1betaq;
kink2betar = kink1betar;

swivalbetaq = 3.4;
swivalbetar = 3.4;

nseg = round(maxseg*betarnd(nsegbetaq,nsegbetar));
nseg(nseg==0)=1;

% Start the fiber with seg in x-z plane
segfield = Genfibseg(0,1);

for i = 1:nseg-1
    
    %         [plotpts,newplotpts] = Plotfib(fibdat);
    %         plot3(h,newplotpts(:,1),newplotpts(:,2),newplotpts(:,3),'LineWidth',2);
    
    %Generate new segment that points in the same direction as the last one
    %ends
    newfibseg = Genfibseg(segfield(i),0);
    
    %Swivel new segment
    swivel = 2*pi*betarnd(swivalbetaq,swivalbetar)-pi;
    newfibseg = Swivelseg(newfibseg,swivel);
    
    % Translate segment to start at the end of the last segment
    t = segfield(i).position(:,2)-newfibseg.position(:,1);
    T = [t,t,t];
    newfibseg.position = newfibseg.position+T;
    
    segfield(i+1) = newfibseg;
    
    test = 1;
end

%     [plotpts,newplotpts] = Plotfib(fibdat);
%     plot3(h,newplotpts(:,1),newplotpts(:,2),newplotpts(:,3),'LineWidth',2);

%Create fiber structure. Position and direction are taken from the first
%point of the first segment
fib = struct;
fib.segs = segfield;
fib.length = sum([segfield(:).length]);
fib.position = segfield(1).position(:,1);
fib.direction = segfield(1).vectors(:,1);
fib.plot = Plotfib(segfield);

test = 1;






