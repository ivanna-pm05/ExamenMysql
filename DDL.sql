CREATE DATABASE sakilacampus;
USE sakilacampus;

CREATE TABLE IF NOT EXISTS pais(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    ultima_actualizacion TIMESTAMP
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS ciudad(
    id INT AUTO_INCREMENT PRIMARY KEY,
    pais_id INT,
    ultima_actualizacion TIMESTAMP,
    CONSTRAINT FK_paisid FOREIGN KEY (pais_id) REFERENCES pais(id)
) ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS direccion(
    id INT AUTO_INCREMENT PRIMARY KEY,
    direccion VARCHAR(50),
    direccion2 VARCHAR(50),
    distrito VARCHAR(20),
    ciudad_id INT,
    codigo_postal VARCHAR(10),
    telefono VARCHAR(20),
    ultima_actualizacion TIMESTAMP,
    CONSTRAINT FK_ciudadid FOREIGN KEY (ciudad_id) REFERENCES ciudad(id)
) ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS actor(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(45),
    apellidos VARCHAR(45),
    ultima_actualizacion TIMESTAMP
) ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS categoria(
    id INT AUTO_INCREMENT PRIMARY KEY,
    ultima_actualizacion TIMESTAMP
) ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS idioma(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre CHAR(20),
    ultima_actualizacion TIMESTAMP
) ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS film_text(
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(225),
    description TEXT
) ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS pelicula(
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255),
    description TEXT,
    anyo_lanzamiento YEAR,
    idioma_id INT,
    duracion_alquiler INT,
    rental_rate DECIMAL(10, 2),
    duracion INT,
    replacement_cost DECIMAL(10, 2),
    ultima_actualizacion TIMESTAMP,
    CONSTRAINT FK_idiomaid FOREIGN KEY(idioma_id) REFERENCES idioma(id)
) ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS pelicula_actor(
    actor_id INT,
    pelicula_id INT,
    ultima_actualizacion TIMESTAMP,
    CONSTRAINT FK_actorid FOREIGN KEY(actor_id) REFERENCES actor(id),
    CONSTRAINT FK_peliculaid FOREIGN KEY(pelicula_id) REFERENCES pelicula(id)
) ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS pelicula_categoria(
    pelicula_id INT,
    categoria_id INT,
    ultima_actualizacion TIMESTAMP,
    CONSTRAINT FK_peliculid FOREIGN KEY(pelicula_id) REFERENCES pelicula(id),
    CONSTRAINT FK_categoriaid FOREIGN KEY(categoria_id) REFERENCES categoria(id)
) ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS empleado_jefe(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(45),
    apellidos VARCHAR(45),
    description TEXT
) ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS almacen(
    id INT AUTO_INCREMENT PRIMARY KEY,
    empleado_jefe_id INT,
    direccion_id INT,
    ultima_actualizacion TIMESTAMP,
    CONSTRAINT FK_empleadojefeid FOREIGN KEY (empleado_jefe_id) REFERENCES empleado_jefe(id),
    CONSTRAINT FK_direccioid FOREIGN KEY(direccion_id) REFERENCES direccion(id)
) ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS empleado(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(45),
    apellidos VARCHAR(45),
    direccion_id INT,
    imagen BLOB,
    email VARCHAR(50),
    almacen_id INT,
    activo INT,
    username VARCHAR(16),
    password VARCHAR(40),
    ultima_actualizacion TIMESTAMP,
    CONSTRAINT FK_direccionid FOREIGN KEY(direccion_id) REFERENCES direccion(id),
    CONSTRAINT FK_almacemid FOREIGN KEY(almacen_id) REFERENCES almacen(id)
) ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS cliente(
    id INT AUTO_INCREMENT PRIMARY KEY,
    almacen_id INT,
    nombre VARCHAR(45),
    apellidos VARCHAR(45),
    email VARCHAR(50),
    direccion_id INT,
    activo BOOLEAN,
    fecha_creacion DATETIME,
    ultima_actualizacion TIMESTAMP,
    CONSTRAINT FK_almaceid FOREIGN KEY (almacen_id) REFERENCES almacen(id),
    CONSTRAINT FK_direcciid FOREIGN KEY(direccion_id) REFERENCES direccion(id)
) ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS inventario(
    id INT AUTO_INCREMENT PRIMARY KEY,
    pelicula_id INT,
    almacen_id INT,
    ultima_actualizacion TIMESTAMP,
    CONSTRAINT FK_peliclaid FOREIGN KEY(pelicula_id) REFERENCES pelicula(id),
    CONSTRAINT FK_almacid FOREIGN KEY(almacen_id) REFERENCES almacen(id)
) ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS alquiler(
    id INT AUTO_INCREMENT PRIMARY KEY,
    fecha_alquiler DATETIME,
    inventario_id INT,
    cliente_id INT,
    fecha_devalucion DATETIME,
    empleado_id INT,
    ultima_actualizacion TIMESTAMP,
    CONSTRAINT FK_inventarioid FOREIGN KEY(inventario_id) REFERENCES inventario(id),
    CONSTRAINT FK_clienteid FOREIGN KEY(cliente_id) REFERENCES cliente(id),
    CONSTRAINT FK_empleadoid FOREIGN KEY(empleado_id) REFERENCES empleado(id)
) ENGINE = INNODB;

CREATE TABLE IF NOT EXISTS pago(
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    empleado_id INT,
    alquiler_id INT,
    total DECIMAL(5, 2),
    fecha_pago DATETIME,
    ultima_actualizacion TIMESTAMP,
    CONSTRAINT FK_clieteid FOREIGN KEY(cliente_id) REFERENCES cliente(id),
    CONSTRAINT FK_empleid FOREIGN KEY(empleado_id) REFERENCES empleado(id),
    CONSTRAINT FK_alquileid FOREIGN KEY(alquiler_id) REFERENCES alquiler(id)
) ENGINE = INNODB;



