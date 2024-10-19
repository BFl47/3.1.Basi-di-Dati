-- giocattolo(codice, nome, categoria)
-- bambino(codice, nome, citta)
-- richiesta(codiceb, codiceg, preferenza)

-- 1
select distinct b.codice, b.nome
from bambino b join richiesta r on b.codice = r.codiceb
where b.citta != 'Milano' and r.preferenza >= 4

-- 2
select distinct r1.codiceb
from richiesta r1 join giocattolo g1 on r1.codiceg = g1.codice, 
	richiesta r2 join giocattolo g2 on r2.codiceg = g2.codice
where r1.preferenza = r2.preferenza and g1.categoria != g2.categoria and r1.codiceb = r2.codiceb

-- 3
select distinct r.codiceb, b.citta, count (r.preferenza) as num_richieste
from richiesta r join bambino b on r.codiceb = b.codice
where r.preferenza = 1
group by r.codiceb, b.citta
union
select distinct r.codiceb, b.citta, 0
from richiesta r join bambino b on r.codiceb = b.codice
where r.codiceb not in (select codiceb
					    from richiesta
					   	where preferenza = 1)

-- 4
with max_grad as (select codiceb, codiceg, max(preferenza) as massimo
				  from richiesta
				  group by codiceb, codiceg)
select distinct b.codice, g.codice, m.massimo
from bambino b, giocattolo g, max_grad m
where (b.codice, g.codice) in (select r.codiceb, r.codiceg
							   from richiesta r)
	and m.codiceb = b.codice and m.codiceg = g.codice	
union 
select distinct b.codice, g.codice, 0
from bambino b, giocattolo g
where (b.codice, g.codice) not in (select r.codiceb, r.codiceg
								   from richiesta r)

-- 5
select distinct r.codiceg, avg(r.preferenza) as media
from richiesta r 
where r.codiceg not in (select distinct r.codiceg
					   	from richiesta r join bambino b on b.codice = r.codiceb
					   	where b.citta = 'Firenze')
group by r.codiceg
union
select distinct g.codice, null::integer
from giocattolo g
where g.codice not in (select r.codiceg
					   from richiesta r)
