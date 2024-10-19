-- traduttore(codice, nome, cognome, annoNascita, madrelingua)
-- traduzione(codice, brano, codTraduttore, linguaOrigina, linguaDestinazione)

-- 1
select distinct t.codice, d.brano
from traduttore t join traduzione d on t.codice = d.codTraduttore
where t.madrelingua = d.linguaDestinazione and t.annoNascita > 1980

-- 2
select distinct t1.nome, t1.cognome, t2.nome, t2.cognome
from traduttore t1, traduttore t2
where t1.codice < t2.codice and t1.madrelingua = t2.madrelingua

-- 3
select distinct t.codice, count(distinct d.codice)
from traduttore t join traduzione d on t.codice = d.codTraduttore
where t.madrelingua = d.linguaDestinazione and d.linguaOrigine = 'inglese'
group by t.codice

-- 4
with num_brani as (select count(distinct brano)
				   from traduzione)
select distinct t.nome, t.cognome
from traduttore t join traduzione d on t.codice = d.codTraduttore
group by t.codice
having count(distinct brano) = (select * from num_brani)

-- 5
with annoN_brano as (select distinct t.annoNascita, d.brano
					 from traduttore t join traduzione d on t.codice = d.codtraduttore)
select distinct d.brano, t.codice
from traduttore t join traduzione d on t.codice = d.codtraduttore
where t.annoNascita >= all (select annoNascita 
							from annoN_brano
						    where brano = d.brano)