BACKUP (PASO 10)
paso 1- comectarse por ssh
ssh ua_eq017@143.198.118.203

paso 2: Generar el archivo de respaldo
pg_dump -U ua_eq017 -d ua_eq017 -F c -b -v -f respaldo_remoto.backup

paso 3: salir 
exit

paso 4: descargar el archivo a tu pc y autorizar con contraseña.
scp ua_eq017@143.198.118.203:respaldo_remoto.backup "C:\Users\javie\OneDrive\Documentos\respaldo_remoto.backup"

<img width="1508" height="1119" alt="imagen" src="https://github.com/user-attachments/assets/6998c805-37f8-4fb9-9cb7-31fdf92c3c6e" />


(Paso 11)
Conexión al servidor remoto
ssh ua_eq017@143.198.118.203

<img width="691" height="593" alt="imagen" src="https://github.com/user-attachments/assets/c33b00a4-ddcb-42d7-9100-d189a67514b6" />


Verificar que el archivo de respaldo esté disponible
ls

<img width="962" height="58" alt="imagen" src="https://github.com/user-attachments/assets/71fe6212-ab2b-4db7-9ed6-2e47ea2c7b0b" />

 Crear la base de datos clon (vacía)
createdb -h 127.0.0.1 -U ua_eq017 ua_eq017_clon

<img width="744" height="34" alt="imagen" src="https://github.com/user-attachments/assets/20b022d5-c728-4bb0-b9f7-3465f1c29b1f" />

Restaurar el respaldo (formato custom de pg_dump) dentro de la base clon
pg_restore -h 127.0.0.1 -U ua_eq017 -d ua_eq017_clon respaldo_remoto.backup

<img width="947" height="138" alt="imagen" src="https://github.com/user-attachments/assets/4becfef0-4897-4cc0-845e-4e77975272dc" />

Conectarse a la base clon para verificar la restauración

psql -h 127.0.0.1 -U ua_eq017 -d ua_eq017_clon
\dt ua_eq017.*

<img width="896" height="446" alt="imagen" src="https://github.com/user-attachments/assets/531273fb-a554-479f-bbbb-f72ec6cf96ee" />


(Paso 12)
-- Iniciamos la transacción
BEGIN;

-- 1. Registrar la nueva orden de pedido
INSERT INTO ua_eq017.ordenes_pedido (id_orden, id_cliente, fecha_orden, estado, total, prioridad, observaciones)
VALUES (51, 1, CURRENT_DATE, 'Pendiente', 7500.00, 'Alta', 'Orden de prueba - transaccion paso 12');

-- 2. Registrar el detalle de esa orden (qué producto y cuánta cantidad)
INSERT INTO ua_eq017.detalle_orden (id_detalle, id_orden, id_producto, cantidad, precio_unitario, subtotal)
VALUES (50, 51, 2, 5, 1500.00, 7500.00);

-- 3. Registrar el envío asociado a la orden
-- (fecha_entrega se deja sin valor porque el envío está "En preparación" y aún no tiene fecha confirmada)
INSERT INTO ua_eq017.envios (id_envio, id_orden, id_transportista, id_empleado, fecha_envio, estado_envio, destino, costo_envio)
VALUES (51, 51, 1, 1, CURRENT_DATE, 'En preparación', 'Av. Principal 123, Santiago', 3500.00);

-- Confirmamos todos los cambios de forma permanente
COMMIT;

-- Verificación: unimos las tres tablas para confirmar que la orden, el detalle
-- y el envío quedaron correctamente relacionados entre sí
SELECT o.id_orden, o.total, o.estado, d.id_producto, d.cantidad, d.subtotal, e.estado_envio, e.destino
FROM ua_eq017.ordenes_pedido o
JOIN ua_eq017.detalle_orden d ON d.id_orden = o.id_orden
JOIN ua_eq017.envios e ON e.id_orden = o.id_orden
WHERE o.id_orden = 51;

COMMIT;
<img width="1091" height="523" alt="imagen" src="https://github.com/user-attachments/assets/6e5d14c3-08d8-450f-85d6-60707ec278d3" />
