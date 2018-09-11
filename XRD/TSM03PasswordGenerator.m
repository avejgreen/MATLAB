function TSM03PasswordGenerator

close all;
clear all;
clc;



Date = date;

rng('shuffle');

Password = rand(1,10);
Password = (126-33)*Password+33;
Password = char(Password);

OldFolder = cd('/Users/averygreen/Dropbox/NFE 1905');
FileID = fopen('TSM03 Passwords.txt','a');
fprintf(FileID, '\n%s', Date);
fprintf(FileID, ': ');
fprintf(FileID, '%s', Password);
fclose(FileID);
cd(OldFolder);

test = 1;

end