function plotfibre(fibdat,color)

for s=1:min(size(fibdat))
    r=fibdat(s,1);
    c=fibdat(s,2:4);
    alfa1=fibdat(s,5);
    alfa2=fibdat(s,6);
    u=fibdat(s,7:9);
    v=fibdat(s,10:12);
    n=cross(u,v);
    
    seg=20;
    
    a1=alfa1;
    
    for i=1:seg
        if alfa1>alfa2
            a2=alfa1+i*(2*pi-alfa1+alfa2)/seg;
            if a2>2*pi
                a2=a2-2*pi;
            end
        else
            a2=alfa1+i*(alfa2-alfa1)/seg;
        end
        
        X1=c+r*(cos(a1)*u+sin(a1)*v);
        X2=c+r*(cos(a2)*u+sin(a2)*v);
        
        line([X1(1) X2(1)],[X1(2) X2(2)],[X1(3) X2(3)],'Color',color);
       
        a1=a2;
        pause(.001);
        hold on
        axis equal;
    end
end