DROP FUNCTION retorna_clificha(integer,integer);
CREATE OR REPLACE FUNCTION public.retorna_clificha(_filial int, _codcli int)
 RETURNS TABLE(_json character varying)
 LANGUAGE plpgsql
AS $function$
declare  
_sql cursor for 
    select json_agg(xxx)
	from (
	select cast(c.obs as text)
	from clificha c 
	where c.codfilial = _filial
	  and c.codcli = _codcli
	) xxx;
begin 
   OPEN _sql;
   FETCH _sql INTO _json;
   CLOSE _sql;   
   return next;	
end;
$function$
;
