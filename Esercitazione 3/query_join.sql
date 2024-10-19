-- 1
select persona.nome, regione
from persona join citta on citta.nome = persona.cittaNascita
where persona.eta >= 18

-- 2
select distinct regione
from persona as genitore join genia on genitore.nome = genia.genitore
	join citta on citta.nome = genitore.cittaNascita
where genitore.eta > 50

-- 3
select gen.nome as genitore, figlio.nome as figlio
from persona as figlio join genia on figlio.nome = genia.figlio
	join persona as gen on gen.nome = genia.genitore
where gen.cittaNascita = figlio.cittaNascita

-- 4
select distinct nonno.nome
from persona as figlio join genia as figlianza on figlio.nome = figlianza.figlio
	join persona as genitore_padre on genitore_padre.nome = figlianza.genitore
	join (persona as genitore_figlio join genia as nonnanza on genitore_figlio.nome = nonnanza.figlio
		  join persona as nonno on nonno.nome = nonnanza.genitore
	) on genitore_padre.nome = genitore_figlio.nome
where nonno.sesso = 'M'

-- 5
select distinct regione
from persona as figlio join genia as figlianza on figlio.nome = figlianza.figlio
	join persona as genitore_padre on genitore_padre.nome = figlianza.genitore
	join (persona as genitore_figlio join genia as nonnanza on genitore_figlio.nome = nonnanza.figlio
		  join persona as nonno on nonno.nome = nonnanza.genitore
	) on genitore_padre.nome = genitore_figlio.nome
	join citta on nonno.cittaNascita = citta.nome
where nonno.sesso = 'M' and nonno.eta < 60

-- 6
select distinct fra1.nome as fratello_a, fra2.nome as fratello_b
from ((persona as bro1 join genia as m1 on bro1.nome = m1.figlio
	join persona as madre1 on (madre1.nome = m1.genitore and madre1.sesso = 'F'))
	join (persona as bro2 join genia as m2 on bro2.nome = m2.figlio
		join persona as madre2 on (madre2.nome = m2.genitore and madre2.sesso = 'F')
	) on madre1.nome = madre2.nome)
	join ((persona as fra1 join genia as p1 on fra1.nome = p1.figlio
		join persona as padre1 on (padre1.nome = p1.genitore and padre1.sesso = 'M'))
		join (persona as fra2 join genia as p2 on fra2.nome = p2.figlio
			join persona as padre2 on (padre2.nome = p2.genitore and padre2.sesso = 'M')
		) on padre1.nome = padre2.nome
	) on (bro1.nome = fra1.nome and bro2.nome = fra2.nome)
where fra1.nome < fra2.nome

-- 7
select distinct nonno.nome as nonno, nonna.nome as nonna
from (persona as figlio join genia as g1 on figlio.nome = g1.figlio
	join persona as padre on padre.nome = g1.genitore)
	join (persona as nonno join genia as g2 on (nonno.nome = g2.genitore and nonno.sesso = 'M'))
	on (padre.nome = g2.figlio)
	join (persona as nonna join genia as g3 on(nonna.nome = g3.genitore and nonna.sesso = 'F'))
	on (padre.nome = g3.figlio)
where padre.sesso = 'M' 
