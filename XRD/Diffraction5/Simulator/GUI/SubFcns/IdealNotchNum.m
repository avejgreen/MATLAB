function IS = IdealNotchNum(Crystal)

% Find the vector of form [h,0,0], where h>0 minimized.

IS = Crystal.hkl(Crystal.hkl(:,1)>0 & Crystal.hkl(:,2)==0 & Crystal.hkl(:,3)==0,:);
IS = IS(IS(:,1)==min(IS(:,1)),1);
IS = find(Crystal.hkl(:,1)==IS & Crystal.hkl(:,2)==0 & Crystal.hkl(:,3)==0);

end
