USE comercial_db;
GO


/*==========================================================
TABLA ESTADOS
==========================================================*/

CREATE TABLE estados
(
id_estado INT IDENTITY(1,1) NOT NULL,
nombre VARCHAR(100) NOT NULL,

CONSTRAINT pk_estados
PRIMARY KEY(id_estado)
);
GO


/*==========================================================
TABLA CIUDADES
==========================================================*/

CREATE TABLE ciudades
(
id_ciudad INT IDENTITY(1,1) NOT NULL,
id_estado INT NOT NULL,
nombre VARCHAR(100) NOT NULL,

CONSTRAINT pk_ciudades
PRIMARY KEY(id_ciudad),

CONSTRAINT fk_ciudades_estados
FOREIGN KEY(id_estado)
REFERENCES estados(id_estado)
);
GO


/*==========================================================
TABLA CLIENTES
==========================================================*/

CREATE TABLE clientes
(
id_cliente INT IDENTITY(1,1) NOT NULL,

nombre VARCHAR(60) NOT NULL,
apellido_paterno VARCHAR(50) NOT NULL,
apellido_materno VARCHAR(50),

fecha_nacimiento DATE NULL,

sexo CHAR(1),

telefono VARCHAR(15),

correo VARCHAR(100),

id_ciudad INT NOT NULL,

CONSTRAINT pk_clientes
PRIMARY KEY(id_cliente),

CONSTRAINT fk_clientes_ciudades
FOREIGN KEY(id_ciudad)
REFERENCES ciudades(id_ciudad)
);
GO


/*==========================================================
TABLA DEPARTAMENTOS
==========================================================*/

CREATE TABLE departamentos
(
id_departamento INT IDENTITY(1,1) NOT NULL,

nombre VARCHAR(100) NOT NULL,

CONSTRAINT pk_departamentos
PRIMARY KEY(id_departamento)
);
GO


/*==========================================================
TABLA EMPLEADOS
==========================================================*/

CREATE TABLE empleados
(
id_empleado INT IDENTITY(1,1) NOT NULL,

nombre VARCHAR(60) NOT NULL,

apellido_paterno VARCHAR(50) NOT NULL,

apellido_materno VARCHAR(50),

fecha_ingreso DATE NOT NULL,

salario DECIMAL(10,2) NOT NULL,

id_departamento INT NOT NULL,

id_jefe INT NULL,


CONSTRAINT pk_empleados
PRIMARY KEY(id_empleado),

CONSTRAINT fk_empleados_departamentos
FOREIGN KEY(id_departamento)
REFERENCES departamentos(id_departamento),

CONSTRAINT fk_empleados_jefe
FOREIGN KEY(id_jefe)
REFERENCES empleados(id_empleado)
);
GO


/*==========================================================
TABLA CATEGORIAS
==========================================================*/

CREATE TABLE categorias
(
id_categoria INT IDENTITY(1,1) NOT NULL,

nombre VARCHAR(100) NOT NULL,

CONSTRAINT pk_categorias
PRIMARY KEY(id_categoria)
);
GO


/*==========================================================
TABLA PROVEEDORES
==========================================================*/

CREATE TABLE proveedores
(
id_proveedor INT IDENTITY(1,1) NOT NULL,

empresa VARCHAR(100) NOT NULL,

contacto VARCHAR(100),

telefono VARCHAR(15),

correo VARCHAR(100),

id_ciudad INT NOT NULL,


CONSTRAINT pk_proveedores
PRIMARY KEY(id_proveedor),

CONSTRAINT fk_proveedores_ciudades
FOREIGN KEY(id_ciudad)
REFERENCES ciudades(id_ciudad)
);
GO


/*==========================================================
TABLA PRODUCTOS
==========================================================*/

CREATE TABLE productos
(
id_producto INT IDENTITY(1,1) NOT NULL,

codigo VARCHAR(20) NOT NULL,

nombre VARCHAR(100) NOT NULL,

precio DECIMAL(10,2) NOT NULL,

existencia INT NOT NULL,

id_categoria INT NOT NULL,

id_proveedor INT NOT NULL,


CONSTRAINT pk_productos
PRIMARY KEY(id_producto),


CONSTRAINT fk_productos_categorias
FOREIGN KEY(id_categoria)
REFERENCES categorias(id_categoria),


CONSTRAINT fk_productos_proveedores
FOREIGN KEY(id_proveedor)
REFERENCES proveedores(id_proveedor)
);
GO


/*==========================================================
TABLA VENTAS
==========================================================*/

CREATE TABLE ventas
(
id_venta INT IDENTITY(1,1) NOT NULL,

fecha DATE NOT NULL,

id_cliente INT NOT NULL,

id_empleado INT NOT NULL,


CONSTRAINT pk_ventas
PRIMARY KEY(id_venta),


CONSTRAINT fk_ventas_clientes
FOREIGN KEY(id_cliente)
REFERENCES clientes(id_cliente),


CONSTRAINT fk_ventas_empleados
FOREIGN KEY(id_empleado)
REFERENCES empleados(id_empleado)
);
GO


/*==========================================================
TABLA DETALLE_VENTAS
==========================================================*/

CREATE TABLE detalle_ventas
(
id_detalle_venta INT IDENTITY(1,1) NOT NULL,

id_venta INT NOT NULL,

id_producto INT NOT NULL,

cantidad INT NOT NULL,

precio DECIMAL(10,2) NOT NULL,

descuento DECIMAL(5,2) DEFAULT 0,


CONSTRAINT pk_detalle_ventas
PRIMARY KEY(id_detalle_venta),


CONSTRAINT fk_detalle_ventas_ventas
FOREIGN KEY(id_venta)
REFERENCES ventas(id_venta),


CONSTRAINT fk_detalle_ventas_productos
FOREIGN KEY(id_producto)
REFERENCES productos(id_producto)
);
GO