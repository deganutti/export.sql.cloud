drop table public.financeiro_exportado;
create table public.financeiro_exportado as
select 'IMPORTAÇÃO FINANCEIRO' as "CONDICAOPAGAMENTO" 
     , 'CP' as "TIPO" --CR para contas a receber e CP para contas a pagar.
     , f1.cnpj as "CNPJFILIAL"
     , '' as "CNPJVENDEDOR"
     , 'BLR' as "MOEDA"
     , '' as "OPERACAOFINANCEIRA"
     , 'REAL' as "ESPECIE"
     , f.cnpj  as "CNPJCLIENTEFORNECEDOR"
     , p1.seqconpag as "DOCUMENTO"
     , dataclarion(p1.dtmovto) as "DATAEMISSAO"
     , '' as "CHAVENFE"
     , '' as "COMPLEMENTO"
     , '' as "PERCENTUALCOMISSAO"
     , '' as "VALORTOTALNF"
     , (select max(c.parcela) from public.conpitem c where c.codfilial = p1.codfilial  and c.serie = p1.serie  and c.seqconpag = p1.seqconpag) as "NRPARCELAS"
     , p2.parcela  as "PARCELA"
     , dataclarion(p2.dtvecto) as "DATAVENCIMENTO"
     , p2.valor as "VALORPARCELA"
     , '' as "NOSSONUMERO"
     , '' as "CONTADEBITO" --APENAS PARA CP
     , '' as "HISTORICODEBITO" --APENAS PARA CP
     , 'Conta importada Conta de origem: '||p2.nrdoccp ||' Fornecedor: '||p1.codfor  as "OBSERVACOES"
     , '' as "CENTROCUSTO"
   --  ,* 
  from public.conpag p1
inner join public.conpitem p2 using (codfilial, serie, seqconpag)
inner join public.fornec f using(codfor)
inner join public.tabpagto t using(codpagto)
inner join public.filial f1
   on f1.codfilial = p1.codfilial 
where codfor not in (
select codfor from public.fornec  x
where x.cnpj in ('00000000000','00000000000000','')
)
and p2.dtpagto = 0
and p2.valorpago = 0
union all
select 'IMPORTAÇÃO FINANCEIRO' as "CONDICAOPAGAMENTO" 
     , 'CR' as "TIPO" --CR para contas a receber e CP para contas a pagar
     , f1.cnpj  as "CNPJFILIAL"
     , '' as "CNPJVENDEDOR"
     , 'BLR' as "MOEDA"
     , '' as "OPERACAOFINANCEIRA"
     , 'REAL' as "ESPECIE"
     , c3.cpf  as "CNPJCLIENTEFORNECEDOR"
     , c1.codped as "DOCUMENTO"
     , dataclarion(c1.dtemissao) as "DATAEMISSAO"
     , '' as "CHAVENFE"
     , '' as "COMPLEMENTO"
     , '' as "PERCENTUALCOMISSAO"
     , '' as "VALORTOTALNF"
     , (select max(c.parcela) from public.conritem c where c.codfilial = c1.codfilial  and c.serie = c1.serie  and c.codped  = c1.codped) as "NRPARCELAS"
     , c2.parcela  as "PARCELA"
     , dataclarion(c2.dtvecto) as "DATAVENCIMENTO"
     , c2.valor as "VALORPARCELA"
     , c2.nossonum as "NOSSONUMERO"
     , '' as "CONTADEBITO" --APENAS PARA CP
     , '' as "HISTORICODEBITO" --APENAS PARA CP
     , 'Conta importada Nosso Número: '||c2.nossonum ||' Cliente: '||c3.codcli as "OBSERVACOES"
     , '' as "CENTROCUSTO"
     --  ,* 
  from public.conrec c1
inner join public.conritem c2 using (codfilial, serie, codped)
inner join public.cliente c3 using(codcli) 
inner join public.filial f1
   on f1.codfilial = c1.codfilial 
where c1.codcli not in (
select codcli from public.cliente  x
where x.cpf  in ('00000000000','00000000000000','')
)
and c2.dtpagto = 0
and c2.valorpago = 0 
