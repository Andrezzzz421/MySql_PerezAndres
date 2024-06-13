-- #####################
-- ###    DIA # 4-RELACIONAMIENTO DE CONSULTAS   ###
-- #####################

create database dia4;

use dia4;

create table pais(
	id int primary key not null,
    nombre varchar(20),
    continente varchar(50),
    poblacion int
);

create table ciudad(
	id int primary key not null,
    nombre varchar(20),
    id_pais int,
    foreign key (id_pais) references pais(id)
);

create table idioma_pais(
	id_idioma int,
    id_pais int,
    es_oficial tinyint(1),
    primary key(id_idioma, id_pais),
    foreign key (id_pais) references pais(id),
	foreign key (id_idioma) references idioma(id)
);

create table idioma(
	id int primary key not null,
    idioma varchar(50)
);

INSERT INTO pais (id, nombre, continente, poblacion) VALUES 
(1, 'España', 'Europa', 47000000),
(2, 'México', 'América', 126000000),
(3, 'Japón', 'Asia', 126300000);

INSERT INTO ciudad (id, nombre, id_pais) VALUES 
(1, 'Madrid', 1),
(2, 'Barcelona', 1),
(3, 'Ciudad de México', 2),
(4, 'Guadalajara', 2),
(5, 'Tokio', 3),
(6, 'Osaka', 3);

INSERT INTO idioma (id, idioma) VALUES 
(1, 'Español'),
(2, 'Catalán'),
(3, 'Inglés'),
(4, 'Japonés');


INSERT INTO idioma_pais (id_idioma, id_pais, es_oficial) VALUES 
(1, 1, 1), -- Español es oficial en España
(2, 1, 1), -- Catalán es oficial en España
(1, 2, 1), -- Español es oficial en México
(4, 3, 1), -- Japonés es oficial en Japón
(3, 1, 0), -- Inglés no es oficial en España
(3, 2, 0), -- Inglés no es oficial en México
(3, 3, 0); -- Inglés no es oficial en Japón

-- Listar todos los pare sde nombres de paises y sus 
-- ciudades correspondientes que estan relacionadas
-- en la base de datos(INNER JOIN)

