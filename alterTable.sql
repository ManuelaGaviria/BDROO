ALTER TABLE AUDITORIAS_CLASES_PROG ADD CONSTRAINT PK_AUD_CLAS_PROG PRIMARY KEY (CODIGO_AUD);

ALTER TABLE ESTADOS ADD CONSTRAINT PK_CODIGO_ESTADO PRIMARY KEY (CODIGO_ESTADO);
ALTER TABLE ESTADOS ADD CONSTRAINT NN_NOMBRE_ESTADO CHECK (NOMBRE_ESTADO IS NOT NULL);

ALTER TABLE ESTADOS_EXAMENES ADD CONSTRAINT PK_ESTADO_EXAMEN PRIMARY KEY (CODIGO_ESTADO);
ALTER TABLE ESTADOS_EXAMENES ADD CONSTRAINT NN_ESTADO_EXAMEN CHECK (ESTADO_EXAMEN IS NOT NULL);

ALTER TABLE ESTADOS_CLASES ADD CONSTRAINT PK_COD_EST_CLA PRIMARY KEY (CODIGO_ESTADO_CLASE);
ALTER TABLE ESTADOS_CLASES ADD CONSTRAINT NN_NOM_EST_CLA CHECK (NOMBRE_ESTADO_CLASE IS NOT NULL);

ALTER TABLE ROLES ADD CONSTRAINT PK_COD_ROL PRIMARY KEY (CODIGO_ROL);
ALTER TABLE ROLES ADD CONSTRAINT NN_NOMBRE_ROL CHECK (NOMBRE_ROL IS NOT NULL);

ALTER TABLE SEXOS ADD CONSTRAINT PK_CODIGO_SEX PRIMARY KEY (CODIGO_SEX);
ALTER TABLE SEXOS ADD CONSTRAINT NN_NOMBRE_SEX CHECK (NOMBRE_SEX IS NOT NULL);

ALTER TABLE TIPODOCUMENTOS ADD CONSTRAINT PK_COD_TIPODOC PRIMARY KEY (CODIGO_TIPODOC);
ALTER TABLE TIPODOCUMENTOS ADD CONSTRAINT NN_NOM_TIPODOC CHECK (NOMBRE_DOC IS NOT NULL);

ALTER TABLE NIVELES ADD CONSTRAINT PK_CODIGO_NIVEL PRIMARY KEY (CODIGO_NIVEL);
ALTER TABLE NIVELES ADD CONSTRAINT NN_NIVEL CHECK (NIVEL IS NOT NULL);

ALTER TABLE IDIOMAS ADD CONSTRAINT PK_COD_IDIOMA PRIMARY KEY (CODIGO_IDIOMA);
ALTER TABLE IDIOMAS ADD CONSTRAINT NN_IDIOMA CHECK (IDIOMA IS NOT NULL);

ALTER TABLE SALONES ADD CONSTRAINT PK_COD_SAL PRIMARY KEY (CODIGO_SALON);
ALTER TABLE SALONES ADD CONSTRAINT NN_NUM_SAL CHECK (NUMERO_SALON IS NOT NULL);

ALTER TABLE HORAS ADD CONSTRAINT PK_COD_HORA PRIMARY KEY (CODIGO_HORA);
ALTER TABLE HORAS ADD CONSTRAINT NN_HO_INICIAL CHECK (HORA_INICIAL IS NOT NULL);
ALTER TABLE HORAS ADD CONSTRAINT NN_HO_FINAL CHECK (HORA_FINAL IS NOT NULL);

-- Tabla CLASES
ALTER TABLE CLASES ADD CONSTRAINT PK_COD_CLA PRIMARY KEY (CODIGO_CLASE);
ALTER TABLE CLASES ADD CONSTRAINT NN_NUM_CLA CHECK (NUMERO_CLASE IS NOT NULL);
ALTER TABLE CLASES ADD CONSTRAINT NN_DES_CLA CHECK (DESCRIPCION_CLASE IS NOT NULL);
ALTER TABLE CLASES ADD CONSTRAINT FK_COD_NI_CLA FOREIGN KEY (CODIGO_NIVEL_CLASE) REFERENCES NIVELES(CODIGO_NIVEL);

