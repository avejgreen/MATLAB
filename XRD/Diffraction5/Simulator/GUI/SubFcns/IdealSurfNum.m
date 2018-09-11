function IS = IdealSurfNum(Crystal)

% Find the vector of form [0,0,l], where l>0 minimized.

IS = Crystal.hkl(Crystal.hkl(:,1)==0 & Crystal.hkl(:,2)==0 & Crystal.hkl(:,3)>0,:);
IS = IS(IS(:,3)==min(IS(:,3)),3);
IS = find(Crystal.hkl(:,1)==0 & Crystal.hkl(:,2)==0 & Crystal.hkl(:,3)==IS);

end
