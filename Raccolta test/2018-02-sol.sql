-- Autore(codice, cognome, eta)
-- Libro(nome, copieVendute)
-- Scritto(codicea, nomel)

-- 1
select distinct codicea 
from libro join scritto on nome = nomel
where copieVendute > 10

-- 2
select distinct codice, cognome
from autore
where eta < 30 and codice in (select distinct codicea
							  from libro join scritto on nome = nomel
							  where copieVendute > 20)

-- 3
select codice, cognome
from autore
where codice not in (select distinct codicea
      				 from libro join scritto on nome = nomel
					 where copieVendute > 10)

-- 4
select nomel, count(codicea)
from scritto
where nomel in (select nome
			    from libro
			   	where copieVendute > 15)
	and codicea in (select codice
				   	from autore
				   	where eta > 40)
group by nomel

select nomel, count(codicea)
from scritto join libro on nomel = nome join autore on codicea = codice
where copieVendute > 15 and eta > 40
group by nomel

-- 5
select codicea, avg(copieVendute)
from scritto join libro on nomel = nome
group by codicea

-- 6
select codicea, sum(copieVendute)
from scritto join libro on nome = nomel
where codicea in (select distinct codicea
				  from scritto join autore on codicea = codicea 
				  where eta > 30 
				  group by codicea
				  having count(distinct nomel) >= 2)
group by codicea
				  
-- 7			  
select nomel
from scritto join autore on codicea = codice
group by nomel
having count(*) = 1

-- 8
select codice, cognome
from autore join scritto on codice = codicea join libro on nome = nomel
group by codice
having sum(copieVendute) = (select max(copieVendute)
							from libro)

-- 9
select distinct aut1.codicea, aut2.codicea
from scritto aut1, scritto aut2 
where aut1.codicea in (select distinct codicea
					   from scritto join libro on nomel = nome
					   where copieVendute > 10
					   group by codicea
					   having count(distinct nomel) >= 2)
	and aut2.codicea in (select distinct codicea
						 from scritto join libro on nomel = nome
						 where copieVendute > 10
						 group by codicea
						 having count(distinct nomel) >= 2 )					
	and aut1.codicea < aut2.codicea 		  
