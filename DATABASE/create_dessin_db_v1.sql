-- Accorder tous les privilèges à l'utilisateur esaip
GRANT ALL PRIVILEGES ON *.* TO 'esaip'@'%' IDENTIFIED BY 'esaip' WITH GRANT OPTION;
FLUSH PRIVILEGES;


CREATE DATABASE ConcoursDessin;
USE ConcoursDessin;

CREATE TABLE Club (
    numClub INT AUTO_INCREMENT PRIMARY KEY,
    numDirecteur INT NOT NULL,
    nomClub VARCHAR(255) NOT NULL,
    adresse VARCHAR(255),
    numTelephone VARCHAR(15),
    nombreAdherents SMALLINT,
    ville VARCHAR(100),
    departement VARCHAR(100),
    region VARCHAR(100)
);

CREATE TABLE Utilisateurs (
    numUtilisateur INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    adresse VARCHAR(255) NOT NULL,
    login VARCHAR(50) UNIQUE NOT NULL,
    motDePasse VARCHAR(255) NOT NULL,
    numClub INT NOT NULL,
    FOREIGN KEY (numClub) REFERENCES Club(numClub)
);

CREATE TABLE Directeur (
    numDirecteur INT PRIMARY KEY,
    dateDebut DATE NOT NULL,
    FOREIGN KEY (numDirecteur) REFERENCES Utilisateurs(numUtilisateur)
);

CREATE TABLE Concours (
    numConcours INT AUTO_INCREMENT PRIMARY KEY,
    numPresident INT NOT NULL,
    theme VARCHAR(255) NOT NULL,
    dateDebut DATE NOT NULL,
    dateFin DATE NOT NULL,
    etat ENUM('non commence', 'en cours', 'en attente des resultats', 'evalue') NOT NULL,
    FOREIGN KEY (numPresident) REFERENCES Utilisateurs(numUtilisateur)
);

CREATE TABLE President (
    numPresident INT PRIMARY KEY,
    prime INT NOT NULL,
    FOREIGN KEY (numPresident) REFERENCES Utilisateurs(numUtilisateur)
);

CREATE TABLE Competiteurs (
    numCompetiteur INT PRIMARY KEY,
    datePremiereParticipation DATE NOT NULL,
    FOREIGN KEY (numCompetiteur) REFERENCES Utilisateurs(numUtilisateur)
);

CREATE TABLE Dessins (
    numDessins INT AUTO_INCREMENT PRIMARY KEY,
    commentaire TEXT,
    classement INT,
    dateRemise DATE,
    leDessin TEXT,
    numConcours INT NOT NULL,
    numCompetiteur INT NOT NULL,
    FOREIGN KEY (numConcours) REFERENCES Concours(numConcours),
    FOREIGN KEY (numCompetiteur) REFERENCES Competiteurs(numCompetiteur)
);

CREATE TABLE Evaluateur (
    numEvaluateur INT PRIMARY KEY,
    specialite VARCHAR(255) NOT NULL,
    FOREIGN KEY (numEvaluateur) REFERENCES Utilisateurs(numUtilisateur)
);

CREATE TABLE Evaluation (
    numDessins INT NOT NULL,
    numEvaluateur INT NOT NULL,
    dateEvaluation DATE,
    note INT,
    commentaire TEXT,
    PRIMARY KEY (numDessins, numEvaluateur),
    FOREIGN KEY (numDessins) REFERENCES Dessins(numDessins),
    FOREIGN KEY (numEvaluateur) REFERENCES Evaluateur(numEvaluateur)
);

CREATE TABLE Administrateur (
    numAdministrateur INT PRIMARY KEY,
    dateDebut DATE,
    FOREIGN KEY (numAdministrateur) REFERENCES Utilisateurs(numUtilisateur)
);

CREATE TABLE Jury (
    numEvaluateur INT NOT NULL,
    numConcours INT NOT NULL,
    PRIMARY KEY (numEvaluateur, numConcours),
    FOREIGN KEY (numEvaluateur) REFERENCES Evaluateur(numEvaluateur),
    FOREIGN KEY (numConcours) REFERENCES Concours(numConcours)
);

CREATE TABLE ParticipeCompetiteur (
    numCompetiteur INT NOT NULL,
    numConcours INT NOT NULL,
    PRIMARY KEY (numCompetiteur, numConcours),
    FOREIGN KEY (numCompetiteur) REFERENCES Competiteurs(numCompetiteur),
    FOREIGN KEY (numConcours) REFERENCES Concours(numConcours)
);

CREATE TABLE ParticipeClub (
    numClub INT NOT NULL,
    numConcours INT NOT NULL,
    PRIMARY KEY (numClub, numConcours),
    FOREIGN KEY (numClub) REFERENCES Club(numClub),
    FOREIGN KEY (numConcours) REFERENCES Concours(numConcours)
);
