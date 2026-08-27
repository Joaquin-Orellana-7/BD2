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
=======
--- 6.a CONSULTA: Ordenes de pedido con datos del cliente
SELECT 
    o.id_orden,
    o.fecha_orden,
    o.estado,
    o.total,
    c.razon_social AS cliente
FROM ordenes_pedido o
INNER JOIN clientes c
    ON o.id_cliente = c.id_cliente
ORDER BY o.id_orden;

--- 6.b CONSULTA: Detalle de ordenes de pedido con datos del producto y categoria
SELECT
    o.id_orden,
    p.nombre_producto AS producto,
    c.nombre_categoria AS categoria,
    d.cantidad AS cantidad_solicitada,
    d.precio_unitario AS precio_unitario,
    d.subtotal AS valor_total
FROM ordenes_pedido o
INNER JOIN detalle_orden d
    ON o.id_orden = d.id_orden
INNER JOIN productos p
    ON d.id_producto = p.id_producto
INNER JOIN categorias c
    ON p.id_categoria = c.id_categoria
ORDER BY o.id_orden;

--- 6.c CONSULTA: Envíos con datos del cliente, transportista y empleado responsable
SELECT
    e.id_envio,
    e.id_orden AS numero_orden,
    c.razon_social AS cliente,
    t.nombre_transportista AS transportista,
    CONCAT(emp.nombre, ' ', emp.apellido) AS empleado_responsable,
    e.fecha_envio,
    e.estado_envio
FROM envios e
INNER JOIN ordenes_pedido o
    ON e.id_orden = o.id_orden
INNER JOIN clientes c
    ON o.id_cliente = c.id_cliente
INNER JOIN transportistas t
    ON e.id_transportista = t.id_transportista
INNER JOIN empleados emp
    ON e.id_empleado = emp.id_empleado
ORDER BY e.id_envio;

--- 6.d CONSULTA: Inventario con datos de bodega, ubicación y producto
SELECT
    b.nombre_bodega AS bodega,
    b.ciudad,
    u.codigo_ubicacion AS ubicacion,
    p.nombre_producto AS producto,
    i.stock,
    i.stock_minimo,
    i.stock_maximo
FROM inventario i
INNER JOIN ubicaciones u
    ON i.id_ubicacion = u.id_ubicacion
INNER JOIN bodegas b
    ON u.id_bodega = b.id_bodega
INNER JOIN productos p
    ON i.id_producto = p.id_producto
ORDER BY b.nombre_bodega, u.codigo_ubicacion, p.nombre_producto;

--- 7 CONSULTA: Productos con stock por debajo del mínimo
SELECT
    p.id_producto,
    p.nombre_producto AS producto,
    i.stock,
    i.stock_minimo,
    i.stock_maximo
FROM inventario i
INNER JOIN productos p
    ON i.id_producto = p.id_producto
WHERE i.stock <= i.stock_minimo
ORDER BY i.stock ASC;
