function plotnet(fibdat,bounds) 
figure
axis off
set(gcf,'Color','w')
plotbox(bounds,'r');
for i=1:size(fibdat,1) 
    temp=squeeze(fibdat(i,:,:)); 
    plotfibre(temp,'b'); 
    title(num2str(i));
end