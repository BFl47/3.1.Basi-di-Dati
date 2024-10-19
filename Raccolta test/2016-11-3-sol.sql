-- giocattolo (codice, nome, classe)
-- bambino(codice, nome, citt�)
-- richiesta(codiceb, codiceg, preferenza)

-- 1
select distinct b.codice, b.nome, b.citt�
from bambino b join richiesta r on b.codice = r.codiceb
where r.preferenza > 1

-- 2
select distinct b.nome
from bambino b join richiesta r on b.codice = r.codiceb
	join giocattolo g on g.codice = r.codiceg
where g.classe != 7 and r.preferenza < 4 and b.citt� = 'Roma'

-- 3
select distinct g.classe, count(r.preferenza)
from bambino b join richiesta r on b.codice = r.codiceb
	join giocattolo g on g.codice = r.codiceg
where b.citt� = 'Pisa'
group by g.classe

-- 4
with richiestaMI as (select distinct r.codiceg
					 from bambino b join richiesta r on b.codice = r.codiceb
					 where b.citt� = 'Milano')
select distinct g.classe, avg(r.preferenza)
from bambino b join richiesta r on b.codice = r.codiceb
	join giocattolo g on g.codice = r.codiceg
where g.codice not in (select * from richiestaMI)
group by g.classe	

-- 5
select distinct b.citt�, max(r.preferenza)
from bambino b join richiesta r on b.codice = r.codiceb
	join giocattolo g on g.codice = r.codiceg
where g.classe <= 9
group by b.citt�
having count(r.preferenza) > 1