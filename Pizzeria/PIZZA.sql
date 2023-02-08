CREATE DATABASE IF NOT EXISTS pizzeriaV2;

USE pizzeriaV2;

CREATE TABLE IF NOT EXISTS
    provincia (
        id_provincia INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
        nombre VARCHAR(45)
    )
    ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS
    categoria (
        id_categoria INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
        nombre VARCHAR(45)
    )
    ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS
    localidad (
        id_localidad INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
        nombre VARCHAR(45),
        id_provincia INT UNSIGNED,
        FOREIGN KEY (id_provincia) REFERENCES provincia (id_provincia)
    )
    ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS
    cliente (
        id_cliente INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
        nombre VARCHAR(60),
        apellidos VARCHAR(60),
        direccion VARCHAR(100),
        c_postal INT,
        id_localidad INT UNSIGNED,
        telefono VARCHAR(45),
        FOREIGN KEY (id_localidad) REFERENCES localidad (id_localidad)
    )
    ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS
    productos (
        id_producto INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
        tipo ENUM (
            'pizza',
            'hamburguesa',
            'bebida'
        ),
        nombre VARCHAR(45),
        descripcion VARCHAR(300),
        imagen BLOB,
        precio FLOAT(6),
        categoria INT UNSIGNED,
        FOREIGN KEY (categoria) REFERENCES categoria (id_categoria)
    )
    ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS
    tienda (
        id_tienda INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
        direccion VARCHAR(60),
        c_postal INT,
        id_localidad INT UNSIGNED,
        FOREIGN KEY (id_localidad) REFERENCES localidad (id_localidad)
    )
    ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS
    empleados (
        id_empleado INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
        nombre VARCHAR(45),
        apellidos VARCHAR(100),
        NIF VARCHAR(45),
        telefono VARCHAR(30),
        rol ENUM('repartidor', 'cocinero'),
        id_tienda INT UNSIGNED,
        FOREIGN KEY (id_tienda) REFERENCES tienda (id_tienda)
    )
    ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS
    direccion_pedido (
        id_domicilio INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
        id_repartidor INT UNSIGNED,
        data DATETIME,
        FOREIGN KEY (id_repartidor) REFERENCES empleados (id_empleado)
    )
    ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS
    pedidos (
        id_pedido INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
        data DATETIME,
        tipo ENUM('domicilio', 'tienda'),
        precio FLOAT(4),
        id_cliente INT UNSIGNED,
        id_domicilio INT UNSIGNED,
        id_tienda INT UNSIGNED,
        id_empleado INT UNSIGNED,
        FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente),
        FOREIGN KEY (id_domicilio) REFERENCES direccion_pedido (id_domicilio),
        FOREIGN KEY (id_tienda) REFERENCES tienda (id_tienda),
        FOREIGN KEY (id_empleado) REFERENCES empleados (id_empleado)
    )
    ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS
    producto_pedido (
        id_producto_pedido INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
        id_producto INT UNSIGNED,
        cantidad INT,
        id_pedido INT UNSIGNED,
        FOREIGN KEY (id_producto) REFERENCES productos (id_producto),
        FOREIGN KEY (id_pedido) REFERENCES pedidos (id_pedido)
    )
    ENGINE = InnoDB;

INSERT INTO provincia (nombre) VALUES ('Albacete');
INSERT INTO provincia (nombre) VALUES ('Barcelona');

INSERT INTO categoria (nombre) VALUES ('vegana');
INSERT INTO categoria (nombre) VALUES ('blanca');
INSERT INTO categoria (nombre) VALUES ('sin gluten');

INSERT INTO localidad (nombre, id_provincia) VALUES ('Barcelona', 1);
INSERT INTO localidad (nombre, id_provincia) VALUES ('Tarragona', 2);


INSERT INTO cliente (nombre, apellidos, direccion, c_postal, id_localidad, telefono) VALUES ('Laura', 'Gutiérrez', 'Calle ficticia, nº 95', '08940', 1, '123456789');
INSERT INTO cliente (nombre, apellidos, direccion, c_postal, id_localidad, telefono) VALUES ('Eric', 'Nicolau', 'Avenida de asdf', '45247', 6, '87654321');


INSERT INTO productos (tipo, nombre, descripcion, precio, categoria) VALUES ('bebida', 'cerveza', 'ipa artesanal', 3.75, 1);
INSERT INTO productos (tipo, nombre, descripcion, precio, categoria) VALUES ('pizza', 'cuatro estaciones', 'pizza con champiñones, 3 quesos, pollo, espinacas' , 12.00, 1);
INSERT INTO productos (tipo, nombre, descripcion, precio) VALUES ('hamburguesa', 'vegana', 'beyond meat con tomate deshidratado, rúcula, queso vegano', 13.00);


INSERT INTO tienda (direccion, c_postal, id_localidad) VALUES ('Sant Pere Màrtir, 39', '08012', 1);
INSERT INTO tienda (direccion, c_postal, id_localidad) VALUES ('Nou de la Rambla, 150', '08004', 2);


INSERT INTO empleados (nombre, apellidos, NIF, telefono, rol, id_tienda) VALUES ('Omar', 'Olmedo', '44618699d', '777555588', 'repartidor', 1);
INSERT INTO empleados (nombre, apellidos, NIF, telefono, rol, id_tienda) VALUES ('Saul', 'Goodman', 'X847472891', '607977977', 'cocinero', 2);


INSERT INTO pedidos (tipo, precio, id_cliente, id_tienda, id_empleado) VALUES ('tienda', 40.15, 1, 1, 1);
INSERT INTO pedidos (tipo, precio, id_cliente, id_tienda, id_empleado) VALUES ('domicilio', 26.50, 2, 2, 2);
INSERT INTO producto_pedido (id_producto, cantidad, id_pedido) VALUES (1, 2, 1);
INSERT INTO producto_pedido (id_producto, cantidad, id_pedido) VALUES (2, 1, 1);
INSERT INTO producto_pedido (id_producto, cantidad, id_pedido) VALUES (3, 1, 1);

-- Prova 1: Llista quants productes del tipus 'begudes' s'han venut en una determinada localitat --

SELECT p.nombre, pd.cantidad FROM producto_pedido pd INNER JOIN productos p ON pd.id_producto_pedido = p.id_producto
INNER JOIN pedidos c ON c.id_pedido = p.id_producto
INNER JOIN localidad l ON l.id_localidad = p.id_producto WHERE p.tipo = 'pizza' AND l.nombre = 'Tarragona';

-- Prova 2: Llista quantes comandes ha efectuat un determinat empleat --

SELECT e.nombre, COUNT(c.id_pedido) AS Pedidos FROM pedidos c INNER JOIN empleados e ON c.id_empleados = e.id_empleado WHERE e.nombre = 'Saul';
INSERT INTO cliente (nombre, apellidos, direccion, c_postal, id_localidad, telefono) VALUES ('Laura', 'Gutiérrez', 'Calle ficticia, nº 95', '08940', 1, '123456789');
INSERT INTO cliente (nombre, apellidos, direccion, c_postal, id_localidad, telefono) VALUES ('Laura', 'Gutiérrez', 'Calle ficticia, nº 95', '08940', 1, '123456789')
