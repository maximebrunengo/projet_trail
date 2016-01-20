function [ values ] = displayExhaust( trk )
    
    portion = struct;
    cpt_ex = 1;
    distance_from_beginning = 0;
    cpt_portion = 1;
    
    for i=2:size(trk,1)
        % Compute elevation between the curent point and the previous point
        elevation_crt = trk(i).Elevation-trk(i-1).Elevation;
        
        % Compute distance
        portion(cpt_portion).Distance = computeDistance(trk(i),trk(i-1));
        distance_from_beginning = distance_from_beginning + portion(cpt_portion).Distance;
        
        % Compute elevation
        if portion(cpt_portion).Distance == 0
            portion(cpt_portion).Slope = 0;
        else
            portion(cpt_portion).Slope = 100*asin(elevation_crt/portion(cpt_portion).Distance);
        end
        
        % Compute duration         
        timeStr_crt = strrep(trk(i).Time, 'T', ' ');
        timeStr_crt = strrep(timeStr_crt, 'Z', '');
        timeStr_prev = strrep(trk(i-1).Time, 'T', ' ');
        timeStr_prev = strrep(timeStr_prev, 'Z', '');
        trk(i).DateNumber = datenum(timeStr_crt, 31);
        trk(i-1).DateNumber = datenum(timeStr_prev, 31);
        portion(cpt_portion).Duration = etime(datevec(trk(i).DateNumber), datevec(trk(i-1).DateNumber));

        % Compute average speed
        if portion(cpt_portion).Duration == 0
            portion(cpt_portion).Speed = 0;
        else
            portion(cpt_portion).Speed = 3.6 * portion(cpt_portion).Distance/portion(cpt_portion).Duration;
        end
        
        % .....
        if portion(cpt_portion).Slope > 7 && portion(cpt_portion).Slope <= 10
            values(1, cpt_ex) = distance_from_beginning;
            values(2, cpt_ex) = portion(cpt_portion).Speed;
            cpt_ex = cpt_ex+1;
        end
        
        cpt_portion = cpt_portion+1;
    end
    
    figure, plot(values(1,:), values(2,:), '*');

end

