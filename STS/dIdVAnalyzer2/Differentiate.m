function D1 = Differentiate(DataIn)

x = DataIn(:,1:2:end);
y = DataIn(:,2:2:end);

D1 = zeros(size(x,1),size(x,2));

for j = 1:size(x,2)
    
    y1=[y(:,j);0;0];
    y0=[0;0;y(:,j)];
    
    dy=y1-y0;
    
    x1=[x(:,j);0;0];
    x0=[0;0;x(:,j)];
    
    dx=x1-x0;
    
    D = dy./dx;
    D = D(2:end-1);
    D(1) = D(2);
    D(end) = D(end-1);
    
    D1(:,j) = D;
end


