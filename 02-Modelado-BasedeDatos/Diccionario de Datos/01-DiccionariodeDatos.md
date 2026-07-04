# Diccionario de Datos de la Base de Datos de Control Escolar


## 1. Información General

| Elemento | Valor |
| :--- | :--- |
| **Proyecto** | Control Escolar |
| **Versión** | 1.1 |
| **Elaboró** | Alfredo Pineda Miranda |
| **SGBD** | SQLSERVER |

---

## 2. Descripción de la Base de Datos

La base de datos administra las siguientes entidades:

* Carrera
* Alumno
* Profesor
* Materia
* Grupo
* Inscripción

> **Objetivo:** Permite controlar la oferta académica, la asignación de docentes a materias y la inscripción formal de estudiantes en grupos específicos.

---

## 3. Catálogo de Restricciones Utilizadas

| Catálogo | Significado |
| :---: | :--- |
| **pk** | Primary Key (Clave Primaria) |
| **fk** | Foreign Key (Clave Foránea) |
| **nn** | Not Null (No Nulo) |
| **uq** | Unique (Único) |
| **ai** | Autoincrement o Identity (Autoincremental) |
| **ck** | Check (Validación de datos) |
| **df** | Default (Valor por defecto) |

---

## 4. Diccionario de Datos

### **Tabla:** *carrera*
**Descripción:** Almacena las carreras ofertadas por la universidad.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :---: | :--- | :--- |
| id_carrera | int | - | pk, ai, nn | Identificador único de la carrera |
| nombre | varchar | 100 | uq, nn | Nombre oficial de la carrera |
| duracion_cuatrimestre | int | - | nn, ck (>0) | Duración total medida en cuatrimestres |

---

### **Tabla:** *alumno*
**Descripción:** Almacena la información personal e institucional de los estudiantes inscritos.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :---: | :--- | :--- |
| id_alumno | int | - | pk, ai, nn | Identificador único del alumno |
| matricula | varchar | 10 | uq, nn | Matrícula institucional única del estudiante |
| nombre | varchar | 50 | nn | Nombre(s) del alumno |
| apellido_paterno | varchar | 50 | nn | Apellido paterno del alumno |
| apellido_materno | varchar | 50 | null | Apellido materno del alumno (Permite nulos) |
| correo | varchar | 100 | uq, null | Correo electrónico institucional |
| fecha_nacimiento | date | - | nn | Fecha de nacimiento del alumno |
| id_carrera | int | - | fk, nn | Identificador de la carrera a la que pertenece |

---

### **Tabla:** *profesor*
**Descripción:** Registra la información de los docentes que imparten clases en la institución.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :---: | :--- | :--- |
| id_profesor | int | - | pk, ai, nn | Identificador único del profesor |
| numero_empleado | varchar | 10 | uq, nn | Número de nómina o empleado único |
| nombre | varchar | 50 | nn | Nombre(s) del docente |
| apellido_paterno | varchar | 50 | nn | Apellido paterno del docente |
| apellido_materno | varchar | 50 | null | Apellido materno del docente |
| correo | varchar | 100 | uq, null | Correo de contacto del profesor |

---

### **Tabla:** *materia*
**Descripción:** Catálogo general de asignaturas ligadas a sus respectivos planes de estudio.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :---: | :--- | :--- |
| id_materia | int | - | pk, ai, nn | Identificador único de la materia |
| nombre | varchar | 100 | nn | Nombre completo de la asignatura |
| creditos | int | - | nn, ck (>=0) | Créditos académicos asignados |
| id_carrera | int | - | fk, nn | Carrera a la que pertenece la materia |

---

### **Tabla:** *grupo*
**Descripción:** Registra los grupos específicos que se abren para impartir una materia con un profesor asignado.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :---: | :--- | :--- |
| id_grupo | int | - | pk, ai, nn | Identificador único del grupo operativo |
| codigo_grupo | varchar | 20 | uq, nn | Código visible del grupo (ej. TI-401) |
| id_materia | int | - | fk, nn | Materia que se dicta en este grupo |
| id_profesor | int | - | fk, nn | Profesor responsable de impartir el grupo |

---

### **Tabla:** *inscripcion*
**Descripción:** Entidad intermedia (Muchos a Muchos) que asocia a los alumnos con los grupos en los que se matriculan.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :---: | :--- | :--- |
| id_inscripcion | int | - | pk, ai, nn | Identificador único del registro de inscripción |
| id_alumno | int | - | fk, nn | Alumno que cursa el grupo |
| id_grupo | int | - | fk, nn | Grupo en el que está el alumno |
| fecha_inscripcion | date | - | df(getdate()), nn | Fecha de registro de la inscripción |

---

## 5. Relaciones de la Base de Datos

| Relación | Cardinalidad | Descripción |
| :--- | :---: | :--- |
| carrera -> alumno | 1:n | Una carrera tiene matriculados muchos alumnos |
| carrera -> materia | 1:n | Una carrera contiene muchas materias en su plan de estudios |
| profesor -> grupo | 1:n | Un profesor puede tener asignados varios grupos |
| materia -> grupo | 1:n | Una materia puede abrirse en múltiples grupos simultáneos |
| alumno -> inscripcion | 1:n | Un alumno puede realizar varias inscripciones a grupos |
| grupo -> inscripcion | 1:n | Un grupo recibe la inscripción de muchos alumnos |

---

## 6. Matriz de Claves Foráneas

| Tabla Origen | Campo FK | Tabla Referenciada (Campo PK) |
| :--- | :--- | :--- |
| alumno | id_carrera | carrera(id_carrera) |
| materia | id_carrera | carrera(id_carrera) |
| grupo | id_profesor | profesor(id_profesor) |
| grupo | id_materia | materia(id_materia) |
| inscripcion | id_alumno | alumno(id_alumno) |
| inscripcion | id_grupo | grupo(id_grupo) |

---

## 7. Reglas del Negocio

| Clave | Regla |
| :--- | :--- |
| **rn-01** | Un alumno puede pertenecer a una sola carrera activa a la vez. |
| **rn-02** | No se permite la creación de un grupo si este no cuenta con un profesor titular y una materia asignada. |
| **rn-03** | La duración de los cuatrimestres de una carrera siempre debe ser un número entero mayor a cero. |

---

## 8. Mecanismos de Integridad Referencial


Para preservar la coherencia de la información y prevenir la existencia de registros huérfanos, el motor de la base de datos aplicará de forma automática las siguientes restricciones transaccionales:

### 1. Relación: *carrera -> alumno* y *carrera -> materia*
* **Estrategia al Actualizar (ON UPDATE CASCADE):** Si se modifica el código o identificador de una carrera, el cambio se propagará automáticamente a todos los alumnos y materias asociados a ella.
* **Estrategia al Eliminar (ON DELETE RESTRICT):** Se bloqueará la eliminación de una carrera si esta cuenta con alumnos inscritos o materias registradas en su plan de estudio. Primero se debe reubicar al personal o eliminar los registros dependientes.

### 2. Relación: *profesor -> grupo*
* **Estrategia al Actualizar (ON UPDATE CASCADE):** Cualquier cambio en el ID de un profesor se reflejará instantáneamente en sus grupos asignados.
* **Estrategia al Eliminar (ON DELETE SET NULL / NO ACTION):** No se permite eliminar de forma directa a un profesor si este tiene grupos a su cargo durante el periodo académico para evitar dejar asignaturas sin docente asignado.

### 3. Relación: *materia -> grupo*
* **Estrategia al Actualizar (ON UPDATE CASCADE):** Si el identificador de una materia es actualizado, se actualizarán las referencias en la tabla de grupos.
* **Estrategia al Eliminar (ON DELETE RESTRICT):** Está estrictamente prohibido borrar una materia del catálogo de la universidad si existen grupos actualmente creados utilizando dicha asignatura.

### 4. Relación: *alumno -> inscripcion* y *grupo -> inscripcion*
* **Estrategia al Actualizar (ON UPDATE CASCADE):** Cualquier corrección en los identificadores de la tabla `alumno` o `grupo` se heredará sin problemas en el histórico de inscripciones.
* **Estrategia al Eliminar (ON DELETE CASCADE):** Si se decide de forma administrativa dar de baja definitiva a un alumno del sistema o eliminar un grupo completo, todas sus inscripciones vinculadas en la tabla intermedia se borrarán en cascada de manera automática para limpiar el espacio de trabajo.



| Clave | Regla |
| :--- | :--- |
| **rn-01** | Cada paciente debe tener asignado obligatoriamente un único expediente médico. |
| **rn-02** | No puede existir un expediente en el sistema si no está asociado a un paciente válido. |
| **rn-03** | No puede haber dos pacientes registrados con el mismo número de paciente (`num_paciente`). |

