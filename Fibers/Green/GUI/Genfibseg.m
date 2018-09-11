function fibseg = Genfibseg(LastSeg,Start)

global betadists;

fieldnum=find(strcmp('Seg Radius',{betadists(:).name}));
r=betadists(fieldnum).min+...
    betadists(fieldnum).range*...
    betarnd(betadists(fieldnum).q,betadists(fieldnum).r);

fieldnum=find(strcmp('Seg Angle',{betadists(:).name}));
phi=betadists(fieldnum).min+...
    betadists(fieldnum).range*...
    betarnd(betadists(fieldnum).q,betadists(fieldnum).r);

if Start==1
    
    a = [0;0;-r];
    c = [0;0;0];
    dc = [0;-1;0];
    
    b = Rot3daxl(c,dc,phi,a);
    da = cross(dc,a-c);
    da = da/norm(da);
    db = cross(dc,b-c);
    db = db/norm(db);
    
else
    
    a = LastSeg.position(:,2);
    da = LastSeg.vectors(:,2);
    da = da/norm(da);
    dc = LastSeg.vectors(:,3);
    dc = dc/norm(dc);
    
    c = LastSeg.position(:,3)+((LastSeg.radius-r)/LastSeg.radius)*...
        (LastSeg.position(:,2)-LastSeg.position(:,3));
    
    b = Rot3daxl(c,dc,phi,a);
    db = cross(dc,b-c);
    db = db/norm(db);
    
end


fibseg = struct;
fibseg.position = [a,b,c];
fibseg.vectors = [da,db,dc];
fibseg.radius = r;
fibseg.phi = phi;
fibseg.length = r*phi;

test = 1;
