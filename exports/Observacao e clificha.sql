select  y.codfilial 
      , y.codcli 
      , y.razao 
      , 'update pessoas set observacoes_internas = concat(observacoes_internas,'''||chr(10)||'-----------'||chr(10)||
        y.obs||''') where razao_social = '''||trim(y.razao)||''' and cpf_cnpj = '''||y.cpf||''' ;' as "sql"
from (
select x.cpf
     , x.codfilial 
     , x.codcli 
     , x.razao 
     , replace(replace(replace(replace(translate(x.obs,'{}[]"''',''),'observacao:',''),'\r\n',chr(10)),'\t',''),'\r','') as obs 
from (
select distinct c.cpf 
     , c.codfilial 
     , c.codcli 
     , c.razao 
     , retorna_cliobs(c2.codcli) as obs
from cliente c 
inner join cliobservacao c2 
   on c2.codfilial =c.codfilial 
  and c2.codcli =c.codcli
  where c.bloquear not in (3,5)
union all 
select distinct c.cpf 
     , c.codfilial 
     , c.codcli 
     , c.razao 
     , retorna_clificha(c2.codcli,c2.codfilial) as obs
from cliente c 
inner join clificha c2 
   on c2.codfilial =c.codfilial 
  and c2.codcli =c.codcli
  where c.bloquear not in (3,5)  
  ) x
  )y
  where y.obs is not null
  /*retorna_clificha
   * 
   */ 
  