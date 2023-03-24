drop table gruger_cliente_export;
create table gruger_cliente_export as
select c.cpf as "CPF/CNPJ"
    , c.rg as "INSCRICAO_ESTADUAL"
    , c.razao as "RAZAOSOCIAL"
    , c.fantasia as "NOMEFANTASIA"
    , c.cep as "CEP"
    , c.endereco as "LOGRADOURO"
    , c.numero as "NUMERO"
    , c.complemento as "COMPLEMENTO"
    , c.cidade as "MUNICIPIO"
    , c.bairro as "BAIRRO"
    , c.uf as "UF"
    , retornaIBGE(unaccent(c.cidade),c.uf) as "IBGE"
    , 1 as "CLIENTE"
    , 0 as "FORNECEDOR" 
    , ajusta_tel(c.fone) as "TELEFONE"
    , ajusta_tel(c.celular) as "TELEFONE_ADICIONAL"
    , ajusta_tel(c.fax) as "TELEFONE_EXTRA"
    , c.email as "EMAIL"
    , c.site as "SITE"
    , cast(c.codcli||''||c.codfilial as int) as "CODIGO"
    , validaCnpjCpf(c.cpf) as "CNPJ_VALIDO"
from cliente c
where (c.bloquear = ANY (ARRAY[0, 1, 4, 6, 7, 8])) AND c.codcli > 0
union 
select c.cpf as "CPF/CNPJ"
    , c.rg as "INSCRICAO_ESTADUAL"
    , c.razao as "RAZAOSOCIAL"
    , c.fantasia as "NOMEFANTASIA"
    , t.cep as "CEP"
    , t.endereco as "LOGRADOURO"
    , t.numero as "NUMERO"
    , t.complemento as "COMPLEMENTO"
    , t.cidade as "MUNICIPIO"
    , t.bairro as "BAIRRO"
    , t.uf as "UF"
    , retornaIBGE(unaccent(t.cidade),t.uf) as "IBGE"
    , 1 as "CLIENTE"
    , 0 as "FORNECEDOR" 
    , ajusta_tel(c.fone) as "TELEFONE"
    , ajusta_tel(c.celular) as "TELEFONE_ADICIONAL"
    , ajusta_tel(c.fax) as "TELEFONE_EXTRA"
    , c.email as "EMAIL"
    , c.site as "SITE"
    , cast('9'||''||c.codcli||''||c.codfilial||''||t.sequencia as int) as "CODIGO"
    , validaCnpjCpf(c.cpf) as "CNPJ_VALIDO"
from cliente c
inner join tabenderecos t 
   on t.codfilial = c.codfilial 
  and t.controle = c.codcli  
where (c.bloquear = ANY (ARRAY[0, 1, 4, 6, 7, 8])) AND c.codcli > 0
  and length(t.endereco)>0