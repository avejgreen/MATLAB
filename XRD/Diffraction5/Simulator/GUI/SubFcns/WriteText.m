function WriteText(Vector1,Vector2,MeasPlane,AllCrystals)

%{

Write text to file. Want to have the following form.

Vectors
Material,Surface Plane,Notch Plane,Measurement Plane,Phi,Om2T,OmRel
Al2O3,(1 0 2),(0 1 0),(3 0 0),50,30,40
GaN,(0 1 1),(1 0 0),(1 1 1),20,60,50

Measurement Plane
Chi,Phi,Om2T Range,OmRelRange
20,30,[40 60],[20 30]

Start there. Can change later.

%}

%First, select the save file name, folder
oldfolder = cd('../');
[FileName,PathName,FilterIndex] = ...
    uiputfile('*.txt','Save Info','RSMInfo.txt');
cd(oldfolder);

File = fopen(horzcat(PathName,FileName),'a');
fprintf(File,'Vectors');
fprintf(File,'\nMaterial,Surface Plane,Notch Plane,Measurement Plane,Phi,Om2T,OmRel');

if ~isempty(AllCrystals(1).LayerNum)
    WriteVector(File,Vector1,AllCrystals,1);
end
if length(AllCrystals) == 2
    WriteVector(File,Vector2,AllCrystals,2);
end

if ~isempty(AllCrystals(1).LayerNum) && length(AllCrystals) == 2
    
fprintf(File,'\n\nMeasurement Plane');
fprintf(File,'\nChi,Phi,Om2T Range,OmRelRange');
fprintf(File,'\n%.2f,%.2f,[%.2f %.2f],[%.2f %.2f]',...
    -MeasPlane.Chi*180/pi,-MeasPlane.Phi*180/pi,...
    min(MeasPlane.BraggRange)*180/pi,...
    max(MeasPlane.BraggRange)*180/pi,...
    min(-MeasPlane.OmegaRange)*180/pi,...
    max(-MeasPlane.OmegaRange)*180/pi)

end

fclose(File)

test = 1;

end

function WriteVector(File,Vector,AllCrystals,i)

fprintf(File,'\n%s,[%d %d %d],[%d %d %d],[%d %d %d],%.2f,%.2f,%.2f',...
            AllCrystals(i).Name,...
            AllCrystals(i).hkl(AllCrystals(i).SurfDirNum,1),...
            AllCrystals(i).hkl(AllCrystals(i).SurfDirNum,2),...
            AllCrystals(i).hkl(AllCrystals(i).SurfDirNum,3),...
            AllCrystals(i).hkl(AllCrystals(i).NotchDirNum,1),...
            AllCrystals(i).hkl(AllCrystals(i).NotchDirNum,2),...
            AllCrystals(i).hkl(AllCrystals(i).NotchDirNum,3),...
            AllCrystals(i).hkl(AllCrystals(i).MeasPlaneNum,1),...
            AllCrystals(i).hkl(AllCrystals(i).MeasPlaneNum,2),...
            AllCrystals(i).hkl(AllCrystals(i).MeasPlaneNum,3),...
            -Vector.Phi*180/pi,Vector.Om2T*180/pi,Vector.OmRel*180/pi);
        
end