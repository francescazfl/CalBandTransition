function [ finalPosition,finalPositionCoordinates ] = myfinalPosition( posPositions,target_formation,time )
%Assigns each marcher a valid spot in the target formation that they can
%reach from their initial position.
%   Indexes through all marchers and their possible solutions, and assigns
%   coordinates based on the marchers with the fewest possible target spots
%   remaining. If a valid solution is not reached, the function will try a
%   different set of solutions until a given amount of time is reached.
 
finalPosition=zeros(size(target_formation));
finalPositionCoordinates=zeros(size(posPositions,2),2);
[SouthtoNorth,EasttoWest]=find(target_formation);   %Coordinates based off target formation
newposPositions=posPositions;
 
tic
 
for n=1:size(newposPositions,2);
[newposPositions,posponumber]=posSolutions(newposPositions);
smallestposponumber=find(posponumber==min(posponumber)); %Finds the positions with the fewest possible un-used solutions
 
    possible=newposPositions{1,smallestposponumber(1)};   %Converts cell values for possible coordinates into a matrix
 
    for k=1:size(possible,1)    %Loops over the length of the matrix of possible values
        for j=1:size(SouthtoNorth,1)
            possible=(newposPositions{1,smallestposponumber(1)});
            if possible(k,1)==SouthtoNorth(j) && possible(k,2)==EasttoWest(j)   %Compares coordinates to those found as solutions to the target formation
                finalPosition(SouthtoNorth(j),EasttoWest(j))=smallestposponumber(1);   %Indexes that cell in the final position matrix, replaces that value with the number of the band member
                %This will make it easier to trace steps
                
                finalPositionCoordinates(smallestposponumber(1),1:2)=[SouthtoNorth(j),EasttoWest(j)];
        %Also, all possible paths with this part in them must be eliminated
        %from the possible solutions for other band members
                for l=1:size(newposPositions,2)
                    for m=1:size(newposPositions{1,l},1)
                    if newposPositions{1,l}(m,1:2)==finalPositionCoordinates(smallestposponumber(1),1:2)
                    newposPositions{1,l}(m,1:3)=zeros(1,3);
                %This will take out used locations as they are used from
                %other marcher's solutions
                    end
                    end
                end
                newposPositions{1,smallestposponumber(1)}=NaN(size(possible));
            end
        end
    end
end
t=toc;
time=time+t;
if sum(sum(finalPosition))~=size(newposPositions,2)*(size(newposPositions,2)+1)/2 && time<=15         %Checks to see if all the marchers have final positions
    modifiedposPositions=changeInitial(posPositions,1);     %Modifies the possible positions matrix
    myfinalPosition(modifiedposPositions,target_formation,time);      %Calls the function recursively
elseif sum(sum(finalPosition))~=size(newposPositions,2)*(size(newposPositions,2)+1)/2 && time<60
    modifiedposPositions=changeInitial(posPositions,2);     %Modifies the possible positions matrix
    myfinalPosition(modifiedposPositions,target_formation,time);       %Calls the function recursively
elseif time>=60
    fprintf('Transition not completely solved with this function')
end
 
end
