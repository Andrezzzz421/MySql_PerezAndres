-- #####################
-- ### EJERCICIO # 1 ###
-- #####################
-- Creacion de la base de datos "tienda"
CREATE DATABASE tienda;

-- Usar base de datos "tienda"
uSE tienda;

-- Crear tabla fabricante
create table fabricante(
id int auto_increment primary key,
nombre varchar(100)
);

-- Mostrar tablas
show tables;

-- Crear tabla "producto"
create table producto(
id int auto_increment primary key,
nombre varchar(100),
precio decimal(10,2),
id_fabricante int,
foreign key (id_fabricante) references fabricante(id)
);

-- Desarrollado por Andres Perez / ID.1065593359
