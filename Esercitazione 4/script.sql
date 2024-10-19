1)
// creazione
create table if not exists automobile
(
	targa varchar(3) primary key,
	cilindrata int,
	citta varchar(15) not null
)

create table if not exists garage
(
	codice varchar(3) primary key,
	citta varchar(15) 
)

create table if not exists custodita
(
	targaauto varchar(3) references automobile,
	codgarage varchar(3) references garage,
	numero int 
)

alter table custodita
add constraint pk_custodita primary key (targaauto, garage);

// inserimento
insert into automobile
	values ('A1', 500, 'Roma'), ('A2', 1200, 'Roma'), ('A3', 900, 'Milano'), ('A4', 1000, 'Firenze'),
	('A5', 2000, 'Palermo'), ('A6', 3000, 'Torino'), ('A7', 2000, 'Torino'), ('A8', 4000, 'Roma'),
	('A9', 4000, 'Napoli'), ('A10', 2500, 'Siena');

insert into garage
	values ('G1', 'Roma'), ('G2', 'Firenze'), ('G3', 'Firenze'), ('G4', 'Milano'), ('G5', 'Milano'), 
	('G6', 'Palermo'), ('G7', 'Roma'), ('G8', 'Palermo'), ('G9', 'Roma'), ('G10', 'Milano'), 
	('G11', 'Roma'), ('G12', 'Siena');

insert into custodita
	values ('A1', 'G1', 2), ('A1', 'G2', 1), ('A3', 'G5', 1), ('A2', 'G6', 15), ('A2', 'G7', 17), 
	('A5', 'G6', 18), ('A5', 'G1', 2), ('A4', 'G3', 1), ('A6', 'G1', 1), ('A5', 'G8', 1), 
	('A8', 'G9', null), ('A8', 'G2', 3), ('A10', 'G12', 5);

2)
// aggiornamento
2.1)
delete from custodita
where targaauto = (select targa
				  from automobile
				  where citta = 'Siena');
				  
delete from automobile
where citta = 'Siena';

2.2)
update custodita
set numero = numero+1
where targaauto in (select targa
				  from automobile
				  where citta = 'Roma')
	and
	codgarage in (select codice
				  from garage
				  where citta = 'Roma');
