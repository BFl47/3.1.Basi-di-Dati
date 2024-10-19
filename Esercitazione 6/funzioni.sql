-- Esercizio 2
create function citta_visitate(codicef varchar)
returns table (citta varchar) as
$$
  begin
  return query select distinct v.citta
  			   from turista t join visita v on t.cf = v.cf
			   where t.cf = codicef;
  end;
$$ language plpgsql;

select *
from citta_visitate('10');

-- Esercizio 3
ALTER TABLE turista
ADD quantiviaggi INTEGER default 0;

per cancellarla:
ALTER TABLE turista
DROP COLUMN quantiviaggi

create or replace function quantiviaggi() returns trigger as
$$
  begin
  with count_viaggi as (select cf, count(distinct viaggio) as somma
					  from visita 
  					  group by cf)
  update turista set quantiviaggi =(select count_viaggi.somma
									 from count_viaggi
									 where turista.cf = count_viaggi.cf);
  update turista set quantiviaggi = 0 where cf = new.cf;							 
  return new;
  end;
$$ language plpgsql;

create or replace trigger inserimentoTurista after insert on turista
for each row execute procedure quantiviaggi();

insert into turista values('50', 'Prova', 1995);

select *
from turista

delete from turista
where cf = '50';
