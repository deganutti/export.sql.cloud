create table grugerExport as
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
    , c.codcli as "CODIGO"
    , validaCnpjCpf(c.cpf) as "CNPJ_VALIDO"
from cliente c
where (c.bloquear = ANY (ARRAY[0, 1, 4, 6, 7, 8])) AND c.codcli > 0