CREATE OR REPLACE FUNCTION public.ajusta_tel(fone character varying)
 RETURNS TABLE(tel character varying)
 LANGUAGE plpgsql
AS $function$
declare  
WtelAjuste cursor for 
    select translate(fone,'abcdefghaijklmnopqrstuvxwyzABCDEFGGAIJALMNOPQRSTUVXWYZ|!#@$¨&_²³£¢¬/*-+.;%{}ªº[]?/°?<>^~()":`´,_=+','');
begin 
   OPEN WtelAjuste;
   FETCH WtelAjuste INTO tel;
   CLOSE WtelAjuste;   
   return next;	
end;
$function$
;
