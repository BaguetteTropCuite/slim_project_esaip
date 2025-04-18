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


INSERT INTO Club (numClub,numDirecteur,nomClub,adresse,numTelephone,nombreAdherents,ville,departement,region) VALUES (1, 101, 'Club A', '10 Rue A', '0101010101', 50, 'Paris', 'Paris', 'Ile-de-France');
INSERT INTO Club (numClub,numDirecteur,nomClub,adresse,numTelephone,nombreAdherents,ville,departement,region) VALUES (2, 102, 'Club B', '20 Rue B', '0202020202', 45, 'Lyon', 'Rhône', 'Auvergne-Rhône-Alpes');
INSERT INTO Club (numClub,numDirecteur,nomClub,adresse,numTelephone,nombreAdherents,ville,departement,region) VALUES (3, 103, 'Club C', '30 Rue C', '0303030303', 60, 'Marseille', 'Bouches-du-Rhône', "Provence-Alpes-Côte d'Azur");
INSERT INTO Club (numClub,numDirecteur,nomClub,adresse,numTelephone,nombreAdherents,ville,departement,region) VALUES (4, 104, 'Club D', '40 Rue D', '0404040404', 55, 'Toulouse', 'Haute-Garonne', 'Occitanie');
INSERT INTO Club (numClub,numDirecteur,nomClub,adresse,numTelephone,nombreAdherents,ville,departement,region) VALUES (5, 105, 'Club E', '50 Rue E', '0505050505', 65, 'Nice', 'Alpes-Maritimes', "Provence-Alpes-Côte d'Azur");
INSERT INTO Club (numClub,numDirecteur,nomClub,adresse,numTelephone,nombreAdherents,ville,departement,region) VALUES (6, 106, 'Club F', '60 Rue F', '0606060606', 40, 'Nantes', 'Loire-Atlantique', 'Pays de la Loire');

INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (101, 'DirNom1', 'DirPren1', 'Adresse Club1', 'dir1', 'mdp', 1);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (102, 'DirNom2', 'DirPren2', 'Adresse Club2', 'dir2', 'mdp', 2);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (103, 'DirNom3', 'DirPren3', 'Adresse Club3', 'dir3', 'mdp', 3);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (104, 'DirNom4', 'DirPren4', 'Adresse Club4', 'dir4', 'mdp', 4);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (105, 'DirNom5', 'DirPren5', 'Adresse Club5', 'dir5', 'mdp', 5);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (106, 'DirNom6', 'DirPren6', 'Adresse Club6', 'dir6', 'mdp', 6);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (201, 'PresNom201', 'PresPren201', 'Adresse Pres201', 'pres201', 'mdp', 2);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (202, 'PresNom202', 'PresPren202', 'Adresse Pres202', 'pres202', 'mdp', 3);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (203, 'PresNom203', 'PresPren203', 'Adresse Pres203', 'pres203', 'mdp', 4);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (204, 'PresNom204', 'PresPren204', 'Adresse Pres204', 'pres204', 'mdp', 5);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (205, 'PresNom205', 'PresPren205', 'Adresse Pres205', 'pres205', 'mdp', 6);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (206, 'PresNom206', 'PresPren206', 'Adresse Pres206', 'pres206', 'mdp', 1);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (207, 'PresNom207', 'PresPren207', 'Adresse Pres207', 'pres207', 'mdp', 2);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (208, 'PresNom208', 'PresPren208', 'Adresse Pres208', 'pres208', 'mdp', 3);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (301, 'CompNom301', 'CompPren301', 'Adresse Comp301', 'comp301', 'mdp', 1);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (302, 'CompNom302', 'CompPren302', 'Adresse Comp302', 'comp302', 'mdp', 1);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (303, 'CompNom303', 'CompPren303', 'Adresse Comp303', 'comp303', 'mdp', 1);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (304, 'CompNom304', 'CompPren304', 'Adresse Comp304', 'comp304', 'mdp', 1);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (305, 'CompNom305', 'CompPren305', 'Adresse Comp305', 'comp305', 'mdp', 1);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (306, 'CompNom306', 'CompPren306', 'Adresse Comp306', 'comp306', 'mdp', 1);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (307, 'CompNom307', 'CompPren307', 'Adresse Comp307', 'comp307', 'mdp', 2);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (308, 'CompNom308', 'CompPren308', 'Adresse Comp308', 'comp308', 'mdp', 2);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (309, 'CompNom309', 'CompPren309', 'Adresse Comp309', 'comp309', 'mdp', 2);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (310, 'CompNom310', 'CompPren310', 'Adresse Comp310', 'comp310', 'mdp', 2);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (311, 'CompNom311', 'CompPren311', 'Adresse Comp311', 'comp311', 'mdp', 2);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (312, 'CompNom312', 'CompPren312', 'Adresse Comp312', 'comp312', 'mdp', 2);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (313, 'CompNom313', 'CompPren313', 'Adresse Comp313', 'comp313', 'mdp', 3);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (314, 'CompNom314', 'CompPren314', 'Adresse Comp314', 'comp314', 'mdp', 3);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (315, 'CompNom315', 'CompPren315', 'Adresse Comp315', 'comp315', 'mdp', 3);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (316, 'CompNom316', 'CompPren316', 'Adresse Comp316', 'comp316', 'mdp', 3);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (317, 'CompNom317', 'CompPren317', 'Adresse Comp317', 'comp317', 'mdp', 3);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (318, 'CompNom318', 'CompPren318', 'Adresse Comp318', 'comp318', 'mdp', 3);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (319, 'CompNom319', 'CompPren319', 'Adresse Comp319', 'comp319', 'mdp', 4);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (320, 'CompNom320', 'CompPren320', 'Adresse Comp320', 'comp320', 'mdp', 4);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (321, 'CompNom321', 'CompPren321', 'Adresse Comp321', 'comp321', 'mdp', 4);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (322, 'CompNom322', 'CompPren322', 'Adresse Comp322', 'comp322', 'mdp', 4);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (323, 'CompNom323', 'CompPren323', 'Adresse Comp323', 'comp323', 'mdp', 4);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (324, 'CompNom324', 'CompPren324', 'Adresse Comp324', 'comp324', 'mdp', 4);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (325, 'CompNom325', 'CompPren325', 'Adresse Comp325', 'comp325', 'mdp', 5);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (326, 'CompNom326', 'CompPren326', 'Adresse Comp326', 'comp326', 'mdp', 5);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (327, 'CompNom327', 'CompPren327', 'Adresse Comp327', 'comp327', 'mdp', 5);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (328, 'CompNom328', 'CompPren328', 'Adresse Comp328', 'comp328', 'mdp', 5);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (329, 'CompNom329', 'CompPren329', 'Adresse Comp329', 'comp329', 'mdp', 5);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (330, 'CompNom330', 'CompPren330', 'Adresse Comp330', 'comp330', 'mdp', 5);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (331, 'CompNom331', 'CompPren331', 'Adresse Comp331', 'comp331', 'mdp', 6);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (332, 'CompNom332', 'CompPren332', 'Adresse Comp332', 'comp332', 'mdp', 6);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (333, 'CompNom333', 'CompPren333', 'Adresse Comp333', 'comp333', 'mdp', 6);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (334, 'CompNom334', 'CompPren334', 'Adresse Comp334', 'comp334', 'mdp', 6);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (335, 'CompNom335', 'CompPren335', 'Adresse Comp335', 'comp335', 'mdp', 6);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (336, 'CompNom336', 'CompPren336', 'Adresse Comp336', 'comp336', 'mdp', 6);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (401, 'EvalNom401', 'EvalPren401', 'Adresse Eval401', 'eval401', 'mdp', 1);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (402, 'EvalNom402', 'EvalPren402', 'Adresse Eval402', 'eval402', 'mdp', 1);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (403, 'EvalNom403', 'EvalPren403', 'Adresse Eval403', 'eval403', 'mdp', 1);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (404, 'EvalNom404', 'EvalPren404', 'Adresse Eval404', 'eval404', 'mdp', 2);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (405, 'EvalNom405', 'EvalPren405', 'Adresse Eval405', 'eval405', 'mdp', 2);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (406, 'EvalNom406', 'EvalPren406', 'Adresse Eval406', 'eval406', 'mdp', 2);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (407, 'EvalNom407', 'EvalPren407', 'Adresse Eval407', 'eval407', 'mdp', 3);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (408, 'EvalNom408', 'EvalPren408', 'Adresse Eval408', 'eval408', 'mdp', 3);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (409, 'EvalNom409', 'EvalPren409', 'Adresse Eval409', 'eval409', 'mdp', 3);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (410, 'EvalNom410', 'EvalPren410', 'Adresse Eval410', 'eval410', 'mdp', 4);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (411, 'EvalNom411', 'EvalPren411', 'Adresse Eval411', 'eval411', 'mdp', 4);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (412, 'EvalNom412', 'EvalPren412', 'Adresse Eval412', 'eval412', 'mdp', 4);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (413, 'EvalNom413', 'EvalPren413', 'Adresse Eval413', 'eval413', 'mdp', 5);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (414, 'EvalNom414', 'EvalPren414', 'Adresse Eval414', 'eval414', 'mdp', 5);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (415, 'EvalNom415', 'EvalPren415', 'Adresse Eval415', 'eval415', 'mdp', 5);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (416, 'EvalNom416', 'EvalPren416', 'Adresse Eval416', 'eval416', 'mdp', 6);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (417, 'EvalNom417', 'EvalPren417', 'Adresse Eval417', 'eval417', 'mdp', 6);
INSERT INTO Utilisateurs (numUtilisateur,nom,prenom,adresse,login,motDePasse,numClub) VALUES (418, 'EvalNom418', 'EvalPren418', 'Adresse Eval418', 'eval418', 'mdp', 6);

