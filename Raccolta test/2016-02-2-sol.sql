-- traduttore(codice, nome, cognome, annonascita, madrelingua)
-- traduzione(codice, brano, codtraduttore, linguaorigine, linguadestinazione)

-- 1
select distinct t.nome, t.cognome, d.brano
from traduttore t join traduzione d on t.codice = d.codtraduttore
where t.annonascita < 1990 and t.madrelingua = d.linguaorigine

-- 2
select distinct t1.nome, t1.cognome, t1.madrelingua, t2.nome, t2.cognome, t2.madrelingua
from traduttore t1, traduttore t2
where t1.madrelingua != t2.madrelingua and t1.annonascita = t2.annonascita and t1.codice < t2.codice

-- 4
with num_traduttori as (select count(distinct codTraduttore)
					    from traduzione)
select distinct d.brano, count(distinct codTraduttore)
from traduzione d
group by d.brano
having count(distinct codTraduttore) = (select * from num_traduttori)

-- 3
select distinct t.codice, count(distinct d.brano) as numBrani
from traduttore t join traduzione d on t.codice = d.codtraduttore
where t.madrelingua = d.linguaorigine and d.linguadestinazione = 'francese'
group by t.codice

-- 5
with brano_trad as (select d.brano, t.codice, t.annonascita
				    from traduttore t join traduzione d on t.codice = d.codtraduttore)
select distinct d.brano, d.codice
from brano_trad d
where d.annonascita <= all (select annonascita
							from brano_trad
							where brano = d.brano)
