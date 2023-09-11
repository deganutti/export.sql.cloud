select distinct 'insert into pessoas_meios_pagamentos (pessoa_id,meio_pagamento_id, usuario_atualizacao_id, usuario_cadastro_id,origem_dados,registro_em_edicao,ativo,data_cadastro,data_atualizado,excluido) 
values ('||xxx.pessoa_id||','
         ||xxx.meio_pag_val_cloud||','
         ||'6,6,0,0,0,(select current_timestamp),(select current_timestamp),0);'
from(
select distinct c.codpagto as meio_pagamento_id
     , v.meio_pag_val_cloud
     , t.descricao 
     , c2.razao
     , c2.codcli as pessoa_id
from clitabpagto c 
inner join tabpagto t 
   on t.codpagto = c.codpagto 
inner join cliente c2 using (codfilial, codcli) 
left outer join valida_meio_pag v
  on v.codpagto = t.codpagto 
where  c.situacao <> 2
  and c2.codfilial =1
  and t.codpagto <> 0 
  and v.meio_pag_val_cloud <> ''
  --and c.codcli = 18338
)xxx