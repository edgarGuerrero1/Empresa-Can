-- ================================================================================================================
-- ==NOMBRE             : Creacion de tablas Empresa       													
-- ==AUTOR				: Edgar guerrero																						
-- ==FECHA CREACION		: 12/9/2019																									
-- ==DESARROLLO			: EmpresaCan																	
-- ==MODULO				: 																											
-- ==DESCRIPCION		: insercion de datos para EmpresaCan
-- ==EJEMPLO			: datosPersonaE	
-- ================================================================================================================
--ConstructoraE
INSERT INTO ConstructoraE (nombre,
direccion,
telefono)
 VALUES ('Constructora Guerrero', 'Av lopez mateos 2040', 1234)

--======================================================================================
--DatosEmpleadoE
INSERT INTO DatosEmpleadoE (nombre, apellidoP, apellidoM, edad, direccion, sexo, nacionalidad, telefono, puesto)
 VALUES ('Edgar', 'Guerrero', 'x', 25, 'claveles', 'h', 'MEX', 1234, 'programador')

--======================================================================================
--EmpleadosE
INSERT INTO EmpleadosE (id_empleado, id_constructora)
 VALUES (1, 1)

--======================================================================================
--TutorE
INSERT INTO TutorE (nombre, direccion, telefono, id_empleado)
 VALUES ('ross', 'lazaro cardenas', 3310, 1)

--======================================================================================
--HorarioE
INSERT INTO HorarioE (entrada, salida, id_empleado)
 VALUES (GETDATE(), GETDATE(), 1)

--======================================================================================
--ProyectoE
-- para crear un nuevo proyecto
INSERT INTO ProyectoE (id_encargado, fecha_inicio, costo)
 VALUES (1, GETDATE(), 7500)
-- para finalizar y dar fecha final a proyecto
UPDATE ProyectoE
SET fecha_termino = GETDATE()
WHERE id_proyecto = 1









--======================================================================================
--PedidosE 
INSERT INTO PedidosE (descripcion, cantidad, fecha_pedido, id_proyecto, id_empleado)
 VALUES ('cemento', '80 kilos', GETDATE(), 1, 1)
 select * from PedidosE
--======================================================================================
-- CostoPedidoE, se debe de dar de alta despues de crear un pedido, haciendo referencia al id_pedido
INSERT INTO CostoPedidoE (
	CostoPedido,
	Autorizacion_empleado ,
	id_pedido ,
	id_solicitante)
 values (1200, 1, 1,1)

 select * from CostoPedidoE