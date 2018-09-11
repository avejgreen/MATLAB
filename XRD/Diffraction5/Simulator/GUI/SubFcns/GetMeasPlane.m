function [error,MeshX,MeshY,MeshZ,Chi,Phi,BraggRange,OmegaRange] = GetMeasPlane(Vector1,Vector2)

%{
1. get CP
2. Rotate CP to x-axis, mid V1,V2 to z-axis
3. Use 150% of the angle between the vectors for the scan
4. Use 150% of the difference of vector magnitudes for the scan
5. Rotate mesh to span vectors
%}

%1. get CP
CP = cross(Vector1,Vector2);

if isequal(CP,[0,0,0])
    CP = cross([0,0,1],Vector2);
    if isequal(CP,[0,0,0])
        %Normal function not possible. End.
        NormalFunction = 0;
        error = 1;
        MeshX = [];
        MeshY = [];
        MeshZ = [];
        Chi = 0;
        Phi = 0;
        
        OmegaRange = [0,0];
        MagMid = mean([norm(Vector1),norm(Vector2)]);
        MagDiff = abs(norm(Vector2)-norm(Vector1));
        MagRange = linspace(MagMid-MagDiff/2,MagMid+MagDiff/2,2);
        lambda = 1.5406;
        BraggRange = asin(lambda*MagRange/2);
        
    else
        %Use altered CP, and continue as normal
        NormalFunction = 1;
    end
else
    %Normal Function. Continue.
    NormalFunction = 1;
    
end

if NormalFunction
    
    AllVectors = [Vector1;Vector2;CP];
    
    %2. Rotate CP to x-axis, mid V1,V2 to z-axis
    %{
3 CP ROTATIONS:
1. ROTATE AROUND Z S.T. CP IS IN X-Y PLANE
2. ROTATE AROUND Y S.T. CP IS ALONG X-AXIS
3. ROTATE AROUND X S.T. THE MIDLINE IS ALONG Z-AXIS

1. GIVES PHI
2. GIVES CHI
3. GIVES MIDDLE OMEGA
    %}
    
    PhiCos = acos(CP(1)/norm([CP(1),CP(2),0]));
    PhiSin = asin(CP(2)/norm([CP(1),CP(2),0]));
    Phi = PhiCos;
    Phi(PhiSin<0) = -PhiCos;
    
    
    AllVectors = AllVectors*RotMat('z',-Phi)';
    
    Chi = acos(AllVectors(3,3)/norm(AllVectors(3,:)))-pi/2;
    
    AllVectors = AllVectors*RotMat('y',-Chi)';
    
    %Use omega = pi/2 gives z axis, go there.
    Omega1Cos = acos(AllVectors(1,2)/norm(AllVectors(1,:)));
    Omega1Sin = asin(AllVectors(1,3)/norm(AllVectors(1,:)));
    Omega1 = Omega1Cos;
    Omega1(Omega1Sin<0) = 2*pi-Omega1Cos;
    
    Omega2Cos = acos(AllVectors(2,2)/norm(AllVectors(2,:)));
    Omega2Sin = asin(AllVectors(2,3)/norm(AllVectors(2,:)));
    Omega2 = Omega2Cos;
    Omega2(Omega2Sin<0) = 2*pi-Omega2Cos;
    
    %Make Omega2 greater than Omega1
    Omega2(Omega2<Omega1) = Omega2+2*pi;
    
    %Get mean position (positive), align to z-axis, change domain.
    OmegaMid = mod(mean([Omega1,Omega2]),2*pi);
    OmegaMid = OmegaMid-pi/2;
    OmegaMid(OmegaMid>pi) = OmegaMid-2*pi;
    
    AllVectors = AllVectors*RotMat('x',-OmegaMid)';
    
    OmegaDiff = mod(Omega2-Omega1,pi);
    MagMid = mean([norm(Vector1),norm(Vector2)]);
    MagDiff = abs(norm(Vector2)-norm(Vector1));
    
    if or(OmegaDiff<1e-6,MagDiff<1e-6)
        
        error = 1;
        MeshX = [];
        MeshY = [];
        MeshZ = [];
        
        OmegaRange = linspace(OmegaMid-OmegaDiff/2,OmegaMid+OmegaDiff/2,ceil(OmegaDiff*180/pi));
        MagRange = linspace(MagMid-MagDiff/2,MagMid+MagDiff/2,2);
        lambda = 1.5406;
        BraggRange = asin(lambda*MagRange/2);
        
        
    else
        error = 0;
        
        OmegaRange = linspace(OmegaMid-OmegaDiff/2,OmegaMid+OmegaDiff/2,ceil(OmegaDiff*180/pi));
        MagRange = linspace(MagMid-MagDiff/2,MagMid+MagDiff/2,2);
        
        lambda = 1.5406;
        BraggRange = asin(lambda*MagRange/2);
        
        MeshX = zeros(length(MagRange),length(OmegaRange));
        MeshY = zeros(length(MagRange),length(OmegaRange));
        MeshZ = ones(length(MagRange),length(OmegaRange));
        
        Mesh = zeros(length(MagRange),length(OmegaRange),3);
        Mesh(:,:,1) = MeshX;
        Mesh(:,:,2) = MeshY;
        Mesh(:,:,3) = MeshZ;
        
        %Generate x rotation matrices and mag scaler
        
        for i = 1:length(MagRange)
            Mesh(i,:,:) =  Mesh(i,:,:) * MagRange(i);
        end
        
        Mesh = permute(Mesh,[3,1,2]);
        
        for i = 1:length(OmegaRange)
            Mesh(:,:,i) = RotMat('x',OmegaRange(i)-OmegaMid)*Mesh(:,:,i);
        end
        
        % Rotate mesh back by OmegaMid, Chi, Phi
        for i = 1:length(OmegaRange)
            Mesh(:,:,i) = RotMat('z',Phi)*RotMat('y',Chi)*RotMat('x',OmegaMid)*Mesh(:,:,i);
        end
        
        Mesh = permute(Mesh,[2,3,1]);
        MeshX = Mesh(:,:,1);
        MeshY = Mesh(:,:,2);
        MeshZ = Mesh(:,:,3);
        
    end
    
end



