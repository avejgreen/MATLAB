function newpts = Plotfib(handles,fibseg)

%Find length of arc
l = fibseg.radius*fibseg.phi;

%Get pts around every PRECISION GIVEN BY GUI dist. units, min start and end
prec = str2double(get(handles.editplotprec,'String'));
nnewpts = 1+round(l/prec);
nnewpts(nnewpts<2)=2;

%Make new pt matrix, populate first and last
newpts = zeros(nnewpts,3);
newpts(1,:) = fibseg.position(:,1)';
newpts(end,:) = fibseg.position(:,2)';

%Populate middle of new pt matrix
for j = 2:size(newpts,1)-1
    
    %Measure out along arc angle number of pts (and segments?)
    dphi = fibseg.phi/(nnewpts-1);
    
    %Rotate a pt starting at a around dc by dphi
    newpts(j,:) = Rot3daxl(fibseg.position(:,3),fibseg.vectors(:,3),...
        (j-1)*dphi,fibseg.position(:,1))';
    
    test = 1;
    
end

test = 1;


% plot3(pts(:,1),pts(:,2),pts(:,3),'LineWidth',2);
% axis equal;
