select 'insert into dbo.pessoas_enderecos (pessoa_id,tipo_endereco,logradouro,cep,numero,letra,complemento,caixa_postal,ponto_referencia
      ,bairro_id,municipio_id,usuario_atualizacao_id,usuario_cadastro_id,origem_dados,id_origem_dados,usuario_edicao_id,registro_em_edicao
      ,ativo,data_cadastro,data_atualizado,excluido 
) values ('||pessoa_id||
        ','||tipo_endereco||
        ','''||logradouro||
        ''','||cep||
        ','||numero||
        ','''||coalesce(letra,'N/A')||
        ''','''||coalesce(complemento,'N/A')||
        ''','''||coalesce(caixa_postal,'N/A')||
        ''','''||coalesce(ponto_referencia,'N/A')||
        ''','||bairro_id||
        ','||municipio_id||
        ','||1||
        ','||1||
        ','||0||
        ','||''''''||
        ','||''''''||
        ','||0||
        ','||1||
        ','||('(select CURRENT_TIMESTAMP)')||
        ','||('(select CURRENT_TIMESTAMP)')||
        ','||0||');'
from (select t.controle as "pessoa_id"
     , 2 as "tipo_endereco" --1 principal 2 secundário
     , t.endereco as "logradouro" 
     , t.cep as "cep"
     , t.numero as "numero"
     , null as "letra"
     , t.complemento as "complemento"
     , null as "caixa_postal"
     , null as "ponto_referencia"
     , '(select id as bairro_id from bairros where municipio_id = (select id from municipios where ibge = '|| public.retornaibge(t.cidade,t.uf) ||') and nome = '''||t.bairro||''')' as "bairro_id" --vinculo com municipio_id 
     , '(select id as municipio_id from municipios where ibge = '|| public.retornaibge(t.cidade,t.uf) ||')' as "municipio_id" --vinculo com código do ibge
     , 1 as "usuario_atualizacao_id"
     , 1 as "usuario_cadastro_id"
     , 0 as "origem_dados"
     , null as "id_origem_dados"
     , null as "usuario_edicao_id"
     , null as "registro_em_edicao"
     , 1 as "ativo"
     , current_timestamp as "data_cadastro"
     , current_timestamp as "data_atualizacao"
     , 0 as "excluido"
     , null as "usuario_excluiu_id"
     , null as "cpf_cnpj_recebimento"
     , null as "razao_social_recebimento"
     , null as "inscricao_estadual_recebimento"
from tabenderecos t 
where endereco <> ''
  and cep <> ''  
) as endereco