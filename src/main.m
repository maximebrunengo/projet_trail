function [ Coureur ] = main( Coureur, Nom, Prenom, trk )

    Nom_coureur = Nom;
    Prenom_coureur = Prenom;

    [average_speed, distance_done] = computeAverageSpeed(trk);

    %Verifier si le coureur est deja dans la structure Coureur
    index_coureur = find(strcmp({Coureur.Nom}, Nom_coureur)==1);

    if isempty(index_coureur)

        sizeCoureur = size(Coureur);
        Coureur(sizeCoureur(1,2)+1).Nom = Nom_coureur;
        Coureur(sizeCoureur(1,2)+1).Prenom = Prenom_coureur;
        Coureur(sizeCoureur(1,2)+1).Speed = average_speed;
        Coureur(sizeCoureur(1,2)+1).DistanceDone = distance_done;

    else

        current_speed = Coureur(index_coureur).Speed;
        current_distance = Coureur(index_coureur).DistanceDone;
        new_speed = zeros(1,9);
        new_distance = zeros(1,9);
        for i=1:9
            if current_distance(1,i)+distance_done(1,i) == 0
                new_speed(1,i) = 0;
            else
                new_speed(1,i) = (current_speed(1,i)*current_distance(1,i)+average_speed(1,i)*distance_done(1,i))/(current_distance(1,i)+distance_done(1,i));                
            end
            new_distance(1,i) = current_distance(1,i)+distance_done(1,i);
        end

        Coureur(index_coureur).Speed = new_speed;
        Coureur(index_coureur).DistanceDone = new_distance;

    end

    % Affichage de la course dont on cherche les vitesses moyennes
    displayElevation(trk);
end



