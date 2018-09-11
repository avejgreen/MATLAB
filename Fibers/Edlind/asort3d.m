function [vect]=asort3d(vect,n)

% Function used by modfib3d in program fibre3d.
% Sorts the angles in vect in their order along
% the circle arc.

alfa1=vect(1);

for i=1:n-1
    minv=1e10;
    
    for k=i:n
        if (vect(k)<minv)
            minv=vect(k);
            index=k;
        end
    end
    
    vect(index)=vect(i);
    vect(i)=minv;
end

while (abs(vect(1)-alfa1)>1e-5)
    a=vect(1);
    for i=1:n-1
        vect(i)=vect(i+1);
    end
    vect(n)=a;
end