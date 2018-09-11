function [NewFile, NewAngles] = ImportScanData(FileNo, FileName, PathName, ExtraHeaders)

NewFile = importdata(strcat(PathName,FileName{FileNo}), ' ', 59+ExtraHeaders);

theta = cell2mat(textscan(NewFile.textdata{20+ExtraHeaders}, '%*s    %f'));
omega = cell2mat(textscan(NewFile.textdata{19+ExtraHeaders}, '%*s    %f'));
chi = cell2mat(textscan(NewFile.textdata{14+ExtraHeaders}, '%*s    %f'));
phi = cell2mat(textscan(NewFile.textdata{15+ExtraHeaders}, '%*s    %f'));

NewAngles = ones(size(NewFile.data,1),1);
NewAngles = NewAngles * [theta, omega, chi, phi, 1];

end