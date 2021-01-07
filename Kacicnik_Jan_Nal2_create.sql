DROP TABLE IF EXISTS ReceptImaSestavino;
DROP TABLE IF EXISTS ProizvajalecImaSestavino;
DROP TABLE IF EXISTS JedilnikImaOsebo;
DROP TABLE IF EXISTS JedilnikImaJed;
DROP TABLE IF EXISTS TrgovinaImaSestavino;
DROP TABLE IF EXISTS JedilnikImaJed;
DROP TABLE IF EXISTS Recept;
DROP TABLE IF EXISTS Sestavina;
DROP TABLE IF EXISTS Proizvajalec;
DROP TABLE IF EXISTS Trgovina;
DROP TABLE IF EXISTS Jed;
DROP TABLE IF EXISTS Jedilnik;
DROP TABLE IF EXISTS Vir;
DROP TABLE IF EXISTS Oseba;
DROP TABLE IF EXISTS Naslov;
DROP TABLE IF EXISTS Cena;
DROP TABLE IF EXISTS CasKuhanja;
DROP TABLE IF EXISTS CasPriprave;
DROP TABLE IF EXISTS CasovnaEnota;

CREATE TABLE CasovnaEnota(
    id INT NOT NULL,
    enota VARCHAR(10) NOT NULL
);

CREATE TABLE CasPriprave(
    id INT NOT NULL,
    cas INT NOT NULL,
    idCasovnaEnota INT NOT NULL
);

CREATE TABLE CasKuhanja(
    id INT NOT NULL,
    cas INT NOT NULL,
    idCasovnaEnota INT NOT NULL
);

CREATE TABLE Cena(
    id INT NOT NULL NOT NULL,
    cena DECIMAL(10,2) NOT NULL,
    valuta VARCHAR(20) NOT NULL
);

CREATE TABLE Naslov(
    id INT NOT NULL,
    ulica VARCHAR(80) NOT NULL,
    hisnaStevilka INT NOT NULL,
    kraj VARCHAR(80) NOT NULL,
    drzava VARCHAR(80)
);

CREATE TABLE Oseba(
    id INT NOT NULL,
    ime VARCHAR(25) NOT NULL,
    priimek VARCHAR(25) NOT NULL,
    elektronskiNaslov VARCHAR(50),
    uporabniskoIme VARCHAR(50)
);

CREATE TABLE Vir(
    id INT NOT NULL,
    naziv VARCHAR(80) NOT NULL,
    stran INT,
    elektronskaPovezava VARCHAR(250),
    idAvtor INT NOT NULL
);

CREATE TABLE Jedilnik(
    id INT NOT NULL,
    namen VARCHAR(80),
    cas DATETIME NOT NULL
);

CREATE TABLE JedilnikImaOsebo(
	id INT NOT NULL,
    idOseba INT NOT NULL,
    idJedilnik INT NOT NULL
);

CREATE TABLE JedilnikImaJed(
    id INT NOT NULL,
    idJed INT NOT NULL,
    idJedilnik INT
);

CREATE TABLE Jed(
    id INT NOT NULL,
    naziv VARCHAR(80) NOT NULL,
    vrsta VARCHAR(60) NOT NULL
);

CREATE TABLE Trgovina(
    id INT NOT NULL,
    naziv VARCHAR(80) NOT NULL,
    idNaslov INT NOT NULL
);

CREATE TABLE Sestavina(
    id INT NOT NULL,
    naziv VARCHAR(50),
    idCena INT 
);

CREATE TABLE Proizvajalec(
    id INT NOT NULL,
    naziv VARCHAR(80) NOT NULL,
    idNaslov INT NOT NULL
);

CREATE TABLE TrgovinaImaSestavino(
    id INT NOT NULL,
    idSestavina INT NOT NULL,
    idTrgovina INT
);

CREATE TABLE ProizvajalecImaSestavino(
    id INT NOT NULL,
    idSestavina INT NOT NULL,
    idProizvajalec INT
);

CREATE TABLE ReceptImaSestavino(
    id INT NOT NULL,
    idRecept INT NOT NULL,
    idSestavina INT,
    kolicina DECIMAL(10,2) NOT NULL,
    enota VARCHAR(45)
);

CREATE TABLE Recept(
    id INT NOT NULL,
    idJed INT NOT NULL,
    idCasKuhanja INT NOT NULL,
    idCasPriprave INT NOT NULL,
    postopek VARCHAR(1000) NOT NULL,
    komentar VARCHAR(1000),
    idVir INT
);

