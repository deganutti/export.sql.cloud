drop table gruger_fornecedor_export;
create table gruger_fornecedor_export as 
select f.cnpj as "CPF/CNPJ"
    , f.inscest as "INSCRICAO_ESTADUAL"
    , f.razao as "RAZAOSOCIAL"
    , f.fantasia as "NOMEFANTASIA"
    , f.cep as "CEP"
    , f.endereco as "LOGRADOURO"
    , f.numero as "NUMERO"
    , f.complemento as "COMPLEMENTO"
    , f.cidade as "MUNICIPIO"
    , f.bairro as "BAIRRO"
    , f.uf as "UF"
    , retornaIBGE(unaccent(f.cidade),f.uf) as "IBGE"
    , 0 as "CLIENTE"
    , 1 as "FORNECEDOR" 
    , ajusta_tel(f.fone) as "TELEFONE"
    , ajusta_tel(f.celular) as "TELEFONE_ADICIONAL"
    , ajusta_tel(f.fax) as "TELEFONE_EXTRA"
    , f.email as "EMAIL"
    , f.site as "SITE"
    , cast(f.codfor as int) as "CODIGO"
    , validaCnpjCpf(f.cnpj) as "CNPJ_VALIDO"
from fornec f 
where f.bloqueado <> 1
/*
select * from fornec f 
where f.codfor =3
*/