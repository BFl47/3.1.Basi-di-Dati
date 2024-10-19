-- giocattolo(codice, nome, categoria)
-- bambino(codice, nome, citta)
-- richiesta(codiceb, codiceg, preferenza)

-- 1
select distinct g.codice, g.nome
from giocattolo g
where g.categoria != 5 and g.codice in (select codiceg
									   	from richiesta
									    where preferenza <= 4)

-- 2
select distinct r1.codiceg as giocattolo
from bambino b, richiesta r1, richiesta r2
where b.codice = r1.codiceb and b.codice = r2.codiceb and r1.codiceg = r2.codiceg 
	and r1.preferenza != r2.preferenza
	
-- 3
select distinct g.codice, g.categoria, avg(r.preferenza)
from richiesta r join giocattolo g on r.codiceg = g.codice
group by g.codice, g.categoria

-- 4
select distinct r.codiceb, r.preferenza, count(r.codiceg)
from richiesta r join giocattolo g on r.codiceg = g.codice
where g.categoria > 3
group by r.codiceb, r.preferenza
union
select distinct b.codice, r.preferenza, 0
from bambino b, richiesta r
where b.codice not in (select codiceb
					   from richiesta)

-- 5
with bimbocat1 as (select distinct r.codiceb as codice
				   from richiesta r 
				   where r.codiceb not in (select codiceb
									   	   from giocattolo join richiesta on codice = codiceg
								           where categoria != 1))
select distinct b.codice, avg(r.preferenza)
from bimbocat1 b join richiesta r on b.codice = r.codiceb
group by b.codice
union
select distinct b.codice, null::integer
from bambino b
where b.codice not in (select codiceb from richiesta)
										   
										   