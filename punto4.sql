CREATE TABLE auditoria_inventario (
    id_auditoria SERIAL PRIMARY KEY,
    id_producto INT NOT NULL,
    id_ubicacion INT NOT NULL,
    stock_anterior INT NOT NULL,
    stock_nuevo INT NOT NULL,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    FOREIGN KEY (id_ubicacion) REFERENCES ubicaciones(id_ubicacion)
);

\dt

ALTER TABLE auditoria_inventario
ADD COLUMN usuario_modificacion VARCHAR(50);

\d auditoria_inventario

ALTER TABLE auditoria_inventario DROP COLUMN usuario_modificacion;

\d auditoria_inventario

DROP TABLE auditoria_inventario;

\d auditoria_inventario
