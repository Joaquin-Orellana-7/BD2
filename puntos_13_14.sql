-- Tarea 13
BEGIN;

INSERT INTO clientes (razon_social, rut, telefono, email, direccion)
VALUES ('Cliente Prueba Rollback SpA', '99999999-9', '+56 9 9999 9999', 'rollback@prueba.cl', 'Calle Falsa 123');

UPDATE empleados 
SET sueldo = 9999999.99 
WHERE id_empleado = 1;

SELECT * FROM clientes WHERE rut = '99999999-9';
SELECT id_empleado, nombre, apellido, sueldo FROM empleados WHERE id_empleado = 1;

ROLLBACK;

SELECT * FROM clientes WHERE rut = '99999999-9';

SELECT id_empleado, nombre, apellido, sueldo FROM empleados WHERE id_empleado = 1;

--Tarea 14
BEGIN;

UPDATE inventario 
SET stock = stock + 10 
WHERE id_producto = 1;

INSERT INTO categorias (nombre_categoria, descripcion, fecha_creacion, estado)
VALUES ('Tecnologia', 'Equipos electronicos y computacion', CURRENT_DATE, 'Activo');

SAVEPOINT punto_control_1;

DELETE FROM proveedores WHERE id_proveedor = 50;

ROLLBACK TO SAVEPOINT punto_control_1;

COMMIT;

SELECT id_proveedor, nombre_proveedor FROM proveedores WHERE id_proveedor = 50;

SELECT * FROM categorias WHERE nombre_categoria = 'Tecnologia';

SELECT id_producto, stock FROM inventario WHERE id_producto = 1;
