-- Giocatore(codice,cognome,eta)
-- Squadra(nome,prestigio)
-- Giocato(codiceg,nomes,gol)

-- 1
select distinct gioc.codice
from giocatore gioc
where gioc.codice in (select codiceg
				from giocato join squadra on nomes = nome
				where prestigio < 3)
				
-- 2
select distinct gioc.codice, gioc.cognome
from giocatore gioc
where gioc.codice in (select codiceg
				from giocato join squadra on nomes = nome
				where prestigio >= 4 and gol > 20)	

-- 3
select distinct gioc.codice, gioc.cognome
from giocatore gioc
where gioc.codice not in (select codiceg
					from giocato
					where gol != 0)
					
-- 4
select nome as squadra, count(codiceg) as num_giocatori
from squadra join giocato on nome = nomes
where prestigio < 3 and gol > 10
group by nome

-- 5
select nome as squadra, avg(gol) as media_gol
from squadra join giocato on nome = nomes
where prestigio >= 4
group by nome

-- 6
select gioc.codice, avg(play.gol)
from giocatore gioc join giocato play on gioc.codice = play.codiceg
where gioc.eta >= 28
group by gioc.codice
having avg(play.gol) > 15

-- 7
select codice, cognome, gol
from giocatore join giocato on codice = codiceg
where nomes = 'Milan' and codice not in (select codiceg
										from giocato
										where nomes != 'Milan')
										
-- 8
select gioc.codice, play.nomes
from giocatore gioc join giocato play on gioc.codice = play.codiceg
where (play.nomes, play.gol) in (select sq.nome as squadra, max(gioc.gol)
								 from squadra sq join giocato gioc on sq.nome = gioc.nomes
								 group by sq.nome)

-- 9
select gioc1.codice as codice1, gioc2.codice as codice2
from giocatore gioc1, giocatore gioc2
where gioc1.codice != gioc2.codice and gioc1.codice < gioc2.codice
	and (gioc1.codice, gioc2.codice) not in (select gioc1.codice, gioc2.codice
											 from giocatore gioc1 join giocato play1 on gioc1.codice = play1.codiceg, 
											 giocatore gioc2 join giocato play2 on gioc2.codice = play2.codiceg 
											 where gioc1.codice != gioc2.codice and play1.nomes != play2.nomes)



