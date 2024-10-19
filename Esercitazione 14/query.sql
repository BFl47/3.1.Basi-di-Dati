-- non si dice che ogni autore ha scritto un libro
-- e che ogni libro ha un autore
-- una query deve essere corretta se restituisce il risultato giusto per ogni DB
-- ricorda di fare lo schemino per capire la base di dati (es foreign key etc)

-- 1
select distinct a.codice
from autore a join scritto s on a.codice = s.codicea
	join libro l on s.nomel = l.nome
where l.copievendute > 10

-- 2
select distinct a.codice, a.cognome
from autore a join scritto s on a.codice = s.codicea
	join libro l on s.nomel = l.nome
where a.eta < 30 and l.copievendute > 20

-- 3
with almeno10 as (select distinct a.codice
				  from autore a join scritto s on a.codice = s.codicea
							join libro l on s.nomel = l.nome
				  where l.copievendute > 10)
select distinct a.codice, a.cognome
from autore a
where a.codice not in (select * from almeno10)

-- 4
with copie15 as (select distinct l.nome
				 from libro l
				 where l.copievendute > 15)
select distinct l.nome, count(distinct a.codice)
from autore a join scritto s on a.codice = s.codicea
	join copie15 l on l.nome = s.nomel
where a.eta > 40
group by l.nome
union
select distinct l.nome, 0
from libro l 
where l.nome not in (select s.nomel
					 from scritto s)

-- 5
with famoso as (select distinct s.codicea
			    from scritto s join libro l on s.nomel = l.nome
			    where l.copievendute > 10
			    group by s.codicea
			    having count(distinct l.nome) > 1)
select distinct s1.codicea, s2.codicea
from famoso s1, famoso s2
where s1.codicea < s2.codicea 
-- 6
with query6 as (
select distinct s.codicea, avg(l.copieVendute) as media
from scritto s join libro l on s.nomel = l.nome
group by s.codicea
union 
select distinct a.codice, NULL::numeric
from autore a
where a.codice not in (select s.codicea
					   from scritto s)
)
select distinct a.codicea
from query6 a
where media is null

-- 7
with almeno2 as (select distinct s.codicea as codice
				 from scritto s
		         group by s.codicea
				 having count(distinct s.nomel) > 1)
select distinct a.codice, sum(l.copievendute)
from autore a join scritto s on a.codice = s.codicea
	join libro l on l.nome = s.nomel
	join almeno2 a2 on a2.codice = a.codice
where a.eta > 30
group by a.codice

-- 8 
with almeno2 as (select distinct s.nomel
				 from scritto s
		         group by s.nomel
				 having count(distinct s.codicea) > 1)
select distinct s.nomel
from scritto s
where s.nomel not in (select * from almeno2)

-- 9
with totcopie as (select distinct s.codicea, sum(l.copievendute) as somma
				  from scritto s join libro l on s.nomel = l.nome
				  group by s.codicea)
select distinct a.codice, a.cognome
from autore a join totcopie t on t.codicea = a.codice
where t.somma >= all (select somma from totcopie)
				
				











