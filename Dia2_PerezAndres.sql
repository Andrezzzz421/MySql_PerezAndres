create database dia2;

-- Utilizar BBDD dia2

use dia2;

-- Crear tabla departamento
create table departamento (
    id int auto_increment primary key,
    nombre varchar(50) not null
);

-- Crear tabla persona
create table persona(
    id int auto_increment primary key,
    nif varchar(9),
    nombre varchar(25) not null,
    apellido1 varchar(50) not null,
    apellido2 varchar (50),
    ciudad varchar(25) not null,
    direccion varchar(50) not null,
    telefono varchar(9),
    fecha_nacimiento DATE not null,
    sexo enum('H','M') not null,
    tipo enum('profesor','alumno') not null
);

-- Crear la tabla de profesor
create table profesor(
    id_profesor int primary key,
    id_departamento int not null,
    foreign key (id_profesor) references persona(id),
    foreign key (id_departamento) references departamento(id)
);

-- Crear la tabla grado

create table grado(
	id int  auto_increment primary key,
	nombre varchar(100) not null
);

-- Crear la tabla asignatura
create table asignatura(
    id int auto_increment primary key,
    nombre varchar(100) not null,
    creditos float not null,
    tipo enum('Basica','Obligatoria','Optativa'),
    curso tinyint(3),
    cuatrimestres tinyint(3),
    id_profesor int, 
    id_grado int,    
    foreign key(id_profesor) references profesor(id_profesor),
    foreign key(id_grado) references grado(id) 
);

-- Crear tabla curso escolar

create table curso_escolar(
	id int auto_increment primary key,
    anyo_inicio year(4),
    anyo_fin year(4)

);

-- Crear tabla alumno_se_matricula_asignatura
create table alumno_se_matricula_asignatura(
    id_alumno int primary key,
    id_asignatura int primary key, 
    id_curso int primary key,
    foreign key(id_alumno) references persona(id),
    foreign key(id_asignatura) references asignatura(id),
    foreign key(id_curso) references curso_escolar(id)
);
show tables;

-- Desarrollado por Andres Perez / ID.1065593359
