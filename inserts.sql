INSERT INTO ESTADOS (CODIGO_ESTADO, NOMBRE_ESTADO)
VALUES (1, 'Activo');

INSERT INTO ESTADOS (CODIGO_ESTADO, NOMBRE_ESTADO)
VALUES (2, 'Inactivo');

INSERT INTO ROLES (CODIGO_ROL, NOMBRE_ROL)
VALUES (1, 'Administrador');

INSERT INTO ROLES (CODIGO_ROL, NOMBRE_ROL)
VALUES (2, 'Superadministrador');

INSERT INTO SEXOS (CODIGO_SEX, NOMBRE_SEX)
VALUES (1, 'Masculino');

INSERT INTO SEXOS (CODIGO_SEX, NOMBRE_SEX)
VALUES (2, 'Femenino');

INSERT INTO TIPODOCUMENTOS (CODIGO_TIPODOC, NOMBRE_DOC)
VALUES (1, 'Cedula');

INSERT INTO TIPODOCUMENTOS (CODIGO_TIPODOC, NOMBRE_DOC)
VALUES (2, 'Pasaporte');

INSERT INTO NIVELES (CODIGO_NIVEL, NIVEL)
VALUES (1, 'A1');

INSERT INTO NIVELES (CODIGO_NIVEL, NIVEL)
VALUES (2, 'A2');

INSERT INTO NIVELES (CODIGO_NIVEL, NIVEL)
VALUES (3, 'B1');

INSERT INTO NIVELES (CODIGO_NIVEL, NIVEL)
VALUES (4, 'B2');

INSERT INTO NIVELES (CODIGO_NIVEL, NIVEL)
VALUES (5, 'C1');

INSERT INTO IDIOMAS (CODIGO_IDIOMA, IDIOMA)
VALUES (1, 'Inglés');

INSERT INTO IDIOMAS (CODIGO_IDIOMA, IDIOMA)
VALUES (2, 'Francés');


INSERT INTO ESTUDIANTES (ESTUDIANTE)
VALUES (
    PERSONA_OBJETO(
        '12345678A', 'Juan', 'Pérez', 'Gómez', 1, 'juan.perez@mail.com', 1, 'password123', TO_DATE('2000-01-01', 'YYYY-MM-DD'), 1
    )
);

INSERT INTO ESTUDIANTES (ESTUDIANTE)
VALUES (
    PERSONA_OBJETO(
        '87654321B', 'María', 'López', 'Díaz', 2, 'maria.lopez@mail.com', 2, 'password456', TO_DATE('1998-05-15', 'YYYY-MM-DD'), 1
    )
);

INSERT INTO PROFESORES (PROFESOR, IDIOMA)
VALUES (
    PERSONA_OBJETO(
        '11223344C', 'Carlos', 'Sánchez', 'Martínez', 1, 'carlos.sanchez@mail.com', 1, 'password789', TO_DATE('1980-10-10', 'YYYY-MM-DD'), 1
    ), 1
);

INSERT INTO PROFESORES (PROFESOR, IDIOMA)
VALUES (
    PERSONA_OBJETO(
        '99887766D', 'Ana', 'Torres', 'Hernández', 2, 'ana.torres@mail.com', 2, 'password321', TO_DATE('1975-07-20', 'YYYY-MM-DD'), 1
    ), 1
);

INSERT INTO NIVELES_MATRICULADOS (NIVEL_MATR, FECHA_LIMITE)
VALUES (
    DATOS_NIVEL_EST_OBJ('12345678A', 1),
    TO_DATE('2024-12-31', 'YYYY-MM-DD')
);

INSERT INTO NIVELES_MATRICULADOS (NIVEL_MATR, FECHA_LIMITE)
VALUES (
    DATOS_NIVEL_EST_OBJ('87654321B', 1),
    TO_DATE('2024-11-30', 'YYYY-MM-DD')
);

INSERT INTO NIVELES_HISTORICO (NIVEL_HIST, FECHA_FIN)
VALUES (
    DATOS_NIVEL_EST_OBJ('12345678A', 1),
    TO_DATE('2023-12-31', 'YYYY-MM-DD')
);

INSERT INTO NIVELES_HISTORICO (NIVEL_HIST, FECHA_FIN)
VALUES (
    DATOS_NIVEL_EST_OBJ('87654321B', 1),
    TO_DATE('2023-11-30', 'YYYY-MM-DD')
);

INSERT INTO EXAMEN_ORAL_PRESENTADO (ORAL, DNI_PROFESOR)
VALUES (
    EXAM_PRESENTADO_OBJ(1, '12345678A', 4.5, TO_DATE('2024-11-15', 'YYYY-MM-DD')),
    '11223344C'
);

INSERT INTO EXAMEN_ORAL_PRESENTADO (ORAL, DNI_PROFESOR)
VALUES (
    EXAM_PRESENTADO_OBJ(1, '87654321B', 3.8, TO_DATE('2024-11-10', 'YYYY-MM-DD')),
    '99887766D'
);

INSERT INTO EXAMEN_ESCRITO_PRESENTADO (ESCRITO, CANT_ACIERTO)
VALUES (
    EXAM_PRESENTADO_OBJ(1, '12345678A', 5.0, TO_DATE('2024-11-14', 'YYYY-MM-DD')),
    9
);

INSERT INTO EXAMEN_ESCRITO_PRESENTADO (ESCRITO, CANT_ACIERTO)
VALUES (
    EXAM_PRESENTADO_OBJ(1, '87654321B', 4.2, TO_DATE('2024-11-09', 'YYYY-MM-DD')),
    8
);

