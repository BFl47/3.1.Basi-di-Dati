-- giocatore(codice, nome, categoria)
-- partita (numero, anno, codvincente, codperdente, setvintig1, setvintig2)

-- 1
select distinct p.numero, p.anno
from partita p join giocatore g on g.codice = p.codvincente
where g.categoria = 1

-- 2
select distinct g1.nome
from partita p join giocatore g1 on g1.codice = p.codvincente
	join giocatore g2 on g2.codice = p.codperdente
where g1.categoria < 3+g2.categoria

-- 3
with p2014 as (select g.nome
					  from giocatore g join partita p on g.codice = p.codperdente
					  where p.anno = 2014),
	p2000 as (select g.nome
			  from giocatore g, partita p 
			  where (g.codice = p.codvincente or g.codice = p.codperdente) and p.anno = 2000)
select distinct g.nome
from p2014 g
where g.nome not in (select * from p2000)

-- 4
with cat_diversa as (select distinct g1.nome
					 from giocatore g1 join partita p on g1.codice = p.codvincente
					 	join giocatore g2 on g2.codice = p.codperdente
					 where g1.categoria = g2.categoria)
select distinct g.nome
from giocatore g join partita p on g.codice = p.codvincente
where g.nome not in (select * from cat_diversa)

-- 5
with cat1 as (select distinct g.codice 
			  from giocatore g 
			  where g.categoria = 1)
select distinct g1.codice, count(distinct p.numero)
from giocatore g1 join partita p on g1.codice = p.codperdente
	join cat1 g2 on g2.codice = p.codvincente
group by g1.codice
having count(distinct p.numero) > 1
