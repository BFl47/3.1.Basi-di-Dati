-- citta(id, nome, regione)
-- centralina(codice, tipo, citta)
-- rilevazione(codice, giorno, valore)

-- 1
select distinct r.codice, r.giorno, r.valore
from centralina c join rilevazione r on r.codice = c.codice 
	join citta t on c.citta = t.id
where r.valore < 1100 and c.tipo = 200 and t.nome != 'Milano'

-- 2
select distinct t.nome, c.tipo
from citta t join centralina c on t.id = c.citta
group by t.nome, c.tipo
having count(distinct c.codice) > 1

-- 3
with num_rilevazioni as (select codice, count(*) as somma
						 from rilevazione
						 group by codice)
select distinct c.codice, t.regione, nr.somma
from centralina c join citta t on t.id = c.citta
	join num_rilevazioni nr on c.codice = nr.codice

-- 4
with gennaio as (select codice
				 from rilevazione
				 where giorno <= 31)
select distinct r.codice
from rilevazione r
where r.codice not in (select * from gennaio)

-- 5
with minimo as (select t.nome, min(r.giorno) 
			    from citta t join centralina c on t.id = c.citta
					join rilevazione r on r.codice = c.codice
			    where r.valore > 500
			    group by t.nome)
select distinct	m.nome, m.min
from minimo m
union
select distinct nome, null::integer
from citta
where nome not in (select nome from minimo)
				

