```
CREATE DATABASE escuela;
USE escuela;

CREATE TABLE alumno(
id_alumno INT NOT NULL IDENTITY (1,1)
CONSTRAINT id_alumno
PRIMARY KEY (id_alumno),

matricula VARCHAR(25) NOT NULL
CONSTRAINT uq_matriqula
UNIQUE (matricula),

nombre VARCHAR(45) NOT NULL,
semestre VARCHAR(20) NOT NULL
);

SELECT * FROM alumno;

CREATE TABLE materia(
id_materia INT NOT NULL
CONSTRAINT pk_id_materia
PRIMARY KEY (id_materia),

nombre_materia VARCHAR(50) NOT NULL,
creditos VARCHAR(45),
);

CREATE TABLE inscribe(
    id_alumno INT NOT NULL,
    id_materia INT NOT NULL,
    fecha_inscripcion DATE NOT NULL,
    calificacion_final DECIMAL(5,2),

    CONSTRAINT pk_inscribe
    PRIMARY KEY (id_alumno, id_materia),

    CONSTRAINT fk_inscribe_alumno
    FOREIGN KEY (id_alumno)
    REFERENCES alumno(id_alumno),

    CONSTRAINT fk_inscribe_materia
    FOREIGN KEY (id_materia)
    REFERENCES materia(id_materia)
);
```
-----
![Ejercicio3CDB](/img/Construccion/Tabla3.png)
