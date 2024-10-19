DROP DATABASE IF EXISTS esame;
CREATE DATABASE esame;
\c esame

CREATE TABLE citta(
   id VARCHAR(4)  PRIMARY KEY,
   nome VARCHAR(20) NOT NULL,
   regione VARCHAR(20) NOT NULL
);

CREATE TABLE centralina(
   codice VARCHAR(4) PRIMARY KEY,
   tipo INTEGER NOT NULL,
   citta VARCHAR(4) NOT NULL
);

CREATE TABLE rilevazione(
	codice VARCHAR(4),
	giorno INTEGER NOT NULL,
	valore INTEGER NOT NULL,
   PRIMARY KEY (codice,giorno)
);

insert into citta values
('ID1','Roma','Lazio'),
('ID2','Latina','Lazio'),
('ID3','Napoli','Campania'),
('ID4','Pompei','Campania'),
('ID5','Milano','Lombardia'),
('ID6','Venezia','Veneto');
insert into centralina values
('C1',100,'ID5'),
('C2',10,'ID5'),
('C3',100,'ID1'),
('C4',200,'ID1'),
('C5',200,'ID2'),
('C6',100,'ID4'),
('C7',10,'ID3'),
('C8',200,'ID6'),
('C9',300,'ID6'),
('C10',200,'ID5'),
('C11',400,'ID2');
insert into rilevazione values 
('C1',10,1120),
('C1',11,1130),
('C2',11,1150),
('C3',256,1130),
('C3',7,80),
('C4',301,1121),
('C5',360,1060),
('C5',234,1130),
('C6',100,1150),
('C6',1,1002),
('C6',2,1005),
('C6',3,1300),
('C6',4,1080),
('C6',5,1002),
('C6',6,1010),
('C6',7,1200),
('C6',8,1300),
('C6',9,1400),
('C6',10,1300),
('C6',11,1200),
('C6',12,1100),
('C6',13,1050),
('C6',14,1000),
('C6',15,1159),
('C6',16,1002),
('C6',17,1005),
('C6',18,1003),
('C6',19,1002),
('C6',20,1170),
('C6',21,1180),
('C6',22,1190),
('C6',23,1005),
('C6',24,1002),
('C6',25,1002),
('C6',26,1002),
('C6',27,1450),
('C6',28,1460),
('C6',29,1450),
('C6',30,1460),
('C6',31,1470),
('C7',1,1002),
('C7',2,1005),
('C7',3,1300),
('C7',4,1080),
('C7',5,1002),
('C7',6,1010),
('C7',7,1200),
('C7',8,1300),
('C7',9,1400),
('C7',10,1300),
('C7',11,1200),
('C7',12,1100),
('C7',13,1050),
('C7',14,1000),
('C7',15,1159),
('C7',16,1002),
('C7',17,1005),
('C7',18,1003),
('C7',19,1002),
('C7',20,1170),
('C7',21,1180),
('C7',22,1190),
('C7',23,1005),
('C7',24,1002),
('C7',25,1002),
('C7',26,1002),
('C7',27,1450),
('C7',28,1460),
('C7',29,1450),
('C7',30,1460),
('C7',31,1470),
('C8',20,1002),
('C8',25,1100),
('C9',220,1100),
('C9',27,1100),
('C10',167,1100),
('C10',168,1100);