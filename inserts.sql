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
VALUES (1, 'Cédula de Ciudadanía');
INSERT INTO TIPODOCUMENTOS (CODIGO_TIPODOC, NOMBRE_DOC)
VALUES (2, 'Tarjeta de identidad');

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

-- Insertar datos en SALONES
INSERT INTO SALONES (CODIGO_SALON, NUMERO_SALON, CAPACIDAD_SALON)
VALUES (1, 101, 6);
INSERT INTO SALONES (CODIGO_SALON, NUMERO_SALON, CAPACIDAD_SALON)
VALUES (2, 102, 6);

-- Insertar datos en HORAS
INSERT INTO HORAS (CODIGO_HORA, HORA_INICIAL, HORA_FINAL)
VALUES (1, '08:00', '10:00');
INSERT INTO HORAS (CODIGO_HORA, HORA_INICIAL, HORA_FINAL)
VALUES (2, '10:00', '12:00');
INSERT INTO HORAS (CODIGO_HORA, HORA_INICIAL, HORA_FINAL)
VALUES (3, '14:00', '16:00');

--Insertar datos en clases
INSERT INTO CLASES (CODIGO_CLASE, NUMERO_CLASE, DESCRIPCION_CLASE, CODIGO_NIVEL_CLASE)
VALUES ('CA101', 1, 'Introducción al Inglés', 1);
INSERT INTO CLASES (CODIGO_CLASE, NUMERO_CLASE, DESCRIPCION_CLASE, CODIGO_NIVEL_CLASE)
VALUES ('CA102', 2, 'Vocabulario Básico', 1);
INSERT INTO CLASES (CODIGO_CLASE, NUMERO_CLASE, DESCRIPCION_CLASE, CODIGO_NIVEL_CLASE)
VALUES ('CA103', 3, 'Conversaciones Simples', 1);
INSERT INTO CLASES (CODIGO_CLASE, NUMERO_CLASE, DESCRIPCION_CLASE, CODIGO_NIVEL_CLASE)
VALUES ('CA104', 4, 'Gramática Básica', 1);
INSERT INTO CLASES (CODIGO_CLASE, NUMERO_CLASE, DESCRIPCION_CLASE, CODIGO_NIVEL_CLASE)
VALUES ('CA105', 5, 'Lectura Intermedia', 1);
INSERT INTO CLASES (CODIGO_CLASE, NUMERO_CLASE, DESCRIPCION_CLASE, CODIGO_NIVEL_CLASE)
VALUES ('CA106', 6, 'Redacción de Ensayos', 1);

INSERT INTO EXAMENES (NUMERO_EXAMEN, UNIDADES_EXAMEN, TEMATICA_EXAMEN, CODIGO_CLASE_EXAMEN, CODIGO_NIVEL_EXAMEN)
VALUES (1, 'Unidad 1', 'Vocabulario Básico', 'CA101', 1);
INSERT INTO EXAMENES (NUMERO_EXAMEN, UNIDADES_EXAMEN, TEMATICA_EXAMEN, CODIGO_CLASE_EXAMEN, CODIGO_NIVEL_EXAMEN)
VALUES (2, 'Unidad 2', 'Conversaciones Simples', 'CA102', 1);

INSERT INTO EXAMENES_ESCRITOS (CODIGO_EXAMEN_ESCRITO, CODIGO_EXAMEN)
VALUES (1, 1);
INSERT INTO EXAMENES_ESCRITOS (CODIGO_EXAMEN_ESCRITO, CODIGO_EXAMEN)
VALUES (2, 2);

INSERT INTO PREGUNTAS (CODIGO_PREGUNTA, CODIGO_EXAMEN_ESCRITO, PREGUNTA)
VALUES (1, 1, '¿Qué significa la palabra "hello"?');
INSERT INTO PREGUNTAS (CODIGO_PREGUNTA, CODIGO_EXAMEN_ESCRITO, PREGUNTA)
VALUES (2, 1, 'Completa la frase: "Good ____."');

INSERT INTO RESPUESTAS (CODIGO_RESPUESTA, CODIGO_PREGUNTA_RESPUESTA, CONTENIDO_RESPUESTA, ACIERTO_RESPUESTA)
VALUES (1, 1, 'Hola', 'true');
INSERT INTO RESPUESTAS (CODIGO_RESPUESTA, CODIGO_PREGUNTA_RESPUESTA, CONTENIDO_RESPUESTA, ACIERTO_RESPUESTA)
VALUES (2, 1, 'Adiós', 'false');
INSERT INTO RESPUESTAS (CODIGO_RESPUESTA, CODIGO_PREGUNTA_RESPUESTA, CONTENIDO_RESPUESTA, ACIERTO_RESPUESTA)
VALUES (3, 2, 'noon', 'false');
INSERT INTO RESPUESTAS (CODIGO_RESPUESTA, CODIGO_PREGUNTA_RESPUESTA, CONTENIDO_RESPUESTA, ACIERTO_RESPUESTA)
VALUES (4, 2, 'fall', 'false');
INSERT INTO RESPUESTAS (CODIGO_RESPUESTA, CODIGO_PREGUNTA_RESPUESTA, CONTENIDO_RESPUESTA, ACIERTO_RESPUESTA)
VALUES (5, 2, 'morning', 'true');

