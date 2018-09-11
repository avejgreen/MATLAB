function Genmat

%Generate matrix from fiber structures

%Rho is length of fiber per volume.
rho = 3;

%Input the dimensions of the (rectangular) box.
Lx = 5;
Ly = 5;
Lz = 2;
matdims = [Lx;Ly;Lz];
matvol = prod(matdims);

%Generate fibers until the correct length is reached.
lengthtarget = round(matvol*rho);

fibmat = Genfib;
totfiblength = fibmat(1).length;

while totfiblength < lengthtarget;
    
    newfib = Genfib;
    fibmat(end+1) = newfib;
    totfiblength = totfiblength + newfib.length;
    
end

%Pick whether to use n fiber or n-1 fibers based on lengths
lengthn = totfiblength;
lengthnm1 = sum([fibmat(1:end-1).length]);

if abs(lengthn-lengthtarget)>abs(lengthtarget-lengthnm1)
    totfiblength = lengthnm1;
    fibmat=fibmat(1:end-1);
end

%Pick random positions, directions in the box. Apply to the fibers.
for i = 1:length(fibmat)
    
    pos = random('unif',0,1,3,1);
    pos = matdims.*pos;
    dir = random('unif',0,1,2,1);
    dir = [2*pi;pi].*dir;
    dir = [cos(dir(1))*sin(dir(2));sin(dir(1))*sin(dir(2));cos(dir(2))];
    
    %Want to align the fiber to its new direction. Must rotate plot field
    %around axis perp. to old, new directions.
    fibrotaxis = cross(dir,fibmat(i).direction);
    fibrotangle = norm(fibrotaxis)/(norm(dir)*norm(fibmat(i).direction));
    
    fibplot = fibmat(i).plot';
    fibplot = Rot3daxl([0;0;0],fibrotaxis,fibrotangle,fibplot);
    fibmat(i).plot = fibplot';
    
    fibmat(i).direction = dir;
    
    %Translate fib to chosen position
    fibplot = fibmat(i).plot';
    
    t = pos-fibmat(i).position;
    T = kron(ones(1,size(fibplot,2)),t);
    fibplot = fibplot+T;
    fibmat(i).plot = fibplot';
    
    fibmat(i).position = pos;
    
    
    test = 1;
    
end


%Draw matrix
h=axes;
hold all;
axis equal;
xlim([0,Lx]);
ylim([0,Ly]);
zlim([0,Lz]);
grid on;
view(3);
xlabel('x');
ylabel('y');
zlabel('z');
cameratoolbar('NoReset');

for i = 1:length(fibmat)
    
   plot3(h,fibmat(i).plot(:,1),fibmat(i).plot(:,2),fibmat(i).plot(:,3),...
       'LineWidth',2);
    
end



test = 1;
