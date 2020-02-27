function [ posPositions,posponumber ] = posSolutions( posPositions )
%Modifies the matrix of posPositions, adding a third row to each cell with
%ones indicating valid solutions or zeros indicating a used solution
%   Also calculates a posponumber, which is the sum of possible solutions
%   remaining for that marcher, and reports it on the secone line of
%   posPositions.
 
posponumber=zeros(1,size(posPositions,2));
for j=1:size(posPositions,2)
    pospo=posPositions{1,j};
    if size(pospo)==[size(pospo,1),2]
        pospo(1:size(posPositions{1,j},1),3)=1;     %Adds a third column to every thing with ones being un-used solutions, and zeros being used solutions
    end
    posponumber(j)=sum(pospo(1:size(pospo,1),3));
    posPositions{1,j}=pospo;
    posPositions{2,j}=posponumber(j);       %Makes a row at the bottom for easy access
end
 
end