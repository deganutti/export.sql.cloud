CREATE OR REPLACE FUNCTION public.retorna_cliobs(_codcli integer)
 RETURNS TABLE(_json character varying)
 LANGUAGE plpgsql
AS $function$
declare  
_sql cursor for 
    select json_agg(xxx)
	from (
		select cast(cliobservacao.observacao as text)
		from cliobservacao  
		where cliobservacao.codcli = _codcli
	) xxx;
begin 
   OPEN _sql;
   FETCH _sql INTO _json;
   CLOSE _sql;   
   return next;	
end;
$function$
;
