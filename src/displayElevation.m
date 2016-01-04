function [  ] = displayElevation( trk )

    timeStr = strrep(trk.Time, 'T', ' ');
    timeStr = strrep(timeStr, 'Z', '');
    trk.DateNumber = datenum(timeStr, 31);
    day = fix(trk.DateNumber(1));
    trk.TimeOfDay = trk.DateNumber - day;

    figure
    minEle = min(trk.Elevation);
    trk.Elevation = trk.Elevation-minEle;
    area(trk.TimeOfDay, trk.Elevation)
    datetick('x', 13, 'keepticks', 'keeplimits')
    ylabel('elevation (meters)')
    xlabel('time(Z) hours:minutes:seconds')
    title({'Elevation Area Plot Adrien le bg', datestr(day)});

end