-- Tabla EXAMENES
ALTER TABLE EXAMENES ADD CONSTRAINT PK_NUM_EXAM PRIMARY KEY (NUMERO_EXAMEN);
ALTER TABLE EXAMENES ADD CONSTRAINT NN_UNIDADES_EXAM CHECK (UNIDADES_EXAMEN IS NOT NULL);
ALTER TABLE EXAMENES ADD CONSTRAINT NN_TEMATICA_EXAM CHECK (TEMATICA_EXAMEN IS NOT NULL);
ALTER TABLE EXAMENES ADD CONSTRAINT NN_CLASE_EXAM CHECK (CODIGO_CLASE_EXAMEN IS NOT NULL);
ALTER TABLE EXAMENES ADD CONSTRAINT NN_NIVEL_EXAM CHECK (CODIGO_NIVEL_EXAMEN IS NOT NULL);
ALTER TABLE EXAMENES ADD CONSTRAINT FK_CLASE_EXAM FOREIGN KEY (CODIGO_CLASE_EXAMEN) REFERENCES CLASES(CODIGO_CLASE);
ALTER TABLE EXAMENES ADD CONSTRAINT FK_NIVEL_EXAM FOREIGN KEY (CODIGO_NIVEL_EXAMEN) REFERENCES NIVELES(CODIGO_NIVEL);

-- Tabla EXAMENES_ESCRITOS
ALTER TABLE EXAMENES_ESCRITOS ADD CONSTRAINT PK_EXAMEN_ESCRITO PRIMARY KEY (CODIGO_EXAMEN_ESCRITO);
ALTER TABLE EXAMENES_ESCRITOS ADD CONSTRAINT FK_EXAMEN_ESCRITO FOREIGN KEY (CODIGO_EXAMEN) REFERENCES EXAMENES(NUMERO_EXAMEN);

-- Tabla PREGUNTAS
ALTER TABLE PREGUNTAS ADD CONSTRAINT PK_PREGUNTA PRIMARY KEY (CODIGO_PREGUNTA);
ALTER TABLE PREGUNTAS ADD CONSTRAINT NN_EXAMEN_ESCRITO CHECK (CODIGO_EXAMEN_ESCRITO IS NOT NULL);
ALTER TABLE PREGUNTAS ADD CONSTRAINT NN_PREGUNTA CHECK (PREGUNTA IS NOT NULL);
ALTER TABLE PREGUNTAS ADD CONSTRAINT FK_EXAMEN_ESCRITO_PREGUNTA FOREIGN KEY (CODIGO_EXAMEN_ESCRITO) REFERENCES EXAMENES_ESCRITOS(CODIGO_EXAMEN_ESCRITO);

-- Tabla RESPUESTAS
ALTER TABLE RESPUESTAS ADD CONSTRAINT PK_RESPUESTA PRIMARY KEY (CODIGO_RESPUESTA);
ALTER TABLE RESPUESTAS ADD CONSTRAINT NN_PREGUNTA_RESPUESTA CHECK (CODIGO_PREGUNTA_RESPUESTA IS NOT NULL);
ALTER TABLE RESPUESTAS ADD CONSTRAINT NN_CONTENIDO_RESPUESTA CHECK (CONTENIDO_RESPUESTA IS NOT NULL);
ALTER TABLE RESPUESTAS ADD CONSTRAINT NN_ACIERTO_RESPUESTA CHECK (ACIERTO_RESPUESTA IS NOT NULL);
ALTER TABLE RESPUESTAS ADD CONSTRAINT FK_PREGUNTA_RESPUESTA FOREIGN KEY (CODIGO_PREGUNTA_RESPUESTA) REFERENCES PREGUNTAS(CODIGO_PREGUNTA);

