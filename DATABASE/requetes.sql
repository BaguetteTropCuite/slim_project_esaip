SELECT 
    u.nom AS nomCompetiteur,
    u.prenom AS prenomCompetiteur,
    u.adresse,
    YEAR(CURDATE()) - YEAR(comp.datePremiereParticipation) AS ageCompetiteur,  -- Correction ici
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



SELECT 
    d.numDessins AS numeroDessin,
    e.note,
    u.nom AS nomCompetiteur,
    c.theme AS themeConcours,  -- Remplacez 'description' par 'theme'
    c.theme AS descriptionConcours  -- 'theme' est ce qui existe dans votre base de données
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


SELECT 
    d.numDessins AS numeroDessin,
    YEAR(c.dateDebut) AS anneeConcours,
    c.theme AS descriptionConcours,  -- Remplacez 'description' par 'theme'
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
    Utilisateurs u ON d.numCompetiteur = u.numUtilisateur  -- Correction de 'numCompétiteur' en 'numCompetiteur'
JOIN 
    Utilisateurs eval ON e.numEvaluateur = eval.numUtilisateur
JOIN 
    Concours c ON d.numConcours = c.numConcours;




SELECT 
    u.nom AS nomCompetiteur,
    u.prenom AS prenomCompetiteur,
    YEAR(CURDATE()) - YEAR(comp.datePremiereParticipation) AS ageCompetiteur  -- Corriger la référence à datePremiereParticipation
FROM 
    Utilisateurs u
JOIN 
    Competiteurs comp ON u.numUtilisateur = comp.numCompetiteur
JOIN 
    ParticipeCompetiteur pc ON comp.numCompetiteur = pc.numCompetiteur  -- Corriger le nom de la table
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
    Dessins d ON comp.numCompetiteur = d.numCompetiteur  -- Correction du nom de la table
JOIN 
    Evaluation e ON d.numDessins = e.numDessins
GROUP BY 
    cl.region
ORDER BY 
    moyenneNotes DESC
LIMIT 1;