INSERT INTO ESTADOS_EXAMENES (CODIGO_ESTADO, ESTADO_EXAMEN) VALUES (1, 'Aprobado');
INSERT INTO ESTADOS_EXAMENES (CODIGO_ESTADO, ESTADO_EXAMEN) VALUES (2, 'Reprobado');
INSERT INTO ESTADOS_EXAMENES (CODIGO_ESTADO, ESTADO_EXAMEN) VALUES (3, 'Pendiente');

INSERT INTO ESTADOS_CLASES (CODIGO_ESTADO_CLASE, NOMBRE_ESTADO_CLASE) VALUES (1, 'Pendiente');
INSERT INTO ESTADOS_CLASES (CODIGO_ESTADO_CLASE, NOMBRE_ESTADO_CLASE) VALUES (2, 'Programada');
INSERT INTO ESTADOS_CLASES (CODIGO_ESTADO_CLASE, NOMBRE_ESTADO_CLASE) VALUES (3, 'Finalizada');

INSERT INTO EXAMENES_ORALES (CODIGO_EXAMEN_ORAL, CODIGO_EXAMEN, ARCHIVO_URL) VALUES (1, 1, '"C:\Users\ASUS\Downloads\Acta de inicio-1.pdf"');
INSERT INTO EXAMENES_ORALES (CODIGO_EXAMEN_ORAL, CODIGO_EXAMEN, ARCHIVO_URL) VALUES (2, 2, '"C:\Users\ASUS\Downloads\Acta de inicio-1.pdf"');

INSERT INTO ESTUDIANTES (ESTUDIANTE)
VALUES (
    PERSONA_OBJETO(
        'ESTU12345', 'Juan', 'Pérez', 'Gómez', 1, 'juan.perez@mail.com', 1, 'password123', TO_DATE('2000-01-01', 'YYYY-MM-DD'), 1
    )
);
INSERT INTO ESTUDIANTES (ESTUDIANTE)
VALUES (
    PERSONA_OBJETO(
        'ESTU876543', 'María', 'López', 'Díaz', 2, 'maria.lopez@mail.com', 2, 'password456', TO_DATE('1998-05-15', 'YYYY-MM-DD'), 1
    )
);
INSERT INTO ESTUDIANTES (ESTUDIANTE)
VALUES (
    PERSONA_OBJETO(
        'ESTU1000412597', 'Manuela', 'Gaviria', 'Moreno', 2, 'mangav@example.com', 2, 'password123', TO_DATE('2002-07-05', 'YYYY-MM-DD'), 1
    )
);

INSERT INTO PROFESORES (PROFESOR, IDIOMA)
VALUES (
    PERSONA_OBJETO(
        'PROF67890', 'Carlos', 'Sánchez', 'Martínez', 1, 'carlos.sanchez@mail.com', 1, 'password789', TO_DATE('1980-10-10', 'YYYY-MM-DD'), 1
    ), 1
);
INSERT INTO PROFESORES (PROFESOR, IDIOMA)
VALUES (
    PERSONA_OBJETO(
        'PROF99887', 'Ana', 'Torres', 'Hernández', 2, 'ana.torres@mail.com', 2, 'password321', TO_DATE('1975-07-20', 'YYYY-MM-DD'), 1
    ), 1
);

INSERT INTO ADMINISTRADORES (ADMINISTRADOR, ROL)
VALUES (
    PERSONA_OBJETO('ADMIN54321', 'Carlos', 'Ramírez', 'Martínez', 1, 'carlos.ramirez@example.com', 1, 'admin789', TO_DATE('1975-03-20', 'YYYY-MM-DD'), 1),
    1
);

INSERT INTO NIVELES_MATRICULADOS (NIVEL_MATR, FECHA_LIMITE)
VALUES (
    DATOS_NIVEL_EST_OBJ('ESTU1000412597', 1),
    TO_DATE('2024-12-31', 'YYYY-MM-DD')
);
INSERT INTO NIVELES_MATRICULADOS (NIVEL_MATR, FECHA_LIMITE)
VALUES (
    DATOS_NIVEL_EST_OBJ('ESTU12345', 1),
    TO_DATE('2024-11-30', 'YYYY-MM-DD')
);

INSERT INTO NIVELES_HISTORICO (NIVEL_HIST, FECHA_FIN)
VALUES (
    DATOS_NIVEL_EST_OBJ('ESTU876543', 1),
    TO_DATE('2023-12-31', 'YYYY-MM-DD')
);

/*
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
    EXAM_PRESENTADO_OBJ(1, '12345678A', null, TO_DATE('2024-11-14', 'YYYY-MM-DD')),
    9
);
INSERT INTO EXAMEN_ESCRITO_PRESENTADO (ESCRITO, CANT_ACIERTO)
VALUES (
    EXAM_PRESENTADO_OBJ(1, '87654321B', null, TO_DATE('2024-11-09', 'YYYY-MM-DD')),
    8
);
*/

