select 'INSERT INTO produto_localizacoes (produto_id,nome,empresa_id,usuario_atualizacao_id,usuario_cadastro_id,origem_dados,id_origem_dados,usuario_edicao_id
,registro_em_edicao,ativo,data_cadastro,data_atualizado,excluido,usuario_excluiu_id)
     VALUES('||y.codart||
            ','''||trim(y.obs)||
            ''','||1||
            ','||1||
            ','||1||
            ','||0||
            ','||0||
            ','||1||
            ','||0||
            ','||1||
            ','||'(current_timestamp)'||
            ','||'(current_timestamp)'||
            ','||0||
            ','||0||');'
from(
	select x.codart
	     , replace(replace(replace(replace(translate(x.loc,'{}[]"''',' '),':',' - '),'\r\n',chr(10)),'\t',' '),'\r',' ') as obs 
	from (
	select a.codart 
	     , retorna_art_localizacao(a.codart) as loc
	  from artigo1 a
	 where a.codart > 0) x
where x.loc is not null) y
 