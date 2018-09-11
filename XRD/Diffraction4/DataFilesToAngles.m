function AllAngles = DataFilesToAngles

% close all;
% clear all;
% clc;

olddir = cd('/Users/averygreen/Documents/CNSE/Diebold Lab/Data/070816_SB1/PoleFig2');
[FileName, PathName] = uigetfile('*.X01','MultiSelect','on');
cd(olddir);

AllAngles = [0,0,0,0,0];

%Check out scans. See what axis and unit are used. Select for angle
%analysis protocol
FileID = fopen(strcat(PathName,FileName{1}));
TestText = textscan(FileID, '%s', 10, 'Delimiter', '\n');
fclose(FileID);
TestText = textscan(TestText{1}{9}, '%s');

if strcmp(TestText{1}{1}, 'Time:')
    %Recipe exists in single scans. Don't add any extra header lines
    ExtraHeaders = 0;
elseif strcmp(TestText{1}{1}, 'Loop')
    %Recipe exists as a loop. Add 2 extra header lines
    ExtraHeaders = 2;
end

NewFile = importdata(strcat(PathName,FileName{1}), ' ', 59+ExtraHeaders);

%%% GET ALL SCAN AXIS INFORMATION

ScanAxis = textscan(NewFile.textdata{10+ExtraHeaders}, '%*s %*s %s %*s %*s %*s');
ScanAxis = ScanAxis{1}{1};
ScanUnit = textscan(NewFile.textdata{11+ExtraHeaders}, '%*s %*s %*f %s');
ScanUnit = ScanUnit{1}{1};

switch ScanUnit   
    case 'sec'       
        ScanUnitConstant = 1/3600;     
    case 'deg'      
        ScanUnitConstant = 1;
end

switch ScanAxis
    
    case 'Omega-2Theta'
        for FileNo = 1:size(FileName,2)
            [NewFile, NewAngles] = ImportDataAngles(FileNo, FileName, PathName, ExtraHeaders);
            NewAngles(:,1) = NewAngles(:,1) + 2*(NewFile.data(:,1)-NewFile.data(1,1)*ones(size(NewAngles,1),1))*ScanUnitConstant;
            NewAngles(:,2) = NewAngles(:,2) + (NewFile.data(:,1)-NewFile.data(1,1)*ones(size(NewAngles,1),1))*ScanUnitConstant;
            NewAngles(:,5) = NewFile.data(:,2);
            AllAngles = [AllAngles;NewAngles];
        end
        
    case 'Omega_Rel'
        for FileNo = 1:size(FileName,2)
            [NewFile, NewAngles] = ImportDataAngles(FileNo, FileName, PathName, ExtraHeaders);
            NewAngles(:,2) = NewAngles(:,2) + NewFile.data(:,1)*ScanUnitConstant;
            NewAngles(:,5) = NewFile.data(:,2);
            AllAngles = [AllAngles;NewAngles];
        end
        
    case '2Theta'
        for FileNo = 1:size(FileName,2)
            [NewFile, NewAngles] = ImportDataAngles(FileNo, FileName, PathName, ExtraHeaders);
            NewAngles(:,1) = NewFile.data(:,1)*ScanUnitConstant;
            NewAngles(:,5) = NewFile.data(:,2);
            AllAngles = [AllAngles;NewAngles];
        end
        
    case 'Omega'
        for FileNo = 1:size(FileName,2)
            [NewFile, NewAngles] = ImportDataAngles(FileNo, FileName, PathName, ExtraHeaders);
            NewAngles(:,2) = NewFile.data(:,1)*ScanUnitConstant;
            NewAngles(:,5) = NewFile.data(:,2);
            AllAngles = [AllAngles;NewAngles];
        end
        
    case 'Chi'
        for FileNo = 1:size(FileName,2)
            [NewFile, NewAngles] = ImportDataAngles(FileNo, FileName, PathName, ExtraHeaders);
            NewAngles(:,3) = NewFile.data(:,1)*ScanUnitConstant;
            NewAngles(:,5) = NewFile.data(:,2);
            AllAngles = [AllAngles;NewAngles];
        end
        
    case 'Phi'
        for FileNo = 1:size(FileName,2)
            [NewFile, NewAngles] = ImportDataAngles(FileNo, FileName, PathName, ExtraHeaders);
            NewAngles(:,4) = NewFile.data(:,1)*ScanUnitConstant;
            NewAngles(:,5) = NewFile.data(:,2);
            AllAngles = [AllAngles;NewAngles];
        end
        
end

AllAngles(1,:) = [];

test = 1;

end