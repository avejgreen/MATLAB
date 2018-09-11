clc;
clear all;

% Will take tabulated layer optical constants, convert dielectric to
% refractive, get the absorbance, save as .csv in same location


% Let user select data file
[filename, pathname, filterindex] = uigetfile('*');

fullfilename = strcat(pathname, filename);

newfilename = strcat('CSVnew',filename);

[didata, didelimit, diheaderlines] = importdata(fullfilename);

sizedat = size(didata.data);

% Create new file, open it, write labels
cd(pathname);

newfile = fopen(newfilename, 'w');

fprintf(newfile, '%s \n', 'Angstroms, e1, e2, n, k, Absorption');

% Build zeros matrix to fill second cell with new data
newdata = zeros(sizedat(1), 6);

% Transfer first 3 columns of original data to new matrix
for j = 1:3

    for l = 1:sizedat(1)
       
        newdata(l,j) = didata.data(l,j);
        
    end
    
end

% Calculate new constants and place in last 3 columns
for l = 1:sizedat(1)
    
    n = sqrt((sqrt(newdata(l,2)^2 + newdata(l,3)^2) + newdata(l,2))/2);
    
    newdata(l,4) = n;
    
    k = sqrt((sqrt(newdata(l,2)^2 + newdata(l,3)^2) - newdata(l,2))/2);
    
    newdata(l,5) = k;
    
    absorbance = 1-exp(-4*pi*k*n*3.4/newdata(l,1));
    
    newdata(l,6) = absorbance;
    
end

for l = 1: sizedat(1)
    
    for j = 1:5
        
        fprintf(newfile,'%d, ',newdata(l,j));
        
    end

    fprintf(newfile,'%d \n', newdata(l,6));
    
end

fclose(newfile);

newdata = importdata(newfilename);

plot(newdata.data(:,1),newdata.data(:,6),'b',newdata.data(:,1),.023,'r','LineWidth',1.05);

xlabel('Wavelength [Angstroms]');

ylabel('Absorbance');

title('Absorbance vs. Wavelength');