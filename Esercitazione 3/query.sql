-- 1
select persona.nome, regione
from persona, citta
where cittaNascita = citta.nome and eta >= 18

-- 2
select distinct regione
from persona, citta, genia
where persona.nome = genia.genitore and  eta > 50 and persona.cittaNascita = citta.nome

-- 3
select gen.nome as genitore, figlio.nome as figlio
from persona as figlio, persona as gen, genia
where figlio.cittaNascita = gen.cittaNascita and 
	genia.figlio = figlio.nome and genia.genitore = gen.nome
	
-- 4
select distinct nonno.nome as nonno
from persona as figlio, persona as gen, persona as nonno, genia as genitanza, genia as nonnanza
where figlio.nome = genitanza.figlio and gen.nome = genitanza.genitore and
	gen.nome = nonnanza.figlio and nonno.nome = nonnanza.genitore and nonno.sesso = 'M'
	
select distinct nonno.nome as nonno
from persona as nonno, genia as genitanza, genia as nonnanza
where nonno.nome = genitanza.genitore and genitanza.figlio = nonnanza.genitore and nonno.sesso = 'M'
	
-- 5
select distinct regione
from citta, persona as nonno, genia as genitanza, genia as nonnanza
where nonno.nome = genitanza.genitore and genitanza.figlio = nonnanza.genitore 
	and nonno.sesso = 'M'and nonno.eta < 60 and nonno.cittaNascita = citta.nome

-- 6
select distinct f1.nome as fratelloA, f2.nome as fratelloB
from persona as f1, persona as f2, genia as maternita1, genia as maternita2, genia as paternita1, 
	genia as paternita2, persona as g1, persona as g2
where f1.nome = maternita1.figlio and g1.nome = maternita1.genitore and g1.sesso = 'F'
	and f2.nome = maternita2.figlio and g1.nome = maternita2.genitore
	and f1.nome = paternita1.figlio and g2.nome = paternita1.genitore and g2.sesso = 'M'
	and f2.nome = paternita2.figlio and g2.nome = paternita2.genitore
	and f1.nome < f2.nome
	
-- 7
select nonno.nome as nonno, nonna.nome as nonna, figlio.nome as nipote
from persona as nonno, persona as nonna, persona as padre, persona as figlio, 
	genia as genitanza, genia as nonnanzaM, genia as nonnanzaF
where figlio.nome = genitanza.figlio and padre.nome = genitanza.genitore and padre.sesso = 'M'
	and nonnanzaF.figlio = padre.nome and nonnanzaF.genitore = nonna.nome and nonna.sesso = 'F'
	and nonnanzaM.figlio = padre.nome and nonnanzaM.genitore = nonno.nome and nonno.sesso = 'M'
