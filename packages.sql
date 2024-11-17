--Paquete de utilidades
-- Especificación del paquete
CREATE OR REPLACE PACKAGE PKG_UTILIDADES AS
  FUNCTION function_calcular_promedio(
    nota_examen_oral NUMBER,
    nota_examen_escrito NUMBER
  ) RETURN NUMBER;

  FUNCTION calcular_nota(
    aciertos NUMBER
  ) RETURN NUMBER;
END PKG_UTILIDADES;
/

-- Cuerpo del paquete
CREATE OR REPLACE PACKAGE BODY PKG_UTILIDADES AS

  FUNCTION function_calcular_promedio(
    nota_examen_oral NUMBER,
    nota_examen_escrito NUMBER
  ) RETURN NUMBER
  IS
    sumarespuesta NUMBER(5, 2) := 0.0;
    respuesta NUMBER(5, 2) := 0.0;
  BEGIN
    sumarespuesta := nota_examen_oral + nota_examen_escrito;
    respuesta := sumarespuesta / 2;
    RETURN respuesta;
  END function_calcular_promedio;

  FUNCTION calcular_nota(
    aciertos NUMBER
  ) RETURN NUMBER 
  IS
    nota NUMBER(5,2) := 0.0;
  BEGIN
    nota := (aciertos/10) * 5.0;
        RETURN nota;
  END calcular_nota;

END PKG_UTILIDADES;
/
--------------------------------------------------------------------------------------------


