function [ modifiedposPositions ] = changeInitial( posPositions,option )
%Bumps the first solution of each cell to the bottom of the list of the
%marcher's possible solutions
%   Option 1: indexes through each marcher, moving all values up one except the first,
%   which it moves to the last value spot. Option 2: only changes the
%   initial value for the first half of the marchers.
 
if option==1
    for j=1:size(posPositions,2)        %Changes every marcher
        previousinitial=posPositions{1,j}(1,1:2);
        for k=2:size(posPositions{1,j}-1,1)
            posPositions{1,j}(k-1,1:2)=posPositions{1,j}(k,1:2);
        end
        posPositions{1,j}(size(posPositions{1,j},1),1:2)=previousinitial;
    end
elseif option==2
    for j=1:size(posPositions,2)/2      %Only changes the first half
        previousinitial=posPositions{1,j}(1,1:2);
        for k=2:size(posPositions{1,j}-1,1)
            posPositions{1,j}(k-1,1:2)=posPositions{1,j}(k,1:2);
        end
        posPositions{1,j}(size(posPositions{1,j},1),1:2)=previousinitial;
    end
end
modifiedposPositions=posPositions;
end