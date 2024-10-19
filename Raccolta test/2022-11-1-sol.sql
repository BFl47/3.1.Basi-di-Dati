-- 1
select distinct p.codice, p.categoria
from prodotto p join contenuto c on p.codice = c.codicep
    join tipocomponente t on t.codice = c.codicet 
where t.materiale = 'Legno'

-- 2
select distinct t.codice, count(distinct c.codicep)
from tipocomponente t left join contenuto c on t.codice = c.codicet
group by t.codice

-- 3
select distinct c.codicep
from contenuto c join tipocomponente t on c.codicet = t.codice
group by c.codicep
having count(distinct t.materiale) = 1

-- 4
select distinct t.materiale, c.codicep, count(distinct t.codice) as componenti
from tipocomponente t join contenuto c on t.codice = c.codicet
group by t.materiale, c.codicep
union 
select distinct t.materiale, p.codice, 0
from tipocomponente t, prodotto p
where p.codice not in (select codicep from contenuto) or
    t.codice not in (select codice t from contenuto)

-- 5
with comp_plastica as (select distinct codicep, count(distinct c.codicet) tot_plastica
                       from contenuto c join tipocomponente t on c.codicet = t.codice
                       where t.materiale = 'Plastica'
                       group by c.codicep)
select distinct cp.codicep
from comp_plastica cp
where cp.tot_plastica <= all (select tot_plastica from comp_plastica)

