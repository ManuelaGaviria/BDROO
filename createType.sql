-- Crear objetos
CREATE OR REPLACE TYPE PERSONA_OBJETO AS OBJECT (
    DNI_USU VARCHAR2(50),
    NOMBRE_USU VARCHAR2(50),
    APELLIDO1_USU VARCHAR2(50),
    APELLIDO2_USU VARCHAR2(50),
    TIPODOC_USU NUMBER(2),
    CORREO_USU VARCHAR(100),
    SEXO_USU NUMBER(1),
    CONTRASENNA_USU VARCHAR2(25),
    NACIMIENTO_USU DATE,
    ESTADO_USU NUMBER(1)
);
/

CREATE OR REPLACE TYPE DATOS_NIVEL_EST_OBJ AS OBJECT (
    DNI_USU VARCHAR2(50),
    COD_NIVEL NUMBER(1)
);
/

CREATE OR REPLACE TYPE EXAM_PRESENTADO_OBJ AS OBJECT (
    ID_EXAMEN NUMBER(2),
    DNI_EST VARCHAR2(50),
    NOTA NUMBER(5,2),
    FECHA DATE
);
/

CREATE OR REPLACE TYPE PROGRAMACION_OBJ AS OBJECT (
    FECHA DATE,
	HORA NUMBER(2),
	NIVEL NUMBER(1)
);
/