# Diccionario de Datos - Sistema de Gestión Médica (Hospital)

## 1. Información General

| Elemento | Valor |
| :--- | :--- |
| **Proyecto** | Gestión Médica de Pacientes |
| **Versión** | 1.1 |
| **Elaboró** | Alfredo Pineda Miranda |
| **SGBD** | SQLSERVER / Genérico |

---

## 2. Descripción de la Base de Datos

Esta base de datos está diseñada para el control interno de un hospital. Administra el registro clínico de los pacientes y vincula a cada uno de ellos con su respectivo expediente médico electrónico para realizar el seguimiento integral de su historial de salud.

---

## 3. Catálogo de Restricciones Utilizadas

| Catálogo | Significado |
| :---: | :--- |
| **pk** | Primary Key (Clave Primaria) |
| **fk** | Foreign Key (Clave Foránea) |
| **nn** | Not Null (No Nulo) |
| **uq** | Unique (Único) |

---

## 4. Diccionario de Datos

### **Tabla:** *PACIENTE*
**Descripción:** Almacena la información de identificación y datos demográficos de los pacientes que asisten al hospital.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :---: | :--- | :--- |
| num_paciente | int | - | pk, nn | Número único de identificación del paciente |
| nombre | varchar | 50 | nn | Nombre(s) del paciente |
| apellido_paterno | varchar | 50 | nn | Apellido paterno |
| apellido_materno | varchar | 50 | - | Apellido materno (Permite valores nulos) |
| fecha_nacimiento | date | - | nn | Fecha de nacimiento del paciente |

---

### **Tabla:** *EXPEDIENTE*
**Descripción:** Contiene los datos de control del expediente médico que se le asigna de forma obligatoria a cada paciente.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :---: | :--- | :--- |
| num_expediente | int | - | pk, nn | Número único identificador del expediente |
| fecha_apertura | date | - | nn | Fecha en la que se creó el expediente |
| tipo_sangre | varchar | 5 | nn | Tipo de sangre y factor Rh (ej. O+, AB-) |
| num_paciente | int | - | fk, uq, nn | Relación con el paciente dueño del expediente (Es único por expediente) |

---

## 5. Relaciones de la Base de Datos

| Relación | Cardinalidad | Descripción |
| :--- | :---: | :--- |
| PACIENTE -> EXPEDIENTE | 1:1 | Un paciente debe tener exactamente un expediente médico, y un expediente pertenece a un único paciente. |

---

## 6. Matriz de Claves Foráneas

| Tabla Origen | Campo FK | Tabla Referenciada (Campo PK) |
| :--- | :--- | :--- |
| EXPEDIENTE | num_paciente | PACIENTE(num_paciente) |

---

## 7. Reglas del Negocio

| Clave | Regla |
| :--- | :--- |
| **rn-01** | Cada paciente debe tener asignado obligatoriamente un único expediente médico dentro del sistema. |
| **rn-02** | No puede existir un expediente activo en el sistema si no está asociado a un paciente válido y registrado. |
| **rn-03** | No puede haber dos pacientes registrados con el mismo número de identificación (`num_paciente`). |

---

## 8. Mecanismos de Integridad Referencial

Para preservar la coherencia estricta de la información médica y prevenir la existencia de expedientes huérfanos o pacientes sin historial, el motor de la base de datos aplicará las siguientes restricciones automáticas:

### Relación: *PACIENTE -> EXPEDIENTE*
* **Código de Restricción:** `FK_EXPEDIENTE_PACIENTE`
* **Campo Origen:** `EXPEDIENTE(num_paciente)`
* **Tabla Referenciada:** `PACIENTE(num_paciente)`

#### **Estrategias Transaccionales:**

1. **Al Actualizar (ON UPDATE CASCADE):**
   * **Comportamiento:** Si por razones administrativas o corrección de errores se llega a modificar el identificador de un paciente (`num_paciente`) en la tabla `PACIENTE`, este cambio se propagará y actualizará automáticamente en la tabla `EXPEDIENTE`. 
   * **Objetivo:** Garantizar que el expediente médico jamás pierda el rastro de su propietario original.

2. **Al Eliminar (ON DELETE RESTRICT / NO ACTION):**
   * **Comportamiento:** El motor de la base de datos bloqueará y arrojará un error si se intenta eliminar a un paciente de la tabla `PACIENTE` que todavía tenga un expediente registrado en la tabla `EXPEDIENTE`.
   * **Objetivo:** Proteger el historial clínico legal del hospital. Para borrar de forma definitiva a un paciente, el administrador debe borrar primero conscientemente su expediente médico asociado, evitando destrucciones accidentales de información médica sensible.

   # Diccionario de Datos de la Base de Datos: Control Académico

## 1. Información General

| Elemento | Valor |
| :--- | :--- |
| **Proyecto** | Sistema de Control Académico y Profesores |
| **Versión** | 1.1 |
| **Fecha** | Junio 2026 |
| **Elaboró** | Alfredo Pineda Miranda |
| **SGBD** | SQL SERVER |

---

## 2. Descripción de la Base de Datos

La base de datos administra las siguientes entidades:

- Curso
- Profesor
- Especialidad

Permite controlar la oferta de cursos, la asignación y datos personales de los profesores, así como el registro de las especialidades profesionales que posee cada docente.

---

## 3. Catálogo de Restricciones Utilizadas

| Catálogo | Significado |
| :--- | :--- |
| **PK** | Primary Key (Clave Primaria) |
| **FK** | Foreign Key (Clave Foránea) |
| **NN** | Not Null (No Nulo) |
| **AI** | Identity (Autoincrementable) |
| **UQ** | Unique (Único) |
| **CK** | Check (Validación de datos) |

---

## 4. Diccionario de Datos

### **Tabla:** *Curso*
**Descripción:** Almacena los cursos o asignaturas que oferta la institución académica.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `numero_curso` | INT | - | PK, AI, NN | Identificador único y autoincrementable del curso. |
| `nombre_curso` | VARCHAR | 100 | UQ, NN | Nombre oficial e irrepetible de la asignatura o curso. |
| `creditos` | INT | - | NN, CK (>0) | Cantidad de créditos académicos que otorga el curso. |

---

### **Tabla:** *Profesor*
**Descripción:** Almacena los datos de identificación de los profesores y los vincula al curso al que pertenecen.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `numero_profesor` | INT | - | PK, AI, NN | Número de nómina o identificador único del profesor. |
| `nombre` | VARCHAR | 50 | NN | Nombre o nombres del docente. |
| `apellido_paterno` | VARCHAR | 50 | NN | Apellido paterno del docente. |
| `apellido_materno` | VARCHAR | 50 | *Null* | Apellido materno del docente (opcional). |
| `numero_curso` | INT | - | FK, NN | Enlace al curso asignado (Relación N:1, muchos profesores a un curso). |

---

### **Tabla:** *Especialidad*
**Descripción:** Almacena las distintas especialidades, maestrías o certificaciones técnicas que ostentan los profesores.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `id_especialidad` | INT | - | PK, AI, NN | Identificador único de registro de la especialidad. |
| `nombre` | VARCHAR | 100 | NN | Nombre o título de la especialidad profesional. |
| `numero_profesor` | INT | - | FK, NN | Enlace al profesor que posee dicha especialidad (Relación N:1). |

---

## 5. Relaciones en la Base de Datos

| Relación | Cardinalidad | Descripción |
| :--- | :--- | :--- |
| Curso -> Profesor | 1:N | Un curso puede ser asignado o dictado por muchos profesores. |
| Profesor -> Especialidad | 1:N | Un profesor puede registrar y contar con muchas especialidades académicas. |

---

## 6. Matriz de Claves Foráneas

| Tabla Origen | Campo FK | Tabla Referenciada (Campo PK) |
| :--- | :--- | :--- |
| Profesor | `numero_curso` | Curso(`numero_curso`) |
| Especialidad | `numero_profesor` | Profesor(`numero_profesor`) |

---

## 7. Mecanismos de Integridad Referencial

Para garantizar la coherencia absoluta de los datos académicos y evitar registros huérfanos o inválidos, el motor de SQL Server aplicará de manera automatizada las siguientes reglas transaccionales:

