-- ================================================================================================================
-- ==NOMBRE             : Creacion de tablas Empresa       													
-- ==AUTOR				: Edgar guerrero																						
-- ==FECHA CREACION		: 13/9/2019																									
-- ==DESARROLLO			: EmpresaCan																	
-- ==MODULO				: 																											
-- ==DESCRIPCION		: joins para EmpresaCan
-- ==EJEMPLO			: execute PedidosProyecto @id_proyecto =1
-- ================================================================================================================

--consultas join
--======================================================================================
--obtener  el detalle de los pedidos que han realizado por proyecto
Create procedure PedidosProyecto
@id_proyecto int
as
begin
	select 
		PR.id_proyecto,
		--PR.id_encargado,
		DE.nombre,
		DE.apellidoP,
		--HE.entrada,
		CE.nombre,
		PE.id_pedido,
		PE.Descripcion,
		PE.fecha_pedido
		--TE.nombre,
		--TE.direccion
	from ProyectoE PR with (nolock)
		join PedidosE PE on PR.id_proyecto = PE.id_proyecto
		join DatosEmpleadoE DE on PR.id_encargado = DE.id_empleado
		--join HorarioE HE on PE.id_proyecto = PE.id_empleado
		join EmpleadosE EE on DE.id_empleado = EE.id_empleado 
		join ConstructoraE CE on EE.id_constructora = CE.id_constructora
		--join TutorE TE on DE.id_empleado = TE.id_empleado
		where PR.id_proyecto =@id_proyecto
end
execute PedidosProyecto @id_proyecto =1

--======================================================================================
--ver todos los pedidos que ha realizado cierto empleado
create procedure PedidosEmpleado
@id_empleado int
as
begin

	select 
		DE.nombre,
		DE.apellidoP,
		PR.id_proyecto,
		PE.id_pedido,
		PE.descripcion,
		PE.fecha_pedido
	from DatosEmpleadoE DE
		join ProyectoE PR on PR.id_encargado = DE.id_empleado
		join PedidosE PE on PE.id_proyecto = PR.id_proyecto
	where DE.id_empleado = @id_empleado
end
execute PedidosEmpleado @id_empleado = 2
--======================================================================================

--entrada y salidas de empleado
--======================================================================================

--descripcion del empleado

Create procedure InfoEmpleado
@id_empleado int
as
begin 
select 
	DE.id_empleado,
	DE.nombre,
	DE.apellidoP, 
	DE.apellidoM, 
	DE.edad,
	DE.direccion, 
	DE.sexo,
	DE.nacionalidad, 
	DE.telefono, 
	DE.puesto,
	HE.entrada, 
	HE.salida,
	TE.nombre,  
	TE.direccion, 
	TE.telefono 
from  DatosEmpleadoE DE
	join HorarioE HE on DE.id_empleado = HE.id_empleado
	join TutorE TE on  DE.id_empleado = TE.id_empleado
where  DE.id_empleado = @id_empleado
end
execute  InfoEmpleado @id_empleado= 1

--======================================================================================

--
	select count(id_empleado) from EmpleadosE where id_constructora = 12
--======================================================================================

--ver el costo de los pedidos aceptados
create procedure BusquedaPedido
@id_pedido int
as
	begin
	select 
		PE.id_pedido,
		PE.descripcion,
		PE.cantidad,
		PR.id_proyecto,
		CPE.CostoPedido,
		CPE.Autorizacion_empleado,
		DE.nombre
	from CostoPedidoE CPE
		join PedidosE PE on CPE.id_pedido = PE.id_pedido
		join ProyectoE PR on PE.id_proyecto =  Pr.id_proyecto
		join DatosEmpleadoE DE on PR.id_encargado = DE.id_empleado

	where PE.id_pedido= @id_pedido
end
execute BusquedaPedido @id_pedido=1

--======================================================================================

Create procedure CrearPedido
@descripcion varchar(100),
@cantidad varchar(100),
@id_proyecto int,
@id_empleado int

as 
begin

	INSERT INTO PedidosE (descripcion, cantidad, fecha_pedido, id_proyecto, id_empleado)
	values (@descripcion, @cantidad, getdate(), @id_proyecto, @id_empleado)

	INSERT INTO CostoPedidoE (id_solicitante)  values (@id_empleado)
end
execute CrearPedido @descripcion='cemento' , @cantidad='200 kilos',  @id_proyecto=1 , @id_empleado=1
drop procedure CrearPedido

select * from PedidosE
--======================================================================================
--agregar 
Create procedure AgregaCosto
@costo float,
@autorizacion_empleado int,
@id_pedido int
as
begin
	update CostoPedidoE set costo= @costo, autorizacion_empleado= @autorizacion_empleado where id_pedido= @id_pedido
	select * from CostoPedidoE  where id_pedido= @id_pedido
end
execute AgregaCosto @costo=1800 , @autorizacion_empleado= 1, @id_pedido=1
drop procedure AgregaCosto
--======================================================================================
--obtener todos los pedidos de cada proyecto

select sum(costo) from CostoPedidoE 

select	
	CPE.id_pedido,
	CPE.costo,
	PE.id_proyecto
from CostoPedidoE CPE
	join PedidosE PE on PE.id_pedido = CPE.id_pedido
-- sumar el costo por proyecto



	


--======================================================================================
--======================================================================================
--======================================================================================
--======================================================================================
--======================================================================================