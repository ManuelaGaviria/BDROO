--Paquete para la auditoria
-- Especificación del paquete
CREATE OR REPLACE PACKAGE PKG_AUDITORIA
AS
  PROCEDURE log_audit_action(
    p_nombre_tabla VARCHAR2,
    p_operacion VARCHAR2,
    p_id_registro INTEGER,
    p_descripcion VARCHAR2
  );
END PKG_AUDITORIA;
/

-- Cuerpo del paquete
CREATE OR REPLACE PACKAGE BODY PKG_AUDITORIA
AS
  PROCEDURE log_audit_action(
    p_nombre_tabla VARCHAR2,
    p_operacion VARCHAR2,
    p_id_registro INTEGER,
    p_descripcion VARCHAR2
  )
  IS
  BEGIN
    INSERT INTO AUDITORIAS_CLASES_PROG (
        CODIGO_AUD,
        NOMBRE_TABLA,
        OPERACION,
        ID_REGISTRO,
        DESCRIPCION,
        FECHA
    ) VALUES (
        SEQ_AUD_CLAS_PROG.NEXTVAL,
        p_nombre_tabla,
        p_operacion,
        p_id_registro,
        p_descripcion,
        SYSTIMESTAMP
    );
  END log_audit_action;  -- Asegura que coincida con la declaración en la especificación
END PKG_AUDITORIA;
/

------------------------------------------------------------------------------------
--Paquete de Asignación Automática
-- Especificación del paquete
CREATE OR REPLACE PACKAGE PKG_ASIGNACION_AUTOMATICA
AS
  FUNCTION default_professor(
    p_fecha IN DATE,
    p_hora IN NUMBER
  ) RETURN VARCHAR2;

  FUNCTION default_salon_code(
    p_fecha IN DATE,
    p_hora IN NUMBER
  ) RETURN NUMBER;
END PKG_ASIGNACION_AUTOMATICA;
/

-- Cuerpo del paquete
CREATE OR REPLACE PACKAGE BODY PKG_ASIGNACION_AUTOMATICA
AS
  FUNCTION default_professor(
    p_fecha IN DATE,
    p_hora IN NUMBER
  ) RETURN VARCHAR2
  IS
    v_profesor VARCHAR2(50);
  BEGIN
    BEGIN
      SELECT TREAT(PROFESOR AS PERSONA_OBJETO).DNI_USU INTO v_profesor
      FROM PROFESORES
      WHERE TREAT(PROFESOR AS PERSONA_OBJETO).DNI_USU NOT IN (
            SELECT DNI_PROFESOR
            FROM CUPOS C
            WHERE C.PROGRAMACION.FECHA = p_fecha AND C.PROGRAMACION.HORA = p_hora
        )
      ORDER BY DBMS_RANDOM.VALUE
      FETCH FIRST 1 ROWS ONLY;

    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        RETURN NULL;
    END;

    RETURN v_profesor;
  END default_professor;

  --cambia left join de clases programadas a cupos
  FUNCTION default_salon_code(
    p_fecha IN DATE,
    p_hora IN NUMBER
  ) RETURN NUMBER
  IS
    v_salon_code NUMBER;
  BEGIN
    SELECT CODIGO_SALON INTO v_salon_code
    FROM (SELECT s.CODIGO_SALON
          FROM SALONES s
          LEFT JOIN CUPOS c
          ON s.CODIGO_SALON = c.CODIGO_SALON
             AND c.PROGRAMACION.FECHA = p_fecha
             AND c.PROGRAMACION.HORA = p_hora
          GROUP BY s.CODIGO_SALON, s.CAPACIDAD_SALON, c.ESTUDIANTES_REGISTRADOS
          HAVING NVL(c.ESTUDIANTES_REGISTRADOS, 0) < s.CAPACIDAD_SALON
          ORDER BY DBMS_RANDOM.VALUE)
    WHERE ROWNUM = 1;

    RETURN v_salon_code;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN NULL;
  END default_salon_code;
END PKG_ASIGNACION_AUTOMATICA;
/

------------------------------------------------------------------------------------
--Paquete de Manejo de Clases
-- Especificación del paquete
CREATE OR REPLACE PACKAGE PKG_CLASES
AS
  FUNCTION agregar_estudiante_clase(
    p_fecha IN DATE,
    p_hora IN NUMBER,
    p_dni IN VARCHAR2
  ) RETURN BOOLEAN;

  PROCEDURE controlador_clases(
    p_fecha DATE,
    p_hora NUMBER,
    p_dni VARCHAR2,
    p_clase VARCHAR2,
    p_estado_clase NUMBER
  );
END PKG_CLASES;
/

