function [ average_speed, distance_done ] = computeAverageSpeed( trk )
    
    % Structure d'average speed :
    % Les vitesses sont stockées avec respectivement la pente la plus
    % descente jusqu'à la plus montante.
    average_speed = zeros(1,9);
    distance_done = zeros(1,9);

    % Classement des points
    %dist=0;
    cpt_portion = 1;
    portion = struct;
    cpt_test = 0;
    for i=2:size(trk,1)

        %dist = dist+computeDistance(trk(i),trk(i-1));

        % Compute elevation between the curent point and the previous point
        elevation_crt = trk(i).Elevation-trk(i-1).Elevation;

        % Compute distance
        portion(cpt_portion).Distance = computeDistance(trk(i),trk(i-1));

        % Compute elevation
        portion(cpt_portion).Slope = 100*asin(elevation_crt/portion(cpt_portion).Distance);

        % Compute duration
        timeStr_crt = strrep(trk(i).Time, 'T', ' ');
        timeStr_crt = strrep(timeStr_crt, 'Z', '');
        timeStr_prev = strrep(trk(i-1).Time, 'T', ' ');
        timeStr_prev = strrep(timeStr_prev, 'Z', '');
        trk(i).DateNumber = datenum(timeStr_crt, 31);
        trk(i-1).DateNumber = datenum(timeStr_prev, 31);
        portion(cpt_portion).Duration = etime(datevec(trk(i).DateNumber), datevec(trk(i-1).DateNumber));

        % Compute average speed
        portion(cpt_portion).Speed = 3.6 * portion(cpt_portion).Distance/portion(cpt_portion).Duration;
        cpt_test = cpt_test + portion(cpt_portion).Speed;

        % Compute class
        % Plat
        if portion(cpt_portion).Slope <= 5 && portion(cpt_portion).Slope >= -5
            portion(cpt_portion).Class = 0;  
        end
        % Montée
        if portion(cpt_portion).Slope > 5 && portion(cpt_portion).Slope <= 7
            portion(cpt_portion).Class = 1;
        end
        if portion(cpt_portion).Slope > 7 && portion(cpt_portion).Slope <= 10
            portion(cpt_portion).Class = 2;
        end
        if portion(cpt_portion).Slope > 10 && portion(cpt_portion).Slope <= 15
            portion(cpt_portion).Class = 3;
        end
        if portion(cpt_portion).Slope > 15
            portion(cpt_portion).Class = 4;
        end
        %Descente
        if portion(cpt_portion).Slope < -5 && portion(cpt_portion).Slope >= -7
            portion(cpt_portion).Class = -1;
        end
        if portion(cpt_portion).Slope < -7 && portion(cpt_portion).Slope >= -10
            portion(cpt_portion).Class = -2;
        end
        if portion(cpt_portion).Slope < -10 && portion(cpt_portion).Slope >= -15
            portion(cpt_portion).Class = -3;
        end
        if portion(cpt_portion).Slope < -15
            portion(cpt_portion).Class = -4;
        end

        cpt_portion = cpt_portion+1;
    end

    % Find all the portions when the runner climbs
    M1 = find([portion.Class] == 1);
    M2 = find([portion.Class] == 2);
    M3 = find([portion.Class] == 3);
    M4 = find([portion.Class] == 4);

    D1 = find([portion.Class] == -1);
    D2 = find([portion.Class] == -2);
    D3 = find([portion.Class] == -3);
    D4 = find([portion.Class] == -4);

    P = find([portion.Class] == 0);

    % Compute average speed in climbs, descents and flats
    v_M1 = 0;
    for i=1:size(M1,2)
        cpt = M1(1,i);
        v_M1 = v_M1 + (portion(cpt).Speed)/size(M1,2);
        average_speed(1,6) = v_M1;
        distance_done(1,6) = distance_done(1,6) + portion(cpt).Distance;
    end

    v_M2 = 0;
    for i=1:size(M2,2)
        cpt = M2(1,i);
        v_M2 = v_M2 + (portion(cpt).Speed)/size(M2,2);
        average_speed(1,7) = v_M2;
        distance_done(1,7) = distance_done(1,7) + portion(cpt).Distance;
    end

    v_M3 = 0;
    for i=1:size(M3,2)
        cpt = M3(1,i);
        v_M3 = v_M3 + (portion(cpt).Speed)/size(M3,2);
        average_speed(1,8) = v_M3;
        distance_done(1,8) = distance_done(1,8) + portion(cpt).Distance;
    end

    v_M4 = 0;
    for i=1:size(M4,2)
        cpt = M4(1,i);
        v_M4 = v_M4 + (portion(cpt).Speed)/size(M4,2);
        average_speed(1,9) = v_M4;
        distance_done(1,9) = distance_done(1,9) + portion(cpt).Distance;
    end

    v_D1 = 0;
    for i=1:size(D1,2)
        cpt = D1(1,i);
        v_D1 = v_D1 + (portion(cpt).Speed)/size(D1,2);
        average_speed(1,4) = v_D1;
        distance_done(1,4) = distance_done(1,4) + portion(cpt).Distance;
    end

    v_D2 = 0;
    for i=1:size(D2,2)
        cpt = D2(1,i);
        v_D2 = v_D2 + (portion(cpt).Speed)/size(D2,2);
        average_speed(1,3) = v_D2;
        distance_done(1,3) = distance_done(1,3) + portion(cpt).Distance;
    end

    v_D3 = 0;
    for i=1:size(D3,2)
        cpt = D3(1,i);
        v_D3 = v_D3 + (portion(cpt).Speed)/size(D3,2);
        average_speed(1,2) = v_D3;
        distance_done(1,2) = distance_done(1,2) + portion(cpt).Distance;
    end

    v_D4 = 0;
    for i=1:size(D4,2)
        cpt = D4(1,i);
        v_D4 = v_D4 + (portion(cpt).Speed)/size(D4,2);
        average_speed(1,1) = v_D4;
        distance_done(1,1) = distance_done(1,1) + portion(cpt).Distance;
    end

    v_P = 0;
    for i=1:size(P,2)
        cpt = P(1,i);
        v_P = v_P + (portion(cpt).Speed)/size(P,2);
        average_speed(1,5) = v_P;
        distance_done(1,5) = distance_done(1,5) + portion(cpt).Distance;
    end

    % Display
    disp('Affichage de la vitesse moyenne du coureur en fonction du profil du terrain');
    disp(['La vitesse moyenne en descente (<-15%) est ', num2str( average_speed(1,1)), 'km/h']);
    disp(['La vitesse moyenne en descente (-10%->-15%) est ', num2str( average_speed(1,2)), 'km/h']);
    disp(['La vitesse moyenne en descente (-7%->-10%) est ', num2str( average_speed(1,3)), 'km/h']);
    disp(['La vitesse moyenne en descente (-5%->-7%) est ', num2str( average_speed(1,4)), 'km/h']);
    disp(['La vitesse moyenne sur plat est ', num2str( average_speed(1,5)), 'km/h']);
    disp(['La vitesse moyenne en montée (5%->7%) est ', num2str( average_speed(1,6)), 'km/h']);
    disp(['La vitesse moyenne en montée (7%->10%) est ', num2str( average_speed(1,7)), 'km/h']);
    disp(['La vitesse moyenne en montée (10%->15%) est ', num2str( average_speed(1,8)), 'km/h']);
    disp(['La vitesse moyenne en montée (>15%) est ', num2str( average_speed(1,9)), 'km/h']);
      
end

