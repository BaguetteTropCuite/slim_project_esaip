import mysql.connector
import sys

# Config database => à éditer au besoin 
config = {
    'host': 'localhost',  # => host de destination (localhost si lancer avec le compose)
    'user': 'esaip',
    'password': 'esaip',
    'database': 'ConcoursDessin'
}

# Liste des requêtes prédéfini dans le projet
requêtes = {
    "1": """
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
    """,
    "2": """
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
            Utilisateurs u ON d.numCompetiteur = u.numUtilisateur
        JOIN 
            Concours c ON d.numConcours = c.numConcours
        WHERE 
            YEAR(e.dateEvaluation) = 2023
        ORDER BY 
            e.note ASC;
    """,
    "3": """
        SELECT 
            d.numDessins AS numeroDessin,
            YEAR(c.dateDebut) AS anneeConcours,
            c.theme AS descriptionConcours,
            u.nom AS nomCompetiteur,
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
    """,
    "4": """
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
    """,
    "5": """
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
    """
}



# Fonction pour lancer les requêtes SQL VERS LA DB 

def exécuter_requête(num):
    try:
        conn = mysql.connector.connect(**config)
        cursor = conn.cursor()

        requête = requêtes.get(num)
        if requête:
            print(f"\n Exécution de la requête {num}...\n")
            cursor.execute(requête)
            résultats = cursor.fetchall()

            # Affichage des colonnes
            colonnes = [desc[0] for desc in cursor.description]
            print(" | ".join(colonnes))
            print("-" * 80)

            for ligne in résultats:
                print(" | ".join(str(val) if val is not None else "NULL" for val in ligne))
            print()

        else:
            print("Numéro de requête invalide.")

        cursor.close()
        conn.close()

    except mysql.connector.Error as err:
        print(f"Erreur : {err}")
        sys.exit(1)

# Menu Princiall
while True:
    print("\n--- MENU REQUÊTES PROJET SLIMANE ---")
    print("1. Liste des compétiteurs ayant participé à un concours en 2024")
    print("2. Liste des dessins évalués en 2023 avec notes et commentaires")
    print("3. Détails des dessins et évaluations")
    print("4. Liste des compétiteurs ayant participé à tous les concours de 2023 et 2024")
    print("5. Club avec la meilleure moyenne de notes par région")
    print("0. Quitter")

    choix = input("\nVotre choix : ").strip()

    if choix == "0":
        print("Au revoir Monsieur Slimane !")
        break
    else:
        exécuter_requête(choix)