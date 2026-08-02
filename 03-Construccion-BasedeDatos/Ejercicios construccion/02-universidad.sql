CREATE DATABASE universidad2;
USE universidad2;

CREATE TABLE profesor(
    numero_profesor VARCHAR(25) NOT NULL
    CONSTRAINT pk_numero_profesor
    PRIMARY KEY (numero_profesor),
    nombre VARCHAR(45) NOT NULL,
    especialidad VARCHAR(100) NOT NULL
);

CREATE TABLE curso(
numero_curso INT NOT NULL 
CONSTRAINT pk_numero_curso
PRIMARY KEY (numero_curso),
nombre_curso VARCHAR(45) NOT NULL,
creditos VARCHAR(100),
numero_profesor VARCHAR(25) NOT NULL
);

ALTER TABLE curso 
ADD 
CONSTRAINT fk_curso_profesor 
FOREIGN KEY (numero_profesor)
REFERENCES profesor(numero_profesor);

