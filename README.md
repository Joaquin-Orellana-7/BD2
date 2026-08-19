#  Sistema de Gestión de Inventario y Logística - Base de Datos

Este repositorio contiene el script SQL para la creación, estructuración y población de una base de datos relacional orientada a la gestión logística, control de inventarios y ventas. Está diseñada para administrar el flujo completo de una empresa: desde los proveedores y el almacenamiento en bodegas, hasta las órdenes de pedido y envíos a clientes finales.

## 🛠️ Tecnologías utilizadas
- **Motor de Base de Datos:** PostgreSQL
- **Lenguaje:** SQL

## 🏗️ Estructura del Esquema
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
