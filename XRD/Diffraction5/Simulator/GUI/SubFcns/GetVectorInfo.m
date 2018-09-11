function VectorInfo = GetVectorInfo(Crystal)

%For each vector, want Phi, Om2T, OmRel info

Vector = Crystal.gVectorsAligned(Crystal.MeasPlaneNum,:);
ProjXY = [Vector(1),Vector(2),0];

lambda = 1.5406;
Om2T = asin(lambda*norm(Vector)/2);

if isequal(ProjXY,[0,0,0])
    Phi = 0;
    OmRel = 0;
else
    
    PhiCos = acos(ProjXY(1)/norm([ProjXY(1),ProjXY(2),0]));
    PhiSin = asin(ProjXY(2)/norm([ProjXY(1),ProjXY(2),0]));
    Phi = PhiCos;
    Phi(PhiSin<0) = 2*pi-PhiCos;
    Phi = Phi-pi/2;
    Phi(Phi>pi) = Phi-2*pi;
    
    Vector = Vector*RotMat('z',-Phi)';
    ProjXY = ProjXY*RotMat('z',-Phi)';
    
    % The vector is now in the +YZ plane, with Y non-negative. Find
    % Omega_rel, as measured from the x-axis. For z>0, Om_rel will be
    % between 0 and 90. For z<0, om_rel will be between 90 and 180.
    OmRel = acos(Vector(3)/norm(Vector));
    
end

VectorInfo = struct;
VectorInfo.Phi = Phi;
VectorInfo.Om2T = Om2T;
VectorInfo.OmRel = OmRel;
