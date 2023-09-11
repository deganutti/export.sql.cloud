DROP FUNCTION retorna_art_localizacao(integer);
CREATE OR REPLACE FUNCTION public.retorna_art_localizacao(_codart int)
 RETURNS TABLE(_json character varying)
 LANGUAGE plpgsql
AS $function$
declare  
_sql cursor for 
    select json_agg(xxx)
	from (
		select corredor, baia, nivel
		  from artigo2
		  where artigo2.codart = _codart
		    and artigo2.codfilial =1
		    and (artigo2.baia <> ''
		    or artigo2.corredor <> ''
		    or artigo2.nivel <> '')
	) xxx;
begin 
   OPEN _sql;
   FETCH _sql INTO _json;
   CLOSE _sql;   
   return next;	
end;
$function$
;
