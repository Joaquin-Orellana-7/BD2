10. Respaldo (Backup) de la Base de Datos

Se realizó un respaldo completo de la base de datos logistica_db utilizando la herramienta pg_dump de PostgreSQL.

Comando de Respaldo
Shell
1
pg_dump -U postgres -d logistica_db -F c -f respaldo_logistica.backup
Mostrar más líneas
Parámetros utilizados
-U postgres: Usuario de PostgreSQL.
-d logistica_db: Base de datos a respaldar.
-F c: Formato personalizado (Custom).
-f respaldo_logistica.backup: Nombre del archivo de respaldo.
Resultado

Se generó el archivo:

Plain Text
1
respaldo_logistica.backup
Mostrar más líneas

el cual contiene:

Estructura de la base de datos.
Tablas.
Restricciones.
Claves primarias.
Claves foráneas.
Registros almacenados.
11. Restauración del Respaldo
Creación de una Nueva Base de Datos
SQL
1
CREATE DATABASE logistica_restaurada;
Mostrar más líneas
Restauración del Backup
Shell
1
pg_restore -U postgres -d logistica_restaurada respaldo_logistica.backup
Mostrar más líneas
Verificación de la Restauración
Verificar Tablas Restauradas
SQL
1
SELECT table_name
2
FROM information_schema.tables
3
WHERE table_schema = 'public';
Mostrar más líneas
Verificar Cantidad de Registros
SQL
1
SELECT COUNT(*) AS clientes FROM clientes;
2
 
3
SELECT COUNT(*) AS productos FROM productos;
4
 
5
SELECT COUNT(*) AS proveedores FROM proveedores;
6
 
7
SELECT COUNT(*) AS inventario FROM inventario;
8
 
9
SELECT COUNT(*) AS ordenes FROM ordenes_pedido;
Mostrar más líneas
Verificar Restricciones
SQL
1
SELECT
2
tc.table_name,
3
tc.constraint_name,
4
tc.constraint_type
5
FROM information_schema.table_constraints tc
6
WHERE tc.table_schema = 'public';
Mostrar más líneas
Resultado Esperado
Todas las tablas fueron restauradas correctamente.
Las claves primarias (PK) se mantienen.
Las claves foráneas (FK) se mantienen.
Los registros continúan disponibles.
La estructura es idéntica a la base de datos original.
12. Transacción para Registrar una Nueva Orden

Se implementó una transacción para registrar una nueva orden, su detalle y el envío asociado, garantizando la integridad de los datos.

Inicio de la Transacción
SQL
1
BEGIN;
Mostrar más líneas
Registrar Nueva Orden
SQL
1
INSERT INTO ordenes_pedido
2
(
3
id_cliente,
4
fecha_orden,
5
estado,
6
total,
7
prioridad,
8
observaciones
9
)
10
VALUES
11
(
12
1,
13
CURRENT_DATE,
14
'Pendiente',
15
250000,
16
'Alta',
17
'Orden creada mediante transacción'
18
);
Mostrar más líneas
Registrar Detalle de la Orden
SQL
1
INSERT INTO detalle_orden
2
(
3
id_orden,
4
id_producto,
5
cantidad,
6
precio_unitario,
7
subtotal
8
)
9
VALUES
10
(
11
51,
12
3,
13
5,
14
50000,
15
250000
16
);
Mostrar más líneas
Registrar Envío Asociado
SQL
1
INSERT INTO envios
2
(
3
id_orden,
4
id_transportista,
5
id_empleado,
6
fecha_envio,
7
fecha_entrega,
8
estado_envio,
9
destino,
10
costo_envio
11
)
12
VALUES
13
(
14
51,
15
1,
16
1,
17
CURRENT_DATE,
18
CURRENT_DATE + INTERVAL '3 days',
19
'Preparando despacho',
20
'Santiago, Chile',
21
12000
22
);
Mostrar más líneas
Confirmación de la Transacción
SQL
1
COMMIT;
Mostrar más líneas
Verificación de la Orden Registrada
Consultar Orden
SQL
1
SELECT *
2
FROM ordenes_pedido
3
WHERE id_orden = 51;
Mostrar más líneas
Consultar Detalle
SQL
1
SELECT *
2
FROM detalle_orden
3
WHERE id_orden = 51;
Mostrar más líneas
Consultar Envío
SQL
1
SELECT *
2
FROM envios
3
WHERE id_orden = 51;
Mostrar más líneas
Resultado Esperado

Al ejecutar la transacción:

Se registra una nueva orden de pedido.
Se registra el detalle de productos asociados.
Se registra el envío correspondiente.
Todos los cambios quedan almacenados permanentemente gracias a COMMIT.
Se mantiene la integridad referencial entre las tablas ordenes_pedido, detalle_orden y envios.

Evidencias a adjuntar en GitHub

Captura del comando pg_dump.
Captura de la creación de la base de datos logistica_restaurada.
Captura de la ejecución de pg_restore.
Capturas mostrando las consultas de verificación.
Captura de la ejecución de la transacción (BEGIN → COMMIT).
Captura de las consultas SELECT comprobando la inserción de la orden, detalle y envío.
Proporcione sus comentarios sobre BizChat
