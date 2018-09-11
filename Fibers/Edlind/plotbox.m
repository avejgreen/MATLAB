function plotbox(bounds,col)

line([0 bounds(1)],[0 0],[0 0],'Color',col);
line([0 0],[0 bounds(2)],[0 0],'Color',col);
line([0 0],[0 0],[0 bounds(3)],'Color',col);
line([bounds(1) bounds(1)],[0 bounds(2)],[bounds(3) bounds(3)],'Color',col); line([bounds(1) bounds(1)],[0 0],[0 bounds(3)],'Color',col);
line([0 bounds(1)],[0 0],[bounds(3) bounds(3)],'Color',col);
line([0 bounds(1)],[bounds(2) bounds(2)],[bounds(3) bounds(3)],'Color',col); line([0 0],[0 bounds(2)],[bounds(3) bounds(3)],'Color',col);
line([0 0],[bounds(2) bounds(2)],[0 bounds(3)],'Color',col);
line([0 bounds(1)],[bounds(2) bounds(2)],[0 0],'Color',col);
line([bounds(1) bounds(1)],[0 bounds(2)],[0 0],'Color',col);
line([bounds(1) bounds(1)],[bounds(2) bounds(2)],[0 bounds(3)],'Color',col);

axis equal
