-- giocattolo(codice, nome, classe)
-- bambino(codice, nome, citta)
-- richiesta(codiceb, codiceg, preferenza)

-- 1
select distinct g.codice, g.nome
from richiesta r join giocattolo g on r.codiceg = g.codice
where r.preferenza = 5

-- 2
select distinct b.nome
from bambino b join richiesta r on b.codice = r.codiceb
	join giocattolo g on g.codice = r.codiceg
where b.citt� = 'Milano' and  g.classe != 8 and r.preferenza < 3

-- 3
select distinct b.citt�, count(distinct r.codiceb)
from bambino b join richiesta r on b.codice = r.codiceb
	join giocattolo g on g.codice = r.codiceg
where g.classe > 3
group by b.citt�

-- 4
select distinct g.codice, avg(r.preferenza) as media
from giocattolo g join richiesta r on g.codice = r.codiceg
where g.codice not in (select distinct codiceg
					   from richiesta join bambino on codiceb = codice
					   where citt� = 'Firenze')
group by g.codice			
union
select distinct g.codice, null::numeric as media
from giocattolo g
where g.codice not in (select codiceg from richiesta)

-- 5
with lista_citta as (select citt� from bambino)
select distinct b.citt�, count(distinct codiceb)
from lista_citta c join bambino b on c.citt� = b.citt�
	join richiesta r on b.codice = r.codiceb
	join giocattolo g on g.codice = r.codiceg
where g.classe >= 6
group by b.citt�
having count(distinct codiceb) > 1

