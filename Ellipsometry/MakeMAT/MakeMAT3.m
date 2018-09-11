function MakeMAT3

close all;
clear all;
clc;

[File,Path,FilterIndex] = uigetfile('/Users/averygreen/CompleteEASE/MAT/Other/*.rtf');
FullFileName = horzcat(Path,File);
% FullFileName = '/Users/averygreen/CompleteEASE/MAT/Other/a-C Hagemann.rtf';
% FullFileName = '/Users/averygreen/CompleteEASE/MAT/Other/a-C Larruquert.rtf';
[Path, File, Ext] = fileparts(FullFileName);

RTFFile = fopen(FullFileName);
FileScan = textscan(RTFFile,'%s','delimiter','\n');
fclose(RTFFile);
FileScan = flipud(FileScan{1});

DataLine = find(strcmp(FileScan,'data: |\'));
DataLine = length(FileScan)-DataLine+2;

FileScan = flipud(FileScan);

Data = FileScan(DataLine:end-1);
Data = cellfun(@(x) x(1:end-1),Data,'UniformOutput',0);
Data = cellfun(@(x) textscan(x,'%f%f%f'),Data,'UniformOutput',0);
DataTemp = NaN(length(Data),3);
for i = 1:length(Data)
    DataTemp(i,:) = cell2mat(Data{i});
end
Data = DataTemp;
clear DataTemp;

CommentTester = cellfun(@(x) CheckComments(x),FileScan,'UniformOutput',0);
CommentTester = [CommentTester{:}]';
CommentLine = find(CommentTester);
if ~isempty(CommentLine)
    Comment = FileScan{CommentLine}(1:end-1);
else
    Comment = 'No comment section given';
end


NewFileName = horzcat(Path,'/',File,'.mat');
NewFile = fopen(NewFileName,'w+');

fprintf(NewFile,'%s\n', Comment);

% Convert data wavelength um to nm
fprintf(NewFile,'nm\n');
Data(:,1) = 1000*Data(:,1);
%

fprintf(NewFile,'NK\n');
fclose(NewFile);

dlmwrite(NewFileName, Data, 'delimiter', '\t', '-append')


test = 1;


function CommentTester = CheckComments(Cell)

if length(Cell)>7
    CommentTester = strcmp(Cell(1:8),'COMMENTS');
else
    CommentTester = 0;
end

test = 1;