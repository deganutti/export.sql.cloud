select c.prazo1||','||c.prazo2||','||c.prazo3||','||c.prazo4 ||','||c.prazo5||','||c.prazo6||','||c.prazo7||','||c.prazo8||','||c.prazo9||','||c.prazo10 as "CONDICAOPAGAMENTO"
     , 'CR' as "TIPO"
     , a.cnpj as "CNPJFILIAL"
     , v.cpf as "CPFVENDEDOR"
     , 'REAL' as "MOEDA"
     , '' as "OPERACAOFINANCEIRA"
     , '' as "ESPECIE"
     , c3.cpf as "CNPJCPFCLIENTEFORNECEDOR"
     , t.descricao as "DOCUMENTO" 
     , dataclarion(c.dtemissao) as "DATAEMISSAO"
     , f.chavenfe as "CHAVENFE"
     , '' as "COMPLEMENTO"
     , '' as "PERCENTUALCOMISSAO"
     , f.valorfatura as "VALORTOTALNF"
     , (select count(cc.parcela) from conritem cc where cc.codfilial = c.codfilial and cc.codped = c.codped and cc.serie = c.serie) as "NRPARCELAS" --criar subselect para trazer a informação correta esta errada
     , c2.parcela as "PARCELA"
     , cast(dataclarion(c2.dtvecto) as DATE) as "DATAVENCIMENTO"
     , c2.valor - c2.valorpago  as "VALORPARCELA" 
  --   , c2.valor as "VALORPARCELA" --verificar se vai o venal ou valor com juros e tudo mais.
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
 where c2.dtvecto >= formatar_data('01/01/2022')
   and c2.valorpago < c2.valor  
group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,16,17,18,19,20,21,22,23,24,c.codfilial, c.codped, c.serie  
 --  order by c2.dtvecto desc
   
   
 --  select formatar_data('01/01/2022')