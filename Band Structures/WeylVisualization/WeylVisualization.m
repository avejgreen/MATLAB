function WeylVisualization

close all;
clear all;
clc;

%{
    Program designed to help visualize Weyl Points. Taken from pg 2 of
    doi:10.1038/nature15768.
%}

x = -1:.01:1;

[y1,x1,z1] = meshgrid(x,x,x);
 
% x1=shiftdim(reshape(ones(201^2,1)*x,201,201,201),2);
% y1=shiftdim(reshape(ones(201^2,1)*x,201,201,201),1);
% z1=shiftdim(reshape(ones(201^2,1)*x,201,201,201),0);

a=1;b=1;c=1;d=1;e=1;A=1;B=1;
Ep = A*x1+B*y1+sqrt((e*z1).^2+(a*x1+c*y1).^2+(b*x1+d*y1).^2);
Em = A*x1+B*y1-sqrt((e*z1).^2+(a*x1+c*y1).^2+(b*x1+d*y1).^2);

dims = {'x','y','z'}';
CS = struct('DimOrder',{dims,circshift(dims,2),circshift(dims,1)});

oldfolder = cd('/Users/averygreen/Documents/MATLAB/Projects/WeylVisualization');

h = figure('Visible','off');
% for i = 1:length(CS) 
%     
%     test = 1;
%     EmTemp = shiftdim(Em,i-1);
%     EpTemp = shiftdim(Ep,i-1);
%     CS(i).DataM = shiftdim(EmTemp(101,:,:),1);
%     CS(i).DataP = shiftdim(EpTemp(101,:,:),1);    
%     
%     %Plot and Save Images
%     
%     surf(gca,x,x,CS(i).DataM,'EdgeAlpha',0);
%     xlabel(horzcat('k',CS(i).DimOrder{2}));
%     ylabel(horzcat('k',CS(i).DimOrder{3}));
%     zlabel('E');
%     hold on;
%     surf(gca,x,x,CS(i).DataP,'EdgeAlpha',0);
%     hold off;
%     title(horzcat('E dispersion Cross Section at k',CS(i).DimOrder{1},' = 0'));
%     print(h,'-dtiff',horzcat('CS ',CS(i).DimOrder{1},' Image.tiff'));
%     
%     
%     % Create camera oscillations around default display positions az = ?37.5,
%     % el = 30
%     % Use 24 fps, 1 osc is 5 sec, 120 frames.
%     fps = 24;
%     T = 10;
%     t = linspace(0,2*pi,fps*T+1);
%     t = t(1:end-1);
%     az = -37.5+40*sin(t);
%     el = 30+40*cos(t);
%     
%     writerObj = VideoWriter(horzcat('CS ',CS(i).DimOrder{1},' Animation.avi'));
%     writerObj.FrameRate = 24;
%     open(writerObj);
%     
%     hwait = waitbar(0,horzcat('Exporting CS ',CS(i).DimOrder{1},' Animation'));
%     for j = 1:length(t)
%         waitbar(j/length(t),hwait,horzcat('Exporting CS ',CS(i).DimOrder{1},' Animation'));
%         view(az(j),el(j));
%         writeVideo(writerObj,hardcopy(h, '-Dopengl', '-r144'));
%     end
%     close(hwait);
%     
%     close(writerObj);
%     
% end



%Scan through kz for a movie

writerObj = VideoWriter(horzcat('kz Evolution Animation.avi'));
writerObj.FrameRate = 10;
open(writerObj);

hwait = waitbar(0,horzcat('kz Evolution Animation'));
for i = 1:length(x)
    
    surf(gca,x,x,Em(:,:,i),'EdgeAlpha',0);
    view(-20,10);
    xlabel('kx');
    ylabel('ky');
    zlabel('E');
    hold on;
    surf(gca,x,x,Ep(:,:,i),'EdgeAlpha',0);
    hold off;
    title(horzcat('E dispersion Cross Section at kz = ',num2str(x(i),3)));
    
    waitbar(i/length(x),hwait,horzcat('kz Evolution Animation'));
    writeVideo(writerObj,hardcopy(h, '-Dopengl', '-r144'));
    
end
close(hwait);

close(writerObj);


cd(oldfolder);

test = 1;





