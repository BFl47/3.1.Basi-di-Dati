-- giornalista(codice, sesso, cittanascita, orientamento)
-- testata(nome, citta, direttore, orientamento)
-- firma(codice, nome, mese, anno, articoli)

-- 1
select distinct g.codice, g.cittanascita
from giornalista g join firma f on g.codice = f.codice 
where f.anno >= 2000 and f.articoli > 0

-- 2
select distinct t.nome
from testata t join firma f1 on t.nome = f1.nome 
		join firma f2 on t.nome = f2.nome
where f2.mese = f1.mese + 1 and f1.anno = f2.anno and f1.codice = f2.codice

-- 3
with stessa_citta as(select distinct g.codice, sum(f.articoli) as somma
					 from firma f join testata t on f.nome = t.nome 
					 	join giornalista g on f.codice = g.codice
					 where t.citta = g.cittanascita
  					 group by g.codice)
select distinct stessa_citta.codice, stessa_citta.somma
from stessa_citta
union
select distinct g.codice, 0
from giornalista g
where g.codice not in (select stessa_citta.codice
					   from stessa_citta)

-- 4 				   
with g_not_sx as (select f.nome
			   from giornalista g join firma f on g.codice = f.codice
			   where g.orientamento != 'sinistra')
select distinct f.nome
from firma f
where f.nome not in (select *
					 from g_not_sx)
			   
-- 5
with max_articoli as (select nome, max(articoli) as massimo
					  from firma 
					  group by nome)		  
select distinct f.nome, f.anno, f.articoli
from firma f join testata t on f.nome = t.nome join max_articoli on f.nome = max_articoli.nome
where f.codice = t.direttore and f.articoli = max_articoli.massimo
