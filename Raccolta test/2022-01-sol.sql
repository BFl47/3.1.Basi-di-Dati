-- attivita(codice, progetto, durata)
-- partecipa(codiceattivita, lavoratore)

-- 1
select distinct p.lavoratore
from partecipa p join attivita a on a.codice = p.codiceattivita
where a.durata > 10

-- 2
select distinct a.progetto, case
								when count(distinct p.lavoratore) is null then 0
								else count(distinct p.lavoratore)
							end
from attivita a left join partecipa p on a.codice = p.codiceattivita
group by a.progetto

-- 3
with attperprog as (select progetto, count(distinct codice) as n_attivita
				    from attivita
				    group by progetto)
select distinct p.lavoratore, avg(distinct ag.n_attivita) as media_att_progetti
from partecipa p join attivita a on p.codiceattivita = a.codice 
		join attperprog ag on a.progetto = ag.progetto
group by p.lavoratore 

-- 4
with richiesta as (select distinct p.lavoratore, a.progetto, sum(a.durata) as somma
				   from partecipa p join attivita a on p.codiceattivita = a.codice
				   group by p.lavoratore, a.progetto)
select *			   
from richiesta
union
select distinct p.lavoratore, a.progetto, 0
from partecipa p, attivita a
where (p.lavoratore, a.progetto) not in (select lavoratore, progetto 
										 from richiesta)

-- 5
with num_attivita_prog as (select progetto, count(distinct codice) as somma
					  	   from attivita
					  	   group by progetto),
	 num_attivita_lav as (select distinct lavoratore, progetto, count(codiceattivita) as somma
						  from partecipa join attivita on codice = codiceattivita
						  group by lavoratore, progetto) 
select distinct nl.lavoratore
from num_attivita_prog np join num_attivita_lav nl on np.progetto = nl.progetto
where np.somma = nl.somma	

