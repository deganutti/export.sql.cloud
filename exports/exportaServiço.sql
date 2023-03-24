select distinct o.codigo as "CODIGO"
     , 0 as "CODIGO_IDENTIFICACAO"
     , '0' as "REFERENCIA_FABRICANTE"
     , 0 as "CODIGO_SIMILARIDADE"
     , 0 as "CODIGO_IMPORTACAO"
     , 0 as "ORIGEM"
     , 0 as "CLASSIFICACAO"
     , o.descricao as "NOME"
     , o.descricao as "APELIDO"
     , o.precoprazo as "PRECO_VENDA"
	, 0 as "PRECO_MINIMO"
	, t.descricao as "UNIDADE"
	, 0 as "NCM"
	, 0 as "TIPO_ITEM"
	, '' as "FAMILIA"
	, '' as "GRUPO_ESTOQUE"
	, '' as "CATEGORIA"
	, '' as "MARCA"
from osservico o  
inner join tabunidade t 
   on t.codunidade = o.codunidade 
where o.status <> 1  