INSERT INTO Directeur (numDirecteur,dateDebut) VALUES (101, '2020-01-01');
INSERT INTO Directeur (numDirecteur,dateDebut) VALUES (102, '2020-01-01');
INSERT INTO Directeur (numDirecteur,dateDebut) VALUES (103, '2020-01-01');
INSERT INTO Directeur (numDirecteur,dateDebut) VALUES (104, '2020-01-01');
INSERT INTO Directeur (numDirecteur,dateDebut) VALUES (105, '2020-01-01');
INSERT INTO Directeur (numDirecteur,dateDebut) VALUES (106, '2020-01-01');

INSERT INTO President (numPresident,prime) VALUES (201, 100);
INSERT INTO President (numPresident,prime) VALUES (202, 200);
INSERT INTO President (numPresident,prime) VALUES (203, 300);
INSERT INTO President (numPresident,prime) VALUES (204, 400);
INSERT INTO President (numPresident,prime) VALUES (205, 500);
INSERT INTO President (numPresident,prime) VALUES (206, 600);
INSERT INTO President (numPresident,prime) VALUES (207, 700);
INSERT INTO President (numPresident,prime) VALUES (208, 800);

INSERT INTO Competiteurs (numCompetiteur,datePremiereParticipation) VALUES (301, '2023-01-01');
INSERT INTO Competiteurs (numCompetiteur,datePremiereParticipation) VALUES (302, '2023-01-01');
INSERT INTO Competiteurs (numCompetiteur,datePremiereParticipation) VALUES (303, '2023-01-01');
INSERT INTO Competiteurs (numCompetiteur,datePremiereParticipation) VALUES (304, '2023-01-01');
INSERT INTO Competiteurs (numCompetiteur,datePremiereParticipation) VALUES (305, '2023-01-01');
INSERT INTO Competiteurs (numCompetiteur,datePremiereParticipation) VALUES (306, '2023-01-01');
INSERT INTO Competiteurs (numCompetiteur,datePremiereParticipation) VALUES (307, '2023-01-01');
INSERT INTO Competiteurs (numCompetiteur,datePremiereParticipation) VALUES (308, '2023-01-01');
INSERT INTO Competiteurs (numCompetiteur,datePremiereParticipation) VALUES (309, '2023-01-01');
INSERT INTO Competiteurs (numCompetiteur,datePremiereParticipation) VALUES (310, '2023-01-01');
INSERT INTO Competiteurs (numCompetiteur,datePremiereParticipation) VALUES (311, '2023-01-01');
INSERT INTO Competiteurs (numCompetiteur,datePremiereParticipation) VALUES (312, '2023-01-01');
INSERT INTO Competiteurs (numCompetiteur,datePremiereParticipation) VALUES (313, '2023-01-01');
INSERT INTO Competiteurs (numCompetiteur,datePremiereParticipation) VALUES (314, '2023-01-01');
INSERT INTO Competiteurs (numCompetiteur,datePremiereParticipation) VALUES (315, '2023-01-01');
INSERT INTO Competiteurs (numCompetiteur,datePremiereParticipation) VALUES (316, '2023-01-01');
INSERT INTO Competiteurs (numCompetiteur,datePremiereParticipation) VALUES (317, '2023-01-01');
INSERT INTO Competiteurs (numCompetiteur,datePremiereParticipation) VALUES (318, '2023-01-01');
INSERT INTO Competiteurs (numCompetiteur,datePremiereParticipation) VALUES (319, '2023-01-01');
INSERT INTO Competiteurs (numCompetiteur,datePremiereParticipation) VALUES (320, '2023-01-01');
INSERT INTO Competiteurs (numCompetiteur,datePremiereParticipation) VALUES (321, '2023-01-01');
INSERT INTO Competiteurs (numCompetiteur,datePremiereParticipation) VALUES (322, '2023-01-01');
INSERT INTO Competiteurs (numCompetiteur,datePremiereParticipation) VALUES (323, '2023-01-01');
INSERT INTO Competiteurs (numCompetiteur,datePremiereParticipation) VALUES (324, '2023-01-01');
INSERT INTO Competiteurs (numCompetiteur,datePremiereParticipation) VALUES (325, '2023-01-01');
INSERT INTO Competiteurs (numCompetiteur,datePremiereParticipation) VALUES (326, '2023-01-01');
INSERT INTO Competiteurs (numCompetiteur,datePremiereParticipation) VALUES (327, '2023-01-01');
INSERT INTO Competiteurs (numCompetiteur,datePremiereParticipation) VALUES (328, '2023-01-01');
INSERT INTO Competiteurs (numCompetiteur,datePremiereParticipation) VALUES (329, '2023-01-01');
INSERT INTO Competiteurs (numCompetiteur,datePremiereParticipation) VALUES (330, '2023-01-01');
INSERT INTO Competiteurs (numCompetiteur,datePremiereParticipation) VALUES (331, '2023-01-01');
INSERT INTO Competiteurs (numCompetiteur,datePremiereParticipation) VALUES (332, '2023-01-01');
INSERT INTO Competiteurs (numCompetiteur,datePremiereParticipation) VALUES (333, '2023-01-01');
INSERT INTO Competiteurs (numCompetiteur,datePremiereParticipation) VALUES (334, '2023-01-01');
INSERT INTO Competiteurs (numCompetiteur,datePremiereParticipation) VALUES (335, '2023-01-01');
INSERT INTO Competiteurs (numCompetiteur,datePremiereParticipation) VALUES (336, '2023-01-01');

