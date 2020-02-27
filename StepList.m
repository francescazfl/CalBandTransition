function [ step_list ] = StepList( finalPositionCoordinates,initial_formation)
% Based on function assigned_postion
% Generate step lists for each marcher to his/her assigned position
% step_list will be a 1-by-countMarchers cell
 
%% Initialization
 
% Finds the number of marchers in the transition and preallocates arrays
% Keep consistency
countMarchers = max(max(initial_formation));
step_list=cell(1,countMarchers);
 
%% Find steps for each marcher
 
% Iterate through each marcher and his/her assigned position
 
for k=1:countMarchers
 
    % Obtain the horizontal and vertical move
        [initialCoordinates(:,1),~] = find(initial_formation == k);
        [~,initialCoordinates(:,2)] = find(initial_formation == k);
        move_xy=finalPositionCoordinates(k,:)-initialCoordinates;
        % [row,column]
        % If their target location is the same as their initial location
        % Stay in place for the duration of the transition.
        % Right(column plus) and down(row plus) positive
 
%         if move_xy(1)==0 && move_xy(2)==0
%             step_list_k=[0,0,0,0;0,0,0,0];
%             
%         elseif move_xy(1)==0 && move_xy(2)~=0
%             step_list_k=[0,0,0,move_xy(2);0,move_xy(2),0,0];
%             % same row move along column
%         elseif move_xy(1)~=0 && move_xy(2)==0 
%             step_list_k=[move_xy(1),0,0,0;0,0,move_xy(1),0];
%             % same column move along row
%         else
            step_list_k=[move_xy(1),0,0,move_xy(2);0,move_xy(2),move_xy(1),0];   
            % First choice: move along row and then along column
            % Second choice: move along column and then along row
%         end
%         % End of step list for k th marcher
      
         step_list{k}=step_list_k;
        % Store the list of each marcher to corresponding cell
        
         
end
% End of interation through each marcher
    
end
 