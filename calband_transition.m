function [instructions] = calband_transition(initial_formation, target_formation, max_beats)
 
[posPositions,time] = possibleFinalPositions(initial_formation, target_formation, max_beats);
[finalPosition,finalPositionCoordinates] = myfinalPosition(posPositions,target_formation,time);
[step_list] = StepList(finalPositionCoordinates,initial_formation);
 
i_target=[];
j_target=[];
n=length(step_list);
wait=cell(1,n);
wait_k=[];
direction=cell(1,n);
 
instructions=struct('i_target',i_target,'j_target',j_target,'wait',wait,'direction',direction);
 
% calculate the possible wait time for each marcher  
for k=1:n
    instructions(k).i_target=finalPositionCoordinates(k,1);
    instructions(k).j_target=finalPositionCoordinates(k,2);
    
    wait_total = max_beats/2 - sum(abs(step_list{k}(1,:)));
    % one grid cell per 2 beats
 
        if wait_total >= 0
            wait_k=[0,wait_total];
 
            for l=1:wait_total
                wait_before=l;
                wait_after=wait_total-wait_before;
                wait_k=[wait_k;wait_before,wait_after];
            end
            % end of wait time combination for each matcher
        end
 
            instructions(k).wait=wait_k(1);
            % Store the list of each marcher to corresponding cell
            
     % For each direction set from steplist, finds the possible directions
     % the marcher could travel
     if step_list{k}(1,1)==0 && step_list{k}(2,2)==0
            instructions(k).direction=('.');
     elseif step_list{k}(1,1) < 0 && step_list{k}(2,2)==0
            instructions(k).direction=('W');
     elseif step_list{k}(1,1) > 0 && step_list{k}(2,2)==0
            instructions(k).direction=('E');
     elseif step_list{k}(1,1) == 0 && step_list{k}(2,2) < 0
            instructions(k).direction=('S');
     elseif step_list{k}(1,1) == 0 && step_list{k}(2,2) > 0
            instructions(k).direction=('N');       
     elseif step_list{k}(1,1) < 0 && step_list{k}(2,2) < 0
            direction=['SW','WS'];
            instructions(k).direction=direction(1:2);
     elseif step_list{k}(1,1) < 0 && step_list{k}(2,2) > 0
            direction=['NW','WN'];
            instructions(k).direction=direction(1:2);
     elseif step_list{k}(1,1) > 0 && step_list{k}(2,2) < 0
            direction=['SE','ES'];
            instructions(k).direction=direction(1:2);          
     elseif step_list{k}(1,1) > 0 && step_list{k}(2,2) > 0
            direction=['NE','EN'];
            instructions(k).direction=direction(1:2);
     end    
    % end of direction assignment 
         
end