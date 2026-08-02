CREATE DATABASE company2;
USE company2;

CREATE TABLE department(
    number_department INT NOT NULL
    CONSTRAINT pk_number_department
    PRIMARY KEY(number_department),
    manager INT NOT NULL,
    name VARCHAR(50) NOT NULL
    CONSTRAINT uq_department_name
    UNIQUE(name),
    start_date DATE NOT NULL
);

CREATE TABLE employee(
    num_employee INT NOT NULL IDENTITY(1,1)
    CONSTRAINT pk_num_employee
    PRIMARY KEY(num_employee),
    ssn VARCHAR(20) NOT NULL
    CONSTRAINT uq_ssn
    UNIQUE(ssn),
    first_name VARCHAR(45) NOT NULL,
    last_name VARCHAR(45) NOT NULL,
    bdate DATE NOT NULL,
    address VARCHAR(100),
    salary DECIMAL(10,2),
    sex CHAR(1),
    number_department INT NOT NULL,
    boss INT,
    CONSTRAINT fk_employee_employee
    FOREIGN KEY(boss)
    REFERENCES employee(num_employee)
);

ALTER TABLE employee
ADD CONSTRAINT fk_employee_department
FOREIGN KEY(number_department)
REFERENCES department(number_department);

ALTER TABLE department
ADD CONSTRAINT fk_department_manager
FOREIGN KEY(manager)
REFERENCES employee(num_employee);

CREATE TABLE project(
    number_project INT NOT NULL
    CONSTRAINT pk_number_project
    PRIMARY KEY(number_project),
    number_department INT NOT NULL,
    location VARCHAR(100) NOT NULL
);

ALTER TABLE project
ADD CONSTRAINT fk_project_department
FOREIGN KEY(number_department)
REFERENCES department(number_department);

CREATE TABLE location(
    num_location INT NOT NULL
    CONSTRAINT pk_num_location
    PRIMARY KEY(num_location),
    number_department INT NOT NULL,
    location VARCHAR(100) NOT NULL
);

ALTER TABLE location
ADD CONSTRAINT fk_location_department
FOREIGN KEY(number_department)
REFERENCES department(number_department);

CREATE TABLE works_on(
    num_employee INT NOT NULL,
    number_project INT NOT NULL,
    hours INT NOT NULL,
    CONSTRAINT pk_works_on
    PRIMARY KEY(num_employee, number_project)
);

ALTER TABLE works_on
ADD CONSTRAINT fk_works_on_employee
FOREIGN KEY(num_employee)
REFERENCES employee(num_employee);

ALTER TABLE works_on
ADD CONSTRAINT fk_works_on_project
FOREIGN KEY(number_project)
REFERENCES project(number_project);

CREATE TABLE dependent(
    num_dependent INT NOT NULL IDENTITY(1,1)
    CONSTRAINT pk_num_dependent
    PRIMARY KEY(num_dependent),
    num_employee INT NOT NULL,
    name VARCHAR(45) NOT NULL,
    birthdate DATE NOT NULL,
    relationship VARCHAR(45),
    CONSTRAINT fk_dependent_employee
    FOREIGN KEY(num_employee)
    REFERENCES employee(num_employee)
);