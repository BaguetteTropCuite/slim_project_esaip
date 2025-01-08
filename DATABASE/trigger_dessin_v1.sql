CREATE TRIGGER LimiteConcoursParAn
BEFORE INSERT ON Concours
FOR EACH ROW
BEGIN
    DECLARE nbConcours INT;
    SELECT COUNT(*) INTO nbConcours
    FROM Concours
    WHERE YEAR(dateDebut) = YEAR(NEW.dateDebut);
    IF nbConcours >= 4 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Limite de 4 concours par an atteinte';
    END IF;
END;

-- Limitation à 8 évaluations par évaluateur
CREATE TRIGGER LimiteEvaluations
BEFORE INSERT ON Evaluation
FOR EACH ROW
BEGIN
    DECLARE nbEvaluations INT;
    SELECT COUNT(*) INTO nbEvaluations
    FROM Evaluation
    WHERE numEvaluateur = NEW.numEvaluateur AND numDessins IN (SELECT numDessins FROM Dessins WHERE numConcours = (SELECT numConcours FROM Dessins WHERE numDessins = NEW.numDessins));
    IF nbEvaluations >= 8 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Un évaluateur ne peut évaluer plus de 8 dessins par concours';
    END IF;
END;

-- Limitation à 3 dessins par compétiteur par concours
CREATE TRIGGER LimiteDessinsParCompetiteur
BEFORE INSERT ON Dessins
FOR EACH ROW
BEGIN
    DECLARE nbDessins INT;
    SELECT COUNT(*) INTO nbDessins
    FROM Dessins
    WHERE numCompetiteur = NEW.numCompetiteur AND numConcours = NEW.numConcours;
    IF nbDessins >= 3 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Un compétiteur ne peut déposer plus de 3 dessins par concours';
    END IF;
END;
