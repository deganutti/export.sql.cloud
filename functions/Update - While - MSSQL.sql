declare @dt as datetime;
declare @id_ini as int;
declare @id_fim as int; 
declare @id_fim_aux as int;
DECLARE @contador INT;

set @id_ini = 1;
set @id_fim = 4200;
set @id_fim_aux = 4200; 
set @contador = 1;
set @dt = '2023-09-01 00:00:00' ;

WHILE  @contador <= 1696
BEGIN
   PRINT concat('Id inicial => ',@id_ini);
   PRINT concat('Id final => ',@id_fim);
   PRINT concat('Data => ',@dt); 
   update pessoas_meios_pagamentos set data_atualizado = @dt where id between @id_ini and @id_fim;
   update pessoas_condicoes_pagamentos set data_atualizado = @dt where id between @id_ini and @id_fim;
   update condicoes_pagamentos set data_atualizado = @dt where id between @id_ini and @id_fim;
   update meios_pagamentos set data_atualizado = @dt where id between @id_ini and @id_fim;
   update pessoas set data_atualizado = @dt where id between @id_ini and @id_fim;
   SET @dt = (@dt+'00:01:00');
   SET @contador = @contador + 1;
   SET @id_ini = @id_ini +  @id_fim_aux;
   SET @id_fim = @id_fim + @id_fim_aux
END;
PRINT 'Feito';
GO