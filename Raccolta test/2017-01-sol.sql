-- scuola(codice, nome, tipo, provincia)
-- provincia(codprovincia, nome, regione)
-- esito(codscuola, anno, promossi, bocciati)

-- 1
select distinct s.codice, s.nome, e.promossi
from scuola s join esito e on s.codice = e.codscuola
where s.provincia = 15 and e.anno = 2015

-- 2
select distinct s.codice
from scuola s join provincia p on s.provincia = p.codprovincia
	join esito e on e.codscuola = s.codice
where p.regione = 'Lazio' and e.bocciati <= e.promossi/2

-- 3
select distinct s.provincia, e.anno, sum(e.promossi)
from scuola s join esito e on s.codice = e.codscuola
where s.tipo = 'classico' or s.tipo = 'scientifico'
group by s.provincia, e.anno

-- 4
with prom_min_bocc as (select codscuola
					   from esito
					   where promossi < bocciati)
select distinct e.codscuola
from esito e
where e.codscuola not in (select * from prom_min_bocc)

-- 5
select distinct p.regione
from scuola s join provincia p on s.provincia = p.codprovincia
	join esito e on s.codice = e.codscuola
group by p.codprovincia, e.anno, p.regione
having sum(e.promossi) < sum(e.bocciati)
