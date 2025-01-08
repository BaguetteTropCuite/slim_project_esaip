SELECT 
    u.nom AS nomCompetiteur,
    u.prenom AS prenomCompetiteur,
    u.adresse,
    YEAR(CURDATE()) - YEAR(u.datePremiereParticipation) AS ageCompetiteur,
    c.theme AS descriptionConcours,
    c.dateDebut,
    c.dateFin,
    cl.nomClub AS nomClub,
    cl.departement,
    cl.region
FROM 
    Utilisateurs u
JOIN 
    Compétiteurs comp ON u.numUtilisateur = comp.numCompétiteur
JOIN 
    Participe_Compétiteur pc ON comp.numCompétiteur = pc.numCompétiteur
JOIN 
    Concours c ON pc.numConcours = c.numConcours
JOIN 
    Club cl ON u.numClub = cl.numClub
WHERE 
    YEAR(c.dateDebut) = 2024;



SELECT 
    d.numDessins AS numeroDessin,
    e.note,
    u.nom AS nomCompetiteur,
    c.theme AS themeConcours,
    c.description AS descriptionConcours
FROM 
    Dessin d
JOIN 
    Evaluation e ON d.numDessins = e.numDessins
JOIN 
    Utilisateurs u ON d.numCompétiteur = u.numUtilisateur
JOIN 
    Concours c ON d.numConcours = c.numConcours
WHERE 
    YEAR(e.dateEvaluation) = 2023
ORDER BY 
    e.note ASC;


SELECT 
    d.numDessins AS numeroDessin,
    YEAR(c.dateDebut) AS anneeConcours,
    c.description AS descriptionConcours,
    u.nom AS nomCompetiteur,
    d.numDessins AS numeroDessin,
    d.commentaire AS commentaireDessin,
    e.note,
    e.commentaire AS commentaireEvaluation,
    eval.nom AS nomEvaluateur
FROM 
    Dessin d
JOIN 
    Evaluation e ON d.numDessins = e.numDessins
JOIN 
    Utilisateurs u ON d.numCompétiteur = u.numUtilisateur
JOIN 
    Utilisateurs eval ON e.numEvaluateur = eval.numUtilisateur
JOIN 
    Concours c ON d.numConcours = c.numConcours;



SELECT 
    u.nom AS nomCompetiteur,
    u.prenom AS prenomCompetiteur,
    YEAR(CURDATE()) - YEAR(u.datePremiereParticipation) AS ageCompetiteur
FROM 
    Utilisateurs u
JOIN 
    Compétiteurs comp ON u.numUtilisateur = comp.numCompétiteur
JOIN 
    Participe_Compétiteur pc ON comp.numCompétiteur = pc.numCompétiteur
JOIN 
    Concours c ON pc.numConcours = c.numConcours
WHERE 
    c.dateDebut BETWEEN '2023-01-01' AND '2024-12-31'
GROUP BY 
    comp.numCompétiteur
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



SELECT 
    cl.region,
    AVG(e.note) AS moyenneNotes
FROM 
    Club cl
JOIN 
    Utilisateurs u ON cl.numClub = u.numClub
JOIN 
    Compétiteurs comp ON u.numUtilisateur = comp.numCompétiteur
JOIN 
    Dessin d ON comp.numCompétiteur = d.numCompétiteur
JOIN 
    Evaluation e ON d.numDessins = e.numDessins
GROUP BY 
    cl.region
ORDER BY 
    moyenneNotes DESC
LIMIT 1;
