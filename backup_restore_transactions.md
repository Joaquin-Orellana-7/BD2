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
- BEGIN;

-- 1. Registrar la nueva orden 
INSERT INTO ordenes_pedido (id_orden, fecha, id_cliente) 
VALUES (999, CURRENT_DATE, 1);

-- 2. Registrar el detalle de esa orden 
INSERT INTO detalle_orden (id_detalle, id_orden, id_producto, cantidad) 
VALUES (888, 999, 1, 5);

-- 3. Registrar el envío 
INSERT INTO envios (id_envio, id_orden, direccion, estado) 
VALUES (777, 999, 'Direccion de prueba 123', 'Pendiente');

COMMIT;
