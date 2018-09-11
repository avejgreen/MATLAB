function BetaTester

%Test beta pdf for kink distribution

x = 0:.01:1;
% A = betapdf(x,1,1);
% B = betapdf(x,1,3);
% C = betapdf(x,1,5);
% D = betapdf(x,1,7);
% E = betapdf(x,1,9);
% F = betapdf(x,1,11);

subplot(6,6,1);
sp = 1;
for i = 1:2:11
    for j = 1:2:11
        Y = betapdf(x,i,j);
        subplot(6,6,sp);
        plot(x,Y);
        title(horzcat('q=',int2str(i),'   r=',int2str(j)));
        sp=sp+1;
    end
end
        
        
% plot(x,A,x,B,x,C,x,D,x,E,x,F);