### 1. Relación: *Curso -> Profesor* (Restricción: `FK_Profesor_Curso`)
* **Al Insertar o Modificar (ON UPDATE CASCADE):** No se puede dar de alta a un profesor asignándole un `numero_curso` que no exista previamente en la tabla `Curso`. Si el identificador de un curso base cambia, la actualización se propagará inmediatamente a todas las fichas de profesores vinculados.
* **Al Eliminar (ON DELETE RESTRICT):** No se permite eliminar un curso de la base de datos si tiene profesores asociados dictándolo. Esto previene que los registros de los docentes pierdan su materia de adscripción. Primero se deberán reasignar las materias de dichos profesores o dar de baja las plazas de forma controlada.

### 2. Relación: *Profesor -> Especialidad* (Restricción: `FK_Especialidad_Profesor`)
* **Al Insertar o Modificar (ON UPDATE CASCADE):** No se puede registrar un título o especialidad ligado a un `numero_profesor` inexistente. Cualquier ajuste en la clave de nómina del profesor actualizará automáticamente su portafolio en la tabla `Especialidad`.
* **Al Eliminar (ON DELETE CASCADE):** Si un profesor es dado de baja definitiva de la institución y su registro es eliminado de la tabla `Profesor`, todas sus especialidades almacenadas en la tabla `Especialidad` se borrarán automáticamente en cascada.
* *Razón de negocio:* Las especialidades van ligadas de manera estricta al perfil humano; si el profesor ya no está en la base de datos, carece de sentido mantener sus diplomas huérfanos en el almacenamiento.

---

## 8. Reglas de Negocio

| Clave | Regla |
| :--- | :--- |
| **RN-01** | Muchos profesores pueden estar calificados y asignados para impartir un mismo y único curso académico base. |
| **RN-02** | Un profesor puede registrar múltiples especialidades o grados académicos para comprobar su capacidad en diferentes ramas de estudio. |
| **RN-03** | Todo curso registrado en el sistema debe contar de forma obligatoria con un valor de créditos académicos mayor a cero (`creditos > 0`). |

# Diccionario de Datos de la Base de Datos: Control de Inscripciones

## 1. Información General

| Elemento | Valor |
| :--- | :--- |
| **Proyecto** | Sistema de Control de Inscripciones y Oferta Académica |
| **Versión** | 1.1 |
| **Elaboró** | Alfredo Pineda Miranda |
| **SGBD** | SQL SERVER |

---

## 2. Descripción de la Base de Datos

La base de datos administra el flujo de matriculación escolar a través de las siguientes entidades:

* Carrera
* Alumno
* Profesor
* Materia
* Grupo
* Inscripción

> **Objetivo:** Controlar la oferta de carreras y asignaturas, el registro y asignación de la plantilla docente, así como la inscripción formal de los estudiantes en sus respectivos grupos académicos.

---

## 3. Catálogo de Restricciones Utilizadas

| Catálogo | Significado |
| :--- | :--- |
| **pk** | Primary Key (Clave Primaria) |
| **fk** | Foreign Key (Clave Foránea) |
| **nn** | Not Null (No Nulo) |
| **uq** | Unique (Único) |
| **ai** | Autoincrement o Identity (Autoincremental) |
| **ck** | Check (Validación de datos) |
| **df** | Default (Valor por defecto) |

---

## 4. Diccionario de Datos

### **Tabla:** *carrera*
**Descripción:** Almacena las carreras ofertadas por la institución educativa.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :---: | :--- | :--- |
| `id_carrera` | int | - | pk, ai, nn | Identificador único de la carrera. |
| `nombre` | varchar | 100 | uq, nn | Nombre oficial de la carrera. |
| `duracion_cuatrimestre` | int | - | nn, ck (>0) | Duración de la carrera medida en cuatrimestres. |

---

### **Tabla:** *alumno*
**Descripción:** Registra la información de identificación y datos de contacto de los estudiantes.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :---: | :--- | :--- |
| `id_alumno` | int | - | pk, ai, nn | Identificador único del alumno. |
| `matricula` | varchar | 10 | uq, nn | Matrícula única asignada al estudiante. |
| `nombre` | varchar | 50 | nn | Nombre o nombres del alumno. |
| `apellido_paterno` | varchar | 50 | nn | Apellido paterno del alumno. |
| `apellido_materno` | varchar | 50 | null | Apellido materno del alumno (opcional). |
| `correo` | varchar | 100 | uq, null | Correo electrónico institucional. |
| `fecha_nacimiento` | date | - | nn | Fecha de nacimiento del estudiante. |
| `id_carrera` | int | - | fk, nn | Enlace a la carrera en la que está inscrito el alumno. |

---

### **Tabla:** *profesor*
**Descripción:** Almacena la información de los docentes que imparten clases en la institución.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :---: | :--- | :--- |
| `id_profesor` | int | - | pk, ai, nn | Identificador único del profesor. |
| `numero_empleado` | varchar | 10 | uq, nn | Número de empleado o nómina único. |
| `nombre` | varchar | 50 | nn | Nombre o nombres del docente. |
| `apellido_paterno` | varchar | 50 | nn | Apellido paterno del docente. |
| `apellido_materno` | varchar | 50 | null | Apellido materno del docente. |
| `correo` | varchar | 100 | uq, null | Correo electrónico de contacto del profesor. |

---

### **Tabla:** *materia*
**Descripción:** Catálogo general de las asignaturas ligadas a los planes de estudio.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :---: | :--- | :--- |
| `id_materia` | int | - | pk, ai, nn | Identificador único de la materia. |
| `nombre` | varchar | 100 | nn | Nombre completo de la asignatura. |
| `creditos` | int | - | nn, ck (>=0) | Créditos académicos que otorga cursar la materia. |
| `id_carrera` | int | - | fk, nn | Enlace a la carrera a la que pertenece la asignatura. |

---

### **Tabla:** *grupo*
**Descripción:** Registra las secciones o grupos específicos que se abren por periodo para dictar una materia.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :---: | :--- | :--- |
| `id_grupo` | int | - | pk, ai, nn | Identificador único del grupo operativo. |
| `codigo_grupo` | varchar | 20 | uq, nn | Código visible y único del grupo (ej. ICO-401). |
| `id_materia` | int | - | fk, nn | Enlace a la materia que se imparte en este grupo. |
| `id_profesor` | int | - | fk, nn | Enlace al profesor responsable de dictar la materia en el grupo. |

---

### **Tabla:** *inscripcion*
**Descripción:** Tabla intermedia (Muchos a Muchos) que documenta qué alumnos se matricularon en qué grupos.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :---: | :--- | :--- |
| `id_inscripcion` | int | - | pk, ai, nn | Identificador único del registro de inscripción. |
| `id_alumno` | int | - | fk, nn | Enlace al alumno que realiza la inscripción. |
| `id_grupo` | int | - | fk, nn | Enlace al grupo académico seleccionado. |
| `fecha_inscripcion` | date | - | df(getdate()), nn | Fecha automática en la que se efectúa el registro. |

---

## 5. Relaciones de la Base de Datos

| Relación | Cardinalidad | Descripción |
| :--- | :---: | :--- |
| carrera -> alumno | 1:N | Una carrera agrupa a muchos alumnos inscritos. |
| carrera -> materia | 1:N | Una carrera contiene múltiples materias dentro de su mapa curricular. |
| profesor -> grupo | 1:N | Un profesor puede ser asignado como titular de varios grupos. |
| materia -> grupo | 1:N | Una materia puede abrirse en diferentes grupos concurrentes. |
| alumno -> inscripcion | 1:N | Un alumno puede generar múltiples inscripciones a materias/grupos. |
| grupo -> inscripcion | 1:N | Un grupo recibe las solicitudes de inscripción de muchos alumnos. |

---

## 6. Matriz de Claves Foráneas

| Tabla Origen | Campo FK | Tabla Referenciada (Campo PK) |
| :--- | :--- | :--- |
| alumno | `id_carrera` | carrera(`id_carrera`) |
| materia | `id_carrera` | carrera(`id_carrera`) |
| grupo | `id_profesor` | profesor(`id_profesor`) |
| grupo | `id_materia` | materia(`id_materia`) |
| inscripcion | `id_alumno` | alumno(`id_alumno`) |
| inscripcion | `id_grupo` | grupo(`id_grupo`) |

---

## 7. Mecanismos de Integridad Referencial

Para preservar la consistencia estricta de los datos en el proceso escolar y evitar registros desvinculados, el motor de base de datos implementará de forma automática los siguientes candados:

### 1. Relación: *carrera -> alumno* y *carrera -> materia*
* **ON UPDATE CASCADE:** Si se corrige o modifica el identificador `id_carrera` de una carrera, el cambio se replicará al instante en las tablas de alumnos matriculados y materias asociadas.
* **ON DELETE RESTRICT:** No se autoriza eliminar una carrera de la base de datos si cuenta con alumnos vigentes o materias cargadas en su plan de estudios. Primero se debe reubicar a los alumnos y limpiar el catálogo antes de dar de baja la carrera.