-- Tabla EXAMENES_ORALES
ALTER TABLE EXAMENES_ORALES ADD CONSTRAINT PK_EXAMEN_ORAL PRIMARY KEY (CODIGO_EXAMEN_ORAL);
ALTER TABLE EXAMENES_ORALES ADD CONSTRAINT NN_ARCHIVO_URL CHECK (ARCHIVO_URL IS NOT NULL);
ALTER TABLE EXAMENES_ORALES ADD CONSTRAINT FK_EXAMEN_ORAL FOREIGN KEY (CODIGO_EXAMEN) REFERENCES EXAMENES(NUMERO_EXAMEN);

-- Tabla estudiantes
ALTER TABLE ESTUDIANTES ADD CONSTRAINT PK_DNI_EST PRIMARY KEY (ESTUDIANTE.DNI_USU);
ALTER TABLE ESTUDIANTES ADD CONSTRAINT NN_NOM_EST CHECK (ESTUDIANTE.NOMBRE_USU IS NOT NULL);
ALTER TABLE ESTUDIANTES ADD CONSTRAINT NN_APE1_EST CHECK (ESTUDIANTE.APELLIDO1_USU IS NOT NULL);
ALTER TABLE ESTUDIANTES ADD CONSTRAINT NN_TIPODOC_EST CHECK (ESTUDIANTE.TIPODOC_USU IS NOT NULL);
ALTER TABLE ESTUDIANTES ADD CONSTRAINT NN_CORREO_EST CHECK (ESTUDIANTE.CORREO_USU IS NOT NULL);
ALTER TABLE ESTUDIANTES ADD CONSTRAINT NN_SEXO_EST CHECK (ESTUDIANTE.SEXO_USU IS NOT NULL);
ALTER TABLE ESTUDIANTES ADD CONSTRAINT NN_CONTRA_EST CHECK (ESTUDIANTE.CONTRASENNA_USU IS NOT NULL);
ALTER TABLE ESTUDIANTES ADD CONSTRAINT NN_NAC_EST CHECK (ESTUDIANTE.NACIMIENTO_USU IS NOT NULL);
ALTER TABLE ESTUDIANTES ADD CONSTRAINT NN_ESDO_EST CHECK (ESTUDIANTE.ESTADO_USU IS NOT NULL);
ALTER TABLE ESTUDIANTES ADD CONSTRAINT UK_CORREO_EST UNIQUE (ESTUDIANTE.CORREO_USU);
ALTER TABLE ESTUDIANTES ADD CONSTRAINT FK_TIPODOC_EST FOREIGN KEY (ESTUDIANTE.TIPODOC_USU) REFERENCES TIPODOCUMENTOS(CODIGO_TIPODOC);
ALTER TABLE ESTUDIANTES ADD CONSTRAINT FK_SEXO_EST FOREIGN KEY (ESTUDIANTE.SEXO_USU) REFERENCES SEXOS(CODIGO_SEX);
ALTER TABLE ESTUDIANTES ADD CONSTRAINT FK_ESDO_EST FOREIGN KEY (ESTUDIANTE.ESTADO_USU) REFERENCES ESTADOS(CODIGO_ESTADO);

