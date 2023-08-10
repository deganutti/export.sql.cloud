drop table casan;
create table casan as
select c1.codfilial as filial
     , case c1.cpf when '0' then '22222222222222' else c1.cpf end as cpf
     , c1.razao as nome_pessoa
     , c.codobjeto as equipamento_id  
     , 2000 as ano  
     , 1 as usuario_atualizacao_id  
     , 1 as usuario_cadastro_id  
     , 0 as origem_dados  
     , null as id_origem_dados  
     , null as usuario_edicao_id  
     , 0 as registro_em_edicao  
     , 1 as ativo  
     , '(select current_timestamp)' as data_cadastro  
     , '(select current_timestamp)' as data_atualizado  
     , 0 as excluido  
     , null as usuario_excluiu_id  
from cliobjeto c 
inner join cliente c1 
   on c1.codfilial = c.codfilcli 
  and c1.codcli = c.codcli 
inner join osobjeto o using(codfilobjeto,codobjeto)
where c1.bloquear not in (3,5)
  and c1.cpf <> '82508433000117' 
-- and c1.codcli = 123
 --  and c1.codfilial in (1,2)

/*
select * 
from cliobjeto c 
inner join osobjeto o using(codfilobjeto,codobjeto)
inner join osobjetogerador o1 using(codfilobjeto,codobjeto),
*/