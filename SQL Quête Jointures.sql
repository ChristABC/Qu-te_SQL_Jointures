CREATE DATABASE Jointures
-- Création des tables
GO

USE Jointures;
GO

-- Table des continents terriens
CREATE TABLE Continent (
    ContinentID INT PRIMARY KEY,
    ContinentName NVARCHAR(100) NOT NULL
);

-- Table des terriens
CREATE TABLE Terrien (
    TerrienID INT PRIMARY KEY,
    TerrienName NVARCHAR(100) NOT NULL,
    ContinentID INT NOT NULL,
    FOREIGN KEY (ContinentID) REFERENCES Continent(ContinentID)
);

-- Table des bases martiennes
CREATE TABLE BaseMartienne (
    BaseID INT PRIMARY KEY,
    BaseName NVARCHAR(100) NOT NULL
);

-- Table des martiens
CREATE TABLE Martien (
    MartienID INT PRIMARY KEY,
    MartienName NVARCHAR(100) NOT NULL,
    BaseID INT NOT NULL,
    TerrienID INT NOT NULL,
    SuperieurID INT NULL,
    FOREIGN KEY (BaseID) REFERENCES BaseMartienne(BaseID),
    FOREIGN KEY (TerrienID) REFERENCES Terrien(TerrienID),
    FOREIGN KEY (SuperieurID) REFERENCES Martien(MartienID)
);

-- Insertion des données de test

-- Insertion des continents
INSERT INTO Continent (ContinentID, ContinentName) VALUES (1, 'Europe');
INSERT INTO Continent (ContinentID, ContinentName) VALUES (2, 'Asie');
INSERT INTO Continent (ContinentID, ContinentName) VALUES (3, 'Amérique');

-- Insertion des terriens
INSERT INTO Terrien (TerrienID, TerrienName, ContinentID) VALUES (1, 'Alice', 1);
INSERT INTO Terrien (TerrienID, TerrienName, ContinentID) VALUES (2, 'Bob', 2);
INSERT INTO Terrien (TerrienID, TerrienName, ContinentID) VALUES (3, 'Charlie', 3);

-- Insertion des bases martiennes
INSERT INTO BaseMartienne (BaseID, BaseName) VALUES (1, 'Base Alpha');
INSERT INTO BaseMartienne (BaseID, BaseName) VALUES (2, 'Base Beta');
INSERT INTO BaseMartienne (BaseID, BaseName) VALUES (3, 'Base Gamma');

-- Insertion des martiens
INSERT INTO Martien (MartienID, MartienName, BaseID, TerrienID, SuperieurID) VALUES (1, 'Xor', 1, 1, NULL); -- L'empereur des martiens est supérieur à lui-même
INSERT INTO Martien (MartienID, MartienName, BaseID, TerrienID, SuperieurID) VALUES (2, 'Yor', 2, 2, 1);
INSERT INTO Martien (MartienID, MartienName, BaseID, TerrienID, SuperieurID) VALUES (3, 'Zor', 3, 3, 2);

-- Mise à jour de l'empereur des martiens
UPDATE Martien SET SuperieurID = 1 WHERE MartienID = 1;

-- Requête pour obtenir l'affiliation de chaque martien à son terrien de référence
SELECT
    m.MartienName AS NomMartien,
    t.TerrienName AS NomReferentTerrien,
    c.ContinentName AS ContinentReferent,
    b.BaseName AS BaseMartien
FROM
    Martien m
JOIN
    Terrien t ON m.TerrienID = t.TerrienID
JOIN
    Continent c ON t.ContinentID = c.ContinentID
JOIN
    BaseMartienne b ON m.BaseID = b.BaseID;