-- Tabla profesores
ALTER TABLE PROFESORES ADD CONSTRAINT PK_DNI_PROF PRIMARY KEY (PROFESOR.DNI_USU);
ALTER TABLE PROFESORES ADD CONSTRAINT NN_NOM_PROF CHECK (PROFESOR.NOMBRE_USU IS NOT NULL);
ALTER TABLE PROFESORES ADD CONSTRAINT NN_APE1_PROF CHECK (PROFESOR.APELLIDO1_USU IS NOT NULL);
ALTER TABLE PROFESORES ADD CONSTRAINT NN_TIPODOC_PROF CHECK (PROFESOR.TIPODOC_USU IS NOT NULL);
ALTER TABLE PROFESORES ADD CONSTRAINT NN_CORREO_PROF CHECK (PROFESOR.CORREO_USU IS NOT NULL);
ALTER TABLE PROFESORES ADD CONSTRAINT NN_SEXO_PROF CHECK (PROFESOR.SEXO_USU IS NOT NULL);
ALTER TABLE PROFESORES ADD CONSTRAINT NN_CONTRA_PROF CHECK (PROFESOR.CONTRASENNA_USU IS NOT NULL);
ALTER TABLE PROFESORES ADD CONSTRAINT NN_NAC_PROF CHECK (PROFESOR.NACIMIENTO_USU IS NOT NULL);
ALTER TABLE PROFESORES ADD CONSTRAINT NN_ESDO_PROF CHECK (PROFESOR.ESTADO_USU IS NOT NULL);
ALTER TABLE PROFESORES ADD CONSTRAINT UK_CORREO_PROF UNIQUE (PROFESOR.CORREO_USU);
ALTER TABLE PROFESORES ADD CONSTRAINT FK_TIPODOC_PROF FOREIGN KEY (PROFESOR.TIPODOC_USU) REFERENCES TIPODOCUMENTOS(CODIGO_TIPODOC);
ALTER TABLE PROFESORES ADD CONSTRAINT FK_SEXO_PROF FOREIGN KEY (PROFESOR.SEXO_USU) REFERENCES SEXOS(CODIGO_SEX);
ALTER TABLE PROFESORES ADD CONSTRAINT FK_ESDO_PROF FOREIGN KEY (PROFESOR.ESTADO_USU) REFERENCES ESTADOS(CODIGO_ESTADO);
ALTER TABLE PROFESORES ADD CONSTRAINT FK_IDIOMA_PROF FOREIGN KEY (IDIOMA) REFERENCES IDIOMAS(CODIGO_IDIOMA);

-- Tabla administradores
ALTER TABLE ADMINISTRADORES ADD CONSTRAINT PK_DNI_ADMIN PRIMARY KEY (ADMINISTRADOR.DNI_USU);
ALTER TABLE ADMINISTRADORES ADD CONSTRAINT NN_NOM_ADMIN CHECK (ADMINISTRADOR.NOMBRE_USU IS NOT NULL);
ALTER TABLE ADMINISTRADORES ADD CONSTRAINT NN_APE1_ADMIN CHECK (ADMINISTRADOR.APELLIDO1_USU IS NOT NULL);
ALTER TABLE ADMINISTRADORES ADD CONSTRAINT NN_TIPODOC_ADMIN CHECK (ADMINISTRADOR.TIPODOC_USU IS NOT NULL);
ALTER TABLE ADMINISTRADORES ADD CONSTRAINT NN_CORREO_ADMIN CHECK (ADMINISTRADOR.CORREO_USU IS NOT NULL);
ALTER TABLE ADMINISTRADORES ADD CONSTRAINT NN_SEXO_ADMIN CHECK (ADMINISTRADOR.SEXO_USU IS NOT NULL);
ALTER TABLE ADMINISTRADORES ADD CONSTRAINT NN_CONTRA_ADMIN CHECK (ADMINISTRADOR.CONTRASENNA_USU IS NOT NULL);
ALTER TABLE ADMINISTRADORES ADD CONSTRAINT NN_NAC_ADMIN CHECK (ADMINISTRADOR.NACIMIENTO_USU IS NOT NULL);
ALTER TABLE ADMINISTRADORES ADD CONSTRAINT NN_ESDO_ADMIN CHECK (ADMINISTRADOR.ESTADO_USU IS NOT NULL);
ALTER TABLE ADMINISTRADORES ADD CONSTRAINT UK_CORREO_ADMIN UNIQUE (ADMINISTRADOR.CORREO_USU);
ALTER TABLE ADMINISTRADORES ADD CONSTRAINT FK_TIPODOC_ADMIN FOREIGN KEY (ADMINISTRADOR.TIPODOC_USU) REFERENCES TIPODOCUMENTOS(CODIGO_TIPODOC);
ALTER TABLE ADMINISTRADORES ADD CONSTRAINT FK_SEXO_ADMIN FOREIGN KEY (ADMINISTRADOR.SEXO_USU) REFERENCES SEXOS(CODIGO_SEX);
ALTER TABLE ADMINISTRADORES ADD CONSTRAINT FK_ESDO_ADMIN FOREIGN KEY (ADMINISTRADOR.ESTADO_USU) REFERENCES ESTADOS(CODIGO_ESTADO);
ALTER TABLE ADMINISTRADORES ADD CONSTRAINT FK_ROL_ADMIN FOREIGN KEY (ROL) REFERENCES ROLES(CODIGO_ROL);

