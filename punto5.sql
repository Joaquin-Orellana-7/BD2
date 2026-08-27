INSERT INTO clientes (razon_social, rut, email, telefono, direccion)
VALUES ('TechLogistics Chile Ltd', '77123456-7', 'contacto@techlogistics.cl', '+56987654321', 'Av. Providencia 1234, Santiago');

INSERT INTO productos (nombre_producto, descripcion, id_categoria, precio)
VALUES ('Escáner de Código de Barras Inalámbrico', 'Escáner industrial con bluetooth', 1, 85000.00);

SELECT * FROM clientes WHERE rut = '77123456-7';

SELECT * FROM productos WHERE nombre_producto LIKE '%Escáner%';

UPDATE inventario
SET stock = 150
WHERE id_producto = 1 AND id_ubicacion = 1;

SELECT * FROM inventario WHERE id_producto = 1 AND id_ubicacion = 1;

UPDATE proveedores
SET telefono = '+56911223344', email = 'soporte@proveedornuevo.cl'
WHERE id_proveedor = 1;

SELECT * FROM proveedores WHERE id_proveedor = 1;

DELETE FROM detalle_orden
WHERE id_detalle = 50;

SELECT * FROM detalle_orden WHERE id_detalle = 50;

SELECT 'Cliente' AS entidad, razon_social AS detalle FROM clientes WHERE rut = '77123456-7'
UNION ALL
SELECT 'Producto', nombre_producto FROM productos WHERE nombre_producto LIKE '%Escáner%'
UNION ALL
SELECT 'Proveedor', email FROM proveedores WHERE id_proveedor = 1;
