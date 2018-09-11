function fib = Genfib(handles)

global betadists;

fieldnum=find(strcmp('N Segs',{betadists(:).name}));
nseg=betadists(fieldnum).min+...
    betadists(fieldnum).range*...
    betarnd(betadists(fieldnum).q,betadists(fieldnum).r);
nseg=round(nseg);
nseg(nseg<1)=1;

fieldnum=find(strcmp('Swivel Angle',{betadists(:).name}));
swivel=betadists(fieldnum).min+...
    betadists(fieldnum).range*...
    betarnd(betadists(fieldnum).q,betadists(fieldnum).r);

fieldnum=find(strcmp('Kink Angles',{betadists(:).name}));
kinks=betadists(fieldnum).min+...
    betadists(fieldnum).range*...
    betarnd(betadists(fieldnum).q,betadists(fieldnum).r,[2,1]);

% kink1betaq = 1;
% kink1betar = 11;
% kink2betaq = kink1betaq;
% kink2betar = kink1betar;

% Start the fiber with seg in x-z plane
segfield = Genfibseg(0,1);
segfield.plot = Plotfib(handles,segfield);

for i = 1:nseg-1
    
    %         [plotpts,newplotpts] = Plotfib(fibdat);
    %         plot3(h,newplotpts(:,1),newplotpts(:,2),newplotpts(:,3),'LineWidth',2);
    
    %Generate new segment that points in the same direction as the last one
    %ends
    newfibseg = Genfibseg(segfield(i),0);
    
    %Swivel new segment and kink if prob decrees
    newfibseg = Swivelseg(newfibseg,swivel);
    
    qkink = unifrnd(0,1);
    if qkink<str2double(get(handles.editkinkprob,'String'))
       newfibseg = Kinkseg(newfibseg,kinks(1),kinks(2));
    end
    
    % Translate segment to start at the end of the last segment
    t = segfield(i).position(:,2)-newfibseg.position(:,1);
    T = [t,t,t];
    newfibseg.position = newfibseg.position+T;
    
    newfibseg.plot = Plotfib(handles,newfibseg);
    
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
fib.plot = vertcat(segfield(:).plot);

%Specify fiber's pos, dir in mat
Lx = str2double(get(handles.editLx,'String'));
Ly = str2double(get(handles.editLy,'String'));
Lz = str2double(get(handles.editLz,'String'));
matdims = [Lx;Ly;Lz];
matpos = random('unif',0,1,3,1);

prec = str2double(get(handles.editplotprec,'String'));
matpos = prec+(matdims-2*prec).*matpos;

%Get theta from fiber direction beta dist. Phi is random
fieldnum=find(strcmp('Fib Dir',{betadists(:).name}));
matdir = [unifrnd(0,2*pi);betadists(fieldnum).range*...
    betarnd(betadists(fieldnum).q,betadists(fieldnum).r)];
matdir = [cos(matdir(1))*sin(matdir(2));sin(matdir(1))*sin(matdir(2));cos(matdir(2))];

fib.matpos = matpos;
fib.matdir = matdir;


%Get distances between all plot pts to find fib axis
dX = kron(fib.plot(:,1),ones(1,size(fib.plot,1)));
dX = dX-dX';
dY = kron(fib.plot(:,2),ones(1,size(fib.plot,1)));
dY = dY-dY';
dZ = kron(fib.plot(:,3),ones(1,size(fib.plot,1)));
dZ = dZ-dZ';
D = sqrt(dX.^2+dY.^2+dZ.^2);
[row,col] = find(D==max(max(D)),1);
fib.longaxis = fib.plot(row,:)-fib.plot(col,:);

test = 1;






