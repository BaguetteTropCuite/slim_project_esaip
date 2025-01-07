CREATE DATABASE ConcoursDessin;
USE ConcoursDessin;

-- Table Club
CREATE TABLE Club (
    numClub INT AUTO_INCREMENT PRIMARY KEY,
    numDirecteur INT NOT NULL,
    nomClub VARCHAR(255) NOT NULL,
    adresse VARCHAR(255),
    numTelephone VARCHAR(15),
    nombreAdherents INT,
    ville VARCHAR(100),
    departement VARCHAR(100),
    region VARCHAR(100)
);

-- Table Utilisateurs
CREATE TABLE Utilisateurs (
    numUtilisateur INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    adresse VARCHAR(255),
    login VARCHAR(50) UNIQUE NOT NULL,
    motDePasse VARCHAR(255) NOT NULL,
    numClub INT,
    FOREIGN KEY (numClub) REFERENCES Club(numClub) ON DELETE CASCADE
);

-- Table Directeur
CREATE TABLE Directeur (
    numDirecteur INT PRIMARY KEY,
    dateDebut DATE,
    FOREIGN KEY (numDirecteur) REFERENCES Utilisateurs(numUtilisateur) ON DELETE CASCADE
);

-- Table Concours
CREATE TABLE Concours (
    numConcours INT AUTO_INCREMENT PRIMARY KEY,
    numPresident INT NOT NULL,
    theme VARCHAR(255) NOT NULL,
    dateDebut DATE NOT NULL,
    dateFin DATE NOT NULL,
    etat ENUM('non commence', 'en cours', 'en attente des resultats', 'evalue') NOT NULL,
    FOREIGN KEY (numPresident) REFERENCES Utilisateurs(numUtilisateur) ON DELETE CASCADE
);

-- Table Président
CREATE TABLE President (
    numPresident INT PRIMARY KEY,
    prime DECIMAL(10, 2),
    FOREIGN KEY (numPresident) REFERENCES Utilisateurs(numUtilisateur) ON DELETE CASCADE
);

-- Table Compétiteurs
CREATE TABLE Competiteurs (
    numCompetiteur INT PRIMARY KEY,
    datePremiereParticipation DATE,
    FOREIGN KEY (numCompetiteur) REFERENCES Utilisateurs(numUtilisateur) ON DELETE CASCADE
);

-- Table Dessins
CREATE TABLE Dessins (
    numDessins INT AUTO_INCREMENT PRIMARY KEY,
    commentaire TEXT,
    classement INT,
    dateRemise DATE,
    leDessin TEXT,
    numConcours INT NOT NULL,
    numCompetiteur INT NOT NULL,
    FOREIGN KEY (numConcours) REFERENCES Concours(numConcours) ON DELETE CASCADE,
    FOREIGN KEY (numCompetiteur) REFERENCES Competiteurs(numCompetiteur) ON DELETE CASCADE
);

-- Table Evaluateur
CREATE TABLE Evaluateur (
    numEvaluateur INT PRIMARY KEY,
    specialite VARCHAR(255),
    FOREIGN KEY (numEvaluateur) REFERENCES Utilisateurs(numUtilisateur) ON DELETE CASCADE
);

-- Table Evaluation
CREATE TABLE Evaluation (
    numDessins INT NOT NULL,
    numEvaluateur INT NOT NULL,
    dateEvaluation DATE,
    note DECIMAL(4, 2),
    commentaire TEXT,
    PRIMARY KEY (numDessins, numEvaluateur),
    FOREIGN KEY (numDessins) REFERENCES Dessins(numDessins) ON DELETE CASCADE,
    FOREIGN KEY (numEvaluateur) REFERENCES Evaluateur(numEvaluateur) ON DELETE CASCADE
);

-- Table Administrateur
CREATE TABLE Administrateur (
    numAdministrateur INT PRIMARY KEY,
    dateDebut DATE,
    FOREIGN KEY (numAdministrateur) REFERENCES Utilisateurs(numUtilisateur) ON DELETE CASCADE
);

-- Table Jury
CREATE TABLE Jury (
    numEvaluateur INT NOT NULL,
    numConcours INT NOT NULL,
    PRIMARY KEY (numEvaluateur, numConcours),
    FOREIGN KEY (numEvaluateur) REFERENCES Evaluateur(numEvaluateur) ON DELETE CASCADE,
    FOREIGN KEY (numConcours) REFERENCES Concours(numConcours) ON DELETE CASCADE
);

-- Table Participe Competiteur
CREATE TABLE ParticipeCompetiteur (
    numCompetiteur INT NOT NULL,
    numConcours INT NOT NULL,
    PRIMARY KEY (numCompetiteur, numConcours),
    FOREIGN KEY (numCompetiteur) REFERENCES Competiteurs(numCompetiteur) ON DELETE CASCADE,
    FOREIGN KEY (numConcours) REFERENCES Concours(numConcours) ON DELETE CASCADE
);

-- Table Participe Club
CREATE TABLE ParticipeClub (
    numClub INT NOT NULL,
    numConcours INT NOT NULL,
    PRIMARY KEY (numClub, numConcours),
    FOREIGN KEY (numClub) REFERENCES Club(numClub) ON DELETE CASCADE,
    FOREIGN KEY (numConcours) REFERENCES Concours(numConcours) ON DELETE CASCADE
);