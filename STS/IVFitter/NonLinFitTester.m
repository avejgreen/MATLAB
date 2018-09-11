function NonLinFitTester

close all;
clear all;
clc;

mdl = @(a,x)(a(1) + a(2)*exp(-a(3)*x));

rng(9845,'twister') % for reproducibility
a = [1;3;2];
x = exprnd(2,100,1);
epsn = normrnd(0,0.1,100,1);
y = mdl(a,x) + epsn;

a0 = [2;2;2];
[ahat,r,J,cov,mse] = nlinfit(x,y,mdl,a0);

xrange = min(x):.01:max(x);
hold on
scatter(x,y)
plot(xrange,mdl(ahat,xrange),'r')
hold off

ci = nlparci(ahat,r,'Jacobian',J)