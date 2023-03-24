drop table gruger_produto_exportado;
create table gruger_produto_exportadvo as
select distinct a.codart as "CODIGO"
     , 0 as "CODIGO_IDENTIFICACAO"
     , a.codfab as "REFERENCIA_FABRICANTE"
     , ajusta_tel(retorna_art_sim(a.codart)) as "CODIGO_SIMILARIDADE"
     , 0 as "CODIGO_IMPORTACAO"
     , 0 as "ORIGEM"
     , 0 as "CLASSIFICACAO"
     , a.descricao as "NOME"
     , a.descricao as "APELIDO"
     , (select preco1 from src_artvenda(1,a.codart)) as "PRECO_VENDA"
	, 0 as "PRECO_MINIMO"
	, t.descricao as "UNIDADE"
	, n.ncm as "NCM"
	, 0 as "TIPO_ITEM"
	, g.descricao as "FAMILIA"
	, l.descricao as "GRUPO_ESTOQUE"
	, 0 as "CATEGORIA"
	, m.descricao as "MARCA"
from artigo1 a 
left outer join artprecos a3 using (codart)
left outer join tabunidade t using (codunidade)
left outer join ncm n using (codncm )
left outer join marca m using (codmarca)
left outer join grupo g using (codgrupo)
left outer join linha l using (codlinha)
inner join artbloqueio a4 using (codfilial,codart)
inner join artigo2 a5 using(codfilial,codart)
where a3.codfilial in (1,2,3)
  and a.codmarca <> 6 
  and a4.pedido = 0
  and a5.estoque > 0 
  order by 1,4