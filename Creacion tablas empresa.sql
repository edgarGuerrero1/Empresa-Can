-- ================================================================================================================
-- ==NOMBRE             : Creacion de tablas Empresa    														
-- ==AUTOR				: Edgar guerrero																						
-- ==FECHA CREACION		: 12/9/2019																									
-- ==DESARROLLO			: EmpresaCan																	
-- ==MODULO				: 																											
-- ==DESCRIPCION		: Creacion de tablas para Empresa, administracion de proyectos, empleados, pedidos, Horarios
-- ==EJEMPLO			: datosPersonaE	
-- ================================================================================================================

Create table ConstructoraE(
	id_constructora int identity(1,1),
	nombre varchar(30),
	direccion varchar(100),
	telefono varchar(12),
	primary key(id_constructora)
)
select * from ConstructoraE
drop table ConstructoraE
truncate table ConstructoraE

--======================================================================================
Create table DatosEmpleadoE (
	id_empleado int identity(1,1),
	nombre varchar(30) not null,
	apellidoP varchar(30) not null,
	apellidoM varchar(30),
	edad int,
	direccion varchar(100) not null,
	sexo varchar(1),
	nacionalidad varchar(30) not null,
	telefono int not null,
	puesto varchar(30)
	primary key(id_empleado)
)
select * from DatosEmpleadoE
drop table DatosEmpleadoE
truncate table DatosEmpleadoE

--======================================================================================
--creamos el vinculo de empleado con empresa
create table EmpleadosE (
	id_empleado int not null, 
	id_constructora int not null,
	CONSTRAINT FK_EmpleadosE_id_costructora FOREIGN KEY (id_constructora) REFERENCES ConstructoraE (id_constructora),
	CONSTRAINT FK_EmpleadoE_id_empleado FOREIGN KEY (id_empleado) REFERENCES DatosEmpleadoE (id_empleado)
)
select * from EmpleadosE
drop table EmpleadosE
truncate table EmpleadosE

--======================================================================================
Create table TutorE (
	nombre varchar(30) not null,
	direccion varchar(100),
	telefono int not null,
	id_empleado int not null,
	CONSTRAINT FK_TutorE_id_empleado FOREIGN KEY (id_empleado) REFERENCES DatosEmpleadoE (id_empleado)
)
select * from TutorE
drop table TutorE
truncate table TutorE
--======================================================================================

Create table HorarioE(
	entrada datetime,
	salida datetime,
	id_empleado int not null,
	CONSTRAINT FK_HorarioE_id_empleado FOREIGN KEY (id_empleado) REFERENCES DatosEmpleadoE (id_empleado)
)
select * from HorarioE
drop table HorarioE
truncate table HorarioE

--======================================================================================
Create table ProyectoE (
	id_proyecto int identity(1,1) not null,
	--id_encargado sera = id_empleado
	id_encargado int,
	fecha_inicio date ,
	fecha_termino date,
	costo int,
	primary key (id_proyecto),
	CONSTRAINT FK_ProyectoE_id_encargado FOREIGN KEY (id_encargado) REFERENCES DatosEmpleadoE (id_empleado)
)

alter table  ProyectoE drop CONSTRAINT FK_ProyectoE_id_encargado
select * from ProyectoE
drop table ProyectoE
truncate table ProyectoE

--======================================================================================
Create table PedidosE (
	id_pedido int identity(1,1) not null,
	descripcion varchar(100),
	cantidad varchar(100),
	fecha_pedido datetime not null,
	id_proyecto int not null,
	id_empleado int not null,
	primary key (id_pedido),
	CONSTRAINT FK_PedidosE_id_proyecto FOREIGN KEY (id_proyecto) REFERENCES ProyectoE (id_proyecto),
	CONSTRAINT FK_PedidosE_id_encargado FOREIGN KEY (id_empleado) REFERENCES DatosEmpleadoE (id_empleado)
)
alter table  PedidosE drop CONSTRAINT FK_PedidosE_id_proyecto
alter table  PedidosE drop CONSTRAINT FK_PedidosE_id_encargado

select * from PedidosE
drop table PedidosE
truncate table PedidosE
--======================================================================================
create table CostoPedidoE(
	id_pedido int identity(1,1) not null,
	Costo float,
	Autorizacion_empleado int,
	id_solicitante int,
	CONSTRAINT FK_CostoPedidoE_id_solicitante FOREIGN KEY (id_solicitante) REFERENCES DatosEmpleadoE (id_empleado)
)

	alter table  CostoPedidoE drop CONSTRAINT FK_CostoPedidoE_id_solicitante 
	alter table  CostoPedidoE drop CONSTRAINT FK_CostoPedidoE_id_pedido 

select * from CostoPedidoE
drop table CostoPedidoE
truncate table CostoPedidoE
--======================================================================================