### 2. Relación: *profesor -> grupo*
* **ON UPDATE CASCADE:** Los ajustes en la clave principal de un profesor actualizarán en automático su asignación en la tabla de grupos.
* **ON DELETE RESTRICT / NO ACTION:** El sistema bloqueará la baja de un docente de la tabla `profesor` si este tiene asignado un grupo activo en el periodo escolar en curso, evitando dejar asignaturas sin titular.

### 3. Relación: *materia -> grupo*
* **ON UPDATE CASCADE:** Si el identificador de una asignatura cambia, la actualización se hereda directamente en la tabla de grupos operativos.
* **ON DELETE RESTRICT:** Está prohibido remover una materia del catálogo escolar si existen grupos creados utilizando dicha clave.

### 4. Relación: *alumno -> inscripcion* y *grupo -> inscripcion*
* **ON UPDATE CASCADE:** Las correcciones de claves primarias en los registros de alumnos o grupos se actualizarán de inmediato en el histórico de inscripciones.
* **ON DELETE CASCADE:** Si administrativamente se da de baja definitiva a un estudiante, o se decide cancelar un grupo completo, el sistema eliminará automáticamente en cascada todas las inscripciones vinculadas en la tabla intermedia `inscripcion` para evitar registros basura flotantes.

---

## 8. Reglas de Negocio

| Clave | Regla |
| :--- | :--- |
| **RN-01** | Un estudiante puede estar matriculado en una única carrera activa de forma simultánea. |
| **RN-02** | No se permite la apertura ni guardado de un grupo si este no cuenta con un profesor responsable y una materia base asignada. |
| **RN-03** | La matrícula del estudiante (`matricula`) y el número de nómina del docente (`numero_empleado`) son llaves únicas e irrepetibles. |

# Diccionario de Datos de la Base de Datos: Control de Pedidos y Ventas

## 1. Información General

| Elemento | Valor |
| :--- | :--- |
| **Proyecto** | Sistema de Control de Pedidos, Ventas e Inventario |
| **Versión** | 1.0 |
| **Fecha** | Junio 2026 |
| **Elaboró** | Alfredo Pineda Miranda |
| **SGBD** | SQL SERVER |

---

## 2. Descripción de la Base de Datos

La base de datos administra el ciclo completo de la comercialización de productos a través de las siguientes entidades:

* Cliente
* Empleado
* Producto
* Pedido (Venta Cabecera)
* Detalle_Pedido (Venta Detalle)

> **Objetivo:** Registrar las compras realizadas por los clientes, identificar al empleado que procesó la venta, controlar el stock disponible de los productos y desglosar los artículos solicitados en cada transacción.

---

## 3. Catálogo de Restricciones Utilizadas

| Catálogo | Significado |
| :--- | :--- |
| **pk** | Primary Key (Clave Primaria) |
| **fk** | Foreign Key (Clave Foránea) |
| **nn** | Not Null (No Nulo) |
| **uq** | Unique (Único) |
| **ai** | Autoincrement o Identity (Autoincremental) |
| **ck** | Check (Validación de datos) |
| **df** | Default (Valor por defecto) |

---

## 4. Diccionario de Datos

### **Tabla:** *cliente*
**Descripción:** Almacena el directorio de clientes que realizan pedidos en la empresa.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :---: | :--- | :--- |
| `id_cliente` | int | - | pk, ai, nn | Identificador único del cliente. |
| `rfc_dni` | varchar | 15 | uq, nn | Documento de identidad fiscal único. |
| `nombre` | varchar | 100 | nn | Nombre completo o razón social. |
| `telefono` | varchar | 15 | null | Teléfono de contacto. |
| `correo` | varchar | 100 | null | Correo electrónico de facturación. |

---

### **Tabla:** *empleado*
**Descripción:** Registra al personal de la empresa responsable de capturar y atender los pedidos.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :---: | :--- | :--- |
| `id_empleado` | int | - | pk, ai, nn | Identificador único del empleado. |
| `codigo_empleado` | varchar | 10 | uq, nn | Código interno de nómina. |
| `nombre` | varchar | 50 | nn | Nombre(s) del trabajador. |
| `apellidos` | varchar | 100 | nn | Apellidos completos del trabajador. |
| `puesto` | varchar | 50 | nn | Cargo o rol dentro de la empresa (Vendedor, Cajero). |

---

### **Tabla:** *producto*
**Descripción:** Catálogo de artículos disponibles para la venta y control de inventario.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :---: | :--- | :--- |
| `id_producto` | int | - | pk, ai, nn | Identificador único del artículo. |
| `nombre` | varchar | 100 | nn | Nombre comercial del producto. |
| `precio_unitario` | decimal | 10,2 | nn, ck (>0) | Precio de venta al público. |
| `stock` | int | - | nn, ck (>=0) | Cantidad de unidades disponibles en almacén. |

---

### **Tabla:** *pedido*
**Descripción:** Cabecera de la venta. Almacena los datos generales de una transacción de compra.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :---: | :--- | :--- |
| `id_pedido` | int | - | pk, ai, nn | Identificador único del pedido / folio de venta. |
| `fecha_pedido` | datetime | - | df(getdate()), nn | Fecha y hora en la que se genera la venta. |
| `id_cliente` | int | - | fk, nn | Enlace al cliente que adquirió los productos. |
| `id_empleado` | int | - | fk, nn | Enlace al empleado que procesó el pedido. |

---

### **Tabla:** *detalle_pedido*
**Descripción:** Tabla de rotura (Muchos a Muchos). Desglosa los artículos y cantidades correspondientes a cada pedido.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :---: | :--- | :--- |
| `id_pedido` | int | - | pk, fk, nn | Folio del pedido al que pertenece el detalle. |
| `id_producto` | int | - | pk, fk, nn | Enlace al producto vendido. |
| `cantidad` | int | - | nn, ck (>0) | Unidades vendidas de este producto en el pedido. |
| `precio_venta` | decimal | 10,2 | nn | Precio real al que se vendió (por si aplica descuento). |

---

## 5. Relaciones de la Base de Datos

| Relación | Cardinalidad | Descripción |
| :--- | :---: | :--- |
| cliente -> pedido | 1:N | Un cliente puede realizar múltiples pedidos a lo largo del tiempo. |
| empleado -> pedido | 1:N | Un empleado puede registrar y procesar muchos pedidos. |
| pedido -> detalle_pedido | 1:N | Un pedido puede contener múltiples artículos desglosados en el detalle. |
| producto -> detalle_pedido | 1:N | Un producto puede estar presente en los detalles de muchos pedidos. |

---

## 6. Matriz de Claves Foráneas

| Tabla Origen | Campo FK | Tabla Referenciada (Campo PK) |
| :--- | :--- | :--- |
| pedido | `id_cliente` | cliente(`id_cliente`) |
| pedido | `id_empleado` | empleado(`id_empleado`) |
| detalle_pedido | `id_pedido` | pedido(`id_pedido`) |
| detalle_pedido | `id_producto` | producto(`id_producto`) |

---

## 7. Mecanismos de Integridad Referencial

Para evitar la pérdida de información comercial histórica y proteger la contabilidad de la empresa, el motor relacional ejecutará de manera estricta los siguientes mecanismos:

### 1. Relación: *cliente -> pedido* y *empleado -> pedido*
* **ON UPDATE CASCADE:** Si el identificador de un cliente o empleado llega a modificarse, la referencia se actualizará inmediatamente en todas sus ventas asociadas sin romper el historial.
* **ON DELETE RESTRICT / NO ACTION:** Está prohibido eliminar a un cliente o a un empleado del sistema si ya tienen registrados pedidos de venta en el histórico. Esto previene que los reportes financieros se queden con transacciones huérfanas de procedencia desconocida.

### 2. Relación: *pedido -> detalle_pedido*
* **ON UPDATE CASCADE:** Si se realiza alguna corrección sobre el folio principal de un `pedido`, sus líneas de detalle se actualizarán en automático.
* **ON DELETE CASCADE:** Si un pedido completo es cancelado y borrado de la base de datos por un administrador, todas las líneas de artículos asociadas en `detalle_pedido` se eliminarán automáticamente en cascada para liberar almacenamiento de registros obsoletos.

