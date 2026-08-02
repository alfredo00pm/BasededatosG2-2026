/*============ CREAR BASE DE DATOS ==============*/
CREATE DATABASE instituto;
GO

USE instituto;
GO

/*============ CREAR TABLA ALUMNO ==============*/
CREATE TABLE alumno(
    matricula INT NOT NULL,
    nombrep VARCHAR(30) NOT NULL,
    apellido1 VARCHAR(30) NOT NULL,
    apellido2 VARCHAR(30),
    correo VARCHAR(60),
    celular VARCHAR(15),
    fechainscripcion DATE,

    CONSTRAINT pk_alumno
    PRIMARY KEY (matricula)
);
GO

/*============ CREAR TABLA CREDENCIAL ==============*/
CREATE TABLE credencial(
    numcredencial INT NOT NULL,
    fechainscripcion DATE,
    vigencia DATE,
    matricula INT NOT NULL,

    CONSTRAINT pk_credencial
    PRIMARY KEY (numcredencial)
);
GO

/*============ CREAR TABLA DEPARTAMENTO ==============*/
CREATE TABLE departamento(
    numdepto INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    edificio VARCHAR(50),

    CONSTRAINT pk_departamento
    PRIMARY KEY (numdepto)
);
GO

/*============ CREAR TABLA PROFESOR ==============*/
CREATE TABLE profesor(
    numprof INT NOT NULL,
    nombrep VARCHAR(30) NOT NULL,
    apellido1 VARCHAR(30) NOT NULL,
    apellido2 VARCHAR(30),
    numdepto INT NOT NULL,

    CONSTRAINT pk_profesor
    PRIMARY KEY (numprof)
);
GO

/*============ CREAR TABLA MATERIA ==============*/
CREATE TABLE materia(
    clavemateria VARCHAR(10) NOT NULL,
    nombremat VARCHAR(50) NOT NULL,
    creditos INT,

    CONSTRAINT pk_materia
    PRIMARY KEY (clavemateria)
);
GO

/*============ CREAR TABLA PROYECTO ==============*/
CREATE TABLE proyecto(
    numproyecto INT NOT NULL,
    nombreproyecto VARCHAR(50) NOT NULL,
    presupuesto DECIMAL(10,2),

    CONSTRAINT pk_proyecto
    PRIMARY KEY (numproyecto)
);
GO

/*============ CREAR TABLA DEPENDIENTE ==============*/
CREATE TABLE dependiente(
    nombre VARCHAR(50) NOT NULL,
    fechanaci DATE,
    parentesco VARCHAR(30),
    numprof INT NOT NULL,

    CONSTRAINT pk_dependiente
    PRIMARY KEY (nombre)
);
GO

/*============ CREAR TABLA CURSA ==============*/
CREATE TABLE cursa(
    matricula INT NOT NULL,
    clavemateria VARCHAR(10) NOT NULL,

    CONSTRAINT pk_cursa
    PRIMARY KEY (matricula, clavemateria)
);
GO

/*============ CREAR TABLA IMPARTE ==============*/
CREATE TABLE imparte(
    numprof INT NOT NULL,
    clavemateria VARCHAR(10) NOT NULL,

    CONSTRAINT pk_imparte
    PRIMARY KEY (numprof, clavemateria)
);
GO

/*============ CREAR TABLA PARTICIPA ==============*/
CREATE TABLE participa(
    numprof INT NOT NULL,
    numproyecto INT NOT NULL,
    rol VARCHAR(40),
    fechainicio DATE,

    CONSTRAINT pk_participa
    PRIMARY KEY (numprof, numproyecto)
);
GO

/*============ FOREIGN KEYS ==============*/

-- Credencial -> Alumno 
ALTER TABLE credencial
ADD CONSTRAINT fk_credencial_alumno
FOREIGN KEY (matricula)
REFERENCES alumno(matricula);
GO

-- Profesor -> Departamento 
ALTER TABLE profesor
ADD CONSTRAINT fk_profesor_departamento
FOREIGN KEY (numdepto)
REFERENCES departamento(numdepto);
GO

-- Dependiente -> Profesor 
ALTER TABLE dependiente
ADD CONSTRAINT fk_dependiente_profesor
FOREIGN KEY (numprof)
REFERENCES profesor(numprof);
GO

-- Cursa -> Alumno 
ALTER TABLE cursa
ADD CONSTRAINT fk_cursa_alumno
FOREIGN KEY (matricula)
REFERENCES alumno(matricula);
GO

-- Cursa -> Materia 
ALTER TABLE cursa
ADD CONSTRAINT fk_cursa_materia
FOREIGN KEY (clavemateria)
REFERENCES materia(clavemateria);
GO

--Imparte -> Profesor 
ALTER TABLE imparte
ADD CONSTRAINT fk_imparte_profesor
FOREIGN KEY (numprof)
REFERENCES profesor(numprof);
GO

-- Imparte -> Materia 
ALTER TABLE imparte
ADD CONSTRAINT fk_imparte_materia
FOREIGN KEY (clavemateria)
REFERENCES materia(clavemateria);
GO

-- Participa -> Profesor 
ALTER TABLE participa
ADD CONSTRAINT fk_participa_profesor
FOREIGN KEY (numprof)
REFERENCES profesor(numprof);
GO

-- Participa -> Proyecto 
ALTER TABLE participa
ADD CONSTRAINT fk_participa_proyecto
FOREIGN KEY (numproyecto)
REFERENCES proyecto(numproyecto);
GO  