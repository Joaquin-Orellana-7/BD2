#  Sistema de Gestión de Inventario y Logística - Base de Datos

Este repositorio contiene el script SQL para la creación, estructuración y población de una base de datos relacional orientada a la gestión logística, control de inventarios y ventas. Está diseñada para administrar el flujo completo de una empresa: desde los proveedores y el almacenamiento en bodegas, hasta las órdenes de pedido y envíos a clientes finales.

## Tecnologías utilizadas
- **Motor de Base de Datos:** PostgreSQL
- **Lenguaje:** SQL

## Estructura del Esquema
El modelo relacional consta de 13 tablas interconectadas:

1. **Gestión de Ventas:** `clientes`, `ordenes_pedido`, `detalle_orden`.
2. **Catálogo y Suministro:** `categorias`, `productos`, `proveedores`, `producto_proveedor`.
3. **Almacenamiento:** `bodegas`, `ubicaciones`, `inventario`.
4. **Logística y Personal:** `empleados`, `transportistas`, `envios`.

## Instalación y Ejecución

Para implementar esta base de datos en tu entorno local, sigue estos pasos:

1. Clona este repositorio:
   ```bash
   git clone [https://github.com/Joaquin-Orellana-7/BD2.git](https://github.com/Joaquin-Orellana-7/BD2.git)

Paso 1: Entrar al servidor

    Abre tu consola PowerShell en Windows.

    Escribe el siguiente comando y presiona Enter:
    ssh ua_eq017@143.198.118.203

    Cuando te solicite la contraseña (recuerda que no se verá en pantalla mientras escribes)

    Presiona Enter. Sabrás que entraste con éxito porque el texto de tu consola cambiará a color verde.

Paso 2: Entrar a la base de datos

    Ahora que estás dentro del servidor, escribe este comando y presiona Enter:
    psql -h 127.0.0.1 -U ua_eq017 -d ua_eq017

    Te pedirá una nueva contraseña.
