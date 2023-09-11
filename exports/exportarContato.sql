select 'insert into contatos (cargo_id, pessoa_id, tipo,nome,telefone,email,acesso_xml_nfe,usuario_atualizacao_id,usuario_cadastro_id,
origem_dados,registro_em_edicao,ativo, data_cadastro, data_atualizado, enviar_nfe, enviar_boleto,notifica_titulo_vencido, notifica_via_mensageria,excluido) values ('
    ||xxx.cargo_id||','
    ||xxx.pessoa_id||','
    ||xxx.tipo||','''   
    ||xxx.nome||''','''
    ||translate(xxx.telefone,' ','')||''','''
    ||xxx.email||''','
    ||xxx.acesso_xml||','
    ||xxx.usuario_atualizacao_id||','
    ||xxx.usuario_cadastro_id||','
    ||xxx.origem_dados||','
    ||xxx.registro_em_edicao||','
    ||xxx.ativo||','
    ||xxx.data_cadastro||','
    ||xxx.data_atualizado||','
    ||xxx.enviar_nfe||','
    ||xxx.enviar_boleto||','
    ||xxx.notifica_titulo_vencido||','
    ||xxx.notifica_via_mensageria||',0'
    ');'
from 
(
select 1 as cargo_id
     , c2.codcli as pessoa_id
     , 0 as tipo
     , c.nome as nome
     , t.fone as telefone
     , t.email as email     
     , 0 as acesso_xml
     , 1 as usuario_atualizacao_id
     , 1 as usuario_cadastro_id
     , 0 as origem_dados
     , 0 as registro_em_edicao
     , 0 as ativo
     , '(select current_timestamp)' as data_cadastro
     , '(select current_timestamp)' as data_atualizado    
     , case when t.envioemail in (1,3) then 1 else 0 end as enviar_nfe
     , case when t.envioemail in (2,3) then 1 else 0 end as enviar_boleto
     , 0 as notifica_titulo_vencido
     , 0 as notifica_via_mensageria
from clifuncionario c 
left join tabenderecos t 
   on t.codfilial = c.codfilial 
  and t.controle = c.codcli 
  and t.sequencia = c.codfunccli 
inner join cliente c2 
   on c2.codfilial = c.codfilial 
  and c2.codcli = c.codcli  
where t.codtabela = 4
 -- and c.codcli <> 101
  ) xxx