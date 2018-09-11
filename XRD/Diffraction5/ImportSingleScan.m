function Data = ImportSingleScan(PathName, FileName)

%% Load file, check if single scan or loop
FileID = fopen(strcat(PathName,FileName));
TestText = textscan(FileID, '%s', 10, 'Delimiter', '\n');
fclose(FileID);
TestText = textscan(TestText{1}{9}, '%s');
if strcmp(TestText{1}{1}, 'Time:')
    %Recipe exists in single scans.
    nheaders = 0;
elseif strcmp(TestText{1}{1}, 'Loop')
    %Recipe exists as a loop.
    nheaders = 2;
else
    error('Could not read test scan.')
end

%% Import data, 2D cell of header text
A = importdata(strcat(PathName,FileName),' ', 59+nheaders);
B = cellfun(@(x) textscan(x, '%s'), A.textdata(:,1));
C = cell(length(B), max(cellfun(@(x) length(x),B)));
for i = 1:length(C)
    C(i,1:length(B{i})) = B{i}';
end

%% Generate big data table
InitialPositions = [str2double(C(14+nheaders:20+nheaders,2))',...
    str2double(C{35+nheaders,2}),...
    str2double(C{45+nheaders,2}),0];
AllData = ones(size(A.data,1),1)*InitialPositions;
AllData(:,end) = A.data(:,2);
switch C{12,3}
    case 'Chi'
        AllData(:,1) = A.data(:,1);
    case 'Phi'
        AllData(:,2) = A.data(:,1);
    case 'X'
        AllData(:,3) = A.data(:,1);
    case 'Y'
        AllData(:,4) = A.data(:,1);
    case 'Z'
        AllData(:,5) = A.data(:,1);
    case 'Omega'
        AllData(:,6) = A.data(:,1);
    case '2Theta'
        AllData(:,7) = A.data(:,1);
    case 'Omega-2Theta'
        AllData(:,6) = AllData(:,6)-A.data(1,1)/3600+A.data(:,1)/3600;
        AllData(:,7) = AllData(:,7)-2*A.data(1,1)/3600+2*A.data(:,1)/3600;
        AllData(:,8) = A.data(:,1);
    case 'Omega_Rel'
        AllData(:,6) = AllData(:,6)-A.data(1,1)/3600+A.data(:,1)/3600;
        AllData(:,9) = A.data(:,1);
end

Data = struct;
Data.HeaderText = C;
Data.ScanData = AllData;

test = 1;

end