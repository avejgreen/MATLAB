function perplot = Makeperplot(handles,fib)

%Breaks up fibers that extend beyond volume boundary, applies mod,
%generates plot data and indicates which fiber the plot portion came from

%Translate/rotate the fiber to its pos/dir in the mat
%Note that every fiber starts with its initial c axis starting at (0, -1,
%0)
fibrotaxis = cross(fib.longaxis,fib.matdir);
fibrotangle = norm(fibrotaxis)/(norm(fib.longaxis)*norm(fib.matdir));

plotpts = Rot3daxl([0;0;0],fibrotaxis,fibrotangle,fib.plot');

t = fib.matpos-plotpts(:,1);
T = kron(ones(1,size(plotpts,2)),t);
plotpts = plotpts+T;
plotpts = plotpts';

Lx = str2double(get(handles.editLx,'String'));
Ly = str2double(get(handles.editLy,'String'));
Lz = str2double(get(handles.editLz,'String'));

%Take mod of positions
plotpts(:,1) = mod(plotpts(:,1),Lx);
plotpts(:,2) = mod(plotpts(:,2),Ly);
plotpts(:,3) = mod(plotpts(:,3),Lz);

%Calculate distance between points. If this exceeds double the plot
%precision, the fiber has crossed a boundary.
dists = zeros(size(plotpts));
dists((2:end),:) = plotpts(2:end,:)-plotpts(1:end-1,:);
plotpts(:,4) = sqrt(dists(:,1).^2+dists(:,2).^2+dists(:,3).^2);
prec = str2double(get(handles.editplotprec,'String'));

perplot = struct;
perplot.fibnum = fib.number;
data = cell(1);

row = 1;
laststart = 1;
while row<size(plotpts,1)
    if plotpts(row,4)>2*prec
        data{end+1}=plotpts(laststart:row-1,1:3);
        laststart = row;
    end
    row = row+1;
end

data{end+1} = plotpts(laststart:end,1:3);
data(1) = [];

perplot.data = data;


