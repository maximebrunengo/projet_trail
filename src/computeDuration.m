function [ duration ] = computeDuration( trk )

    % Classement des points
    %dist=0;
    cpt_portion = 1;
    portion = struct;
    duration = 0;
    
    for i=2:size(trk,1)
        % Compute duration
        
        timeStr_crt = strrep(trk(i).Time, 'T', ' ');
        timeStr_crt = strrep(timeStr_crt, 'Z', '');
        timeStr_prev = strrep(trk(i-1).Time, 'T', ' ');
        timeStr_prev = strrep(timeStr_prev, 'Z', '');
        trk(i).DateNumber = datenum(timeStr_crt, 31);
        trk(i-1).DateNumber = datenum(timeStr_prev, 31);
        portion(cpt_portion).Duration = etime(datevec(trk(i).DateNumber), datevec(trk(i-1).DateNumber));
        duration = duration + portion(cpt_portion).Duration;
        
        cpt_portion = cpt_portion + 1;
    end
    
end

