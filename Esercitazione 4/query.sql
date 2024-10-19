-- automobile(targa, cilindrata, citta)
-- garage(codice, città)
-- custodita (targaauto, codgarage, numero)

-- 1
select auto.targa, gar.codice, gar.citta
from automobile auto join custodita cus on auto.targa = cus.targaauto 
	join garage gar on gar.codice = cus.codgarage
where cus.numero = 1
order by auto.citta;

-- 2
select distinct auto.citta, auto.targa
from automobile auto 
where auto.targa in (select targaauto
					from custodita, garage
					where numero > 10 and garage.citta = auto.citta)
	and	auto.cilindrata > 100;

-- 3
select gar.codice, sum(cus.numero) as tot_custodie
from garage gar join custodita cus on gar.codice = cus.codgarage
where cus.numero > 0
group by gar.codice

-- 4
select gar.codice, sum(cus.numero) as tot_custodie
from garage gar join custodita cus on gar.codice = cus.codgarage
where cus.numero > 0
group by gar.codice
having sum(cus.numero) > 10 or sum(cus.numero) is null

-- 5
select auto.targa, sum(cus.numero)
from automobile auto join custodita cus on auto.targa = cus.targaauto
	join garage gar on gar.codice = cus.codgarage
where cus.numero > 0 and auto.citta = gar.citta
group by auto.targa

-- 6
select codice
from garage
where codice not in (select codgarage
					from custodita join automobile on targa = targaauto
					where citta = 'Roma')

-- 7
select codice
from garage gar 
where codice not in (select codgarage
					from custodita join automobile on targa = targaauto
					where gar.citta != citta)
	and codice in (select codgarage
				  from custodita)

-- 8
select auto.targa, gar.citta
from automobile auto, garage gar
where (auto.targa, gar.citta) not in (
					select auto.targa, gar1.citta
					from custodita join garage gar1 on codgarage = codice
					where auto.targa = targaauto)
group by auto.targa, gar.citta

-- 9
select auto.targa, count(distinct cus.codgarage)
from automobile auto join custodita cus on auto.targa = cus.targaauto
group by auto.targa

-- 10
select targaauto, codgarage
from custodita
where (targaauto, numero) in (select auto.targa, max(cus.numero)
							from automobile auto join custodita cus on auto.targa = cus.targaauto 
							group by auto.targa)
