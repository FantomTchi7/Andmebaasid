-- Kasuta XAMPP / Kirjuta kõik SQL laused ümber nii, et nad sobivad XAMPPi kasutamisel.
-- Käivita SQL lause ja kui tabel on loodud, tee vastava  pilt-aruanne Word'is.
CREATE TABLE auto(
autoID int not null Primary key identity(1,1),
regNumber char(6) UNIQUE,
markID int,
varv varchar(20),
v_aasta int,
kaigukastID int,
km decimal(6,2)
);
SELECT * FROM auto
 
CREATE TABLE mark(
markID int not null Primary key identity(1,1),
autoMark varchar(30) UNIQUE
);
 
INSERT INTO mark(autoMark)
VALUES ('Ziguli');
INSERT INTO mark(autoMark)
VALUES ('Lambordzini');
INSERT INTO mark(autoMark)
VALUES ('BMW');
SELECT * FROM mark;
 
CREATE TABLE kaigukast(
kaigukastID int not null Primary key identity(1,1),
kaigukast varchar(30) UNIQUE
);
INSERT INTO kaigukast(kaigukast)
VALUES ('Automaat');
INSERT INTO kaigukast(kaigukast)
VALUES ('Manual');
SELECT * FROM kaigukast;
 
ALTER TABLE auto
ADD FOREIGN KEY (markID) REFERENCES mark(markID);
ALTER TABLE auto
ADD FOREIGN KEY (kaigukastID) REFERENCES kaigukast(kaigukastID);

-- Lisa järgmised 4 tabelid ja seosta need omavahel.
CREATE TABLE klient(
klientiID int not null Primary key identity(1,1),
kliendiNimi varchar(50),
telefon varchar(20),
aadress varchar(50),
soiduKogemus varchar(30)
);

-- Lisa oma tabeli ja seosta teisega (piisab ühega)

CREATE TABLE amet(
ametiID int not null Primary key identity(1,1),
markID int,
ametiNimi varchar(50),
FOREIGN KEY (markID) REFERENCES mark(markID)
);
 

CREATE TABLE tootaja(
tootajaID int not null Primary key identity(1,1),
tootajanimi varchar(50),
ametiID int,
FOREIGN KEY (ametiID) REFERENCES amet(ametiID)
);
 
CREATE TABLE rendiLeping(
lepingID int not null Primary key identity(1,1),
rendiAlgus date,
rendiLopp date,
klientiID int,
regNumber char(6),
rendiKestvus int,
hindKokku decimal(5,2),
tootajaID int,
FOREIGN KEY (klientiID) REFERENCES klient(klientiID),
FOREIGN KEY (regNumber) REFERENCES auto(regNumber),
FOREIGN KEY (tootajaID) REFERENCES tootaja(tootajaID)
);

-- Koosta SQL laused auto tabeli täitmiseks.

INSERT INTO mark(autoMark) VALUES ('Mercedes');
INSERT INTO mark(autoMark) VALUES ('Toyota');

INSERT INTO kaigukast(kaigukast) VALUES ('CVT');
INSERT INTO kaigukast(kaigukast) VALUES ('Poolautomaatne');
INSERT INTO kaigukast(kaigukast) VALUES ('Topeltsidur');

INSERT INTO auto (regNumber, markID, varv, v_aasta, kaigukastID, km) VALUES 
('AB1234', 1, 'Punane', 2010, 1, 1200.50),
('CD5678', 2, 'Kollane', 2015, 2, 250.75),
('EF9012', 3, 'Must', 2018, 3, 300.25),
('GH3456', 4, 'Valge', 2020, 4, 150.60),
('IJ7890', 5, 'Sinine', 2021, 5, 50.00);
INSERT INTO klient (kliendiNimi, telefon, aadress, soiduKogemus) VALUES
('Vlad K', '58024408', 'Vilde tee', '5 aastat'),
('David L', '58021122', 'Ehitajate tee', '3 aastat'),
('David M', '58012233', 'Sõpruse pst', '10 aastat'),
('Bogdan V', '58016643', 'Kullerkupu', '7 aastat'),
('Erik G', '58021178', 'Tulika', '2 aastat');

INSERT INTO amet (markID, ametiNimi) VALUES
(1, 'Toyota EE'),
(2, 'Mercedes Eesti'),
(3, 'Ziguli OÜ'),
(1, 'Lambordzini EST'),
(2, 'BMW EE');

INSERT INTO tootaja (tootajanimi, ametiID) VALUES
('Iurii K', 1),
('Sofia O', 2),
('Valerii K', 3),
('Lena K', 1),
('Galya O', 2);

