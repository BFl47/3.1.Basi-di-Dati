-- giocatore(codice, nome, categoria)
-- partita(numero, anno, codvincente, codperdente, setvintg1, setvintig2)

-- 1
with cat3 as (select codice
			  from giocatore
			  where categoria = 3)
select distinct g.codice
from giocatore g join partita p on g.codice = p.codperdente
where p.codvincente in (select * from cat3)

-- 2
select distinct g2.nome, g1.nome, p.anno
from giocatore g1 join partita p on g1.codice = p.codvincente
	join giocatore g2 on g2.codice = p.codperdente
where (p.setvintig1 - p.setvintig2) >= 2 and g1.categoria < g2.categoria

-- 3
select distinct g.nome
from giocatore g
where g.codice in (select p.codvincente
				   from partita p
				   where anno = 2014)
	and g.codice in (select p.codvincente
					 from partita p
					 where anno = 2015)

-- 4
with cat_inf as (select p.codvincente
				 from partita p join giocatore g1 on p.codvincente = g1.codice
				 	join giocatore g2 on p.codperdente = g2.codice
				 where g1.categoria > g2.categoria)
select distinct g.nome
from giocatore g
where g.codice not in (select * from cat_inf)
union
select distinct g.nome
from giocatore g
where g.codice not in (select codvincente from partita) 
	and g.codice not in (select codperdente from partita)

-- 5
with cat5 as (select codice from giocatore where categoria > 5),
	cat10 as (select codice from giocatore where categoria = 10)
select 	g1.codice, count(distinct p.numero)
from cat5 g1 join partita p on g1.codice = p.codvincente
	join cat10 g2 on g2.codice = p.codperdente
group by g1.codice
having count(distinct p.numero) > 1