CREATE OR REPLACE PACKAGE BODY PKG_CLASES
AS
  FUNCTION agregar_estudiante_clase(
    p_fecha IN DATE,
    p_hora IN NUMBER,
    p_dni IN VARCHAR2
  ) RETURN BOOLEAN
  IS
    v_salon_code NUMBER(2);
    v_profesor_dni VARCHAR2(50);
    v_cupo_id NUMBER(5);
    v_estudiantes_registrados NUMBER(1);
    v_nivel NUMBER(1);
  BEGIN
    -- Validar si ya existe un cupo en la fecha y hora
    BEGIN
      SELECT C.CODIGO_CUPO, C.ESTUDIANTES_REGISTRADOS
      INTO v_cupo_id, v_estudiantes_registrados
      FROM CUPOS C
      WHERE C.PROGRAMACION.FECHA = p_fecha
        AND C.PROGRAMACION.HORA = p_hora
        FOR UPDATE;

      -- Si hay menos de 6 estudiantes registrados, actualiza el cupo
      IF v_estudiantes_registrados < 6 THEN
          UPDATE CUPOS
          SET ESTUDIANTES_REGISTRADOS = ESTUDIANTES_REGISTRADOS + 1
          WHERE CODIGO_CUPO = v_cupo_id;

          PKG_AUDITORIA.log_audit_action('CUPOS', 'UPDATE', v_cupo_id, 'Estudiante ' || p_dni || ' añadido a un cupo existente');
          COMMIT;
          RETURN TRUE;
      ELSE
          RAISE_APPLICATION_ERROR(-20003, 'Cupo completo, no se puede agregar más estudiantes.');
      END IF;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        -- Si no existe un registro, asignar salón y profesor
        v_salon_code := PKG_ASIGNACION_AUTOMATICA.default_salon_code(p_fecha, p_hora);
        IF v_salon_code IS NULL THEN
            RAISE_APPLICATION_ERROR(-20001, 'No hay salones disponibles para la fecha y hora específicadas');
        END IF;

        v_profesor_dni := PKG_ASIGNACION_AUTOMATICA.default_professor(p_fecha, p_hora);
        IF v_profesor_dni IS NULL THEN
            RAISE_APPLICATION_ERROR(-20002, 'No hay profesores disponibles para la fecha y hora específicadas');
        END IF;

        -- Asignar nivel según las reglas del sistema
        v_nivel := 1; -- Nivel predeterminado, ajusta según sea necesario
        v_cupo_id := SEQ_CUPOS.NEXTVAL;
        -- Insertar un nuevo registro en CUPOS
        INSERT INTO CUPOS (
            CODIGO_CUPO,
            PROGRAMACION,
            CODIGO_SALON,
            DNI_PROFESOR,
            ESTUDIANTES_REGISTRADOS
        ) VALUES (
            v_cupo_id, -- Genera el próximo valor para el cupo
            PROGRAMACION_OBJ(
                p_fecha,
                p_hora,
                v_nivel
            ),
            v_salon_code, -- Código del salón asignado
            v_profesor_dni, -- DNI del profesor asignado
            1 -- Primer estudiante registrado
        );

        PKG_AUDITORIA.log_audit_action('CUPOS', 'INSERT', v_cupo_id, 'Estudiante añadido a un nuevo cupo ' || p_dni);
        COMMIT;
        RETURN TRUE;
    END;
  END agregar_estudiante_clase;

  PROCEDURE controlador_clases(
    p_fecha DATE,
    p_hora NUMBER,
    p_dni VARCHAR2,
    p_clase VARCHAR2,
    p_estado_clase NUMBER
  )
  IS
    v_success BOOLEAN;
  BEGIN
    -- Llamar a la función agregar_estudiante_clase
    v_success := agregar_estudiante_clase(p_fecha, p_hora, p_dni);

    IF v_success THEN
        -- Insertar en clases programadas
        INSERT INTO CLASES_PROGRAMADAS (
            DNI_EST, PROGRAMACION, CODIGO_CLASE, ESTADO_CLASE_PROG
        ) VALUES (
            p_dni,
            PROGRAMACION_OBJ(
                p_fecha, -- Fecha de programación
                p_hora, -- Código de la hora (número)
                1  -- Nivel (código del nivel)
            ),
            p_clase,
            p_estado_clase
        );
        PKG_AUDITORIA.log_audit_action('CLASES_PROGRAMADAS', 'INSERT', p_dni , 'Se creo una nueva clase programada y se asignó el estudiante ' || p_dni);
        COMMIT;
    ELSE
        RAISE_APPLICATION_ERROR(-20004, 'No se pudo registrar la clase programada, no hay cupos para esa fecha y hora');
    END IF;
  END controlador_clases;
END PKG_CLASES;
/


------------------------------------------------------------------------------------
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


