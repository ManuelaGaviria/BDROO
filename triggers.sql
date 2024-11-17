CREATE OR REPLACE TRIGGER trg_examen_oral_presentado
AFTER INSERT ON EXAMEN_ORAL_PRESENTADO
FOR EACH ROW
DECLARE
  v_nota_examen_escrito NUMBER;
  v_promedio NUMBER;
BEGIN
  -- Intentar obtener la nota del examen escrito asociada, si existe
  BEGIN
    SELECT es.ESCRITO.NOTA INTO v_nota_examen_escrito
    FROM EXAMEN_ESCRITO_PRESENTADO es
    WHERE es.ESCRITO.ID_EXAMEN = TREAT(:NEW.ORAL AS EXAM_PRESENTADO_OBJ).ID_EXAMEN
    AND es.ESCRITO.DNI_EST = TREAT(:NEW.ORAL AS EXAM_PRESENTADO_OBJ).DNI_EST;

    -- Si se encuentra la nota del examen escrito, calcular el promedio
    BEGIN
      v_promedio := PKG_UTILIDADES.function_calcular_promedio(TREAT(:NEW.ORAL AS EXAM_PRESENTADO_OBJ).NOTA, v_nota_examen_escrito);
    EXCEPTION
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20003, 'Error al calcular el promedio: ' || SQLERRM);
    END;

    -- Actualizar el promedio y estado en la tabla NOTAS
    BEGIN
      UPDATE NOTAS
      SET PROMEDIO = v_promedio,
          ESTADO = CASE WHEN v_promedio > 4.0 THEN 1 ELSE 2 END
      WHERE ID_EXAMEN = TREAT(:NEW.ORAL AS EXAM_PRESENTADO_OBJ).ID_EXAMEN AND DNI_ESTUDIANTE= (TREAT(:NEW.ORAL AS EXAM_PRESENTADO_OBJ).DNI_EST);
    EXCEPTION
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20004, 'Error al actualizar la tabla NOTAS: ' || SQLERRM);
    END;

    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      -- Si no se encuentra la nota del examen escrito, insertar en NOTAS solo con la nota del examen oral
      BEGIN
        INSERT INTO NOTAS (ID_EXAMEN, DNI_ESTUDIANTE, PROMEDIO, ESTADO)
        VALUES (TREAT(:NEW.ORAL AS EXAM_PRESENTADO_OBJ).ID_EXAMEN, TREAT(:NEW.ORAL AS EXAM_PRESENTADO_OBJ).DNI_EST, TREAT(:NEW.ORAL AS EXAM_PRESENTADO_OBJ).NOTA, 3);
      EXCEPTION
        WHEN OTHERS THEN
          RAISE_APPLICATION_ERROR(-20005, 'Error al insertar en la tabla NOTAS: ' || SQLERRM);
      END;
  END;
END;
/

---------------------------------------------------------------------
CREATE OR REPLACE TRIGGER trg_examen_escrito_presentado
AFTER INSERT ON EXAMEN_ESCRITO_PRESENTADO
FOR EACH ROW
DECLARE
  v_numero_examen NUMBER;
  v_nota_examen_oral NUMBER;
  v_promedio NUMBER;
  v_nota_calculada NUMBER;
BEGIN

  -- Calcular la nota a partir de los aciertos
  BEGIN
    v_nota_calculada := PKG_UTILIDADES.calcular_nota(:NEW.CANT_ACIERTO);
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20002, 'Error al calcular la nota desde los aciertos: ' || SQLERRM);
  END;

  -- Intentar obtener la nota del examen oral asociada, si existe
  BEGIN
    SELECT eo.ORAL.NOTA INTO v_nota_examen_oral
    FROM EXAMEN_ORAL_PRESENTADO eo
    WHERE eo.ORAL.ID_EXAMEN = TREAT(:NEW.ESCRITO AS EXAM_PRESENTADO_OBJ).ID_EXAMEN
    AND eo.ORAL.DNI_EST = TREAT(:NEW.ESCRITO AS EXAM_PRESENTADO_OBJ).DNI_EST;


    -- Calcular el promedio
    BEGIN
      v_promedio := PKG_UTILIDADES.function_calcular_promedio(v_nota_examen_oral, v_nota_calculada);
    EXCEPTION
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20003, 'Error al calcular el promedio: ' || SQLERRM);
    END;

    -- Actualizar la tabla NOTAS
    BEGIN
      UPDATE NOTAS
      SET PROMEDIO = v_promedio,
          ESTADO = CASE WHEN v_promedio > 4.0 THEN 1 ELSE 2 END
      WHERE ID_EXAMEN = TREAT(:NEW.ESCRITO AS EXAM_PRESENTADO_OBJ).ID_EXAMEN AND DNI_ESTUDIANTE = TREAT(:NEW.ESCRITO AS EXAM_PRESENTADO_OBJ).DNI_EST;
    EXCEPTION
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20004, 'Error al actualizar la tabla NOTAS: ' || SQLERRM);
    END;

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      -- Insertar en la tabla NOTAS si el examen oral no existe
      BEGIN
        INSERT INTO NOTAS (ID_EXAMEN, DNI_ESTUDIANTE, PROMEDIO, ESTADO)
        VALUES (TREAT(:NEW.ESCRITO AS EXAM_PRESENTADO_OBJ).ID_EXAMEN, TREAT(:NEW.ESCRITO AS EXAM_PRESENTADO_OBJ).DNI_EST, v_nota_calculada, 3);
      EXCEPTION
        WHEN OTHERS THEN
          RAISE_APPLICATION_ERROR(-20005, 'Error al insertar en la tabla NOTAS: ' || SQLERRM);
      END;
  END;
END;
/