INSERT INTO rendiLeping (rendiAlgus, rendiLopp, klientiID, regNumber, rendiKestvus, hindKokku, tootajaID) VALUES
('2024-01-01', '2024-01-07', 1, 'AB1234', 7, 200.00, 1),
('2024-02-15', '2024-02-20', 2, 'CD5678', 5, 150.00, 2),
('2024-03-10', '2024-03-15', 3, 'EF9012', 5, 250.00, 3),
('2024-04-05', '2024-04-12', 4, 'GH3456', 7, 300.00, 4),
('2024-05-01', '2024-05-10', 5, 'IJ7890', 9, 350.00, 5);

-- SELECT laused.
-- Näide, kuvame andmed kolmest tabelist, võttes arvesse tabelite vahelist sekundaarset võtit või seost.

select * from auto, mark, kaigukast
where mark.markID=auto.markID and kaigukast.kaigukastID=auto.kaigukastID
 
select * from auto
INNER JOIN mark ON mark.markID=auto.markID
INNER JOIN kaigukast ON kaigukast.kaigukastID=auto.kaigukastID
 
SELECT auto.regNumber, mark.autoMark, auto.varv, auto.v_aasta, kaigukast.kaigukast, auto.km FROM auto
JOIN mark ON auto.markID = mark.markID
JOIN kaigukast ON auto.kaigukastID = kaigukast.kaigukastID;
 
-- Ülesanne:

-- 1.	Koosta SELECT lause ja näita mis autos milline käigukast (kasuta INNER JOIN)
SELECT auto.regNumber, kaigukast.kaigukast FROM auto INNER JOIN kaigukast ON auto.kaigukastID = kaigukast.kaigukastID;
 
-- 2.	Koosta SELECT lause ja näita mis autos milline automark (kasuta INNER JOIN)
SELECT auto.regNumber, mark.autoMark FROM auto INNER JOIN mark ON auto.markID = mark.markID;
 
-- 3.	Koosta SELECT lause ja näita millised autod töötaja andis rendile.
SELECT rendiLeping.regNumber, auto.varv, tootaja.tootajanimi FROM rendiLeping INNER JOIN auto ON rendiLeping.regNumber = auto.regNumber INNER JOIN tootaja ON rendiLeping.tootajaID = tootaja.tootajaID;
 
-- 4.	Otsi summaarne autode arv (COUNT) ja summaarne maksumus (SUM) tabelis rendileping.
SELECT COUNT(regNumber) AS Renditudautosidkokku, SUM(hindKokku) AS HindKokku FROM rendiLeping;
 
-- 5.	Koosta oma SQL lause mis kasutab kaks seostatud tabelid.
SELECT klient.kliendiNimi, auto.regNumber FROM rendiLeping INNER JOIN klient ON rendiLeping.klientiID = klient.klientiID INNER JOIN auto ON rendiLeping.regNumber = auto.regNumber;



-- Tegin GUI-s muid õigusi

GRANT SELECT, INSERT ON rendileping TO tootaja;

-- Tootaja õigused kontroll
DELETE FROM amet WHERE ametiNimi = 'test';

-- Protseduurid:

-- 1.	Loo protseduur andmete lisamiseks tabelisse rendileping.

CREATE PROCEDURE lisaUurileping
@rendiAlgus DATE, 
@rendiLopp DATE, 
@klientiID INT, 
@regNumber VARCHAR(6), 
@rendiKestvus INT, 
@hindKokku DECIMAL(5,2), 
@tootajaID INT
AS
BEGIN
    INSERT INTO rendiLeping (
        rendiAlgus, 
        rendiLopp, 
        klientiID, 
        regNumber, 
        rendiKestvus, 
        hindKokku, 
        tootajaID
    )
    VALUES (
        @rendiAlgus, 
        @rendiLopp, 
        @klientiID, 
        @regNumber, 
        @rendiKestvus, 
        @hindKokku, 
        @tootajaID
    );
END

-- 2.	Loo protseduur lepingu kustutamiseks  id järgi.

CREATE PROCEDURE kustutaRendileping
@lepingID INT
AS
BEGIN
    DELETE FROM rendiLeping
    WHERE lepingID = @lepingID;
END

-- 3.	Loo oma protseduur, mis erineb varem loodud protseduuridest.

CREATE PROCEDURE uuendaRendilepingut
@lepingID INT,
@rendiAlgus DATE, 
@rendiLopp DATE, 
@rendiKestvus INT, 
@hindKokku DECIMAL(5,2)
AS
BEGIN
    UPDATE rendiLeping SET rendiAlgus = @rendiAlgus, rendiLopp = @rendiLopp, rendiKestvus = @rendiKestvus, hindKokku = @hindKokku WHERE lepingID = @lepingID;
END

