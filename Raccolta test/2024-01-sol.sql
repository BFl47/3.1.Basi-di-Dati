-- 1
select distinct m.codicemuseo
from ingresso i join museo m on i.codicemuseo = m.codicemuseo
where m.citta = 'Roma' and i.giorno = 1

-- 2
with iscrizioni_gen as (select distinct p.nome, count(distinct i.gruppo) as num
						from persona p join iscritto i on p.nome = i.nomepersona
						where i.giorno <= 31
						group by p.nome)
select distinct p.nome, num
from iscrizioni_gen p
union 
select distinct p.nome, 0
from persona p
where p.nome not in (select distinct nomepersona from iscritto) or
	p.nome not in (select distinct nome from iscrizioni_gen)

-- 3
with visite_div_gen as (select distinct codicemuseo
				    from ingresso
				    where giorno > 31)
select distinct m.codicemuseo, m.citta
from museo m 
where m.codicemuseo not in (select * from visite_div_gen)

-- 4
with tutti_gruppi as (select distinct gruppo from iscritto
					  union
					  select distinct gruppo from ingresso)
select distinct i.gruppo
from iscritto i join persona p on i.nomepersona = p.nome
group by i.gruppo
having count(distinct p.eta) = 1
union
select distinct gruppo
from tutti_gruppi 
where gruppo not in (select distinct gruppo from iscritto)

-- 5
with gruppo_maxg as (select distinct gruppo, max(giorno) as maxg
					 from iscritto 
					 group by gruppo),
	tutti_gruppi as (select distinct gruppo from iscritto
					 union
					 select distinct gruppo from ingresso)
select distinct g.gruppo
from tutti_gruppi g
except
select distinct g.gruppo
from gruppo_maxg g join ingresso i on g.gruppo = i.gruppo
where i.giorno < g.maxg