INSERT INTO Evaluateur (numEvaluateur,specialite) VALUES (401, 'Specialite1');
INSERT INTO Evaluateur (numEvaluateur,specialite) VALUES (402, 'Specialite1');
INSERT INTO Evaluateur (numEvaluateur,specialite) VALUES (403, 'Specialite1');
INSERT INTO Evaluateur (numEvaluateur,specialite) VALUES (404, 'Specialite2');
INSERT INTO Evaluateur (numEvaluateur,specialite) VALUES (405, 'Specialite2');
INSERT INTO Evaluateur (numEvaluateur,specialite) VALUES (406, 'Specialite2');
INSERT INTO Evaluateur (numEvaluateur,specialite) VALUES (407, 'Specialite3');
INSERT INTO Evaluateur (numEvaluateur,specialite) VALUES (408, 'Specialite3');
INSERT INTO Evaluateur (numEvaluateur,specialite) VALUES (409, 'Specialite3');
INSERT INTO Evaluateur (numEvaluateur,specialite) VALUES (410, 'Specialite4');
INSERT INTO Evaluateur (numEvaluateur,specialite) VALUES (411, 'Specialite4');
INSERT INTO Evaluateur (numEvaluateur,specialite) VALUES (412, 'Specialite4');
INSERT INTO Evaluateur (numEvaluateur,specialite) VALUES (413, 'Specialite5');
INSERT INTO Evaluateur (numEvaluateur,specialite) VALUES (414, 'Specialite5');
INSERT INTO Evaluateur (numEvaluateur,specialite) VALUES (415, 'Specialite5');
INSERT INTO Evaluateur (numEvaluateur,specialite) VALUES (416, 'Specialite6');
INSERT INTO Evaluateur (numEvaluateur,specialite) VALUES (417, 'Specialite6');
INSERT INTO Evaluateur (numEvaluateur,specialite) VALUES (418, 'Specialite6');

INSERT INTO Concours (numConcours,numPresident,theme,dateDebut,dateFin,etat) VALUES (1,201,'Thème 2023-1','2023-03-20','2023-03-27','evalue');
INSERT INTO Concours (numConcours,numPresident,theme,dateDebut,dateFin,etat) VALUES (2,202,'Thème 2023-2','2023-06-21','2023-06-28','en cours');
INSERT INTO Concours (numConcours,numPresident,theme,dateDebut,dateFin,etat) VALUES (3,203,'Thème 2023-3','2023-09-23','2023-09-30','non commence');
INSERT INTO Concours (numConcours,numPresident,theme,dateDebut,dateFin,etat) VALUES (4,204,'Thème 2023-4','2023-12-21','2023-12-28','en attente des resultats');
INSERT INTO Concours (numConcours,numPresident,theme,dateDebut,dateFin,etat) VALUES (5,205,'Thème 2024-1','2024-03-20','2024-03-27','evalue');
INSERT INTO Concours (numConcours,numPresident,theme,dateDebut,dateFin,etat) VALUES (6,206,'Thème 2024-2','2024-06-21','2024-06-28','en cours');
INSERT INTO Concours (numConcours,numPresident,theme,dateDebut,dateFin,etat) VALUES (7,207,'Thème 2024-3','2024-09-23','2024-09-30','non commence');
INSERT INTO Concours (numConcours,numPresident,theme,dateDebut,dateFin,etat) VALUES (8,208,'Thème 2024-4','2024-12-21','2024-12-28','en attente des resultats');

