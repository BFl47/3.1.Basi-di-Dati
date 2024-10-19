-- giocattolo(codice, nome, classe)
-- bambino(codice, nome, citta)
-- richiesta(codiceb, codiceg, preferenza)
-- b.citt�

-- 1 
select distinct b.codice, b.nome
from bambino b join richiesta r on b.codice = r.codiceb
where r.preferenza = 1

-- 2
select distinct g.nome
from bambino b join richiesta r on b.codice = r.codiceb
	join giocattolo g on g.codice = r.codiceg
where g.classe > 2 and b.citt� = 'Milano' and r.preferenza > 1

-- 3
select distinct g.classe, count(codiceb)
from bambino b join richiesta r on b.codice = r.codiceb
	join giocattolo g on g.codice = r.codiceg
where b.citt� = 'Palermo'
group by g.classe

-- 4
with richiesta_classe10 as (select b.codice
						    from bambino b join richiesta r on b.codice = r.codiceb
								join giocattolo g on g.codice = r.codiceg
						    where g.classe = 10)
select distinct b.codice, avg(r.preferenza)
from bambino b join richiesta r on b.codice = r.codiceb
where b.codice not in (select * from richiesta_classe10)
group by b.codice
union
select distinct b.codice, 0
from bambino b
where b.codice not in (select codiceb from richiesta)

-- 5
select distinct b.citt�, min(r.preferenza)
from bambino b join richiesta r on b.codice = r.codiceb
	join giocattolo g on g.codice = r.codiceg
where g.classe <= 10
group by b.citt�
having count(r.preferenza) > 1
