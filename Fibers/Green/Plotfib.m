function [pts,newpts] = Plotfib(fib)

pts = [0,0,0];

for i = 1:length(fib)
   
    %Find length of arc
    l = fib(i).radius*fib(i).phi;
    
    %Get pts around every 0.05 dist. units, min start and end
    nnewpts = 1+round(l/.05);
    nnewpts(nnewpts<2)=2;
    
    %Make new pt matrix, populate first and last
    newpts = zeros(nnewpts,3);
    newpts(1,:) = fib(i).position(:,1)';
    newpts(end,:) = fib(i).position(:,2)';
    
    %Populate middle of new pt matrix
    for j = 2:size(newpts,1)-1
        
       %Measure out along arc angle number of pts (and segments?)
       dphi = fib(i).phi/(nnewpts-1);
       
       %Rotate a pt starting at a around dc by dphi
       newpts(j,:) = Rot3daxl(fib(i).position(:,3),fib(i).vectors(:,3),...
           (j-1)*dphi,fib(i).position(:,1))';
       
       test = 1;

    end
    
    test = 1;
    
    pts = [pts;newpts];
    
end

pts(1,:)=[];

% plot3(pts(:,1),pts(:,2),pts(:,3),'LineWidth',2);
% axis equal;

test = 1;

