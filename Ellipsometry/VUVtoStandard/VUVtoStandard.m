function VUVtoStandard

close all;
clear all;
clc;

Path = '/Users/averygreen/Documents/MATLAB/Projects/Ellipsometry/VUVtoStandard/';
StdName = 'Standard Se Test.dat';
VUVName = 'rich a-c.dat';

StdFile = fopen(horzcat(Path,StdName));
VUVFile = fopen(horzcat(Path,VUVName));

StdCell = textscan(StdFile,'%s','Delimiter','\n','HeaderLines',3);
VUVCell = textscan(VUVFile,'%f%f%f%f%f%f','Delimiter','\t','Headerlines',4);

fclose(StdFile);
fclose(VUVFile);

ECell = StdCell{1}(1:3:end);
uRCell = StdCell{1}(2:3:end);
dPolECell = StdCell{1}(3:3:end);

% ECell2 = textscan(ECell{1},'%s%f%f%f%f%f%f','Delimiter',' ');

ECell2 = cellfun(@(x) textscan(x,'%c%f%f%f%f%f%f','Delimiter','\t'),ECell,'UniformOutput',0);
uRCell2 = cellfun(@(x) textscan(x,'%2c%f%f%8c%f','Delimiter','\t'),uRCell,'UniformOutput',0);
dPolECell2 = cellfun(@(x) textscan(x,'%5c%f%f%f%f','Delimiter','\t'),dPolECell,'UniformOutput',0);

ECell3 = cell(length(ECell),7);
uRCell3 = cell(length(ECell),5);
dPolECell3 = uRCell3;

for i = 1:length(ECell2)
    ECell3(i,:) = ECell2{i};
    uRCell3(i,:) = uRCell2{i};
    dPolECell3(i,:) = dPolECell2{i};
end

VUVCell2 = cell(length(VUVCell{1}),length(VUVCell));
for i = 1:length(VUVCell)
    VUVCell2(:,i) = num2cell(VUVCell{i});
end


NewFile = fopen(horzcat(Path,'FormattedVUV.dat'),'w+');
for i = 1:size(VUVCell2,1)
    fprintf(NewFile,'%s\t%f\t%f\t%f\t%f\t%f\t%f\n',ECell3{1,1},10*VUVCell2{i,1},VUVCell2{i,2},VUVCell2{i,3},VUVCell2{i,4},VUVCell2{i,5},VUVCell2{i,6});
    fprintf(NewFile,'%s\t%f\t%f\t%s\t%f\n',uRCell3{1,1},10*VUVCell2{i,1},VUVCell2{i,2},uRCell3{1,4},uRCell3{1,5});
    fprintf(NewFile,'%s\t%f\t%f\t%f\t%f\n',dPolECell3{1,1},10*VUVCell2{i,1},VUVCell2{i,2},dPolECell3{1,4},dPolECell3{1,5});
end
fclose(NewFile);


test = 1;