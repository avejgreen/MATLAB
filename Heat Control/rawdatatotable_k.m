function rawdatatotable_k

close all;
clear all;
clc;

oldfolder = cd('/Users/averygreen/Documents/MATLAB/Projects/Heat Control');
Data = load('TableData_K.mat');


AllTemps = [linspace(-270,1372,1643)',zeros(1643,1)];

for i = 1:size(Data.Section1,1)
    for j = 1:10
        AllTemps(10*(i-1)+j,2) = Data.Section1(i,j+1);
    end
end

for i = 1:size(Data.Section2,1)
    for j = 1:10
        AllTemps(10*(i-1)+j+270,2) = Data.Section2(i,j+1);
    end
end

for i = 1:size(Data.Section3,1)
    for j = 1:10
        AllTemps(10*(i-1)+j+520,2) = Data.Section3(i,j+1);
    end
end

for i = 1:size(Data.Section4,1)
    for j = 1:10
        AllTemps(10*(i-1)+j+1070,2) = Data.Section4(i,j+1);
    end
end

for i = 1:size(Data.Section5,1)-1
    for j = 1:10
        AllTemps(10*(i-1)+j+1370,2) = Data.Section5(i,j+1);
    end
end

AllTemps(end-2:end,end) = Data.Section5(end,2:4)';

figure;
plot(AllTemps(:,1),AllTemps(:,2));

csvwrite('ReferenceTable_K.csv',AllTemps)
cd(oldfolder);

test = 1;