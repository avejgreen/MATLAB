function newseg = Kinkseg(seg,angle1,angle2)

oldposition = seg.position;
oldvectors = seg.vectors;

%Kink around a, direction dc
positiontemp = Rot3daxl(oldposition(:,1),oldvectors(:,3),angle1,oldposition);
vectorstemp = Rot3daxl([0;0;0],oldvectors(:,3),angle1,oldvectors);

%Kink around a, new direction da
position = Rot3daxl(positiontemp(:,1),vectorstemp(:,1),angle2,positiontemp);
vectors = Rot3daxl([0;0;0],vectorstemp(:,1),angle2,vectorstemp);

newseg = seg;
newseg.position = position;
newseg.vectors = vectors;