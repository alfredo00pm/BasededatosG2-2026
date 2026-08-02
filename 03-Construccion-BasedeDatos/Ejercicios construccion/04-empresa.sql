CREATE DATABASE empresa;
USE empresa;

CREATE TABLE cliente(
    numero_cliente INT NOT NULL
    CONSTRAINT pk_numero_cliente
    PRIMARY KEY (numero_cliente),
    nombre VARCHAR(45) NOT NULL,
    apellido_paterno VARCHAR(25) NOT NULL,
    apellido_materno VARCHAR(25)
);

CREATE TABLE pedidos(
    numero_pedido INT NOT NULL
    CONSTRAINT pk_numero_pedido
    PRIMARY KEY (numero_pedido),
    fecha_pedido DATE NOT NULL,
    numero_cliente INT NOT NULL
);

CREATE TABLE producto(
    numero_producto INT NOT NULL 
    CONSTRAINT pk_numero_producto
    PRIMARY KEY (numero_producto),
    nombre_producto VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2) NOT NULL
);

CREATE TABLE detalle_pedido(
    id_detalle_pedido INT NOT NULL IDENTITY(1,1)
    CONSTRAINT pk_id_detalle_pedido
    PRIMARY KEY (id_detalle_pedido),
    numero_pedido INT NOT NULL,
    numero_producto INT NOT NULL,
    cantidad INT NOT NULL
    CONSTRAINT ck_cantidad
    CHECK (cantidad > 0),
    precio_venta DECIMAL (10,2) NOT NULL
    CONSTRAINT ck_precio_venta
    CHECK (precio_venta > 0.0)
);

ALTER TABLE pedidos
ADD CONSTRAINT fk_pedidos_clientes
FOREIGN KEY (numero_cliente)
REFERENCES cliente(numero_cliente);

ALTER TABLE detalle_pedido
ADD CONSTRAINT fk_detalle_pedido_pedido
FOREIGN KEY (numero_pedido)
REFERENCES pedidos(numero_pedido);


ALTER TABLE detalle_pedido
ADD CONSTRAINT fk_detalle_pedido_producto
FOREIGN KEY (numero_producto)
REFERENCES producto(numero_producto);
