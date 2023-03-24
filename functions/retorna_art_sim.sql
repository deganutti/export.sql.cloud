DROP FUNCTION retorna_art_sim(integer);
CREATE OR REPLACE FUNCTION public.retorna_art_sim(_codart int)
 RETURNS TABLE(_json character varying)
 LANGUAGE plpgsql
AS $function$
declare  
_sql cursor for 
    select json_agg(xxx)
	from (
	select cast(artsim.codsim as text)
	from artsim
	where artsim.codart = _codart
	) xxx;
begin 
   OPEN _sql;
   FETCH _sql INTO _json;
   CLOSE _sql;   
   return next;	
end;
$function$
;
