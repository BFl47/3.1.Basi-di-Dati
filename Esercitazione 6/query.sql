-- turista(cf, cognome, annonascita, quantiviaggi)
-- viaggio(codice, anno)
-- visita(cf, citta, viaggio, costo)

-- 1
select v.cf, v.citta
from visita v join viaggio vi on vi.codice = v.viaggio
where vi.anno > 2010
union 
select distinct t.cf, null
from turista t 
where t.cf not in (select v.cf
				   from visita v join viaggio vi on vi.codice = v.viaggio
				   where vi.anno > 2010)

select v.cf, string_agg(v.citta, ', ')
from visita v join viaggio vi on vi.codice = v.viaggio
where vi.anno > 2010
group by v.cf
union 
select distinct t.cf, null
from turista t 
where t.cf not in (select v.cf
				   from visita v join viaggio vi on vi.codice = v.viaggio
				   where vi.anno > 2010)

-- 2
with calcoloEta as (select t.cf, vg.codice, anno - annonascita as eta
			 		from turista t join visita v on t.cf = v.cf join viaggio vg on v.viaggio = vg.codice)
select distinct t.cf, v.viaggio, c.eta
from turista t join visita v on t.cf = v.cf join calcoloEta c on (c.cf = t.cf and c.codice = v.viaggio)

-- 3
with calcoloEta as (select t.cf, vg.codice, anno - annonascita as eta
			 		from turista t join visita v on t.cf = v.cf join viaggio vg on v.viaggio = vg.codice)
select distinct v.citta, count(c.eta) as num_minorenni
from visita v join calcoloEta c on v.viaggio = c.codice
where c.eta < 18
group by v.citta 
having count(c.eta) > 1 

-- 4
select distinct cf, viaggio, max(costo)
from visita
group by cf, viaggio
union
select distinct t.cf, v.codice, 0
from turista t, viaggio v
where (t.cf, v.codice) not in (select cf, viaggio
						   	   from visita)

-- 5
select distinct v.cf, string_agg(v.citta, ', ')
from visita v
group by v.cf, v.viaggio
having count(distinct v.citta) = (select count(distinct citta)
						 		  from visita
						 		  where cf = v.cf)

-- 6
select distinct v.viaggio, v.citta, count(distinct v.cf)
from visita v join turista t on v.cf = t.cf
group by v.viaggio, v.citta

-- 7
with costo_maggiorenni as (select distinct v.viaggio, sum(v.costo) as costo
						   from turista t join visita v on t.cf = v.cf join viaggio vg on v.viaggio = vg.codice
						   where (vg.anno - t.annonascita) >= 18
						   group by v.viaggio)
select distinct v.viaggio, c.costo
from visita v join costo_maggiorenni c on v.viaggio = c.viaggio
where c.costo = (select min(costo)
				 from costo_maggiorenni)

-- 8
select distinct v1.viaggio, v2.viaggio
from visita v1 join visita v2 on v1.cf = v2.cf
where v1.viaggio < v2.viaggio
except
select distinct v1.viaggio, v2.viaggio
from visita v1 join visita v2 on v1.cf = v2.cf
where v1.citta not in (select citta
					   from visita
					   where viaggio = v2.viaggio)
					   
-- 9
with almeno1viaggio as (select distinct anno
						from viaggio
						group by anno
						having count (codice) > 1) 					
select distinct vg.anno, count(distinct v.citta)
from almeno1viaggio a, visita v join viaggio vg on vg.codice = v.viaggio
where vg.anno = a.anno
group by vg.anno, v.citta
having count(distinct v.viaggio) > 1






