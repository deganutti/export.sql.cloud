select 'insert into produtos_aplicacoes (ativo,data_atualizado, data_cadastro,descricao,material_id,usuario_atualizacao_id,usuario_cadastro_id,origem_dados,id_origem_dados,usuario_edicao_id,registro_em_edicao) 
values ('||1||
      ','||('(select CURRENT_TIMESTAMP)')||
      ','||('(select CURRENT_TIMESTAMP)')||
      ','''||y.obs||''''||
      ','||y.codart||
      ','||1||
      ','||1||
      ','||0||
      ','||0||
      ','||0||
      ','||0||');'
from(
select x.codart
     , replace(replace(replace(replace(translate(x.obs,'{}[]"''',''),'descricao:',''),'\r\n',chr(10)),'\t',''),'\r','') as obs 
from(
select aa.codart 
     , retorna_aplicacao(aa.codart) as obs
from artigo1a aa 
where aa.descricao <> '') x
)y