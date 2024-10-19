-- 1
select distinct t.codice, t.materiale
from tipocomponente t join contenuto c on t.codice = c.codicet 
    join prodotto on p.codice = c.codicep
where p.categoria = 'Edilizia'

-- 2
select distinct p.codice, count(distinct c.codicet)
from prodotto p left join contenuto c on p.codice = c.codicep
group by p.codice

-- 3
select distinct c.codicet
from contenuto c join prodotto p on c.codicep = p.codice
group by c.codicet
having count(distinct p.categoria) = 1

-- 5
with num_prod as (select distinct c.codicet, count(distinct c.codicep) as num
                  from contenuto c join prodotto p on c.codicep = p.codice
                  where p.categoria = 'Edilizia'
                  group by c.codicet)
select distinct np.codicet
from num_prod np
where np.num >= (select num from num_prod)

            
