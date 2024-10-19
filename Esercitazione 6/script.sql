CREATE TABLE turista(
   cf VARCHAR(20) CONSTRAINT pk_turista PRIMARY KEY,
   cognome VARCHAR (50),
   annonascita INTEGER
);

CREATE TABLE viaggio(
   codice INTEGER CONSTRAINT pk_viaggio PRIMARY KEY,
   anno INTEGER
);

CREATE TABLE visita(
   cf VARCHAR(20),
   citta VARCHAR(20), 
   viaggio INTEGER,
   costo INTEGER check (costo > 0),
   CONSTRAINT pk_visita PRIMARY KEY (cf, citta, viaggio),
   CONSTRAINT visita_cf_fkey FOREIGN KEY (cf) 
		REFERENCES turista(cf)
		DEFERRABLE INITIALLY DEFERRED,
   CONSTRAINT visita_viaggio_fkey FOREIGN KEY (viaggio)
		REFERENCES viaggio(codice)
		ON UPDATE CASCADE
		ON DELETE CASCADE
		DEFERRABLE INITIALLY DEFERRED
);

insert into turista values
('10', 'Rossi', 1980),
('20', 'Bianchi', 1990),
('30', 'Verdi', 1985),
('40', 'Gialli', 1995);

insert into viaggio values
(1, 2000),
(2, 2005),
(3, 2010),
(4, 2012),
(5, 2017),
(6, 2020);

insert into visita values
('10', 'Roma', 1, 500),
('10', 'Viterbo', 1, 200),
('10', 'Napoli', 2, 100),
('20', 'Roma', 1, 300),
('30', 'Venezia', 2, 700),
('30', 'Roma', 3, 400),
('30', 'Torino', 3, 500),
('40', 'Roma',4, 600),
('40', 'Verona', 4, 400),
('40', 'Genova', 5, 100),
('40','Livorno', 5, 200),
('40', 'Firenze', 6, 700);
