function SimulatorMain

%Allows you to select crystals, define surface vectors, relative angles,
%get chi, phi, omega, 2theta
%Define phi=0 as substrate rel direction

close all;
clear all;
clc;

oldfolder = cd('/Users/averygreen/Documents/MATLAB/Projects/XRD/Diffraction5/Simulator');

%Load elemental information
A=fopen('ElementTable.csv');
ElementInfo=textscan(A,'%d%f%s%s%d%d%f%f%s%d%s%f','Delimiter',',');
fclose(A); clear A;
ElementInfo{12}(109) = ElementInfo{12}(108);

AllCrystals = struct;
error = 0; LayerNum=1;
while error == 0;
    
    [error,Name,a,b,S,Atoms] = XTLLoader(LayerNum);
    if error == 0
        AllCrystals(LayerNum).LayerNum = LayerNum;
        AllCrystals(LayerNum).Name=Name;
        AllCrystals(LayerNum).a=a;
        AllCrystals(LayerNum).b=b;
        AllCrystals(LayerNum).S=S;
        AllCrystals(LayerNum).Atoms=Atoms;
        clear Name a b S Atoms;
        
        test = 1;
        
        %Get available atoms, planes, and structure factors
        AllCrystals(LayerNum).Atoms = [num2cell(cellfun(@(x) find(strcmp(x,ElementInfo{4})),AllCrystals(LayerNum).Atoms(:,1))),AllCrystals(LayerNum).Atoms];
        [AllCrystals(LayerNum).hkl,AllCrystals(LayerNum).gVectors] = PlaneCalculator(AllCrystals(LayerNum));      
        AllCrystals(LayerNum).SF = SFCalculator(AllCrystals(LayerNum));
        
        %Define the surface vectors for each crystal, in HKL
        AllCrystals(LayerNum).SurfDir = SurfSelector(AllCrystals(LayerNum));
        test = 1;
        
        %Choose the notch direction, in HKL
        AllCrystals(LayerNum).NotchDir = NotchAligner(AllCrystals(LayerNum));
        test = 1;
        
        %Compute Chi, Phi, Bragg for each plane
        %Phi: need reference plane. Take from Notch UVW.
        test = 1;
        AllCrystals(LayerNum).Phi = PhiCalculator(AllCrystals(LayerNum));
        AllCrystals(LayerNum).Chi = ChiCalculator(AllCrystals(LayerNum));
        
        LayerNum = LayerNum+1;
        
    else
    end
    
end

if LayerNum > 1
    
    RSMSelection = RSMSelector(AllCrystals);
    
    [Phi,Chi] = CalculateRSMOrientation(RSMSelection,AllCrystals);
    
end

test = 1;

cd(oldfolder);

end








