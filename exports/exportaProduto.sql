select a.codart as "CODIGO"
     , '' as "CODIGO_IDENTIFICACAO"
     , a.codfab as "REFERENCIA_FABRICANTE"
     , a2.codsim as "CODIGO_SIMILARIDADE"
     , '' as "CODIGO_IMPORTACAO"
     , '' as "ORIGEM"
     , '' as "CLASSIFICACAO"
     , a.descricao as "NOME"
     , a.descricao as "APELIDO"
     , a3.preco1 as "PRECO_VENDA"
	, 0 as "PRECO_MINIMO"
	, t.descricao as "UNIDADE"
	, n.ncm as "NCM"
	, '' as "TIPO_ITEM"
	, l.descricao as "FAMILIA"
	, g.descricao as "GRUPO_ESTOQUE"
	, '' as "CATEGORIA"
	, m.descricao as "MARCA"
from artigo1 a
left outer join artsim a2 using (codart)
inner join artprecos a3 using (codart)
inner join tabunidade t using (codunidade)
inner join ncm n using (codncm )
inner join marca m using (codmarca)
inner join grupo g using (codgrupo)
inner join linha l using (codlinha)
where a3.codfilial = 1
  and m.codmarca not in (6)


-- select * from artsim a2