### 3. Relación: *producto -> detalle_pedido*
* **ON UPDATE CASCADE:** Cualquier ajuste en la clave de un producto se hereda al instante en las tablas de detalle de ventas.
* **ON DELETE RESTRICT:** No se puede eliminar un artículo del catálogo si este ya ha sido vendido previamente en algún pedido. Si el producto ya no se comercializa, se debe inactivar mediante programación, pero su registro debe permanecer intacto para no alterar las auditorías de ventas pasadas.

---

## 8. Reglas de Negocio

| Clave | Regla |
| :--- | :--- |
| **RN-01** | La clave primaria de `detalle_pedido` es compuesta (`id_pedido` + `id_producto`), garantizando que un mismo producto no se repita en líneas diferentes dentro del mismo folio. |
| **RN-02** | El `precio_unitario` de un producto y la `cantidad` en los pedidos deben ser estrictamente superiores a cero. |
| **RN-03** | El campo `stock` de la tabla producto no puede albergar valores negativos bajo ninguna circunstancia (`stock >= 0`). |

# Diccionario de Datos de la Base de Datos: Empresa (Versión 1)

## 1. Información General

| Elemento | Valor |
| :--- | :--- |
| **Proyecto** | Sistema de Administración de Personal y Proyectos Corporativos |
| **Versión** | 1.0 |
| **Fecha** | Junio 2026 |
| **Elaboró** | Alfredo Pineda Miranda |
| **SGBD** | SQL SERVER |

---

## 2. Descripción de la Base de Datos

La base de datos administra el capital humano y la planeación de proyectos de la empresa a través de las siguientes entidades:

* **EMPLOYEE (Empleado):** Información personal, salarios y jerarquías del personal.
* **DEPARTMENT (Departamento):** Áreas operativas de la organización y sus directores.
* **LOCATIONS (Ubicaciones):** Sedes geográficas de los departamentos.
* **PROJECT (Proyecto):** Proyectos controlados por la empresa.
* **WORKS_ON (Trabaja en):** Registro de horas invertidas por los empleados en los proyectos.
* **DEPENDENT (Dependiente):** Familiares directos de los empleados para la extensión de beneficios.

> **Objetivo:** Gestionar de forma integral la estructura organizacional, la asignación de presupuestos de tiempo/horas por proyecto, la subordinación laboral y las prestaciones familiares del personal.

---

## 3. Catálogo de Restricciones Utilizadas

| Catálogo | Significado |
| :--- | :--- |
| **pk** | Primary Key (Clave Primaria) |
| **fk** | Foreign Key (Clave Foránea) |
| **nn** | Not Null (No Nulo) |
| **uq** | Unique (Único) |
| **ck** | Check (Validación de datos) |

---

## 4. Diccionario de Datos

### **Tabla:** *EMPLOYEE*
**Descripción:** Almacena los registros principales y de nómina de todos los colaboradores de la empresa.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :---: | :--- | :--- |
| `ssn` | varchar | 11 | pk, nn | Número de Seguro Social (Identificador único del empleado). |
| `first_name` | varchar | 50 | nn | Primer nombre del colaborador. |
| `last_name` | varchar | 50 | nn | Apellidos completos del colaborador. |
| `birthdate` | date | - | - | Fecha de nacimiento. |
| `address` | varchar | 100 | - | Dirección residencial de contacto. |
| `sex` | char | 1 | ck ('M', 'F') | Género o sexo biológico del empleado. |
| `salary` | decimal | 10,2 | ck (>0) | Sueldo o salario mensual bruto asignado. |
| `jef_ssn` | varchar | 11 | fk | SSN del jefe o supervisor directo (Relación recursiva). |
| `number_department` | int | - | fk, nn | Número de departamento operativo al que pertenece. |

---

### **Tabla:** *DEPARTMENT*
**Descripción:** Registra los departamentos operativos o divisiones de la compañía.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :---: | :--- | :--- |
| `number_department` | int | - | pk, nn | Número único e identificador del departamento. |
| `name` | varchar | 100 | uq, nn | Nombre oficial e irrepetible del área (ej. Finanzas). |
| `manager_ssn` | varchar | 11 | fk, nn | SSN del empleado que ejerce como gerente o mánager. |
| `startdate` | date | - | - | Fecha formal en la que el mánager asumió el puesto. |

---

### **Tabla:** *LOCATIONS*
**Descripción:** Registra las diferentes sedes o locaciones donde opera un departamento.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :---: | :--- | :--- |
| `num_location` | int | - | pk, nn | Identificador secuencial de la ubicación. |
| `number_department` | int | - | fk, nn | Departamento asociado a esta ubicación. |
| `location_name` | varchar | 100 | nn | Dirección o nombre de la sede/sucursal física. |

---

### **Tabla:** *PROJECT*
**Descripción:** Contiene la planeación de proyectos institucionales desarrollados por la compañía.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :---: | :--- | :--- |
| `number_project` | int | - | pk, nn | Número único identificador del proyecto. |
| `name` | varchar | 100 | uq, nn | Nombre único asignado al proyecto. |
| `location` | varchar | 100 | - | Sede o zona donde se ejecuta el proyecto. |
| `number_department` | int | - | fk, nn | Departamento responsable de coordinar el proyecto. |

---

### **Tabla:** *WORKS_ON*
**Descripción:** Tabla de rotura (Muchos a Muchos) encargada del control de horas asignadas a los proyectos.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :---: | :--- | :--- |
| `ssn` | varchar | 11 | pk, fk, nn | SSN del empleado asignado al proyecto. |
| `number_project` | int | - | pk, fk, nn | Número del proyecto en desarrollo. |
| `hours` | decimal | 5,2 | nn, ck (>=0) | Cantidad de horas acumuladas trabajadas en el proyecto. |

---

### **Tabla:** *DEPENDENT*
**Descripción:** Registra el padrón de familiares beneficiarios dependientes de los empleados para la extensión de seguros médicos.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :---: | :--- | :--- |
| `ssn_employee` | varchar | 11 | pk, fk, nn | SSN del empleado del cual depende el familiar. |
| `dependent_name` | varchar | 50 | pk, nn | Nombre completo del dependiente. |
| `sex` | char | 1 | ck ('M', 'F') | Género o sexo del dependiente. |
| `birthdate` | date | - | - | Fecha de nacimiento del dependiente. |
| `relationship` | varchar | 50 | nn | Grado de parentesco (Hijo, Hija, Cónyuge, etc.). |

---

## 5. Relaciones de la Base de Datos

| Relación | Cardinalidad | Descripción |
| :--- | :---: | :--- |
| EMPLOYEE -> EMPLOYEE | 1:N | Un empleado puede supervisar o ser jefe de muchos empleados. |
| DEPARTMENT -> EMPLOYEE | 1:N | Un departamento cobija o tiene contratados a muchos empleados. |
| EMPLOYEE -> DEPARTMENT | 1:1 | Un empleado administra en calidad de mánager a un solo departamento. |
| DEPARTMENT -> LOCATIONS | 1:N | Un departamento puede estar distribuido en múltiples sedes físicas. |
| DEPARTMENT -> PROJECT | 1:N | Un departamento es responsable de controlar varios proyectos. |
| EMPLOYEE -> WORKS_ON | 1:N | Un empleado reporta y desglosa horas en diferentes proyectos. |
| PROJECT -> WORKS_ON | 1:N | Un proyecto consolida las horas de trabajo de múltiples empleados. |
| EMPLOYEE -> DEPENDENT | 1:N | Un empleado puede dar de alta a múltiples familiares beneficiarios. |

---

## 6. Matriz de Claves Foráneas

| Tabla Origen | Campo FK | Tabla Referenciada (Campo PK) |
| :--- | :--- | :--- |
| EMPLOYEE | `jef_ssn` | EMPLOYEE(`ssn`) |
| EMPLOYEE | `number_department` | DEPARTMENT(`number_department`) |
| DEPARTMENT | `manager_ssn` | EMPLOYEE(`ssn`) |
| LOCATIONS | `number_department` | DEPARTMENT(`number_department`) |
| PROJECT | `number_department` | DEPARTMENT(`number_department`) |
| WORKS_ON | `ssn` | EMPLOYEE(`ssn`) |
| WORKS_ON | `number_project` | PROJECT(`number_project`) |
| DEPENDENT | `ssn_employee` | EMPLOYEE(`ssn`) |

---

## 7. Mecanismos de Integridad Referencial

Para mitigar riesgos de incoherencias en las relaciones corporativas y evitar la pérdida de registros históricos, se configuran las siguientes directrices relacionales:

