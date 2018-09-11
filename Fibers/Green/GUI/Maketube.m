function tube = Maketube(handles,plotpts)

test = 1;

global betadists;

%Get radius. Put a point every 30 deg.
fieldnum=find(strcmp('Fib Radius',{betadists(:).name}));
fibrad=betadists(fieldnum).min+...
    betadists(fieldnum).range*...
    betarnd(betadists(fieldnum).q,betadists(fieldnum).r);

test = 1;

%Delete duplicate plotpts
pts = unique(plotpts,'rows','stable');

%Get ring vector at each pt
vectors = zeros(size(pts));
vectors(1,:) = pts(2,:)-pts(1,:);
vectors(end,:) = pts(end,:)-pts(end-1,:);
for i = 2:size(vectors,1)-1
    vectors(i,:) = pts(i+1,:)-pts(i-1,:);
end
vnorms = sqrt(vectors(:,1).^2+vectors(:,2).^2+vectors(:,3).^2);
for i = 1:3
   vectors(:,i) = vectors(:,i)./ vnorms;
end


test = 1;

%Generate first ring of pts
% tube = zeros(12*size(pts,1),3);

nring=12;
nring = nring+1;
ring = zeros(nring,3);

tubeX = zeros(size(pts,1),nring);
tubeY = tubeX;
tubeZ = tubeX;


fieldnum=find(strcmp('Fib Radius',{betadists(:).name}));
ringrad=betadists(fieldnum).min+...
    betadists(fieldnum).range*...
    betarnd(betadists(fieldnum).q,betadists(fieldnum).r);

for k = 0:nring-1
    ring(k+1,:) = ringrad*[cos(k*2*pi/(nring-1)),sin(k*2*pi/(nring-1)),0];
end

ringdir = [0,0,1];

%Move ring to plot pts, rotate to vectors
test = 1;
for i = 1:size(pts,1)
    if all(vectors(i,:)==ringdir)
        tempring = ring;
    else
        axdir = cross(ringdir,vectors(i,:));
        theta = acos(dot(ringdir,vectors(i,:)));
        tempring = Rot3daxl([0;0;0],axdir',theta,ring');
        tempring = tempring';
    end
    
    T = kron(pts(i,:),ones(nring,1));
    tempring = tempring + T;
    
    tubeX(i,:) = tempring(:,1)';
    tubeY(i,:) = tempring(:,2)';
    tubeZ(i,:) = tempring(:,3)';
    
    %     tube(nring*(i-1)+1:nring*i,:) = tempring+T';
end

%Generate spherical end caps
[capX,capY,capZ] = sphere(nring-1);
capX = ringrad*capX;
capY = ringrad*capY;
capZ = ringrad*capZ;

tempcap = cat(3,capX,capY,capZ);
midcap = (nring+1)/2;
botcap = tempcap(1:floor(midcap),:,:);
topcap = tempcap(ceil(midcap):end,:,:);

botveccap = zeros(numel(botcap(:,:,1)),3);
topveccap = zeros(numel(topcap(:,:,1)),3);
for i = 1:midcap
    botveccap(1+(i-1)*nring:i*nring,:) = permute(botcap(i,:,:),[2,3,1]);
    topveccap(1+(i-1)*nring:i*nring,:) = permute(topcap(i,:,:),[2,3,1]);
end


%Rotate the caps to start and end vectors
%Rotate the cap 180 deg. first. It's backward.
capdir = ringdir;

botveccap = Rot3daxl([0;0;0],capdir,pi,botveccap');
botveccap = botveccap';
topveccap = Rot3daxl([0;0;0],capdir,pi,topveccap');
topveccap = topveccap';

if all(vectors(1,:)==capdir)
else
    axdir = cross(capdir,vectors(1,:));
    theta = acos(dot(capdir,vectors(1,:)));
    botveccap = Rot3daxl([0;0;0],axdir',theta,botveccap');
    botveccap = botveccap';
end

if all(vectors(end,:)==capdir)
else
    axdir = cross(capdir,vectors(end,:));
    theta = acos(dot(capdir,vectors(end,:)));
    topveccap = Rot3daxl([0;0;0],axdir',theta,topveccap');
    topveccap = topveccap';
end

%Shift caps to start and end pts of fib
botveccap = botveccap+kron(pts(1,:),ones(size(botveccap,1),1));
topveccap = topveccap+kron(pts(end,:),ones(size(topveccap,1),1));


tubeX = [zeros(midcap,nring);tubeX;zeros(midcap,nring)];
tubeY = [zeros(midcap,nring);tubeY;zeros(midcap,nring)];
tubeZ = [zeros(midcap,nring);tubeZ;zeros(midcap,nring)];
for i = 1:size(botcap,1)
    tubeX(i,:) = botveccap(1+(i-1)*nring:i*nring,1);
    tubeX(end-size(botcap,1)+i,:) = topveccap(1+(i-1)*nring:i*nring,1);
    tubeY(i,:) = botveccap(1+(i-1)*nring:i*nring,2);
    tubeY(end-size(botcap,1)+i,:) = topveccap(1+(i-1)*nring:i*nring,2);
    tubeZ(i,:) = botveccap(1+(i-1)*nring:i*nring,3);
    tubeZ(end-size(botcap,1)+i,:) = topveccap(1+(i-1)*nring:i*nring,3);
end

tube.X = tubeX;
tube.Y = tubeY;
tube.Z = tubeZ;

test = 1;



