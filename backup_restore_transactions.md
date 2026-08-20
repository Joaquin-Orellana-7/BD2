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
- como seguir trabajando - (paso 11 y 12)

1- Crea la base de datos clon:
  createdb -h 127.0.0.1 -U ua_eq017 ua_eq017_clon

2- Restaura el respaldo:
  psql -h 127.0.0.1 -U ua_eq017 -d ua_eq017_clon -f respaldo_bd.sql

3- Entra a la nueva base para verificar:
    psql -h 127.0.0.1 -U ua_eq017 -d ua_eq017_clon
  




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
