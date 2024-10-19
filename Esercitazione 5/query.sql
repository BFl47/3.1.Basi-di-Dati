-- autore(codice, cognome, eta)
-- libro(titolo, copieVendute)
-- scritto(codicea, titolo)

-- 1
select distinct s.codicea
from scritto s join libro l on s.titolo = l.titolo
where l.copieVendute > 10	

-- 2
select distinct a.codice, a.cognome
from autore a
where a.eta < 30 and a.codice in (select s.codicea
								  from scritto s join libro l on s.titolo = l.titolo
								  where l.copieVendute > 20)

-- 3
select distinct a.codice, a.cognome
from autore a
where a.codice not in (select distinct s.codicea
					   from scritto s join libro l on s.titolo = l.titolo
					   where l.copieVendute > 10)
					   
-- 4		
select a.codice, sum(l.copieVendute)
from autore a join scritto s on a.codice = s.codicea join libro l on s.titolo = l.titolo
where a.eta > 30
group by a.codice
having count(*) > 1

-- 5
select distinct a.codice, case
							when avg(l.copieVendute) is null then 0
							else avg(l.copieVendute) end as mediaCopie		
from scritto s join libro l on s.titolo = l.titolo 
	right join autore a on a.codice = s.codicea
group by a.codice

select distinct a.codice, avg(l.copieVendute) as mediaCopie		
from scritto s join libro l on s.titolo = l.titolo 
	join autore a on a.codice = s.codicea
group by a.codice
union
select distinct a.codice, 0
from autore a
where a.codice not in (select s.codicea
					   from scritto s)

-- 6
with more40 as (select codice
				from autore 
				where eta > 40)
select l.titolo, count(*)
from libro l join scritto s on l.titolo = s.titolo join more40 on more40.codice = s.codicea
where l.copieVendute > 15
group by l.titolo
union 
select l.titolo, 0
from libro l 
where l.copieVendute > 15

-- 7
select l.titolo
from libro l join scritto s on l.titolo = s.titolo
group by l.titolo
having count(*) = 1

select s.titolo
from scritto s
group by s.titolo
having count(*) = 1

-- 8
with totale_vendite as (select s.codicea, sum(l.copieVendute) as somma
						from scritto s join libro l on s.titolo = l.titolo
						group by s.codicea)					
select a.codice, a.cognome
from autore a join totale_vendite t on a.codice = t.codicea 
group by a.codice, a.cognome, t.somma
having t.somma = (select max(somma)
				  from totale_vendite)

-- 9
with autore_famoso as (select s.codicea
					   from scritto s join libro l on s.titolo = l.titolo
					   where l.copieVendute > 10
					   group by s.codicea
					   having count(*) > 1)
select s.titolo
from scritto s
except
select s.titolo
from scritto s
where s.codicea not in (select *
						from autore_famoso)

-- 10
with autore_famoso as (select s.codicea
					   from scritto s join libro l on s.titolo = l.titolo
					   where l.copieVendute > 10
					   group by s.codicea
					   having count(*) > 1),
 	autore_solitario as (select s1.codicea
						  from scritto s1 join scritto s2 on s1.titolo = s2.titolo
						  group by s1.codicea
						  having count(*) = 1)
select a.codice, a.cognome
from autore a
where a.codice not in (select *
					   from autore_solitario)
	and a.codice in (select *
					 from autore_famoso)

