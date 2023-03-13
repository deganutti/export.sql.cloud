CREATE OR REPLACE FUNCTION removeCaracteres(texto character varying)
 RETURNS TABLE(txt character varying)
 LANGUAGE plpgsql
AS $function$
declare  
WtelAjuste cursor for 
    select translate(texto,'abcdefghaijklmnopqrstuvxwyzABCDEFGGAIJALMNOPQRSTUVXWYZ|!#@$¨&_²³£¢¬/*-+.;%{}ªº[]?/°?<>^~()`´,_=+','');
begin 
   OPEN WtelAjuste;
   FETCH WtelAjuste INTO texto;
   CLOSE WtelAjuste;   
   return next;	
end;
$function$
;