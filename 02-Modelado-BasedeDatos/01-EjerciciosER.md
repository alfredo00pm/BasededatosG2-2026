# Ejercicios del modelo E-R

## Ejercicio 1.

Un hospital registra informacion de sus pacientes:
> De cada paciente se almacena
- Numero de paciente que lo identifica
- Nombre
- Fecha de nacimiento

> De cada Expendiente medico se almacena:
- Número de expediente
- Fecha de apertura
- Tipo de sangre 

> Reglas del negocio
1. Cada paciente debe tener exactamente un expediente médico
2. Cada expediente medico pertenece a un unico paciente 
3. No puede existir un expediente sin paciente 
4. No puede existir un paciente sin expediente

> Que se debe realizar:

- Identificar las entidades 
- Identificar atributos
- Dibujar las relaciones 
- Determinar la cardinalidad
- Determinar la participación de cada entidad

![Ejercico1](../img/1001562397.jpg)

## Ejercicio 2.
Una universidad administra profesores y cursos 

> De cada profesor se almacena:

- Numero de profesor 
- Nombre 
- Especialidad

> De cada curso **Curso** se almacena:

- Numero de curso 
- Nombre del curso
- Creditos

> Reglas del Negocio
1. Un profesor puede impartir varios cursos 
2. Un curso solo puede ser impartido por un profesor 
3. Puede existir un profesor que actualmente no imparta cursos
4. Todo curso debe estar asignado a un profesor

--- 
![Ejercico2](../img/1001562395.jpg)

## Ejercicio 3.

Una escuela administra alumnos y materias

> De cada **alumno** se almacena:

- Matricula
- Nombre
- Semestre

> De cada **Materia** se almacena:

- Clave de la materia
- Nombre de la materia
- Creditos

> Reglas del negocio

1. Un alumno puede inscribirse en varias materias 
2. Una materia puede tener muchos alumnos inscritos
3. Puede exisitir una materia sin alumnos inscritos
4. Todo alumno debe de estar inscrito en almenos una materia
5. De cada inscripción se desea almacenar: 
    - Fecha de inscripción
    - Calificación Final
    
Nota: a la relacion nombrarla **INSCRIBE**

![Ejercico2](../img/1001562393.jpg)



## Ejercicio 4

Una empresa dedicada a las ventas a por el mayor necesita registrar lo siguiente 

> Para los clientes:
- Numero de cliente
- Nombre (el cual es una persona moral)
> Pedidos
- Numero de pedido
- Fecha de pedido

> Producto:

- Numero de producto
- Nombre
- Precio

> Reglas del negocio

1. Un cliente puede realizar muchos pedidos
2. Cada pedido pertenece a un solo cliente
3. Un pedido contiene varios productos
4. Un producto puede aparecer en muchos pedidos
5. Un pedido debe contener almenos un producto
6. Un producto puede no haber sido vendido
7. El detalle del pedido no existe sin pedido
8. El detalle del pedido no existe sin producto
9. El detalle almacena la cantidad vendida y el precio de venta

![Ejercico4](../img/)


## Ejercicio 5

### Company Database Requirements

> Departments

The company is organized into departments. Each department has:

- A unique name
- A unique number
- A manager (an employee)

Additionally, we store:

- The date when the manager started managing the department
- One or more department locations

---

> Projects

Each department controls a number of projects.

Each project has:

- A unique name
- A unique number
- A single location

---

> Employees

For each employee, we store:

- Name
- Social Security Number (SSN)
- Address
- Salary
- Sex (gender)
- Birth date

Employee relationships and assignments:

- Each employee is assigned to one department
- An employee may work on multiple projects
- Projects worked on do not necessarily belong to the employee's department
- The number of hours worked per week on each project is recorded
- Each employee has a direct supervisor (who is also an employee)

---

> Dependents

For insurance purposes, we keep track of each employee's dependents.

For each dependent, we store:

- First name
- Sex
- Birth date
- Relationship to the employee

![Ejercico5](../img/ER/bd.drawio.png)