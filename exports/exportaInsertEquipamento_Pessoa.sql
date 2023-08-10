select 'insert into equipamento_pessoa (ativo, pessoa_id, equipamento_id, data_atualizado, data_cadastro, usuario_atualizacao_id, usuario_cadastro_id, origem_dados, modelu, numero_motor, numero_chassi, capacidade_nominal, bateria, numero_transmissao, numero_diferencial, serie, torre, observacao,excluido,registro_em_edicao) values ('
    ||xxx.ativo||','
    ||xxx.pessoa_id||','
    ||xxx.equipamento_id||','
    ||xxx.data_atualizacao||','
    ||xxx.data_cadastro||','
    ||xxx.usuario_atualizacao_id||','
    ||xxx.usuario_cadastro_id||','
    ||xxx.origem_dados||','
    ||''''||xxx.modelu||''''||','
    ||''''||xxx.numero_motor||''''||','
    ||''''||xxx.numero_chassi||''''||','
    ||''''||xxx.capacidade_nominal||''''||','
    ||''''||xxx.bateria||''''||','
    ||''''||xxx.numero_transmissao||''''||','
    ||''''||xxx.numero_diferencial||''''||','
    ||''''||xxx.serie||''''||','
    ||''''||xxx.torre||''''||','
    ||''''||xxx.observacao||''','
    ||0||','
    ||0
||');'
from(
select 1 as ativo
     , c3.id as pessoa_id
     , '(select id from produtos where codigo_identificacao_interno = '''||c.codfilobjeto||' - '||c.codobjeto||''')'  as equipamento_id  
     , '(select current_timestamp)' as data_atualizacao
     , '(select current_timestamp)' as data_cadastro
     , 1 as usuario_atualizacao_id  
     , 1 as usuario_cadastro_id  
     , 0 as origem_dados  
     , o.modelomotor as modelu
     , o.numeromotor as numero_motor
     , o.modelogerador as numero_chassi
     , cast(o.potencia as varchar(50)) as capacidade_nominal
     , cast(o.tensao as varchar(50)) as bateria
     , o.quadrocomando as numero_transmissao
     , o.contactor as numero_diferencial
     , o.numeroserie as serie
     , o.usca as torre
     , 'contrato: '|| o.contrato||chr(10)||'escopo: '||escopo as observacao 
from osobjetogerador o 
inner join osobjeto o2 
   on o2.codfilobjeto = o.codfilobjeto 
  and o2.codobjeto = o.codobjeto  
inner join cliobjeto c 
   on c.codfilobjeto = o.codfilobjeto 
  and c.codobjeto = o.codobjeto  
inner join cliente c2 
   on c2.codfilial = c.codfilcli 
  and c2.codcli = c.codcli  
inner join clicloud c3 
   on c3.cpf_cnpj = c2.cpf 
  and c3.razao_social = c2.razao  
inner join casan c4 
   on c4.cpf = c2.cpf 
  and c4.nome_pessoa = c3.razao_social  
where c2.cpf <> '82508433000117'
) xxx