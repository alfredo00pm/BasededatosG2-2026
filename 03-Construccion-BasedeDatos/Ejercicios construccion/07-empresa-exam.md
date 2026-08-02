```
-- Base de datos
CREATE DATABASE empresa;
GO

USE empresa;
GO

-- Tabla empleado
CREATE TABLE empleado(
    numempleado INT NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    apellido1 VARCHAR(30) NOT NULL,
    apellido2 VARCHAR(30),
    telefono VARCHAR(15),
    curp VARCHAR(18),

    CONSTRAINT pk_empleado
    PRIMARY KEY (numempleado)
);
GO

-- Tabla departamento
CREATE TABLE departamento(
    clavedepto INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    ubicacion VARCHAR(60),
    presupuesto DECIMAL(12,2),

    CONSTRAINT pk_departamento
    PRIMARY KEY (clavedepto)
);
GO

-- Tabla puesto
CREATE TABLE puesto(
    clavepuesto INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    niveljerarquico VARCHAR(30),
    salariomin DECIMAL(10,2),
    salariomax DECIMAL(10,2),

    CONSTRAINT pk_puesto
    PRIMARY KEY (clavepuesto)
);
GO

-- Tabla proyecto
CREATE TABLE proyecto(
    claveproyecto INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    fechainicio DATE,
    fechatermino DATE,
    presupuesto DECIMAL(12,2),

    CONSTRAINT pk_proyecto
    PRIMARY KEY (claveproyecto)
);
GO

-- Tabla sucursal
CREATE TABLE sucursal(
    clavesucursal INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    ciudad VARCHAR(40),
    estado VARCHAR(40),

    CONSTRAINT pk_sucursal
    PRIMARY KEY (clavesucursal)
);
GO

-- Tabla capacitacion
CREATE TABLE capacitacion(
    clavecapacitacion INT NOT NULL,
    nombre VARCHAR(60),

    CONSTRAINT pk_capacitacion
    PRIMARY KEY (clavecapacitacion)
);
GO

-- Relación empleado - departamento
/* Empleado pertenece a un Departamento */

CREATE TABLE pertenece(
    numempleado INT NOT NULL,
    clavedepto INT NOT NULL,

    CONSTRAINT pk_pertenece
    PRIMARY KEY(numempleado)
);
GO

-- Relación empleado - puesto
/* Empleado ocupa un Puesto */

CREATE TABLE ocupa(
    numempleado INT NOT NULL,
    clavepuesto INT NOT NULL,

    CONSTRAINT pk_ocupa
    PRIMARY KEY(numempleado)
);
GO

-- Relación puesto - sucursal
/* Sucursal tiene varios puestos */

CREATE TABLE asignado(
    clavepuesto INT NOT NULL,
    clavesucursal INT NOT NULL,

    CONSTRAINT pk_asignado
    PRIMARY KEY(clavepuesto)
);
GO

-- Relación empleado - proyecto

CREATE TABLE participa(
    numempleado INT NOT NULL,
    claveproyecto INT NOT NULL,
    rol VARCHAR(40),
    horas INT,

    CONSTRAINT pk_participa
    PRIMARY KEY(numempleado, claveproyecto)
);
GO

-- Relación empleado - capacitación

CREATE TABLE asiste(
    numempleado INT NOT NULL,
    clavecapacitacion INT NOT NULL,
    fechaasignacion DATE,
    fechaasistencia DATE,
    calificacion DECIMAL(5,2),
    estatus VARCHAR(20),

    CONSTRAINT pk_asiste
    PRIMARY KEY(numempleado, clavecapacitacion)
);
GO

-- Relación departamento - capacitación
/* Departamento administra capacitaciones */

CREATE TABLE administra(
    clavedepto INT NOT NULL,
    clavecapacitacion INT NOT NULL,

    CONSTRAINT pk_administra
    PRIMARY KEY(clavedepto, clavecapacitacion)
);
GO

-- Relación jefe - empleado
/* Un empleado puede ser jefe de otros empleados */

CREATE TABLE jefe(
    jefe INT NOT NULL,
    subordinado INT NOT NULL,

    CONSTRAINT pk_jefe
    PRIMARY KEY(jefe, subordinado)
);
GO

-- Llaves foráneas

/* Pertenece */
ALTER TABLE pertenece
ADD CONSTRAINT fk_pertenece_empleado
FOREIGN KEY(numempleado)
REFERENCES empleado(numempleado);
GO

ALTER TABLE pertenece
ADD CONSTRAINT fk_pertenece_departamento
FOREIGN KEY(clavedepto)
REFERENCES departamento(clavedepto);
GO

/* Ocupa */
ALTER TABLE ocupa
ADD CONSTRAINT fk_ocupa_empleado
FOREIGN KEY(numempleado)
REFERENCES empleado(numempleado);
GO

ALTER TABLE ocupa
ADD CONSTRAINT fk_ocupa_puesto
FOREIGN KEY(clavepuesto)
REFERENCES puesto(clavepuesto);
GO

/* Asignado */
ALTER TABLE asignado
ADD CONSTRAINT fk_asignado_puesto
FOREIGN KEY(clavepuesto)
REFERENCES puesto(clavepuesto);
GO

ALTER TABLE asignado
ADD CONSTRAINT fk_asignado_sucursal
FOREIGN KEY(clavesucursal)
REFERENCES sucursal(clavesucursal);
GO

/* Participa */
ALTER TABLE participa
ADD CONSTRAINT fk_participa_empleado
FOREIGN KEY(numempleado)
REFERENCES empleado(numempleado);
GO

ALTER TABLE participa
ADD CONSTRAINT fk_participa_proyecto
FOREIGN KEY(claveproyecto)
REFERENCES proyecto(claveproyecto);
GO

/* Asiste */
ALTER TABLE asiste
ADD CONSTRAINT fk_asiste_empleado
FOREIGN KEY(numempleado)
REFERENCES empleado(numempleado);
GO

ALTER TABLE asiste
ADD CONSTRAINT fk_asiste_capacitacion
FOREIGN KEY(clavecapacitacion)
REFERENCES capacitacion(clavecapacitacion);
GO

/* Administra */
ALTER TABLE administra
ADD CONSTRAINT fk_administra_departamento
FOREIGN KEY(clavedepto)
REFERENCES departamento(clavedepto);
GO

ALTER TABLE administra
ADD CONSTRAINT fk_administra_capacitacion
FOREIGN KEY(clavecapacitacion)
REFERENCES capacitacion(clavecapacitacion);
GO

/* Jefe */
ALTER TABLE jefe
ADD CONSTRAINT fk_jefe_empleado
FOREIGN KEY(jefe)
REFERENCES empleado(numempleado);
GO

ALTER TABLE jefe
ADD CONSTRAINT fk_subordinado_empleado
FOREIGN KEY(subordinado)
REFERENCES empleado(numempleado);
GO
```
![Ejercicio7CDB](/img/Construccion/Tabla8.png)