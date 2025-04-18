# Requêtes SQL pour le projet de gestion de concours de dessins


#Requête 1 : Afficher le nom et l’adresse et l’âge de tous les compétiteurs qui ont participé dans un concours en 2024.  Vous afficherez aussi la description du concours la date de début et la date de fin. Le club du compétiteur, le département et la région.
SELECT 
    u.nom AS nomCompetiteur,
    u.prenom AS prenomCompetiteur,
    u.adresse,
    YEAR(CURDATE()) - YEAR(comp.datePremiereParticipation) AS ageCompetiteur,
    c.theme AS descriptionConcours,
    c.dateDebut,
    c.dateFin,
    cl.nomClub AS nomClub,
    cl.departement,
    cl.region
FROM 
    Utilisateurs u
JOIN 
    Competiteurs comp ON u.numUtilisateur = comp.numCompetiteur
JOIN 
    ParticipeCompetiteur pc ON comp.numCompetiteur = pc.numCompetiteur
JOIN 
    Concours c ON pc.numConcours = c.numConcours
JOIN 
    Club cl ON u.numClub = cl.numClub
WHERE 
    YEAR(c.dateDebut) = 2024 
LIMIT 0, 25;


# Requête 2 : Afficher par ordre croissant de la note tous les dessins qui ont été évalués en 2023. Vous afficherez les informations suivantes : le numéro du dessin et la note attribuée, le nom du compétiteur, la description du concours et le thème du concours.
SELECT 
    d.numDessins AS numeroDessin,
    e.note,
    u.nom AS nomCompetiteur,
    c.theme AS themeConcours,
    c.theme AS descriptionConcours
FROM 
    Dessins d
JOIN 
    Evaluation e ON d.numDessins = e.numDessins
JOIN 
    Utilisateurs u ON d.numCompetiteur = u.numUtilisateur  -- Correction de 'numCompétiteur' en 'numCompetiteur'
JOIN 
    Concours c ON d.numConcours = c.numConcours
WHERE 
    YEAR(e.dateEvaluation) = 2023
ORDER BY 
    e.note ASC;


# Requête 3 :Pour cette requête on vous demande d’afficher des informations sur tous les dessins qui ont été évalués et qui sont stockés dans la base. Voici les informations qu’on souhaite voir affichés : le numéro, l’année, la description du concours dans lequel le dessin a été évalué ; le nom du compétiteur ayant proposé le dessin ; le numéro et le commentaire du dessin fait par le compétiteur ; la note et le commentaire de l’évaluation ; le nom de l’évaluateur.
SELECT 
    d.numDessins AS numeroDessin,
    YEAR(c.dateDebut) AS anneeConcours,
    c.theme AS descriptionConcours,
    u.nom AS nomCompetiteur,
    d.numDessins AS numeroDessin,
    d.commentaire AS commentaireDessin,
    e.note,
    e.commentaire AS commentaireEvaluation,
    eval.nom AS nomEvaluateur
FROM 
    Dessins d
JOIN 
    Evaluation e ON d.numDessins = e.numDessins
JOIN 
    Utilisateurs u ON d.numCompetiteur = u.numUtilisateur
JOIN 
    Utilisateurs eval ON e.numEvaluateur = eval.numUtilisateur
JOIN 
    Concours c ON d.numConcours = c.numConcours;



# Requête 4 :Nom, prénom et âge des compétiteurs qui ont participé à tous les concours qui ont été organisés en 2023 et 2024. L’affichage doit se faire dans l’ordre croissant des âges.
SELECT 
    u.nom AS nomCompetiteur,
    u.prenom AS prenomCompetiteur,
    YEAR(CURDATE()) - YEAR(comp.datePremiereParticipation) AS ageCompetiteur
FROM 
    Utilisateurs u
JOIN 
    Competiteurs comp ON u.numUtilisateur = comp.numCompetiteur
JOIN 
    ParticipeCompetiteur pc ON comp.numCompetiteur = pc.numCompetiteur
JOIN 
    Concours c ON pc.numConcours = c.numConcours
WHERE 
    c.dateDebut BETWEEN '2023-01-01' AND '2024-12-31'
GROUP BY 
    comp.numCompetiteur
HAVING 
    COUNT(DISTINCT c.numConcours) = (
        SELECT 
            COUNT(*) 
        FROM 
            Concours
        WHERE 
            YEAR(dateDebut) IN (2023, 2024)
    )
ORDER BY 
    ageCompetiteur ASC;



# Requête 5 :Nom de la région qui a la meilleure moyenne des notes des dessins proposés. Afficher le nom de la région et la moyenne des notes de cette région.
SELECT 
    cl.region,
    AVG(e.note) AS moyenneNotes
FROM 
    Club cl
JOIN 
    Utilisateurs u ON cl.numClub = u.numClub
JOIN 
    Competiteurs comp ON u.numUtilisateur = comp.numCompetiteur
JOIN 
    Dessins d ON comp.numCompetiteur = d.numCompetiteur
JOIN 
    Evaluation e ON d.numDessins = e.numDessins
GROUP BY 
    cl.region
ORDER BY 
    moyenneNotes DESC
LIMIT 1;