### 1. Relación: *DEPARTMENT -> EMPLOYEE* / *DEPARTMENT -> PROJECT* / *DEPARTMENT -> LOCATIONS*
* **ON UPDATE CASCADE:** Si se modifica el número clave de un departamento (`number_department`), este cambio se propagará automáticamente hacia las tablas de empleados, locaciones y proyectos asociados.
* **ON DELETE RESTRICT:** Se denegará el borrado de un departamento si este cuenta con empleados adscritos, sedes operando o proyectos asignados vigentes. Primero se deberán reestructurar dichos recursos antes de la baja del área.

### 2. Relación: *EMPLOYEE -> DEPARTMENT* (Mánager del Área)
* **ON UPDATE CASCADE:** Si el Seguro Social (`ssn`) de un empleado cambia por corrección, se actualizará su valor de manera inmediata en la columna `manager_ssn` de la tabla de departamentos.
* **ON DELETE RESTRICT / NO ACTION:** El sistema bloqueará la eliminación de un empleado si este figura activamente como el director o mánager titular de un departamento, evitando dejar áreas corporativas acéfalas.

### 3. Relación: *EMPLOYEE -> EMPLOYEE* (Supervisión interna)
* **ON UPDATE CASCADE:** Los cambios en el `ssn` de un jefe directo actualizan el campo `jef_ssn` de sus subordinados vinculados.
* **ON DELETE SET NULL:** Si un jefe es dado de baja definitiva de la empresa, los campos `jef_ssn` de sus subordinados directos cambiarán automáticamente a `NULL` provisionalmente, denotando que están temporalmente sin supervisor asignado.

### 4. Relación: *EMPLOYEE -> WORKS_ON* / *PROJECT -> WORKS_ON*
* **ON UPDATE CASCADE:** Cualquier modificación en el `ssn` de un empleado o en el número identificador de un proyecto (`number_project`) se heredará instantáneamente en las hojas de control de horas.
* **ON DELETE CASCADE:** Si administrativamente se da de baja a un empleado de la organización o se cancela definitivamente un proyecto, el sistema limpiará en cascada de forma automática todas las filas de horas correspondientes en la tabla intermedia `WORKS_ON`.

### 5. Relación: *EMPLOYEE -> DEPENDENT*
* **ON UPDATE CASCADE:** Modificaciones de documentos de identidad `ssn` se corrigen de inmediato en las hojas de beneficiarios de la tabla `DEPENDENT`.
* **ON DELETE CASCADE:** Si un empleado deja de prestar servicios en la corporación y es borrado de la base de datos, los registros de sus familiares en la tabla `DEPENDENT` se destruirán en cascada automáticamente, debido a que las prestaciones médicas expiran junto con la baja del titular.

---

## 8. Reglas de Negocio

| Clave | Regla |
| :--- | :--- |
| **RN-01** | La llave primaria de la tabla `DEPENDENT` es de carácter compuesto (`ssn_employee` + `dependent_name`), lo que impide duplicar el registro del mismo familiar para un empleado. |
| **RN-02** | El sueldo asignado a los empleados (`salary`) y las horas registradas en los proyectos (`hours`) deben ser forzosamente valores mayores a cero. |
| **RN-03** | Todo mánager al frente de un departamento debe estar registrado de forma obligatoria como un empleado activo y vigente en la empresa. |

# Diccionario de Datos de la Base de Datos: Empresa (Versión 2)

## 1. Información General

| Elemento | Valor |
| :--- | :--- |
| **Proyecto** | Sistema de Administración de Personal, Proyectos y Sedes (Optimizado) |
| **Versión** | 2.0 |
| **Fecha** | Junio 2026 |
| **Elaboró** | Alfredo Pineda Miranda |
| **SGBD** | SQL SERVER |

---

## 2. Descripción de la Base de Datos

Esta revisión (Versión 2) optimiza el flujo relacional de la organización corporativa. Administra el ciclo operativo de los departamentos, el catálogo de localizaciones geográficas, la planeación de proyectos independientes, la asignación de horas del capital humano (`WORKS_ON`) con auditoría temporal, y el censo de familiares dependientes para el otorgamiento de prestaciones laborales.

---

## 3. Catálogo de Restricciones Utilizadas

| Catálogo | Significado |
| :--- | :--- |
| **pk** | Primary Key (Clave Primaria) |
| **fk** | Foreign Key (Clave Foránea) |
| **nn** | Not Null (No Nulo) |
| **uq** | Unique (Único) |
| **ck** | Check (Validación de datos) |

---

## 4. Diccionario de Datos

### **Tabla:** *EMPLOYEE*
**Descripción:** Almacena los datos maestros, salarios e indicadores jerárquicos de todo el personal de la empresa.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :---: | :--- | :--- |
| `ssn` | varchar | 11 | pk, nn | Número de Seguro Social (Identificador único e invariable). |
| `first_name` | varchar | 50 | nn | Primer nombre del empleado. |
| `last_name` | varchar | 50 | nn | Apellidos completos del empleado. |
| `birthdate` | date | - | - | Fecha de nacimiento (Validación de mayoría de edad). |
| `address` | varchar | 100 | - | Dirección particular del colaborador. |
| `sex` | char | 1 | ck ('M', 'F') | Género o sexo del trabajador. |
| `salary` | decimal | 10,2 | ck (>0) | Salario mensual bruto percibido. |
| `jef_ssn` | varchar | 11 | fk | SSN del supervisor o jefe directo (Estructura jerárquica recursiva). |
| `number_department` | int | - | fk, nn | Departamento de adscripción operativa. |

---

### **Tabla:** *DEPARTMENT*
**Descripción:** Catálogo de las divisiones o áreas de negocio que componen la compañía.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :---: | :--- | :--- |
| `number_department` | int | - | pk, nn | Número identificador único del departamento. |
| `name` | varchar | 100 | uq, nn | Nombre oficial e irrepetible del área corporativa. |
| `manager_ssn` | varchar | 11 | fk, nn | SSN del empleado que funge como mánager actual del área. |
| `startdate` | date | - | - | Fecha exacta en la que el mánager tomó posesión del cargo. |

---

### **Tabla:** *LOCATIONS*
**Descripción:** Registra la distribución de las sedes o plantas físicas asociadas a los departamentos.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :---: | :--- | :--- |
| `num_location` | int | - | pk, nn | Identificador único de registro de la ubicación. |
| `number_department` | int | - | fk, nn | Departamento que tiene presencia en esta ubicación. |
| `location_name` | varchar | 100 | nn | Dirección o nombre de la sede física/sucursal. |

---

### **Tabla:** *PROJECT*
**Descripción:** Catálogo de proyectos institucionales bajo el control y financiamiento de la empresa.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :---: | :--- | :--- |
| `number_project` | int | - | pk, nn | Número único identificador del proyecto. |
| `name` | varchar | 100 | uq, nn | Nombre único e identificable del proyecto corporativo. |
| `location` | varchar | 100 | - | Ubicación específica donde se ejecuta físicamente el proyecto. |
| `number_department` | int | - | fk, nn | Departamento responsable de la dirección del proyecto. |

---

### **Tabla:** *WORKS_ON*
**Descripción:** Tabla de rotura de asignación (Muchos a Muchos). Registra y audita las horas semanales o mensuales que un empleado le dedica a un proyecto específico.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :---: | :--- | :--- |
| `ssn` | varchar | 11 | pk, fk, nn | SSN del empleado asignado al proyecto. |
| `number_project` | int | - | pk, fk, nn | Número del proyecto asignado. |
| `hours` | decimal | 5,2 | nn, ck (>=0) | Acumulado de horas laboradas por el empleado en este proyecto. |

---

### **Tabla:** *DEPENDENT*
**Descripción:** Almacena el padrón de beneficiarios familiares directos vinculados a los empleados para coberturas de seguros corporativos.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :---: | :--- | :--- |
| `ssn_employee` | varchar | 11 | pk, fk, nn | SSN del empleado del cual es dependiente. |
| `dependent_name` | varchar | 50 | pk, nn | Nombre completo del familiar directo. |
| `sex` | char | 1 | ck ('M', 'F') | Género o sexo del dependiente. |
| `birthdate` | date | - | - | Fecha de nacimiento del dependiente. |
| `relationship` | varchar | 50 | nn | Parentesco oficial registrado (Hijo, Cónyuge, etc.). |

---

## 5. Relaciones de la Base de Datos

