CREATE DATABASE bdEjemplo;

USE bdejemplo;

CREATE TABLE categoria(
    id INT NOT NULL, 
    nombre VARCHAR(50) NOT NULL,
    CONSTRAINT pk_categoria
    PRIMARY KEY (id)
);

INSERT INTO categoria
VALUES(1, 'Carnes Frias'),
      (2, 'Vinos y licores')
SELECT * FROM categoria;

-- RAZON DE CARDINALIDAD 

USE bdejemplo;
CREATE TABLE Empleado (
id_empleado INT NOT NULL PRIMARY KEY,
nombre VARCHAR(30) NOT NULL,
apellido1 VARCHAR(30) NOT NULL,
apellido2 VARCHAR(30) NOT NULL,
salario MONEY NOT NULL,
fecha_naci DATE NOT NULL
);

INSERT INTO Empleado
VALUES (1, 'ARCADIA', 'ROBLES', 'LOPEZ', 30000, 2007-06-16),
        (2, 'MONICO', 'CABEZA', 'DE VACA'),
        (3, 'JOSE LUIS', 'HERRERA', 'GALLARDO', '58.23', '1983,-04-06')

SELECT
    id_empleado, apellido1, apellido2,
    salario, fecha_naci
FROM Empleado

-- MANEJO DE VALORES NULOS 

USE bdejemplo;
GO

CREATE TABLE alumno (
    idAlumno INT NOT NULL PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    apellidoPaterno VARCHAR(20) NOT NULL,
    apellidoMaterno VARCHAR(20) NULL,
    fechaNaci DATE NOT NULL,
    calle VARCHAR(50) NOT NULL,
    numeroInt INT,
    numeroExt INT,

    );
    INSERT INTO alumno
    VALUES (1,'MONSERRATH', 'MUÑOZ', NULL, '2007-07-17', 'CALLE INFIERNO', NULL, 666);
    INSERT INTO alumno
    VALUES (2,'IRVING', 'ANDABLO', 'ISLAS', '2007-06-16', 'CALLE CIELO', NULL, NULL);
    INSERT INTO alumno (idAlumno,nombre, apellidoPaterno, fechaNaci, calle)
    VALUES (3,'CRISTOFER', 'GARCIA', '2007-11-03', 'Conocida');

    SELECT * FROM alumno;




    -- RAZON DE CARDINALIDAD 1:N
    CREATE TABLE categoria2(
    categoriaId INT NOT NULL,
    nombre VARCHAR(20) NOT NULL,
    CONSTRAINT pk_categoria2
    PRIMARY KEY (categoriaId)
    );

    CREATE TABLE productos2(
    productoId INT NOT NULL PRIMARY KEY,
    nombre VARCHAR(35) NOT NULL,
    existencia INT NOT NULL,
    precio DECIMAL (10,2) NOT NULL,
    categoriaId INT,
    CONSTRAINT fk_producto2_categoria2
    FOREIGN KEY (categoriaId)
    REFERENCES categoria2(categoriaId)
    );