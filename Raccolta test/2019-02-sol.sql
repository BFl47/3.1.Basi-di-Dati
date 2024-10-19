-- citta(id,nome,regione)
-- centralina(codice,tipo,citta)
-- rilevazione(codice,giorno,valore)

-- 1
select ril.codice, ril.giorno, ril.valore
from rilevazione ril
where ril.valore > 100 and ril.codice in (select codice
										 from centralina join citta cit on citta = cit.id
										 where cit.nome = 'Milano' and tipo != 1)

select ril.codice, ril.giorno, ril.valore
from rilevazione ril join centralina c on c.codice = ril.codice 
	join citta t on c.citta = t.id
where ril.valore > 100 and t.nome = 'Milano' and c.tipo != 1
										 
-- 2
select cent.codice, cit.regione, avg(valore)
from citta cit join centralina cent on cit.id = cent.citta 
		   	   join rilevazione r on r.codice = cent.codice
group by cent.codice, cit.regione	   

-- 3
select cent.codice
from centralina cent
where cent.codice in (select r1.codice
					 from rilevazione r1 join rilevazione r2 on r1.codice = r2.codice
					 where r1.giorno = r2.giorno+1 and r1.valore = r2.valore)

-- 4
select distinct cent.codice
from centralina cent
where cent.codice not in (select codice
						 from rilevazione 
						 where giorno > 90)

--5
with lv_inquinamento as (select cit.regione, avg(r.valore) as media
						from citta cit join centralina cent on cit.id = cent.citta
									join rilevazione r on cent.codice = r.codice
						group by cit.regione)
select distinct regione, media
from lv_inquinamento
where media < (select avg(valore)
			   from rilevazione)


