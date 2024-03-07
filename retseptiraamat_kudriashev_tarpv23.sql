CREATE TABLE toiduaine(
    toiduaine_id int PRIMARY KEY AUTO_INCREMENT,
    toiduaine_nimi varchar(100));
    
CREATE TABLE yhik(
    yhik_id int PRIMARY KEY AUTO_INCREMENT,
    yhik_nimi varchar(100));
    

CREATE TABLE koostis(
    koostis_id int PRIMARY KEY AUTO_INCREMENT,
    kogus int,
    retsept_retsept_id int,
    toiduaine_id int,
    yhik_id int,
    FOREIGN KEY (toiduaine_id) REFERENCES toiduaine(toiduaine_id),
    FOREIGN KEY (yhik_id) REFERENCES yhik(yhik_id)
    );
