select c.prazo1||','||c.prazo2||','||c.prazo3||','||c.prazo4 ||','||c.prazo5||','||c.prazo6||','||c.prazo7||','||c.prazo8||','||c.prazo9||','||c.prazo10 as "CONDICAOPAGAMENTO"
     , 'CP' as "TIPO"
     , a.cnpj as "CNPJFILIAL"
     , v.cpf as "CPFVENDEDOR"
     , 'BLR' as "MOEDA"
     , '' as "OPERACAOFINANCEIRA"
     , '' as "ESPECIE"
     , c3.cpf as "CNPJCPFCLIENTEFORNECEDOR"
     , t.descricao as "DOCUMENTO" 
     , dataclarion(c.dtemissao) as "DATAEMISSAO"
     , f.chavenfe as "CHAVENFE"
     , '' as "COMPLEMENTO"
     , '' as "PERCENTUALCOMISSAO"
     , f.valorfatura as "VALORTOTALNF"
     , max(c2.parcela) as "NRPARCELAS" --criar subselect para trazer a informação correta esta errada
     , c2.parcela as "PARCELA"
     , dataclarion(c2.dtvecto) as "DATAVENCIMENTO"
     , c2.valor as "VALORPARCELA" --verificar se vai o venal ou valor com juros e tudo mais.
     , c.codped||''||c.serie  as "NOSSONUMERO"
     , '' as "CONTADEBITO"
     , '' as "HISTORICO"
     , '' as "OBSERVACOES"
     , '' as "CENTROCUSTO"
     , validacnpjcpf(c3.cpf) as "CNPJ_VALIDO"
from conrec c
inner join cliente c3 using (codfilial,codcli)
inner join conritem c2 using (codfilial,codped,serie)
inner join filial a using(codfilial)
inner join tabpagto t on
   t.codpagto = c.codpagto 
left outer join vendedor v 
  on v.codfilial = c.codfilial 
 and v.codvend = c.codvend
left outer join fatura f 
  on f.codfilial = c.codfilial 
 and f.codped = c.codped 
 and f.serie = c.serie  
group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,16,17,18,19,20,21,22,23,24
   