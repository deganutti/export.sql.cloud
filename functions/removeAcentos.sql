CREATE OR REPLACE FUNCTION removeAcentos(texto character varying)
 RETURNS TABLE(txt character varying)
 LANGUAGE plpgsql
AS $function$
declare  
WtelAjuste cursor for 
    select translate(texto,'ÀÁÃãáàÉÈéèÍíÓóÒòÕõÚúÇç','AAAaaaEEeeIiOoOoOoUuCc');
begin 
   OPEN WtelAjuste;
   FETCH WtelAjuste INTO texto;
   CLOSE WtelAjuste;   
   return next;	
end;
$function$
;