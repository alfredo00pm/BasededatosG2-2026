```
CREATE DATABASE hospital;
GO

USE hospital;

CREATE TABLE paciente(
numero_paciente VARCHAR(20) NOT NULL,
nombre VARCHAR(45) NOT NULL,
apellidoPaterno VARCHAR(30) NOT NULL,
apellidoMaterno VARCHAR(30),
fecha_nacimiento DATE,
CONSTRAINT pk_paciente
PRIMARY KEY (numero_paciente)
);
GO

SELECT * FROM paciente;

CREATE TABLE expediente(
numero_expediente VARCHAR(25) NOT NULL,
fecha_apertura DATETIME2 NOT NULL
CONSTRAINT df_fecha_apertura_at
DEFAULT SYSDATETIME(),
tipo_sangre CHAR(5) NOT NULL,
numero_paciente VARCHAR(45) NOT NULL,
CONSTRAINT uq_numero_expediente
);
```
![Ejercicio1CDB](/img/Construccion/Tabla1.png)
