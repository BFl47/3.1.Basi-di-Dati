-- giocattolo(codice, nome, categoria)
-- bambino(codice, nome, citta)
-- richiesta(codiceb, codiceg, preferenze)

-- 1
select distinct r.codiceg
from richiesta r join bambino b on r.codiceb = b.codice
where b.citta = 'Roma' and r.preferenza = 1

-- 2
select distinct r1.codiceg
from richiesta r1, richiesta r2, bambino b1, bambino b2
where r1.codiceb = b1.codice and r2.codiceb = b2.codice and r1.codiceg = r2.codiceg
	and r1.preferenza = r2.preferenza and b1.citta != b2.citta

-- 3
select distinct g.codice, g.categoria, max(r.preferenza)
from richiesta r join giocattolo g on r.codiceg = g.codice
group by g.codice, g.categoria

-- 4
with b_cat as (select distinct r.codiceb, g.categoria, count (r.codiceg) as conto
				   from richiesta r join giocattolo g on g.codice = r.codiceg
				   group by r.codiceb, g.categoria)
select distinct bc.codiceb, bc.categoria, bc.conto
from b_cat bc
union
select distinct b.codice, g.categoria, 0
from bambino b, giocattolo g
where (b.codice, g.categoria) not in (select distinct codiceb, categoria
								   	  from b_cat)
					
-- 5
with notcat5 as (select distinct r.codiceb
				 from giocattolo g join richiesta r on g.codice = r.codiceg
				 where g.categoria != 5),
	almeno2 as (select distinct codice
			    from bambino join richiesta on codice = codiceb
			    group by codice
			    having count(*) >= 2),
	prefuguali as (select distinct r1.codiceb
			   	   from richiesta r1 join richiesta r2 on r1.codiceb = r2.codiceb
			       where r1.preferenza = r2.preferenza and r1.codiceg != r2.codiceg)			
select distinct r.codiceb
from richiesta r join almeno2 a2 on r.codiceb = a2.codice
where r.codiceb not in (select * from notcat5) and r.codiceb not in (select * from prefuguali)
