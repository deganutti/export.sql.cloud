DROP FUNCTION retorna_aplicacao(integer);
CREATE OR REPLACE FUNCTION public.retorna_aplicacao(_codart int)
 RETURNS TABLE(_json character varying)
 LANGUAGE plpgsql
AS $function$
declare  
_sql cursor for 
    select json_agg(xxx)
	from (
	select cast(a.descricao as text)
	from artigo1a a  
	where a.codart = _codart 
	) xxx;
begin 
   OPEN _sql;
   FETCH _sql INTO _json;
   CLOSE _sql;   
   return next;	
end;
$function$
;
