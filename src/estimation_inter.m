function [ timeFromBeginning ] = estimation_inter( Nom, trk, liste_points )

    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Estimation d'une course %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    load('coureur_struct.mat');

    index_coureur = find(strcmp({Coureur.Nom}, Nom)==1);

    trk(1).DistanceFromBeginning = 0;
    for i=2:size(trk,1)
        distanceToAdd = computeDistance(trk(i),trk(i-1));
        trk(i).DistanceFromBeginning = trk(i-1).DistanceFromBeginning + distanceToAdd;
    end

    % Estimation du temps total
    portion = struct;

    timeFromBeginning = 0;
    cpt_portion = 1;
    j=1;
    
    for i=2:size(trk,1)
        
        % Compute elevation between the curent point and the previous point
        elevation_crt = trk(i).Elevation-trk(i-1).Elevation;

        % Compute distance
        portion(cpt_portion).Distance = computeDistance(trk(i),trk(i-1));
        
        % Compute slope
        if portion(cpt_portion).Distance == 0
            portion(cpt_portion).Slope = 0;
        else
            portion(cpt_portion).Slope = 100*asin(elevation_crt/portion(cpt_portion).Distance);
        end

        % Plat
        if portion(cpt_portion).Slope <= 5 && portion(cpt_portion).Slope >= -5
            portion(cpt_portion).Class = 0;  
            portion(cpt_portion).AverageSpeed = Coureur(index_coureur).Speed(1,5);
        end
        % Montée
        if portion(cpt_portion).Slope > 5 && portion(cpt_portion).Slope <= 7
            portion(cpt_portion).Class = 1;
            portion(cpt_portion).AverageSpeed = Coureur(index_coureur).Speed(1,6);
        end
        if portion(cpt_portion).Slope > 7 && portion(cpt_portion).Slope <= 10
            portion(cpt_portion).Class = 2;
            portion(cpt_portion).AverageSpeed = Coureur(index_coureur).Speed(1,7);
        end
        if portion(cpt_portion).Slope > 10 && portion(cpt_portion).Slope <= 15
            portion(cpt_portion).Class = 3;
            portion(cpt_portion).AverageSpeed = Coureur(index_coureur).Speed(1,8);
        end
        if portion(cpt_portion).Slope > 15
            portion(cpt_portion).Class = 4;
            portion(cpt_portion).AverageSpeed = Coureur(index_coureur).Speed(1,9);
        end
        %Descente
        if portion(cpt_portion).Slope < -5 && portion(cpt_portion).Slope >= -7
            portion(cpt_portion).Class = -1;
            portion(cpt_portion).AverageSpeed = Coureur(index_coureur).Speed(1,4);
        end
        if portion(cpt_portion).Slope < -7 && portion(cpt_portion).Slope >= -10
            portion(cpt_portion).Class = -2;
            portion(cpt_portion).AverageSpeed = Coureur(index_coureur).Speed(1,3);
        end
        if portion(cpt_portion).Slope < -10 && portion(cpt_portion).Slope >= -15
            portion(cpt_portion).Class = -3;
            portion(cpt_portion).AverageSpeed = Coureur(index_coureur).Speed(1,2);
        end
        if portion(cpt_portion).Slope < -15
            portion(cpt_portion).Class = -4;
            portion(cpt_portion).AverageSpeed = Coureur(index_coureur).Speed(1,1);
        end

        % Compute time needed to do the portion
        portion(cpt_portion).TimeNeeded = 3.6*portion(cpt_portion).Distance/portion(cpt_portion).AverageSpeed;

        timeFromBeginning = timeFromBeginning + portion(cpt_portion).TimeNeeded;
        
        if j<= size(liste_points,2)
            if trk(i).DistanceFromBeginning >= liste_points(1,j)
                inter = datestr(timeFromBeginning/86400, 'HH:MM:SS');
                fprintf('Temps au %5.0f m : %s\n',liste_points(1,j), inter);
                j=j+1;
            end
        end
        
        timeEstimate = datestr(timeFromBeginning/86400, 'HH:MM:SS');

        cpt_portion = cpt_portion+1;
    end
    
    % Affichage du tracé
    displayElevationFromDistance(trk);
    
    disp(['Estimation totale : ', num2str(timeEstimate), '.']);

end