ALTER TABLE CasPriprave ADD CONSTRAINT PK_cas_priprave PRIMARY KEY(id), MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE CasKuhanja ADD CONSTRAINT PK_cas_kuhanja PRIMARY KEY(id), MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE CasovnaEnota ADD CONSTRAINT PK_casovna_enota PRIMARY KEY(id), MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE Cena ADD CONSTRAINT PK_cena PRIMARY KEY(id), MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE Naslov ADD CONSTRAINT PK_naslov PRIMARY KEY(id), MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE Oseba ADD CONSTRAINT PK_oseba PRIMARY KEY(id), MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE Vir ADD CONSTRAINT PK_vir PRIMARY KEY(id), MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE Jedilnik ADD CONSTRAINT PK_jedilnik PRIMARY KEY(id), MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE JedilnikImaJed ADD CONSTRAINT PK_jedilnik_ima_jed PRIMARY KEY(id), MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE JedilnikImaOsebo ADD CONSTRAINT PK_jedilnik_ima_osebo PRIMARY KEY(id), MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE Jed ADD CONSTRAINT PK_jed PRIMARY KEY(id), MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE Trgovina ADD CONSTRAINT PK_trgovina PRIMARY KEY(id), MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE Proizvajalec ADD CONSTRAINT PK_proizvajalec PRIMARY KEY(id), MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE TrgovinaImaSestavino ADD CONSTRAINT PK_trgovina_ima_sestavino PRIMARY KEY(id), MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE ProizvajalecImaSestavino ADD CONSTRAINT PK_proizvajalec_ima_sestavino PRIMARY KEY(id), MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE Sestavina ADD CONSTRAINT PK_sestavina PRIMARY KEY(id), MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE ReceptImaSestavino ADD CONSTRAINT PK_recept_ima_sestavino PRIMARY KEY(id), MODIFY id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE Recept ADD CONSTRAINT PK_recept PRIMARY KEY(id), MODIFY id INT NOT NULL AUTO_INCREMENT;




ALTER TABLE CasPriprave ADD CONSTRAINT FK_cas_priprave_enota FOREIGN KEY(idCasovnaEnota) REFERENCES CasovnaEnota(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE CasKuhanja ADD CONSTRAINT FK_cas_kuhanja_enota FOREIGN KEY(idCasovnaEnota) REFERENCES CasovnaEnota(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Vir ADD CONSTRAINT FK_vir_avtor FOREIGN KEY(idAvtor) REFERENCES Oseba(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE JedilnikImaOsebo ADD CONSTRAINT FK_jedilnik_ima_osebo_oseba FOREIGN KEY(idOseba) REFERENCES Oseba(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE JedilnikImaOsebo ADD CONSTRAINT FK_jedilnik_ima_osebo_jedilnik FOREIGN KEY(idJedilnik) REFERENCES Oseba(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE JedilnikImaJed ADD CONSTRAINT FK_jedilnik_ima_jed_jed FOREIGN KEY(idJed) REFERENCES Jed(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE JedilnikImaJed ADD CONSTRAINT FK_jedilnik_ima_jed_jedilnik FOREIGN KEY(idJedilnik) REFERENCES Jedilnik(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Trgovina ADD CONSTRAINT FK_naslov_trgovine FOREIGN KEY(idNaslov) REFERENCES Naslov(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Proizvajalec ADD CONSTRAINT FK_naslov_proizvajalca FOREIGN KEY(idNaslov) REFERENCES Naslov(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE TrgovinaImaSestavino ADD CONSTRAINT FK_trgovina_ima_sestavino_sestavina FOREIGN KEY(idSestavina) REFERENCES Sestavina(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE TrgovinaImaSestavino ADD CONSTRAINT FK_trgovina_ima_sestavino_trgovina FOREIGN KEY(idTrgovina) REFERENCES Trgovina(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE ProizvajalecImaSestavino ADD CONSTRAINT FK_proizvajalec_ima_sestavino_sestavina FOREIGN KEY(idSestavina) REFERENCES Sestavina(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE ProizvajalecImaSestavino ADD CONSTRAINT FK_proizvajalec_ima_sestavino_proizvajalec FOREIGN KEY(idProizvajalec) REFERENCES Proizvajalec(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Sestavina ADD CONSTRAINT FK_cena FOREIGN KEY(idCena) REFERENCES Cena(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE ReceptImaSestavino ADD CONSTRAINT FK_recept_ima_sestavino_recept FOREIGN KEY(idRecept) REFERENCES Recept(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE ReceptImaSestavino ADD CONSTRAINT FK_recept_ima_sestavino_sestavina FOREIGN KEY(idSestavina) REFERENCES Sestavina(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Recept ADD CONSTRAINT FK_recept_jed FOREIGN KEY(idJed) REFERENCES Jed(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Recept ADD CONSTRAINT FK_recept_cas_priprave FOREIGN KEY(idCasPriprave) REFERENCES CasPriprave(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Recept ADD CONSTRAINT FK_recept_cas_kuhanja FOREIGN KEY(idCasKuhanja) REFERENCES CasKuhanja(id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Recept ADD CONSTRAINT FK_recept_vir FOREIGN KEY(idVir) REFERENCES Vir(id) ON DELETE CASCADE ON UPDATE CASCADE;









