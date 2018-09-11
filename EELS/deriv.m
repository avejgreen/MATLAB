function NewData = deriv(data, points, order)

%% Take Derivative

NewData = cell(1,order+1);
NewData{1} = data;

% NewData = zeros(size(data,1), size(data,2));
% NewData(:,1) = data(:,1);

if isinteger(points/2)
    points = points+1;
else
end

for j = 2:length(NewData)
    
%     NewData{j} = zeros(size(data,1),size(data,2));
    NewData{j}(:,1) = NewData{j-1}(:,1);
    
    for i = (points+1)/2 : size(data,1) - (points+1)/2
        
        NewData{j}(i,2) = (NewData{j-1}(i+(points-1)/2,2)-NewData{j-1}(i-(points-1)/2,2))/(NewData{j-1}(i+(points-1)/2,1)-NewData{j-1}(i-(points-1)/2,1));
        test = 1;
        
    end
    
    test = 1;
    
    for i = 1:(points-1)/2
        
        NewData{j}(i,2) = (NewData{j-1}(i+(points-1)/2,2)-NewData{j-1}(1,2))/(NewData{j-1}(i+(points-1)/2,1)-NewData{j-1}(1,1));
        NewData{j}(end-i+1,2) = (NewData{j-1}(end,2)-NewData{j-1}(end-(i+(points-1)/2)))/(NewData{j-1}(end,1)-NewData{j-1}(end-(i+(points-1)/2),1));
        test = 1;
        
    end
    
end

% NewData = NewData(2:end);

test = 1;