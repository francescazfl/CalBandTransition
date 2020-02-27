function [posPositions,time] = possibleFinalPositions(initial_formation, target_formation, max_beats)
%Finds the possible final positions of each marcher
%   Finds the indices of the possible final positions in target_formation
%   of each marcher in initial_formation given max_beats. Output is a
%   1-by-n cell array, where n is the number of the marcher. Each element
%   of the cell array is a 2-by-n matrix, where each row is the index of
%   each possible final position.
%% Create variables and arrays
    %Finds the number of marchers in the transition and preallocates arrays
    %used within the function based on this information
countMarchers = max(max(initial_formation));
initialCoordinates = zeros(countMarchers,2);
finalCoordinates = zeros(countMarchers,2);
distances = zeros(20,2,20);
steps = zeros(20,1,20);
posPositions = cell(1,countMarchers);
 
%% Find initial formation coordinates
    % Finds the row and column indices of each marcher in the initial
    % formation. The row index of initialCoordinates corresponds to the
    % marcher number in the initial formation.
for i = 1:countMarchers
    [initialCoordinates(i,1),~] = find(initial_formation == i);
    [~,initialCoordinates(i,2)] = find(initial_formation == i);
end
 
%% Find final formation coordinates
    % Finds the coordinates of each marcher in the target formation
[finalCoordinates(:,1),~] = find(target_formation == 1);
[~,finalCoordinates(:,2)] = find(target_formation == 1);
 
%% Find steps from initial to final positions
    % Calculates the steps to each final position from each initial
    % position. The array steps is a n-by-1-by-n matrix, where the row
    % index corresponds to each final position, and the 3rd index
    % corresponds to each marcher.
for j = 1:countMarchers
    for k = 1:countMarchers
        distances(k,1,j) = finalCoordinates(k,1) - initialCoordinates(j,1); %switched j and k
        distances(k,2,j) = finalCoordinates(k,2) - initialCoordinates(j,2);
        steps(k,1,j) = abs(distances(k,1,j)) + abs(distances(k,2,j));
    end
end
 
%% Find possible final positions
    %Finds the possible final positions for each marcher by checking which
    %final positions are within the step range of each marcher.
for u = 1:countMarchers
    posMoves = [];
    for v = 1:countMarchers
        if steps(v,1,u) <= max_beats/2
            posMove = finalCoordinates(v,:);
            posMoves = [posMoves;posMove];
        end
    end
    posPositions(u) = {posMoves};
end
time=0;
end