-- Tabla niveles matriculados
ALTER TABLE NIVELES_MATRICULADOS ADD CONSTRAINT PK_NIVEL_MATR PRIMARY KEY (NIVEL_MATR.DNI_USU);
ALTER TABLE NIVELES_MATRICULADOS ADD CONSTRAINT NN_FECHA_LIMITE CHECK (FECHA_LIMITE IS NOT NULL);
ALTER TABLE NIVELES_MATRICULADOS ADD CONSTRAINT FK_MATR_EST FOREIGN KEY (NIVEL_MATR.DNI_USU) REFERENCES ESTUDIANTES(ESTUDIANTE.DNI_USU); 
ALTER TABLE NIVELES_MATRICULADOS ADD CONSTRAINT FK_NIVEL_MATR_EST FOREIGN KEY (NIVEL_MATR.COD_NIVEL) REFERENCES NIVELES(CODIGO_NIVEL);

-- Tabla niveles historico
ALTER TABLE NIVELES_HISTORICO ADD CONSTRAINT PK_NIVEL_HIST PRIMARY KEY (NIVEL_HIST.DNI_USU);
ALTER TABLE NIVELES_HISTORICO ADD CONSTRAINT NN_FECHA_FIN CHECK (FECHA_FIN IS NOT NULL);
ALTER TABLE NIVELES_HISTORICO ADD CONSTRAINT FK_HIST_EST FOREIGN KEY (NIVEL_HIST.DNI_USU) REFERENCES ESTUDIANTES(ESTUDIANTE.DNI_USU);
ALTER TABLE NIVELES_HISTORICO ADD CONSTRAINT FK_NIVEL_HIST_EST FOREIGN KEY (NIVEL_HIST.COD_NIVEL) REFERENCES NIVELES(CODIGO_NIVEL);

-- Tabla examen_oral_presentado
ALTER TABLE EXAMEN_ORAL_PRESENTADO ADD CONSTRAINT PK_EXAM_ORAL PRIMARY KEY (ORAL.ID_EXAMEN, ORAL.DNI_EST);
ALTER TABLE EXAMEN_ORAL_PRESENTADO ADD CONSTRAINT NN_NOTA_ORAL CHECK (ORAL.NOTA IS NOT NULL);
ALTER TABLE EXAMEN_ORAL_PRESENTADO ADD CONSTRAINT NN_FECHA_ORAL CHECK (ORAL.FECHA IS NOT NULL);
ALTER TABLE EXAMEN_ORAL_PRESENTADO ADD CONSTRAINT FK_ORAL_EST FOREIGN KEY (ORAL.DNI_EST) REFERENCES ESTUDIANTES(ESTUDIANTE.DNI_USU);
ALTER TABLE EXAMEN_ORAL_PRESENTADO ADD CONSTRAINT FK_ORAL_PROF FOREIGN KEY (DNI_PROFESOR) REFERENCES PROFESORES(PROFESOR.DNI_USU);

-- Tabla examen_escrito_presentado
ALTER TABLE EXAMEN_ESCRITO_PRESENTADO ADD CONSTRAINT PK_EXAM_ESCRITO PRIMARY KEY (ESCRITO.ID_EXAMEN, ESCRITO.DNI_EST);
ALTER TABLE EXAMEN_ESCRITO_PRESENTADO ADD CONSTRAINT NN_FECHA_ESCRITO CHECK (ESCRITO.FECHA IS NOT NULL);
ALTER TABLE EXAMEN_ESCRITO_PRESENTADO ADD CONSTRAINT NN_ACIERTOS CHECK (CANT_ACIERTO IS NOT NULL);
ALTER TABLE EXAMEN_ESCRITO_PRESENTADO ADD CONSTRAINT FK_ESCRITO_EST FOREIGN KEY (ESCRITO.DNI_EST) REFERENCES ESTUDIANTES(ESTUDIANTE.DNI_USU);

