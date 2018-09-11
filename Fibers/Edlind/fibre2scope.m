function fibre2scope(filename,fibdat,prec,t)

%{

Exports fibre network geometry to nef file format

fibre2scope(filename,fibdat,prec,t)

INPUT:
filename    - location and name of exported file
fibdat      - vector containing radius of curvature
              centre point, alfa1, alfa2, u and v for the network
prec        - number of straight lines to represent one fibre segment
t           - diameter of the fibres circular cross-section

%}

nfibs=size(fibdat,1);
maxarcs=size(fibdat,2);

fid=fopen(filename,'w');
fprintf(fid,'%12f\n',t);

for fib=1:nfibs
    n=0;
    for arc=1:maxarcs
        r=fibdat(fib,arc,1);
        c=fibdat(fib,arc,2:4);
        alfa1=fibdat(fib,arc,5);
        alfa2=fibdat(fib,arc,6);
        u=fibdat(fib,arc,7:9);
        v=fibdat(fib,arc,10:12);
        
        if r==0
            arc=arc-1;
            break
        end
        
        for i=0:prec
            n=n+1;
            if alfa1>alfa2
                a2=alfa1+i*(2*pi-alfa1+alfa2)/prec;
                if a2>2*pi
                    a2=a2-2*pi;
                end
            else
                a2=alfa1+i*(alfa2-alfa1)/prec;
            end
            points(n,:)=c+r*(cos(a2)*u+sin(a2)*v);
        end
    end
    fprintf(fid,'%12f\n',arc*(prec+1));
    for j=1:n
        fprintf(fid,'%12.8f %12.8f %12.8f\n',points(j,:));
    end
end

fclose(fid);








