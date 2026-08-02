CREATE DATABASE hospital;
GO

USE hospital;

CREATE TABLE paciente(
numero_paciente VARCHAR(45) NOT NULL,
nombre VARCHAR(45) NOT NULL,
apellidoPaterno VARCHAR(30) NOT NULL,
apellidoMaterno VARCHAR(30),
fecha_nacimiento DATE NOT NULL,
CONSTRAINT pk_paciente
PRIMARY KEY (numero_paciente)
);
GO
CREATE TABLE expediente(
numero_expediente VARCHAR(25) NOT NULL
CONSTRAINT pk_numero_expediente
PRIMARY KEY (numero_expediente),
fecha_apertura DATETIME2 NOT NULL
CONSTRAINT df_fecha_apertura_at
DEFAULT SYSDATETIME(),
tipo_sangre CHAR(10) NOT NULL,
numero_paciente VARCHAR(45) NOT NULL
);

ALTER TABLE expediente
ADD CONSTRAINT 
fk_expediente_paciente
FOREIGN KEY (numero_paciente)
REFERENCES paciente(numero_paciente);