INSERT INTO ParticipeClub (numClub,numConcours) VALUES (1,1);
INSERT INTO ParticipeClub (numClub,numConcours) VALUES (1,2);
INSERT INTO ParticipeClub (numClub,numConcours) VALUES (1,3);
INSERT INTO ParticipeClub (numClub,numConcours) VALUES (1,4);
INSERT INTO ParticipeClub (numClub,numConcours) VALUES (1,5);
INSERT INTO ParticipeClub (numClub,numConcours) VALUES (1,6);
INSERT INTO ParticipeClub (numClub,numConcours) VALUES (1,7);
INSERT INTO ParticipeClub (numClub,numConcours) VALUES (1,8);
INSERT INTO ParticipeClub (numClub,numConcours) VALUES (2,1);
INSERT INTO ParticipeClub (numClub,numConcours) VALUES (2,2);
INSERT INTO ParticipeClub (numClub,numConcours) VALUES (2,3);
INSERT INTO ParticipeClub (numClub,numConcours) VALUES (2,4);
INSERT INTO ParticipeClub (numClub,numConcours) VALUES (2,5);
INSERT INTO ParticipeClub (numClub,numConcours) VALUES (2,6);
INSERT INTO ParticipeClub (numClub,numConcours) VALUES (2,7);
INSERT INTO ParticipeClub (numClub,numConcours) VALUES (2,8);
INSERT INTO ParticipeClub (numClub,numConcours) VALUES (3,1);
INSERT INTO ParticipeClub (numClub,numConcours) VALUES (3,2);
INSERT INTO ParticipeClub (numClub,numConcours) VALUES (3,3);
INSERT INTO ParticipeClub (numClub,numConcours) VALUES (3,4);
INSERT INTO ParticipeClub (numClub,numConcours) VALUES (3,5);
INSERT INTO ParticipeClub (numClub,numConcours) VALUES (3,6);
INSERT INTO ParticipeClub (numClub,numConcours) VALUES (3,7);
INSERT INTO ParticipeClub (numClub,numConcours) VALUES (3,8);
INSERT INTO ParticipeClub (numClub,numConcours) VALUES (4,1);
INSERT INTO ParticipeClub (numClub,numConcours) VALUES (4,2);
INSERT INTO ParticipeClub (numClub,numConcours) VALUES (4,3);
INSERT INTO ParticipeClub (numClub,numConcours) VALUES (4,4);
INSERT INTO ParticipeClub (numClub,numConcours) VALUES (4,5);
INSERT INTO ParticipeClub (numClub,numConcours) VALUES (4,6);
INSERT INTO ParticipeClub (numClub,numConcours) VALUES (4,7);
INSERT INTO ParticipeClub (numClub,numConcours) VALUES (4,8);
INSERT INTO ParticipeClub (numClub,numConcours) VALUES (5,1);
INSERT INTO ParticipeClub (numClub,numConcours) VALUES (5,2);
INSERT INTO ParticipeClub (numClub,numConcours) VALUES (5,3);
INSERT INTO ParticipeClub (numClub,numConcours) VALUES (5,4);
INSERT INTO ParticipeClub (numClub,numConcours) VALUES (5,5);
INSERT INTO ParticipeClub (numClub,numConcours) VALUES (5,6);
INSERT INTO ParticipeClub (numClub,numConcours) VALUES (5,7);
INSERT INTO ParticipeClub (numClub,numConcours) VALUES (5,8);
INSERT INTO ParticipeClub (numClub,numConcours) VALUES (6,1);
INSERT INTO ParticipeClub (numClub,numConcours) VALUES (6,2);
INSERT INTO ParticipeClub (numClub,numConcours) VALUES (6,3);
INSERT INTO ParticipeClub (numClub,numConcours) VALUES (6,4);
INSERT INTO ParticipeClub (numClub,numConcours) VALUES (6,5);
INSERT INTO ParticipeClub (numClub,numConcours) VALUES (6,6);
INSERT INTO ParticipeClub (numClub,numConcours) VALUES (6,7);
INSERT INTO ParticipeClub (numClub,numConcours) VALUES (6,8);

INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (301,1);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (301,2);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (301,3);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (301,4);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (301,5);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (301,6);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (301,7);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (301,8);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (302,1);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (302,2);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (302,3);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (302,4);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (302,5);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (302,6);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (302,7);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (302,8);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (303,1);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (303,2);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (303,3);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (303,4);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (303,5);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (303,6);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (303,7);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (303,8);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (304,1);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (304,2);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (304,3);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (304,4);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (304,5);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (304,6);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (304,7);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (304,8);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (305,1);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (305,2);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (305,3);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (305,4);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (305,5);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (305,6);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (305,7);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (305,8);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (306,1);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (306,2);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (306,3);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (306,4);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (306,5);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (306,6);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (306,7);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (306,8);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (307,1);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (307,2);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (307,3);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (307,4);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (307,5);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (307,6);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (307,7);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (307,8);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (308,1);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (308,2);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (308,3);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (308,4);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (308,5);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (308,6);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (308,7);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (308,8);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (309,1);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (309,2);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (309,3);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (309,4);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (309,5);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (309,6);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (309,7);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (309,8);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (310,1);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (310,2);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (310,3);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (310,4);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (310,5);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (310,6);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (310,7);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (310,8);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (311,1);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (311,2);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (311,3);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (311,4);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (311,5);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (311,6);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (311,7);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (311,8);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (312,1);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (312,2);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (312,3);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (312,4);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (312,5);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (312,6);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (312,7);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (312,8);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (313,1);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (313,2);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (313,3);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (313,4);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (313,5);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (313,6);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (313,7);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (313,8);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (314,1);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (314,2);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (314,3);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (314,4);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (314,5);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (314,6);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (314,7);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (314,8);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (315,1);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (315,2);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (315,3);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (315,4);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (315,5);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (315,6);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (315,7);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (315,8);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (316,1);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (316,2);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (316,3);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (316,4);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (316,5);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (316,6);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (316,7);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (316,8);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (317,1);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (317,2);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (317,3);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (317,4);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (317,5);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (317,6);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (317,7);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (317,8);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (318,1);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (318,2);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (318,3);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (318,4);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (318,5);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (318,6);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (318,7);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (318,8);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (319,1);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (319,2);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (319,3);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (319,4);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (319,5);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (319,6);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (319,7);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (319,8);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (320,1);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (320,2);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (320,3);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (320,4);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (320,5);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (320,6);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (320,7);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (320,8);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (321,1);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (321,2);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (321,3);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (321,4);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (321,5);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (321,6);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (321,7);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (321,8);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (322,1);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (322,2);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (322,3);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (322,4);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (322,5);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (322,6);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (322,7);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (322,8);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (323,1);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (323,2);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (323,3);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (323,4);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (323,5);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (323,6);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (323,7);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (323,8);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (324,1);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (324,2);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (324,3);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (324,4);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (324,5);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (324,6);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (324,7);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (324,8);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (325,1);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (325,2);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (325,3);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (325,4);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (325,5);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (325,6);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (325,7);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (325,8);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (326,1);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (326,2);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (326,3);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (326,4);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (326,5);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (326,6);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (326,7);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (326,8);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (327,1);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (327,2);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (327,3);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (327,4);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (327,5);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (327,6);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (327,7);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (327,8);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (328,1);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (328,2);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (328,3);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (328,4);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (328,5);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (328,6);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (328,7);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (328,8);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (329,1);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (329,2);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (329,3);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (329,4);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (329,5);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (329,6);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (329,7);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (329,8);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (330,1);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (330,2);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (330,3);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (330,4);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (330,5);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (330,6);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (330,7);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (330,8);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (331,1);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (331,2);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (331,3);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (331,4);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (331,5);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (331,6);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (331,7);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (331,8);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (332,1);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (332,2);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (332,3);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (332,4);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (332,5);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (332,6);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (332,7);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (332,8);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (333,1);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (333,2);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (333,3);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (333,4);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (333,5);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (333,6);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (333,7);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (333,8);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (334,1);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (334,2);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (334,3);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (334,4);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (334,5);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (334,6);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (334,7);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (334,8);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (335,1);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (335,2);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (335,3);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (335,4);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (335,5);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (335,6);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (335,7);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (335,8);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (336,1);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (336,2);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (336,3);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (336,4);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (336,5);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (336,6);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (336,7);
INSERT INTO ParticipeCompetiteur (numCompetiteur,numConcours) VALUES (336,8);

