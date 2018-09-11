%%%%%%%%%%%%%%%%%
% Make csvs into usefuls structures
%%%%%%%%%%%%%%%%%

function AllData = GetData(PathName)

% Get all data from the path name folder csvs

% PathName = '/Users/averygreen/Documents/CNSE/Diebold Lab/Data/Samples Hinkle/TPD/All_Mass_Spec/';
OldFolder = cd(PathName);
FileName = textscan(ls('*.csv'),'%s');
FileName = FileName{1};
cd(OldFolder);

% if ischar(FileName)
%     FileName = {FileName};
% end
% 
% %%% For testing, use given file.
% PathName = '/Users/averygreen/Documents/CNSE/Diebold Lab/Data/Samples Hinkle/TPD/All_Mass_Spec/';
% FileName = {'Test5_100516.csv'};

w = waitbar(0,horzcat('Parsing file 0 of ',int2str(length(FileName))));

AllData = struct;
Field = 1;
for i = 1:length(FileName)
    
    waitbar(i/length(FileName), w,...
        horzcat('Parsing file ', int2str(i),...
        ' of ',int2str(length(FileName))));
    
    % Go through all data files, import lines
    
    %    AllData(i).RawFile = csvread(horzcat(PathName, FileName{i}));
    NewFile = fopen(horzcat(PathName, FileName{i}));
    TempNewData = textscan(NewFile,'%s','Delimiter','\n');
    fclose(NewFile);
    
    NewData = cell(length(TempNewData{1}),1);
    for j = 1:length(TempNewData{1})
        % Go through a line, sparate into csvs
        
        TempLine = textscan(TempNewData{1}{j},'%s','Delimiter',',');
        
        for k = 1:length(TempLine{1})
            % Go through csvs, place in dat file
            NewData{j,k} = TempLine{1}{k};
        end

    end
    
    AllData(Field).RawData = NewData;
    AllData(Field).FileName = FileName{i};
    
%     if i == 15
%         test = 1;
%     end
    
    HeadersRow = GetHeadersRow(NewData);
    if HeadersRow == 0
        AllData(Field) = [];
        continue
    end
        
    HeaderCols = GetHeadersCols(NewData, HeadersRow);
    
    AllData(Field).Headers = NewData(HeadersRow,2:HeaderCols);
    AllData(Field).Data = cellfun(@str2double, NewData(HeadersRow+1:end,2:HeaderCols));
    
    AllData(Field).msCol = find(~cellfun(@isempty,... 
        strfind(AllData(Field).Headers, 'ms')));
    AllData(Field).Se80Col = find(~cellfun(@isempty,... 
        strfind(AllData(Field).Headers, '80')));
    AllData(Field).Se78Col = find(~cellfun(@isempty,...
        strfind(AllData(Field).Headers, '78')));
    
    if isempty(AllData(Field).Se80Col)
        AllData(Field) = [];
        continue
    end

    test = 1;
    
    Field = Field + 1;
    
end

close(w)

test = 1;


function HeadersRow = GetHeadersRow(RawData)

HeadersRowFound = false;
SearchRow = 1;
HeadersRow = 0;

while and(~HeadersRowFound, SearchRow <= size(RawData,1))
    
    if strcmp(RawData{SearchRow,1}, '"Time"')
        HeadersRowFound = true;
        HeadersRow = SearchRow;
    end
    
    SearchRow = SearchRow + 1;
    
end

test = 1;


function LastCol = GetHeadersCols(NewData, HeadersRow)

LastColFound = false;
SearchCol = 1;
LastCol = 0;

while ~LastColFound
    
    if isempty(NewData{HeadersRow, SearchCol})
        LastCol = SearchCol - 1;
        LastColFound = true;
    elseif SearchCol == length(NewData(HeadersRow,:))
        LastCol = length(NewData(HeadersRow,:));
        LastColFound = true;
    end
    
    SearchCol = SearchCol + 1;
    
end
    
%{ 
function Se80Col = GetSe80Col(Headers)

%Test over Se80, Se 80, 80Se, 80 Se
SeStrings = {'Se80','Se 80','80Se','80 Se'};
j = 1;
SeFound = false;
while and(j <= length(SeStrings), ~SeFound)
    
    Se80Col = find(~cellfun(@isempty, strfind(Headers, SeStrings{j})));

    if ~isempty(Se80Col)
        SeFound = true;
    end
        
    j = j + 1;
end


function Se78Col = GetSe78Col(Headers)

%Test over Se78, Se 78, 78Se, 78 Se
SeStrings = {'Se78','Se 78','78Se','78 Se'};
j = 1;
SeFound = false;
while and(j <= length(SeStrings), ~SeFound)
    
    Se78Col = find(~cellfun(@isempty, strfind(Headers, SeStrings{j})));

    if ~isempty(Se78Col)
        SeFound = true;
    end
        
    j = j + 1;
end
%}

