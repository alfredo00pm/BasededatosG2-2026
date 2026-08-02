CREATE DATABASE company;
USE company;

CREATE TABLE departments (
    id_number_departments INT NOT NULL
    CONSTRAINT pk_id_number_departments
    PRIMARY KEY (id_number_departments),
    names VARCHAR(50) NOT NULL
    CONSTRAINT uq_names
    UNIQUE (names),
    manager_start_date DATETIME2 NOT NULL
    CONSTRAINT df_manager_start_date
    DEFAULT SYSDATETIME(),
    manager INT NOT NULL
);
GO

CREATE TABLE employees(
    id_employees INT NOT NULL IDENTITY(1,1)
    CONSTRAINT pk_id_employees
    PRIMARY KEY (id_employees), 
    nss INT NOT NULL 
    CONSTRAINT uq_nss
    UNIQUE (nss),
    names VARCHAR(45) NOT NULL,
    address VARCHAR(100),
    salary DECIMAL(10,2),
    sex CHAR(1) ,
    birth DATE NOT NULL,
    id_number_departments INT NOT NULL,
    id_supervisor INT,
    CONSTRAINT fk_employees_employees
    FOREIGN KEY (id_supervisor)
    REFERENCES employees(id_employees)
);
GO

ALTER TABLE employees
ADD CONSTRAINT fk_employees_departments
FOREIGN KEY (id_number_departments)
REFERENCES departments(id_number_departments);

ALTER TABLE departments
ADD CONSTRAINT fk_departments_employees
FOREIGN KEY (manager)
REFERENCES employees(id_employees);



CREATE TABLE projects(
    id_number_projects INT NOT NULL
    CONSTRAINT pk_id_number_projects
    PRIMARY KEY (id_number_projects),
    names VARCHAR(45) NOT NULL
    CONSTRAINT uq_name
    UNIQUE (names),
    id_number_departments INT NOT NULL
);
GO

ALTER TABLE projects 
ADD CONSTRAINT fk_projects_departaments
FOREIGN KEY (id_number_departments)
REFERENCES departments(id_number_departments);



 CREATE TABLE locations(
     id_location INT NOT NULL,
     CONSTRAINT pk_id_location
     PRIMARY KEY (id_location),
     name_location VARCHAR(100) NOT NULL,
     id_number_departments INT NOT NULL,
     CONSTRAINT fk_location_departments
     FOREIGN KEY (id_number_departments)
     REFERENCES departments(id_number_departments)
 );
 GO

 CREATE TABLE works_on(
    id_employees INT NOT NULL,
    id_number_projects INT NOT NULL,
    CONSTRAINT pk_id_employees_id_number_projects
    PRIMARY KEY (id_employees, id_number_projects),
    horas INT NOT NULL
 );
 GO

 ALTER TABLE works_on
 ADD CONSTRAINT fk_works_on_employees
 FOREIGN KEY (id_employees)
 REFERENCES employees(id_employees);

 ALTER TABLE works_on
 ADD CONSTRAINT fk_works_on_projects
 FOREIGN KEY (id_number_projects)
 REFERENCES projects(id_number_projects);



CREATE TABLE dependents(
    id_dependents INT NOT NULL IDENTITY(1,1)
    CONSTRAINT pk_id_dependents
    PRIMARY KEY (id_dependents),
    names VARCHAR(45) NOT NULL,
    sex CHAR(1), 
    birthdate DATE NOT NULL,
    relationship_employee VARCHAR(45),
    id_employees INT NOT NULL 
);
GO


ALTER TABLE dependents
ADD CONSTRAINT fk_dependents_employees
FOREIGN KEY (id_employees)
REFERENCES employees(id_employees);