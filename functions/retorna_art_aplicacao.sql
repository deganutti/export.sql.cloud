CREATE OR REPLACE FUNCTION public.retorna_art_aplicacao(_codart integer)
 RETURNS TABLE(_json character varying)
 LANGUAGE plpgsql
AS $function$
declare  
_sql cursor for 
    select json_agg(xxx)
	from (
	select cast(artigo1a.descricao  as text)
	from artigo1a
	where artigo1a.codart = _codart
	) xxx;
begin 
   OPEN _sql;
   FETCH _sql INTO _json;
   CLOSE _sql;   
   return next;	
end;
$function$
;