INSERT INTO Jury (numEvaluateur,numConcours) VALUES (401,1);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (401,2);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (401,3);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (401,4);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (401,5);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (401,6);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (401,7);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (401,8);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (402,1);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (402,2);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (402,3);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (402,4);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (402,5);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (402,6);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (402,7);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (402,8);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (403,1);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (403,2);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (403,3);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (403,4);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (403,5);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (403,6);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (403,7);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (403,8);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (404,1);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (404,2);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (404,3);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (404,4);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (404,5);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (404,6);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (404,7);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (404,8);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (405,1);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (405,2);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (405,3);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (405,4);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (405,5);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (405,6);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (405,7);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (405,8);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (406,1);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (406,2);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (406,3);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (406,4);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (406,5);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (406,6);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (406,7);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (406,8);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (407,1);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (407,2);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (407,3);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (407,4);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (407,5);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (407,6);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (407,7);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (407,8);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (408,1);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (408,2);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (408,3);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (408,4);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (408,5);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (408,6);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (408,7);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (408,8);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (409,1);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (409,2);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (409,3);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (409,4);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (409,5);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (409,6);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (409,7);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (409,8);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (410,1);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (410,2);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (410,3);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (410,4);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (410,5);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (410,6);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (410,7);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (410,8);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (411,1);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (411,2);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (411,3);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (411,4);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (411,5);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (411,6);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (411,7);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (411,8);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (412,1);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (412,2);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (412,3);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (412,4);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (412,5);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (412,6);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (412,7);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (412,8);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (413,1);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (413,2);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (413,3);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (413,4);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (413,5);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (413,6);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (413,7);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (413,8);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (414,1);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (414,2);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (414,3);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (414,4);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (414,5);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (414,6);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (414,7);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (414,8);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (415,1);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (415,2);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (415,3);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (415,4);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (415,5);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (415,6);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (415,7);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (415,8);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (416,1);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (416,2);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (416,3);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (416,4);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (416,5);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (416,6);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (416,7);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (416,8);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (417,1);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (417,2);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (417,3);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (417,4);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (417,5);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (417,6);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (417,7);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (417,8);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (418,1);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (418,2);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (418,3);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (418,4);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (418,5);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (418,6);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (418,7);
INSERT INTO Jury (numEvaluateur,numConcours) VALUES (418,8);

