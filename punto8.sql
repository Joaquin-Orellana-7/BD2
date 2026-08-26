SELECT 
    b.nombre_bodega, 
    SUM(i.stock) AS total_productos_almacenados
FROM bodegas b
JOIN ubicaciones u ON b.id_bodega = u.id_bodega
JOIN inventario i ON u.id_ubicacion = i.id_ubicacion
GROUP BY b.id_bodega, b.nombre_bodega
ORDER BY total_productos_almacenados DESC;