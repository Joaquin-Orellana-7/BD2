# LogiTrack SpA — Base de Datos ua_eq017

## Nombre de la base de datos
`ua_eq017`

## Motor y versión de PostgreSQL
PostgreSQL 15.5 (Ubuntu 15.5-0ubuntu0.23.04.1)

## Instrucciones de ejecución de los scripts

Ejecutar en el siguiente orden, usando `psql` conectado a la base de datos:

1. `01_creacion_bd.sql` — Creación de tablas, claves primarias, claves foráneas y restricciones de integridad (incluye restricción de stock no negativo).
2. `02_carga_datos.sql` — Carga de datos iniciales (mínimo 50 registros por tabla).
3. `03_ddl.sql` — Operaciones DDL: creación de tabla `auditoria_inventario`, `ALTER TABLE` (agregar y eliminar columna), `DROP TABLE`.
4. `04_dml.sql` — Operaciones DML: inserciones, actualizaciones, eliminación de registro de prueba y consultas de verificación.
5. `05_consultas.sql` — Consultas de negocio (órdenes, detalle, envíos, inventario, stock bajo, totales por bodega, productos por proveedor).
6. `06_transacciones.sql` (o `punto-6-y-7.sql` / `puntos_13_14.sql`, según nombre final) — Transacciones con `BEGIN`/`COMMIT`, `ROLLBACK`, y `SAVEPOINT`.

Ejemplo de ejecución de un script:
```bash
psql -h 127.0.0.1 -U ua_eq017 -d ua_eq017 -f 01_creacion_bd.sql
```

## Datos generales de conexión a la base de datos remota

- **Host:** 143.198.118.203
- **Usuario BD:** ua_eq017
- **Base de datos:** ua_eq017
- **Conexión SSH:** `ssh ua_eq017@143.198.118.203`
- **Conexión a psql (una vez dentro del servidor):** `psql -h 127.0.0.1 -U ua_eq017 -d ua_eq017`

> Las contraseñas de acceso fueron entregadas por separado y no se incluyen en este documento por motivos de seguridad.

## Estructura de archivos entregados

- `01_creacion_bd.sql` — Script de creación de tablas y restricciones.
- `02_carga_datos.sql` (o `carga_datos.sql`) — Script de carga de datos.
- `punto4.sql`, `punto5.sql` — Scripts DDL.
- `punto8.sql`, `punto9.sql`, `punto-6-y-7.sql` — Scripts de consultas.
- `puntos_13_14.sql` — Transacciones con ROLLBACK y SAVEPOINT.
- `Diagrama BD.jpeg` — Modelo relacional de la base de datos.
- `integrantes.txt` — Datos del equipo e integrantes.
- `backup_restore_transactions.md` — Documentación del proceso de respaldo, restauración y transacción de ejemplo.
- `respaldo_remoto.backup` — Respaldo de la base de datos en formato custom de `pg_dump`.
- `evidencias/` — Capturas de pantalla de la ejecución de scripts, consultas y transacciones en la base remota.
- `README.md` — Este documento.

## Consideraciones para restaurar el respaldo y verificar la solución

El respaldo (`respaldo_remoto.backup`) está en **formato custom de pg_dump**, por lo tanto debe restaurarse con `pg_restore` (no con `psql -f`, que solo funciona para dumps en texto plano).

Pasos para restaurar en una base nueva:

```bash
# 1. Crear una base de datos vacía
createdb -h 127.0.0.1 -U ua_eq017 ua_eq017_clon

# 2. Restaurar el respaldo dentro de la base nueva
pg_restore -h 127.0.0.1 -U ua_eq017 -d ua_eq017_clon respaldo_remoto.backup

# 3. Conectarse para verificar
psql -h 127.0.0.1 -U ua_eq017 -d ua_eq017_clon
```

Verificación recomendada dentro de `psql`:
```sql
\dt ua_eq017.*                                  -- confirmar que las 13 tablas se restauraron
\d ua_eq017.detalle_orden                       -- confirmar restricciones (PK y FK)
SELECT count(*) FROM ua_eq017.clientes;         -- confirmar que los datos llegaron
```

Se recomienda contar con las credenciales de conexión (entregadas por separado) y verificar que el archivo de respaldo esté en el mismo directorio desde donde se ejecuta `pg_restore`.