INSERT INTO Dessins (numDessins, commentaire, classement, dateRemise, leDessin, numConcours, numCompetiteur) VALUES (1, 'Dessin n°1 du compétiteur 301', 1, '2023-03-22', '/var/lib/mysql-files/dessins/conc1_comp301.png', 1, 301);
INSERT INTO Dessins (numDessins, commentaire, classement, dateRemise, leDessin, numConcours, numCompetiteur) VALUES (2, 'Dessin n°2 du compétiteur 302', 2, '2023-03-22', '/var/lib/mysql-files/dessins/conc1_comp302.png', 1, 302);
INSERT INTO Dessins (numDessins, commentaire, classement, dateRemise, leDessin, numConcours, numCompetiteur) VALUES (3, 'Dessin n°3 du compétiteur 303', 3, '2023-03-22', '/var/lib/mysql-files/dessins/conc1_comp303.png', 1, 303);
INSERT INTO Dessins (numDessins, commentaire, classement, dateRemise, leDessin, numConcours, numCompetiteur) VALUES (4, 'Dessin n°4 du compétiteur 304', 4, '2023-03-22', '/var/lib/mysql-files/dessins/conc1_comp304.png', 1, 304);
INSERT INTO Dessins (numDessins, commentaire, classement, dateRemise, leDessin, numConcours, numCompetiteur) VALUES (5, 'Dessin n°5 du compétiteur 305', 5, '2023-03-22', '/var/lib/mysql-files/dessins/conc1_comp305.png', 1, 305);
INSERT INTO Dessins (numDessins, commentaire, classement, dateRemise, leDessin, numConcours, numCompetiteur) VALUES (6, 'Dessin n°6 du compétiteur 306', 6, '2023-03-22', '/var/lib/mysql-files/dessins/conc1_comp306.png', 1, 306);
INSERT INTO Dessins (numDessins, commentaire, classement, dateRemise, leDessin, numConcours, numCompetiteur) VALUES (7, 'Dessin n°7 du compétiteur 301', NULL, '2023-06-23', '/var/lib/mysql-files/dessins/conc2_comp301.png', 2, 301);
INSERT INTO Dessins (numDessins, commentaire, classement, dateRemise, leDessin, numConcours, numCompetiteur) VALUES (8, 'Dessin n°8 du compétiteur 302', NULL, '2023-06-23', '/var/lib/mysql-files/dessins/conc2_comp302.png', 2, 302);
INSERT INTO Dessins (numDessins, commentaire, classement, dateRemise, leDessin, numConcours, numCompetiteur) VALUES (9, 'Dessin n°9 du compétiteur 303', NULL, '2023-06-23', '/var/lib/mysql-files/dessins/conc2_comp303.png', 2, 303);
INSERT INTO Dessins (numDessins, commentaire, classement, dateRemise, leDessin, numConcours, numCompetiteur) VALUES (10, 'Dessin n°10 du compétiteur 304', NULL, '2023-06-23', '/var/lib/mysql-files/dessins/conc2_comp304.png', 2, 304);
INSERT INTO Dessins (numDessins, commentaire, classement, dateRemise, leDessin, numConcours, numCompetiteur) VALUES (11, 'Dessin n°11 du compétiteur 305', NULL, '2023-06-23', '/var/lib/mysql-files/dessins/conc2_comp305.png', 2, 305);
INSERT INTO Dessins (numDessins, commentaire, classement, dateRemise, leDessin, numConcours, numCompetiteur) VALUES (12, 'Dessin n°12 du compétiteur 306', NULL, '2023-06-23', '/var/lib/mysql-files/dessins/conc2_comp306.png', 2, 306);
INSERT INTO Dessins (numDessins, commentaire, classement, dateRemise, leDessin, numConcours, numCompetiteur) VALUES (13, 'Dessin n°13 du compétiteur 301', NULL, '2023-09-25', '/var/lib/mysql-files/dessins/conc3_comp301.png', 3, 301);
INSERT INTO Dessins (numDessins, commentaire, classement, dateRemise, leDessin, numConcours, numCompetiteur) VALUES (14, 'Dessin n°14 du compétiteur 302', NULL, '2023-09-25', '/var/lib/mysql-files/dessins/conc3_comp302.png', 3, 302);
INSERT INTO Dessins (numDessins, commentaire, classement, dateRemise, leDessin, numConcours, numCompetiteur) VALUES (15, 'Dessin n°15 du compétiteur 303', NULL, '2023-09-25', '/var/lib/mysql-files/dessins/conc3_comp303.png', 3, 303);
INSERT INTO Dessins (numDessins, commentaire, classement, dateRemise, leDessin, numConcours, numCompetiteur) VALUES (16, 'Dessin n°16 du compétiteur 304', NULL, '2023-09-25', '/var/lib/mysql-files/dessins/conc3_comp304.png', 3, 304);
INSERT INTO Dessins (numDessins, commentaire, classement, dateRemise, leDessin, numConcours, numCompetiteur) VALUES (17, 'Dessin n°17 du compétiteur 305', NULL, '2023-09-25', '/var/lib/mysql-files/dessins/conc3_comp305.png', 3, 305);
INSERT INTO Dessins (numDessins, commentaire, classement, dateRemise, leDessin, numConcours, numCompetiteur) VALUES (18, 'Dessin n°18 du compétiteur 306', NULL, '2023-09-25', '/var/lib/mysql-files/dessins/conc3_comp306.png', 3, 306);
INSERT INTO Dessins (numDessins, commentaire, classement, dateRemise, leDessin, numConcours, numCompetiteur) VALUES (19, 'Dessin n°19 du compétiteur 301', NULL, '2023-12-23', '/var/lib/mysql-files/dessins/conc4_comp301.png', 4, 301);
INSERT INTO Dessins (numDessins, commentaire, classement, dateRemise, leDessin, numConcours, numCompetiteur) VALUES (20, 'Dessin n°20 du compétiteur 302', NULL, '2023-12-23', '/var/lib/mysql-files/dessins/conc4_comp302.png', 4, 302);
INSERT INTO Dessins (numDessins, commentaire, classement, dateRemise, leDessin, numConcours, numCompetiteur) VALUES (21, 'Dessin n°21 du compétiteur 303', NULL, '2023-12-23', '/var/lib/mysql-files/dessins/conc4_comp303.png', 4, 303);
INSERT INTO Dessins (numDessins, commentaire, classement, dateRemise, leDessin, numConcours, numCompetiteur) VALUES (22, 'Dessin n°22 du compétiteur 304', NULL, '2023-12-23', '/var/lib/mysql-files/dessins/conc4_comp304.png', 4, 304);
INSERT INTO Dessins (numDessins, commentaire, classement, dateRemise, leDessin, numConcours, numCompetiteur) VALUES (23, 'Dessin n°23 du compétiteur 305', NULL, '2023-12-23', '/var/lib/mysql-files/dessins/conc4_comp305.png', 4, 305);
INSERT INTO Dessins (numDessins, commentaire, classement, dateRemise, leDessin, numConcours, numCompetiteur) VALUES (24, 'Dessin n°24 du compétiteur 306', NULL, '2023-12-23', '/var/lib/mysql-files/dessins/conc4_comp306.png', 4, 306);
INSERT INTO Dessins (numDessins, commentaire, classement, dateRemise, leDessin, numConcours, numCompetiteur) VALUES (25, 'Dessin n°25 du compétiteur 301', 1, '2024-03-22', '/var/lib/mysql-files/dessins/conc5_comp301.png', 5, 301);
INSERT INTO Dessins (numDessins, commentaire, classement, dateRemise, leDessin, numConcours, numCompetiteur) VALUES (26, 'Dessin n°26 du compétiteur 302', 2, '2024-03-22', '/var/lib/mysql-files/dessins/conc5_comp302.png', 5, 302);
INSERT INTO Dessins (numDessins, commentaire, classement, dateRemise, leDessin, numConcours, numCompetiteur) VALUES (27, 'Dessin n°27 du compétiteur 303', 3, '2024-03-22', '/var/lib/mysql-files/dessins/conc5_comp303.png', 5, 303);
INSERT INTO Dessins (numDessins, commentaire, classement, dateRemise, leDessin, numConcours, numCompetiteur) VALUES (28, 'Dessin n°28 du compétiteur 304', 4, '2024-03-22', '/var/lib/mysql-files/dessins/conc5_comp304.png', 5, 304);
INSERT INTO Dessins (numDessins, commentaire, classement, dateRemise, leDessin, numConcours, numCompetiteur) VALUES (29, 'Dessin n°29 du compétiteur 305', 5, '2024-03-22', '/var/lib/mysql-files/dessins/conc5_comp305.png', 5, 305);
INSERT INTO Dessins (numDessins, commentaire, classement, dateRemise, leDessin, numConcours, numCompetiteur) VALUES (30, 'Dessin n°30 du compétiteur 306', 6, '2024-03-22', '/var/lib/mysql-files/dessins/conc5_comp306.png', 5, 306);
INSERT INTO Dessins (numDessins, commentaire, classement, dateRemise, leDessin, numConcours, numCompetiteur) VALUES (31, 'Dessin n°31 du compétiteur 301', NULL, '2024-06-23', '/var/lib/mysql-files/dessins/conc6_comp301.png', 6, 301);
INSERT INTO Dessins (numDessins, commentaire, classement, dateRemise, leDessin, numConcours, numCompetiteur) VALUES (32, 'Dessin n°32 du compétiteur 302', NULL, '2024-06-23', '/var/lib/mysql-files/dessins/conc6_comp302.png', 6, 302);
INSERT INTO Dessins (numDessins, commentaire, classement, dateRemise, leDessin, numConcours, numCompetiteur) VALUES (33, 'Dessin n°33 du compétiteur 303', NULL, '2024-06-23', '/var/lib/mysql-files/dessins/conc6_comp303.png', 6, 303);
INSERT INTO Dessins (numDessins, commentaire, classement, dateRemise, leDessin, numConcours, numCompetiteur) VALUES (34, 'Dessin n°34 du compétiteur 304', NULL, '2024-06-23', '/var/lib/mysql-files/dessins/conc6_comp304.png', 6, 304);
INSERT INTO Dessins (numDessins, commentaire, classement, dateRemise, leDessin, numConcours, numCompetiteur) VALUES (35, 'Dessin n°35 du compétiteur 305', NULL, '2024-06-23', '/var/lib/mysql-files/dessins/conc6_comp305.png', 6, 305);
INSERT INTO Dessins (numDessins, commentaire, classement, dateRemise, leDessin, numConcours, numCompetiteur) VALUES (36, 'Dessin n°36 du compétiteur 306', NULL, '2024-06-23', '/var/lib/mysql-files/dessins/conc6_comp306.png', 6, 306);
INSERT INTO Dessins (numDessins, commentaire, classement, dateRemise, leDessin, numConcours, numCompetiteur) VALUES (37, 'Dessin n°37 du compétiteur 301', NULL, '2024-09-25', '/var/lib/mysql-files/dessins/conc7_comp301.png', 7, 301);
INSERT INTO Dessins (numDessins, commentaire, classement, dateRemise, leDessin, numConcours, numCompetiteur) VALUES (38, 'Dessin n°38 du compétiteur 302', NULL, '2024-09-25', '/var/lib/mysql-files/dessins/conc7_comp302.png', 7, 302);
INSERT INTO Dessins (numDessins, commentaire, classement, dateRemise, leDessin, numConcours, numCompetiteur) VALUES (39, 'Dessin n°39 du compétiteur 303', NULL, '2024-09-25', '/var/lib/mysql-files/dessins/conc7_comp303.png', 7, 303);
INSERT INTO Dessins (numDessins, commentaire, classement, dateRemise, leDessin, numConcours, numCompetiteur) VALUES (40, 'Dessin n°40 du compétiteur 304', NULL, '2024-09-25', '/var/lib/mysql-files/dessins/conc7_comp304.png', 7, 304);
INSERT INTO Dessins (numDessins, commentaire, classement, dateRemise, leDessin, numConcours, numCompetiteur) VALUES (41, 'Dessin n°41 du compétiteur 305', NULL, '2024-09-25', '/var/lib/mysql-files/dessins/conc7_comp305.png', 7, 305);
INSERT INTO Dessins (numDessins, commentaire, classement, dateRemise, leDessin, numConcours, numCompetiteur) VALUES (42, 'Dessin n°42 du compétiteur 306', NULL, '2024-09-25', '/var/lib/mysql-files/dessins/conc7_comp306.png', 7, 306);
INSERT INTO Dessins (numDessins, commentaire, classement, dateRemise, leDessin, numConcours, numCompetiteur) VALUES (43, 'Dessin n°43 du compétiteur 301', NULL, '2024-12-23', '/var/lib/mysql-files/dessins/conc8_comp301.png', 8, 301);
INSERT INTO Dessins (numDessins, commentaire, classement, dateRemise, leDessin, numConcours, numCompetiteur) VALUES (44, 'Dessin n°44 du compétiteur 302', NULL, '2024-12-23', '/var/lib/mysql-files/dessins/conc8_comp302.png', 8, 302);
INSERT INTO Dessins (numDessins, commentaire, classement, dateRemise, leDessin, numConcours, numCompetiteur) VALUES (45, 'Dessin n°45 du compétiteur 303', NULL, '2024-12-23', '/var/lib/mysql-files/dessins/conc8_comp303.png', 8, 303);
INSERT INTO Dessins (numDessins, commentaire, classement, dateRemise, leDessin, numConcours, numCompetiteur) VALUES (46, 'Dessin n°46 du compétiteur 304', NULL, '2024-12-23', '/var/lib/mysql-files/dessins/conc8_comp304.png', 8, 304);
INSERT INTO Dessins (numDessins, commentaire, classement, dateRemise, leDessin, numConcours, numCompetiteur) VALUES (47, 'Dessin n°47 du compétiteur 305', NULL, '2024-12-23', '/var/lib/mysql-files/dessins/conc8_comp305.png', 8, 305);
INSERT INTO Dessins (numDessins, commentaire, classement, dateRemise, leDessin, numConcours, numCompetiteur) VALUES (48, 'Dessin n°48 du compétiteur 306', NULL, '2024-12-23', '/var/lib/mysql-files/dessins/conc8_comp306.png', 8, 306);

INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (1,401,'2023-03-20',6,'Note par Eval 401');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (1,402,'2023-03-20',7,'Note par Eval 402');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (2,401,'2023-06-21',6,'Note par Eval 401');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (2,402,'2023-06-21',7,'Note par Eval 402');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (3,401,'2023-09-23',6,'Note par Eval 401');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (3,402,'2023-09-23',7,'Note par Eval 402');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (4,401,'2023-12-21',6,'Note par Eval 401');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (4,402,'2023-12-21',7,'Note par Eval 402');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (5,401,'2024-03-20',6,'Note par Eval 401');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (5,402,'2024-03-20',7,'Note par Eval 402');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (6,401,'2024-06-21',6,'Note par Eval 401');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (6,402,'2024-06-21',7,'Note par Eval 402');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (7,401,'2024-09-23',6,'Note par Eval 401');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (7,402,'2024-09-23',7,'Note par Eval 402');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (8,401,'2024-12-21',6,'Note par Eval 401');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (8,402,'2024-12-21',7,'Note par Eval 402');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (9,404,'2023-03-20',7,'Note par Eval 404');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (9,405,'2023-03-20',8,'Note par Eval 405');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (10,404,'2023-06-21',7,'Note par Eval 404');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (10,405,'2023-06-21',8,'Note par Eval 405');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (11,404,'2023-09-23',7,'Note par Eval 404');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (11,405,'2023-09-23',8,'Note par Eval 405');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (12,404,'2023-12-21',7,'Note par Eval 404');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (12,405,'2023-12-21',8,'Note par Eval 405');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (13,404,'2024-03-20',7,'Note par Eval 404');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (13,405,'2024-03-20',8,'Note par Eval 405');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (14,404,'2024-06-21',7,'Note par Eval 404');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (14,405,'2024-06-21',8,'Note par Eval 405');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (15,404,'2024-09-23',7,'Note par Eval 404');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (15,405,'2024-09-23',8,'Note par Eval 405');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (16,404,'2024-12-21',7,'Note par Eval 404');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (16,405,'2024-12-21',8,'Note par Eval 405');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (17,407,'2023-03-20',8,'Note par Eval 407');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (17,408,'2023-03-20',9,'Note par Eval 408');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (18,407,'2023-06-21',8,'Note par Eval 407');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (18,408,'2023-06-21',9,'Note par Eval 408');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (19,407,'2023-09-23',8,'Note par Eval 407');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (19,408,'2023-09-23',9,'Note par Eval 408');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (20,407,'2023-12-21',8,'Note par Eval 407');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (20,408,'2023-12-21',9,'Note par Eval 408');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (21,407,'2024-03-20',8,'Note par Eval 407');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (21,408,'2024-03-20',9,'Note par Eval 408');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (22,407,'2024-06-21',8,'Note par Eval 407');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (22,408,'2024-06-21',9,'Note par Eval 408');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (23,407,'2024-09-23',8,'Note par Eval 407');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (23,408,'2024-09-23',9,'Note par Eval 408');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (24,407,'2024-12-21',8,'Note par Eval 407');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (24,408,'2024-12-21',9,'Note par Eval 408');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (25,410,'2023-03-20',9,'Note par Eval 410');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (25,411,'2023-03-20',10,'Note par Eval 411');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (26,410,'2023-06-21',9,'Note par Eval 410');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (26,411,'2023-06-21',10,'Note par Eval 411');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (27,410,'2023-09-23',9,'Note par Eval 410');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (27,411,'2023-09-23',10,'Note par Eval 411');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (28,410,'2023-12-21',9,'Note par Eval 410');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (28,411,'2023-12-21',10,'Note par Eval 411');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (29,410,'2024-03-20',9,'Note par Eval 410');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (29,411,'2024-03-20',10,'Note par Eval 411');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (30,410,'2024-06-21',9,'Note par Eval 410');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (30,411,'2024-06-21',10,'Note par Eval 411');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (31,410,'2024-09-23',9,'Note par Eval 410');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (31,411,'2024-09-23',10,'Note par Eval 411');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (32,410,'2024-12-21',9,'Note par Eval 410');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (32,411,'2024-12-21',10,'Note par Eval 411');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (33,413,'2023-03-20',5,'Note par Eval 413');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (33,414,'2023-03-20',6,'Note par Eval 414');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (34,413,'2023-06-21',5,'Note par Eval 413');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (34,414,'2023-06-21',6,'Note par Eval 414');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (35,413,'2023-09-23',5,'Note par Eval 413');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (35,414,'2023-09-23',6,'Note par Eval 414');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (36,413,'2023-12-21',5,'Note par Eval 413');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (36,414,'2023-12-21',6,'Note par Eval 414');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (37,413,'2024-03-20',5,'Note par Eval 413');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (37,414,'2024-03-20',6,'Note par Eval 414');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (38,413,'2024-06-21',5,'Note par Eval 413');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (38,414,'2024-06-21',6,'Note par Eval 414');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (39,413,'2024-09-23',5,'Note par Eval 413');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (39,414,'2024-09-23',6,'Note par Eval 414');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (40,413,'2024-12-21',5,'Note par Eval 413');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (40,414,'2024-12-21',6,'Note par Eval 414');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (41,416,'2023-03-20',6,'Note par Eval 416');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (41,417,'2023-03-20',7,'Note par Eval 417');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (42,416,'2023-06-21',6,'Note par Eval 416');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (42,417,'2023-06-21',7,'Note par Eval 417');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (43,416,'2023-09-23',6,'Note par Eval 416');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (43,417,'2023-09-23',7,'Note par Eval 417');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (44,416,'2023-12-21',6,'Note par Eval 416');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (44,417,'2023-12-21',7,'Note par Eval 417');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (45,416,'2024-03-20',6,'Note par Eval 416');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (45,417,'2024-03-20',7,'Note par Eval 417');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (46,416,'2024-06-21',6,'Note par Eval 416');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (46,417,'2024-06-21',7,'Note par Eval 417');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (47,416,'2024-09-23',6,'Note par Eval 416');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (47,417,'2024-09-23',7,'Note par Eval 417');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (48,416,'2024-12-21',6,'Note par Eval 416');
INSERT INTO Evaluation (numDessins,numEvaluateur,dateEvaluation,note,commentaire) VALUES (48,417,'2024-12-21',7,'Note par Eval 417');