-- Tabla NOTAS
ALTER TABLE NOTAS ADD CONSTRAINT PK_NOTA PRIMARY KEY (ID_EXAMEN, DNI_ESTUDIANTE);
ALTER TABLE NOTAS ADD CONSTRAINT FK_DNI_ESTUDIANTE_NOTAS FOREIGN KEY (DNI_ESTUDIANTE) REFERENCES ESTUDIANTES(ESTUDIANTE.DNI_USU);
ALTER TABLE NOTAS ADD CONSTRAINT FK_ESTADO_NOTA FOREIGN KEY (ESTADO) REFERENCES ESTADOS_EXAMENES(CODIGO_ESTADO);
ALTER TABLE NOTAS ADD CONSTRAINT FK_ID_EXAMEN_NOTA FOREIGN KEY (ID_EXAMEN) REFERENCES EXAMENES(NUMERO_EXAMEN);

--Tabla clases_programadas
ALTER TABLE CLASES_PROGRAMADAS ADD CONSTRAINT PK_CLA_PROG PRIMARY KEY (DNI_EST, PROGRAMACION.FECHA, PROGRAMACION.HORA);
ALTER TABLE CLASES_PROGRAMADAS ADD CONSTRAINT NN_COD_NI_CLA_PROG CHECK (PROGRAMACION.NIVEL IS NOT NULL);
ALTER TABLE CLASES_PROGRAMADAS ADD CONSTRAINT FK_ESTU_CLA_PROG FOREIGN KEY (DNI_EST) REFERENCES ESTUDIANTES(ESTUDIANTE.DNI_USU);
ALTER TABLE CLASES_PROGRAMADAS ADD CONSTRAINT FK_NI_CLA_PROG FOREIGN KEY (PROGRAMACION.NIVEL) REFERENCES NIVELES(CODIGO_NIVEL);
ALTER TABLE CLASES_PROGRAMADAS ADD CONSTRAINT FK_CLA_CL_PROG FOREIGN KEY (CODIGO_CLASE) REFERENCES CLASES(CODIGO_CLASE);
ALTER TABLE CLASES_PROGRAMADAS ADD CONSTRAINT FK_EST_CLA_PROG FOREIGN KEY (ESTADO_CLASE_PROG) REFERENCES ESTADOS_CLASES(CODIGO_ESTADO_CLASE);
ALTER TABLE CLASES_PROGRAMADAS ADD CONSTRAINT FK_HO_CLA_PROG FOREIGN KEY (PROGRAMACION.HORA) REFERENCES HORAS(CODIGO_HORA);

--Tabla cupos
ALTER TABLE CUPOS ADD CONSTRAINT PK_COD_CUPO PRIMARY KEY (CODIGO_CUPO);
ALTER TABLE CUPOS ADD CONSTRAINT NN_FEC_CUPO CHECK (PROGRAMACION.FECHA IS NOT NULL);
ALTER TABLE CUPOS ADD CONSTRAINT NN_COD_HO_CUPO CHECK (PROGRAMACION.HORA IS NOT NULL);
ALTER TABLE CUPOS ADD CONSTRAINT NN_COD_NI_CUPO CHECK (PROGRAMACION.NIVEL IS NOT NULL);
ALTER TABLE CUPOS ADD CONSTRAINT NN_COD_SAL_CUPO CHECK (CODIGO_SALON IS NOT NULL);
ALTER TABLE CUPOS ADD CONSTRAINT FK_HO_CUPOS FOREIGN KEY (PROGRAMACION.HORA) REFERENCES HORAS(CODIGO_HORA);
ALTER TABLE CUPOS ADD CONSTRAINT FK_NI_CUPOS FOREIGN KEY (PROGRAMACION.NIVEL) REFERENCES NIVELES(CODIGO_NIVEL);
ALTER TABLE CUPOS ADD CONSTRAINT FK_SAL_CUPOS FOREIGN KEY (CODIGO_SALON) REFERENCES SALONES(CODIGO_SALON);