-- #####################
-- ### DIA # 3 -  GESTION DE DATOS E INSERCIONES ###
-- #####################

Create database dia3;

use dia3;

-- tabla gama producto

create table gama_producto(
	gama varchar(50)not null primary key,
	descripcion_texto text,
	descripcion_html text,
	imagen varchar(256)
);

-- tabla producto

create table producto(
    codigo_producto varchar(15)primary key,
    nombre varchar(70) not null,
    gama varchar(50) not null,
    dimensiones varchar(25),
    proveedor varchar(50),
    descripcion text,
    cantidad_en_stock smallint(6) not null,
    precio_venta decimal(15,2) not null,
    precio_proveedor decimal(15,2),
    foreign key (gama) references gama_producto(gama)
);


-- tabla detalle pedido

create table detalle_pedido(
    codigo_pedido int(11) primary key,
    codigo_producto varchar(15),
    cantidad int(11) not null,
    precio_unidad decimal(15,2),
    numero_linea smallint(5),
    foreign key (codigo_pedido) references pedido(codigo_pedido),
    foreign key (codigo_producto) references producto(codigo_producto)
);

-- tabla cliente

create table cliente(
	codigo_cliente int(11) primary key,
	nombre_cliente varchar(50)not null,
	nombre_contacto varchar(30),
	apellido_contacto varchar(30),
	telefono varchar(15) not null,
	fax varchar (15) not null,
	linea_direccion1 varchar(50) not null,
	linea_direccion2 varchar(50),
	ciudad varchar(50) not null,
	region varchar(50),
	pais varchar(50),
	codigo_postal varchar(10),
	codigo_empleado_rep_ventas int(11),
	limite_credito decimal(15,2),
    foreign key (codigo_empleado_rep_ventas) references empleado(codigo_empleado)
);

-- tabla empleado

create table empleado(
	codigo_empleado int(11) primary key not null,
    nombre varchar(50) not null,
    apellido1 varchar(50) not null,
    apellido2 varchar(10),
    extension varchar(10) not null,
    email varchar(100) not null,
    codigo_oficina varchar(10) not null,
    codigo_jefe int(11),
    puesto varchar(50),
    foreign key (codigo_oficina) references oficina(codigo_oficina)
); 

-- tabla oficina

create table oficina(
	codigo_oficina varchar(10) not null primary key,
    ciudad varchar(30) not null,
    pais varchar(50) not null,
    region varchar(50),
    codigo_postal varchar(10) not null,
    telefono varchar(20),
    linea_direccion1 varchar(50) not null,
    linea_direccion2 varchar(50)
);

-- tabla pago

create table pago(
	codigo_cliente int(11) primary key ,
	forma_pago varchar(40),
	id_transanccio varchar(50) not null,
	fecha_pago date,
	total decimal(15,2),
    foreign key (codigo_cliente) references cliente(codigo_cliente)
);

-- tabla pedido

create table pedido(
	codigo_pedido int(11)primary key,
    fecha_pedido date not null,
    fehca_esperada date not null,
    fecha_entrega date,
    estado varchar(15) not null,
    comentarios text,
    codigo_cliente int(11) not null,
    foreign key(codigo_cliente) references cliente(codigo_cliente)
);

show tables;

-- Desarrollado por Andres Perez / ID.1065593359