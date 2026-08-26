SELECT 
    prov.nombre_proveedor, 
    prod.nombre_producto,
    pp.costo_compra,
    pp.fecha_contrato
FROM proveedores prov
JOIN producto_proveedor pp ON prov.id_proveedor = pp.id_proveedor
JOIN productos prod ON pp.id_producto = prod.id_producto
ORDER BY prov.nombre_proveedor, prod.nombre_producto;