| Relación | Cardinalidad | Descripción |
| :--- | :---: | :--- |
| EMPLOYEE -> EMPLOYEE | 1:N | Un empleado ejerce autoridad y supervisión sobre muchos subordinados. |
| DEPARTMENT -> EMPLOYEE | 1:N | Un departamento cobija en su estructura a muchos colaboradores. |
| EMPLOYEE -> DEPARTMENT | 1:1 | Un empleado asume la dirección única (Mánager) de un departamento. |
| DEPARTMENT -> LOCATIONS | 1:N | Un departamento puede operar de manera descentralizada en varias sedes. |
| DEPARTMENT -> PROJECT | 1:N | Un departamento supervisa y aprueba el presupuesto de múltiples proyectos. |
| EMPLOYEE -> WORKS_ON | 1:N | Un empleado desglosa sus actividades en diversos proyectos asignados. |
| PROJECT -> WORKS_ON | 1:N | Un proyecto se nutre del esfuerzo de tiempo de múltiples colaboradores. |
| EMPLOYEE -> DEPENDENT | 1:N | Un empleado ampara bajo sus prestaciones contractuales a varios familiares. |

---

## 6. Matriz de Claves Foráneas

| Tabla Origen | Campo FK | Tabla Referenciada (Campo PK) |
| :--- | :--- | :--- |
| EMPLOYEE | `jef_ssn` | EMPLOYEE(`ssn`) |
| EMPLOYEE | `number_department` | DEPARTMENT(`number_department`) |
| DEPARTMENT | `manager_ssn` | EMPLOYEE(`ssn`) |
| LOCATIONS | `number_department` | DEPARTMENT(`number_department`) |
| PROJECT | `number_department` | DEPARTMENT(`number_department`) |
| WORKS_ON | `ssn` | EMPLOYEE(`ssn`) |
| WORKS_ON | `number_project` | PROJECT(`number_project`) |
| DEPENDENT | `ssn_employee` | EMPLOYEE(`ssn`) |

---

## 7. Mecanismos de Integridad Referencial (Versión 2 Optimizado)

En esta versión 2.0 se configuran las restricciones transaccionales de SQL Server para evitar ciclos de eliminación infinita y asegurar que las operaciones concurrentes mantengan la consistencia de los datos:

### 1. Relación: *DEPARTMENT -> EMPLOYEE* / *DEPARTMENT -> PROJECT* / *DEPARTMENT -> LOCATIONS*
* **ON UPDATE CASCADE:** Si la gerencia decide recodificar el número de un departamento (`number_department`), este cambio impactará automáticamente a sus empleados, sucursales y proyectos.
* **ON DELETE RESTRICT / NO ACTION:** Se bloquea estrictamente la eliminación de un departamento si este contiene personal activo o proyectos vigentes. Esto protege la contabilidad operativa de la empresa.

### 2. Relación: *EMPLOYEE -> DEPARTMENT* (Mánager del Área)
* **ON UPDATE CASCADE:** Si se corrige el Seguro Social (`ssn`) de un empleado, el campo `manager_ssn` del departamento que lidera se actualizará al unísono.
* **ON DELETE RESTRICT:** No se puede eliminar de la base de datos a un empleado si este es el mánager activo de un departamento. Se le debe revocar el cargo directivo antes de proceder con su baja.

### 3. Relación: *EMPLOYEE -> EMPLOYEE* (Estructura Jerárquica)
* **ON UPDATE CASCADE:** Los ajustes en la clave primaria de un director modifican el campo `jef_ssn` de su equipo a cargo de forma transparente.
* **ON DELETE SET NULL:** Si un supervisor es dado de baja, los campos `jef_ssn` de sus subordinados directos pasan a valor `NULL`. Esto evita errores de eliminación circular en SQL Server y marca que esos empleados están en espera de la asignación de un nuevo jefe.

### 4. Relación: *EMPLOYEE -> WORKS_ON* / *PROJECT -> WORKS_ON*
* **ON UPDATE CASCADE:** Correcciones en los identificadores maestros de proyectos o empleados se heredan inmediatamente en la asignación de tiempo.
* **ON DELETE CASCADE:** Si un proyecto es cancelado definitivamente o un empleado es removido del sistema, todas las filas correspondientes al desglose de sus horas en la tabla intermedia `WORKS_ON` se eliminarán automáticamente en cascada para optimizar el almacenamiento.

### 5. Relación: *EMPLOYEE -> DEPENDENT*
* **ON UPDATE CASCADE:** Sincronización inmediata ante cambios del `ssn` del trabajador titular.
* **ON DELETE CASCADE:** Si un colaborador causa baja definitiva de la organización, los registros de sus beneficiarios familiares en la tabla `DEPENDENT` se eliminan en cascada en el acto, dado que la vigencia de sus pólizas médicas corporativas depende enteramente del estatus del empleado titular.

---

## 8. Reglas de Negocio

| Clave | Regla |
| :--- | :--- |
| **RN-01** | La tabla `DEPENDENT` utiliza una llave primaria compuesta integrada por (`ssn_employee` + `dependent_name`), impidiendo el duplicado exacto de un familiar bajo el mismo trabajador. |
| **RN-02** | Todo proyecto registrado en el catálogo maestro debe estar coordinado obligatoriamente por un departamento existente y activo dentro de la estructura empresarial. |
| **RN-03** | Las validaciones del sistema deben asegurar que el campo `salary` de un empleado y el campo `hours` en `WORKS_ON` representen cifras de carácter estrictamente positivo. |

# Diccionario de Datos de la Base de Datos: Control de Alumnos, Profesores y Proyectos

## 1. Información General

| Elemento | Valor |
| :--- | :--- |
| **Proyecto** | Sistema de Control de Alumnos, Profesores, Materias y Proyectos |
| **Versión** | 1.1 |
| **Fecha** | Junio 2026 |
| **Elaboró** | Alfredo Pineda Miranda |
| **SGBD** | SQL SERVER |

---

## 2. Descripción de la Base de Datos

La base de datos administra el flujo académico y operativo de una institución educativa, permitiendo el control de:
- **Alumnos y sus Credenciales:** Registro único de estudiantes, sus medios de contacto, teléfonos (atendiendo atributos multivalorados) y su credencial institucional (relación de cardinalidad estricta 1:1).
- **Control de Asignaturas (CURSA e IMPARTE):** Inscripción histórica de alumnos en materias con sus respectivas evaluaciones y la asignación de profesores titulares que las imparten.
- **Estructura Docente (DEPTO y PROFESOR):** Organización de los profesores dentro de sus respectivos departamentos o divisiones académicas adscritas.
- **Investigación y Desarrollo (PARTICIPA):** Registro de la participación de los docentes en proyectos institucionales bajo roles específicos y fechas de asignación.
- **Prestaciones y Beneficios (DEPENDIENTE):** Padrón de los familiares directos que dependen laboralmente del profesor para la extensión de seguros y prestaciones.

---

## 3. Catálogo de Restricciones Utilizadas

| Catálogo | Significado |
| :--- | :--- |
| **PK** | Primary Key (Clave Primaria) |
| **FK** | Foreign Key (Clave Foránea) |
| **NN** | Not Null (No Nulo) |
| **UQ** | Unique (Único) |
| **AI** | Identity / Autoincrementable |
| **CK** | Check (Validación de datos) |

---

## 4. Diccionario de Datos por Tabla

### **Tabla:** *ALUMNO*
**Descripción:** Almacena la información de identificación y datos generales de los estudiantes de la institución.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `matricula` | VARCHAR | 20 | PK, NN | Clave única e institucional del alumno. |
| `pila_nombre` | VARCHAR | 50 | NN | Nombre o nombres de pila del estudiante. |
| `apellido_paterno`| VARCHAR | 50 | NN | Apellido paterno del alumno. |
| `apellido_materno`| VARCHAR | 50 | *Null* | Apellido materno del alumno (opcional). |
| `correo` | VARCHAR | 100 | UQ, NN | Correo electrónico institucional único. |

---

### **Tabla:** *ALUMNO_TEL*
**Descripción:** Entidad que resuelve el atributo multivalorado de teléfonos del alumno, permitiendo registrar múltiples números de contacto.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `id_telefono` | INT | - | PK, NN | Identificador secuencial del teléfono para el alumno. |
| `matricula` | VARCHAR | 20 | PK, FK, NN | Enlace con la matrícula del alumno (Clave compuesta). |
| `numero_telefono`| VARCHAR | 20 | NN | Número telefónico de la línea (celular o casa). |

---

### **Tabla:** *CREDENCIAL*
**Descripción:** Entidad que registra los folios de identificación física expedidos para cada alumno (Relación 1:1).

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `num_credencial` | VARCHAR | 20 | PK, NN | Número de folio único de la credencial física. |
| `fecha_inscripcion`| DATE | - | NN | Fecha en la que se emitió o renovó el plástico. |
| `matricula` | VARCHAR | 20 | FK, UQ, NN | Matrícula del alumno dueño de la credencial. |

