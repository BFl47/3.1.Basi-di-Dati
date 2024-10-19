-- inizializzazione

ALTER TABLE viaggio
ADD COLUMN incasso INTEGER;

create or replace function inizializza_incasso() returns void as
$$
  begin
  update viaggio set incasso = (select sum(v.costo)
	  							from visita v
								where codice = v.viaggio
	  							group by v.viaggio);
  end;
$$ language plpgsql;  

select inizializza_incasso();

select * from viaggio


-- aggiornamento dopo:

-- insert
create or replace function ricalcoloIncasso_dopo_insert() returns trigger as
$$
begin
	update viaggio set incasso = incasso + new.costo 
	where codice = new.codice;
	return null;
end;
$$ language plpgsql;

create trigger trigger_insert_incasso after insert on visita
for each row execute procedure ricalcoloIncasso_dopo_insert();

-- delete
create or replace function ricalcoloIncasso_dopo_delete() returns trigger as
$$
begin
	update viaggio set incasso = incasso - old.costo 
	where codice = old.codice;
	return null;
end;
$$ language plpgsql;

create trigger trigger_delete_incasso after delete on visita
for each row execute procedure ricalcoloIncasso_dopo_delete();

-- update
create or replace function ricalcoloIncasso_dopo_update() returns trigger as
$$
begin
	update viaggio set incasso = incasso - old.costo 
	where codice = new.codice;
	
	update viaggio set incasso = incasso + new.costo
	where codice = new.codice;
	return null;
end;
$$ language plpgsql;

create trigger trigger_update_incasso after update on visita
for each row execute procedure ricalcoloIncasso_dopo_update();


select * from viaggio

insert into viaggio values (10, 2020, 10)

update viaggio
set incasso = 100
where codice = 10

delete from viaggio
where codice = 10
