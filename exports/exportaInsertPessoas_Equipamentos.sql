select 'insert into pessoas_equipamentos (pessoa_id,equipamento_id,ano,usuario_atualizacao_id,usuario_cadastro_id,origem_dados,registro_em_edicao,ativo,data_cadastro,data_atualizado,excluido) values ('
    ||xxx.pessoa_id||','
    ||xxx.equipamento_id||','	
    ||xxx.ano||','
    ||xxx.usuario_atualizacao_id||','
    ||xxx.usuario_cadastro_id||','
    ||xxx.origem_dados||','
    ||xxx.registro_em_edicao||','
    ||xxx.ativo||','
    ||xxx.data_cadastro||','
    ||xxx.data_atualizado||','
    ||xxx.excluido||
');'
from (
select distinct c1.id as pessoa_id
     , '(select id from produtos where codigo_identificacao_interno = '''||c.filial ||' - '||c.equipamento_id||''')'  as equipamento_id  
     , c.ano 
     , c.usuario_atualizacao_id 
     , c.usuario_cadastro_id 
     , c.origem_dados 
     , c.registro_em_edicao 
     , c.ativo 
     , c.data_cadastro 
     , c.data_atualizado 
     , c.excluido 
from public.casan c
inner join clicloud c1
   on c1.cpf_cnpj = c.cpf
  and c1.razao_social = c.nome_pessoa 
--where c1.cpf_cnpj <> '82508433000117'  
)xxx   
   
   /**
   *89
   */
  -- select count (*) from clicloud c where c.cpf_cnpj ='82508433000117'



-- public.tabgrupoprecos definition

-- Drop table

-- DROP TABLE public.tabgrupoprecos;
-- public.tabgrupoprecosfilial definition

-- Drop table

-- DROP TABLE public.tabgrupoprecosfilial;
