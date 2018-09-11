function rawdatatotable_j

close all;
clear all;
clc;

oldfolder = cd('/Users/averygreen/Documents/MATLAB/Projects/Heat Control');
Data = load('TableData_J.mat');


AllTemps = [linspace(-210,1200,1411)',zeros(1411,1)];

for i = 1:size(Data.Section1,1)
    for j = 1:10
        AllTemps(10*(i-1)+j,2) = Data.Section1(i,j+1);
    end
end

for i = 1:size(Data.Section2,1)
    for j = 1:10
        AllTemps(10*(i-1)+j+210,2) = Data.Section2(i,j+1);
    end
end

for i = 1:size(Data.Section3,1)
    for j = 1:10
        AllTemps(10*(i-1)+j+710,2) = Data.Section3(i,j+1);
    end
end

AllTemps(end,end) = Data.Section3(end,12);

% figure;
% plot(AllTemps(:,1),AllTemps(:,2));

csvwrite('ReferenceTable_J.csv',AllTemps)
cd(oldfolder);

test = 1;