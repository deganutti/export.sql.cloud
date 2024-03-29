CREATE OR REPLACE FUNCTION public.retornaIBGE(cidade character varying, _uf varchar)
 RETURNS TABLE(ibge int)
 LANGUAGE plpgsql
AS $function$
declare  
return_IBGE cursor for
	SELECT codibge FROM dblink('host=127.0.0.1 user=postgres password=161851 dbname=cep2018',
               'select codcidade,nome,uf,codibge from cep_cidade')
     AS t1(codcidade int,nome text,uf text,codibge int) where nome=unaccent(upper(cidade)) and uf=upper(_uf);   
begin 
   OPEN return_IBGE;
   FETCH return_IBGE INTO ibge;
   CLOSE return_IBGE;   
   return next;	
end;
$function$
;





begin;
update cliente_export set
"IBGE" = (SELECT codibge FROM dblink('host=127.0.0.1 user=postgres password=161851 dbname=cep2018',
               'select codcidade,nome,uf,codibge from cep_cidade')
     AS t1(codcidade int,nome text,uf text,codibge int) where nome=unaccent(upper("MUNICIPIO")) and uf=upper("UF") limit 1)
where "CODIGO" between 20001 and 40000
 and "IBGE" = 0;
commit;
 