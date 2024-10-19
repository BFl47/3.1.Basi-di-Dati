-- Giocatore (codice, nome, categoria)
-- Partita(numero,anno,codvincente,codperdente,setvintig1,setvintig2)

-- 1
select distinct p.codvincente
from partita p join giocatore g on g.codice = p.codperdente
where g.categoria = 10 and p.anno > 1999

-- 2
select distinct g1.nome, g2.nome, p.numero, p.anno
from giocatore g1 join partita p on g1.codice = p.codvincente 
	join giocatore g2 on g2.codice = p.codperdente
where (p.setvintig1-p.setvintig2) >= 2 and g1.categoria < g2.categoria

-- 3
with p2015 as (select numero, codvincente, codperdente
			   from partita
			   where anno = 2015)
select distinct g.nome
from giocatore g, p2015 p
where g.codice not in (select codvincente
					   from p2015)
	 and g.codice not in (select codperdente
						  from p2015)
union
select distinct g.nome
from giocatore g
where g.codice not in (select codvincente
					   from partita)
	and g.codice not in (select codperdente
						 from partita)
						 
-- 4
select distinct g1.codice, count(distinct p.numero) as "Num partite"
from giocatore g1 join partita p on g1.codice = p.codperdente
	join giocatore g2 on g2.codice = p.codvincente
where g2.categoria = 1
group by g1.codice
having count(distinct p.numero) > 1

-- 5
with cat_sup as (select distinct g1.codice
				 from giocatore g1 join partita p on g1.codice = p.codvincente
					join giocatore g2 on g2.codice = p.codperdente
				 where g1.categoria < g2.categoria)
select distinct g.codice
from giocatore g
where g.codice not in (select * from cat_sup)