---

### **Tabla:** *MATERIA*
**Descripción:** Catálogo maestro de asignaturas ofertadas por la institución. Incluye el vínculo con el profesor que la imparte.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `clave_materia` | VARCHAR | 20 | PK, NN | Código único identificador de la materia. |
| `nombre_materia` | VARCHAR | 100 | NN | Nombre oficial de la asignatura. |
| `id_profesor` | VARCHAR | 20 | FK, NN | ID del profesor que dicta la materia (Relación IMPARTE). |

---

### **Tabla:** *CURSA*
**Descripción:** Tabla intermedia (N:M) que registra el historial de inscripción y calificaciones de los alumnos en las materias.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `matricula` | VARCHAR | 20 | PK, FK, NN | Matrícula del alumno inscrito. |
| `clave_materia` | VARCHAR | 20 | PK, FK, NN | Clave de la materia que está cursando. |
| `fecha_inscripcion`| DATE | - | NN | Fecha de alta de la materia en el periodo escolar. |
| `calif_final` | DECIMAL(4,2) | - | *Null*, CK | Calificación final obtenida por el alumno (Rango 0.00 a 10.00). |

---

### **Tabla:** *DEPTO*
**Descripción:** Catálogo de los departamentos o divisiones académicas que componen la estructura de la institución.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `num_depto` | VARCHAR | 20 | PK, NN | Número o código de identificación del departamento. |
| `nombre` | VARCHAR | 100 | UQ, NN | Nombre oficial de la división académica. |
| `edificio` | VARCHAR | 50 | *Null* | Nombre o clave del edificio donde se ubica la oficina. |

---

### **Tabla:** *PROFESOR*
**Descripción:** Almacena los datos de identificación del personal docente adscrito a la institución.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `id_profesor` | VARCHAR | 20 | PK, NN | Clave única o número de nómina del profesor. |
| `pila_nombre` | VARCHAR | 50 | NN | Nombre o nombres propios del profesor. |
| `apellido_paterno`| VARCHAR | 50 | NN | Apellido paterno del docente. |
| `apellido_materno`| VARCHAR | 50 | *Null* | Apellido materno del docente. |
| `num_depto` | VARCHAR | 20 | FK, NN | Departamento al que pertenece el profesor (PERTENECE). |

---

### **Tabla:** *PROYECTO*
**Descripción:** Catálogo de proyectos de investigación o desarrollo institucional financiados.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `num_proyecto` | VARCHAR | 20 | PK, NN | Número o código de control del proyecto. |
| `nombre_proyecto`| VARCHAR | 100 | UQ, NN | Título oficial del proyecto de investigación. |
| `presupuesto` | DECIMAL(12,2)| - | *Null* | Fondo económico asignado para el desarrollo del proyecto. |

---

### **Tabla:** *PARTICIPA*
**Descripción:** Tabla intermedia (N:M) que gestiona la asignación de profesores a proyectos, indicando su rol y fechas de estancia.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `id_profesor` | VARCHAR | 20 | PK, FK, NN | ID del profesor asignado. |
| `num_proyecto` | VARCHAR | 20 | PK, FK, NN | Número del proyecto en el que colabora. |
| `fecha_inicio` | DATE | - | NN | Fecha de alta del profesor en el proyecto. |
| `rol` | VARCHAR | 50 | NN | Cargo o rol desempeñado (ej. Líder, Colaborador). |

---

### **Tabla:** *DEPENDIENTE*
**Descripción:** Entidad que registra los datos de los familiares a cargo del profesor para la asignación de beneficios.

| Campo | Tipo | Longitud | Restricciones | Descripción |
| :--- | :--- | :--- | :--- | :--- |
| `id_dependiente` | INT | - | PK, AI, NN | ID único autoincrementable del dependiente. |
| `nombre` | VARCHAR | 100 | NN | Nombre completo del familiar. |
| `fecha_nacimiento`| DATE | - | *Null* | Fecha de nacimiento del dependiente. |
| `parentesco` | VARCHAR | 50 | *Null* | Relación familiar (ej. Hijo, Hija, Cónyuge). |
| `id_profesor` | VARCHAR | 20 | FK, NN | ID del profesor de quien depende (DEPENDE). |

---

## 5. Relaciones en la Base de Datos

| Relación | Cardinalidad | Descripción |
| :--- | :---: | :--- |
| ALUMNO -> ALUMNO_TEL | 1:N | Un alumno puede tener registrados varios números telefónicos. |
| ALUMNO -> CREDENCIAL | 1:1 | Un alumno posee una única credencial activa, y la credencial pertenece a un solo alumno. |
| PROFESOR -> MATERIA | 1:N | Un profesor puede impartir múltiples materias en la institución. |
| ALUMNO -> CURSA | 1:N | Un alumno puede cursar e inscribirse en varias materias históricamente. |
| MATERIA -> CURSA | 1:N | Una materia recibe la inscripción de múltiples alumnos concurrentes. |
| DEPTO -> PROFESOR | 1:N | Un departamento académico cobija y agrupa a muchos profesores. |
| PROFESOR -> PARTICIPA | 1:N | Un profesor puede colaborar en múltiples proyectos de investigación. |
| PROYECTO -> PARTICIPA | 1:N | Un proyecto cuenta con la participación de varios docentes. |
| PROFESOR -> DEPENDIENTE | 1:N | Un profesor puede registrar a múltiples familiares directos como beneficiarios. |

---

## 6. Matriz de Claves Foráneas

| Tabla Origen | Campo FK | Tabla Referenciada | Campo PK Referenciado |
| :--- | :--- | :--- | :--- |
| ALUMNO_TEL | `matricula` | ALUMNO | `matricula` |
| CREDENCIAL | `matricula` | ALUMNO | `matricula` |
| MATERIA | `id_profesor` | PROFESOR | `id_profesor` |
| CURSA | `matricula` | ALUMNO | `matricula` |
| CURSA | `clave_materia` | MATERIA | `clave_materia` |
| PROFESOR | `num_depto` | DEPTO | `num_depto` |
| PARTICIPA | `id_profesor` | PROFESOR | `id_profesor` |
| PARTICIPA | `num_proyecto` | PROYECTO | `num_proyecto` |
| DEPENDIENTE | `id_profesor` | PROFESOR | `id_profesor` |

---

## 7. Mecanismos de Integridad Referencial

Para asegurar la coherencia estricta de la información académica y evitar la existencia de datos huérfanos, el motor de SQL Server aplicará de manera automatizada las siguientes reglas transaccionales:

### 1. Relación Estudiante (`ALUMNO` -> `ALUMNO_TEL` / `ALUMNO` -> `CREDENCIAL`)
* **ON UPDATE CASCADE:** Si la matrícula de un alumno se modifica o corrige en la tabla madre, el cambio se replicará de inmediato en sus registros telefónicos y en su folio de credencial.
* **ON DELETE CASCADE:** Al dar de baja a un alumno de la institución, sus registros telefónicos en `ALUMNO_TEL` y su asignación en `CREDENCIAL` se eliminarán automáticamente en cascada para evitar registros huérfanos obsoletos.

### 2. Relación de Cursos e Inscripciones (`ALUMNO` -> `CURSA` / `MATERIA` -> `CURSA`)
* **ON UPDATE CASCADE:** Cualquier corrección en la matrícula del alumno o en la clave de la materia se actualizará de forma transparente en el histórico de actas de la tabla `CURSA`.
* **ON DELETE RESTRICT / NO ACTION:** Se bloqueará el intento de borrar un alumno o una materia si existen registros de inscripción asociados en la tabla `CURSA`. Esto protege el historial y kárdex legal de evaluaciones de la institución académica.

### 3. Relación Docente y Académica (`DEPTO` -> `PROFESOR` / `PROFESOR` -> `MATERIA`)
* **ON UPDATE CASCADE:** Si se modifican las claves identificadoras de los departamentos o de las nóminas de profesores, las referencias en cascada mantendrán las materias y adscripciones bien vinculadas.
* **ON DELETE RESTRICT:** No se autoriza la eliminación de un departamento si tiene profesores adscritos, ni se permite borrar a un profesor si este tiene materias asignadas como titular en la tabla `MATERIA`. Primero se debe reubicar al personal docente o reasignar las asignaturas.

### 4. Relación de Investigación y Beneficios (`PROFESOR` -> `PARTICIPA` / `PROYECTO` -> `PARTICIPA` / `PROFESOR` -> `DEPENDIENTE`)
* **ON UPDATE CASCADE:** Sincronización inmediata ante correcciones de claves en las nóminas docentes o códigos