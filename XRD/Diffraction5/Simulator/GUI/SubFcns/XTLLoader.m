function [error,Name,a,b,S,Atoms] = XTLLoader(XTLDir)

% close all;
% clear all;
% clc;

%%% CODE FOR CIF LATER. FOR NOW, USE XTL
% oldfolder = cd('/Users/averygreen/Desktop/VESTA/Files xtl');

[FileName,PathName] = uigetfile(horzcat(XTLDir,'/*.xtl'),'Select .xtl file');


if FileName == 0
    error = 1;
    Name=0;
    a=0;
    b=0;
    S=0;
    Atoms=0;
    
else
    
    error = 0;
    XTL = importdata(horzcat(PathName,FileName),' ',7);
    % XTL = importdata('/Users/averygreen/Desktop/VESTA/Files xtl/Al2O3.xtl',' ',7);
    
    Name = FileName(1:end-4);
    
    cellparams = cell2mat(textscan(XTL.textdata{3,1},'%f%f%f%f%f%f'));
    a=cellparams(1);b=cellparams(2);c=cellparams(3);
    alpha=cellparams(4);beta=cellparams(5);gamma=cellparams(6);
    alpha=alpha*pi/180;
    beta=beta*pi/180;
    gamma=gamma*pi/180;
    
    %CAN SHORTEN WITH LOOP. LATER.
    S11=b^2*c^2*(sin(gamma))^2;
    S22=a^2*c^2*(sin(beta))^2;
    S33=a^2*b^2*(sin(gamma))^2;
    S23=a^2*b*c*(cos(beta)*cos(gamma)-cos(alpha));
    S13=a*b^2*c*(cos(gamma)*cos(alpha)-cos(beta));
    S12=a*b*c^2*(cos(alpha)*cos(beta)-cos(gamma));
    S=[S11,S22,S33,S23,S13,S12];
    
    % Works for all UCs
    a1 = [a,0,0];
    a2 = [b*cos(gamma),b*sin(gamma),0];
    cx = c*cos(beta);
    cy = c*(cos(alpha)-cos(beta)*cos(gamma))/sin(gamma);
    cz = sqrt(c^2-cx^2-cy^2);
    a3 = [cx,cy,cz];
    a=[a1;a2;a3];
    
    % MAKE B VECTORS WITHOUT 2PI FACTOR. CAN ADD LATER
    b = zeros(1,3);
    for i = 1:3
        j=mod(i+1,3);
        if j==0 j=3; end
        k=mod(i+2,3);
        if k==0 k=3; end
        b(i,:) = cross(a(j,:),a(k,:))/(dot(a(i,:),cross(a(j,:),a(k,:))));
    end
    
    test = 1;
    
    Atoms = cell(size(XTL.textdata,1)-8,4);
    Atoms(:,1) = XTL.textdata(8:end-1,1);
    Atoms(:,2:end) = num2cell(XTL.data);
    Atoms = Atoms(~((XTL.data(:,1)==1)|(XTL.data(:,2)==1)|(XTL.data(:,3)==1)),:);
    
    test = 1;
    
end

end