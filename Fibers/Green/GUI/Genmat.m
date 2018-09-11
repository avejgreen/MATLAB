function Genmat(handles)

global mat;

%Generate matrix from fiber structures

%Rho is length of fiber per volume.
rho = str2double(get(handles.editrho,'String'));

%Input the dimensions of the (rectangular) box.
Lx = str2double(get(handles.editLx,'String'));
Ly = str2double(get(handles.editLy,'String'));
Lz = str2double(get(handles.editLz,'String'));

matdims = [Lx;Ly;Lz];
matvol = prod(matdims);

%Generate fibers until the correct length is reached.
lengthtarget = round(matvol*rho);

if isempty(mat)
    cumlengths = 0;
else
    cumlengths = [mat.fibs(:).length];
    for i = 2:length(mat.fibs)
        cumlengths(i) = cumlengths(i)+cumlengths(i-1);
    end
end

%Assuming there's not enough fiber, generate more until there's enough
if cumlengths(end) < lengthtarget
    
    hwait = waitbar(cumlengths(end)/lengthtarget,'Generating Matrix');
    
    while cumlengths(end) < lengthtarget;
        
        fib = Genfib(handles);
        
        if isempty(mat)
            fib.number = 1;
            
            mat.fibs = fib;
            mat.length = fib.length;
            %Mat plot is structure containing fib number and plot data
            mat.plot = Makematplot(handles,fib);
            %         mat.plot = Makeperplot(handles,fib);
        else
            fib.number = length(mat.fibs)+1;
            
            mat.fibs(end+1) = fib;
            mat.length = sum([mat.fibs(:).length]);
            mat.plot(end+1) = Makematplot(handles,fib);
            %         mat.plot(end+1) = Makeperplot(handles,fib);
        end
        
        cumlengths(end+1) = mat.length;
        
        hwait = waitbar(cumlengths(end)/lengthtarget,...
            hwait,'Generating Matrix');
        
    end
    
end

close(hwait);

if cumlengths(1)==0
    cumlengths(1)=[];
end

%See which cumlength gets closeset to target
nfib = find(min(abs(cumlengths-lengthtarget))==...
    abs(cumlengths-lengthtarget));

%Only keep up to nfib.
mat.fibs = mat.fibs(1:nfib);
mat.length = cumlengths(nfib);
mat.plot = mat.plot(1:nfib);


test = 1;











