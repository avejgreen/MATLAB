function [aAligned,bAligned,rVectorsAligned,gVectorsAligned] = Aligner(Crystal)


%% Find Phi value of gSurf
gSurf = Crystal.gVectors(Crystal.SurfDirNum,:);
ProjXYgSurf = [gSurf(1:2),0];

if isequal(ProjXYgSurf,[0,0,0])
    aAligned = Crystal.a;
    bAligned = Crystal.b;
    rVectorsAligned = Crystal.rVectors;
    gVectorsAligned = Crystal.gVectors;
else
    PhiCos = acos(ProjXYgSurf(1)/norm(ProjXYgSurf));
    PhiSin = asin(ProjXYgSurf(2)/norm(ProjXYgSurf));
    Phi = PhiCos;
    Phi(PhiSin<0) = 2*pi-Phi(PhiSin<0);
    
    %% Rotate all gVectors around z by -Phi
    aAligned = Crystal.a*RotMat('z',-Phi)';
    bAligned = Crystal.b*RotMat('z',-Phi)';
    rVectorsAligned = Crystal.rVectors*RotMat('z',-Phi)';
    gVectorsAligned = Crystal.gVectors*RotMat('z',-Phi)';
    
    gSurf = gSurf*RotMat('z',-Phi)';
end

%% Find Chi value of new gSurf
Chi = acos(gSurf(3)/norm(gSurf));

if Chi == 0
else
    %% Rotate all gVectors around y by -Chi
    aAligned = aAligned*RotMat('y',-Chi)';
    bAligned = bAligned*RotMat('y',-Chi)';
    rVectorsAligned = rVectorsAligned*RotMat('y',-Chi)';
    gVectorsAligned = gVectorsAligned*RotMat('y',-Chi)';
end

%% Find new Phi value of gNotch, project it to XY plane, align to x axis
gNotch = gVectorsAligned(Crystal.NotchDirNum,:);
ProjXYgNotch = [gNotch(1:2),0];

if isequal(ProjXYgNotch,[0,0,0]);
else
    PhiCos = acos(ProjXYgNotch(1)/norm(ProjXYgNotch));
    PhiSin = asin(ProjXYgNotch(2)/norm(ProjXYgNotch));
    Phi = PhiCos;
    Phi(PhiSin<0) = 2*pi-Phi(PhiSin<0);
    
    aAligned = aAligned*RotMat('z',-Phi)';
    bAligned = bAligned*RotMat('z',-Phi)';
    rVectorsAligned = rVectorsAligned*RotMat('z',-Phi)';
    gVectorsAligned = gVectorsAligned*RotMat('z',-Phi)';
end

