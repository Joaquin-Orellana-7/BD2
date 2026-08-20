1 -Se utiliza el comando pg_dump -h 127.0.0.1 -U ua_eq017 -d ua_eq017 -f respaldo_bd.sql para generar el respaldo.
2- se adjunta contraseña para confirmar. 
3- se verifica con el comando ls 
4- se intenta crear un clon de la base de datos con createdb -h 127.0.0.1 -U ua_eq017 ua_eq017_clon pero no existen permisos.




<img width="1161" height="804" alt="Captura de pantalla 2026-08-20 112923" src="https://github.com/user-attachments/assets/97cdcc6e-bf4a-4d45-8e30-334b60bff990" />

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
