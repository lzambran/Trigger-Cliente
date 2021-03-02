--trigger para cliente--

create or replace function tr_clienteinsert()
returns trigger as $$
declare
registros int;
begin

registros :=(select count (idcliente) from cliente where 
cedula_cliente = new.cedula_cliente);
if(registros > 0) then
   raise exception SQLSTATE 'E0002' using
        message = 'Hey..Este cliente ya se encuentra registrado ';
	return false;
end if;


return new;
end;
$$ language plpgsql;

create trigger tr_clienteinsert
before insert or update on cliente
for each row
execute procedure tr_clienteinsert();