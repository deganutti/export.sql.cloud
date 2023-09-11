drop table vendedores_export;
create table vendedores_export as
select c.cpf as "CPF/CNPJ"
    , c.rg as "INSCRICAO_ESTADUAL"
    , c.nome as "RAZAOSOCIAL"
    , c.nome as "NOMEFANTASIA"
    , c.cep as "CEP"
    , c.endereco as "LOGRADOURO"
    , c.numero as "NUMERO"
    , c.complemento as "COMPLEMENTO"
    , c.cidade as "MUNICIPIO"
    , c.bairro as "BAIRRO"
    , c.uf as "UF"
    , (SELECT codibge FROM dblink('host=127.0.0.1 user=postgres password=161851 dbname=cep2018',
               'select codcidade,nome,uf,codibge from cep_cidade')
     AS t1(codcidade int,nome text,uf text,codibge int) where nome=unaccent(c.cidade) and uf=upper(c.uf) limit 1)as "IBGE"
    , 1 as "CLIENTE"
    , 0 as "FORNECEDOR" 
    , ajusta_tel(c.fone) as "TELEFONE"
    , ajusta_tel(c.celular) as "TELEFONE_ADICIONAL"
    , ajusta_tel(c.fax) as "TELEFONE_EXTRA"
    , c.email as "EMAIL"
    , '' as "SITE"
    , c.codvend as "CODIGO"
    , validaCnpjCpf(c.cpf) as "CNPJ_VALIDO"
from vendedor c
where codfilial = 1
  and codvend <> 0
  and bloqueado <>1
order by codvend  