function newseg = Swivelseg(seg,angle)

oldposition = seg.position;
oldvectors = seg.vectors;

%Swivel position around position a, direction da
position = Rot3daxl(oldposition(:,1),oldvectors(:,1),angle,oldposition);
vectors = Rot3daxl([0;0;0],oldvectors(:,1),angle,oldvectors);

newseg = seg;
newseg.position = position;
newseg.vectors = vectors;