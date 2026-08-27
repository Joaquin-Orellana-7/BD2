DROP TABLE IF EXISTS
    envios,
    detalle_orden,
    ordenes_pedido,
    inventario,
    ubicaciones,
    bodegas,
    producto_proveedor,
    proveedores,
    productos,
    categorias,
    clientes,
    transportistas,
    empleados
CASCADE;

BEGIN;

CREATE TABLE clientes (
    id_cliente SERIAL PRIMARY KEY,
    razon_social VARCHAR(100) NOT NULL,
    rut VARCHAR(15) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    email VARCHAR(100),
    direccion VARCHAR(200)
);

CREATE TABLE categorias (
    id_categoria SERIAL PRIMARY KEY,
    nombre_categoria VARCHAR(100) NOT NULL,
    descripcion TEXT,
    fecha_creacion DATE,
    estado VARCHAR(20)
);

CREATE TABLE productos (
    id_producto SERIAL PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10,2),
    peso DECIMAL(8,2),
    unidad_medida VARCHAR(20),
    id_categoria INT NOT NULL,
    FOREIGN KEY (id_categoria)
        REFERENCES categorias(id_categoria)
);

CREATE TABLE proveedores (
    id_proveedor SERIAL PRIMARY KEY,
    nombre_proveedor VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    email VARCHAR(100),
    direccion VARCHAR(200),
    ciudad VARCHAR(100)
);

CREATE TABLE producto_proveedor (
    id_producto INT,
    id_proveedor INT,
    fecha_contrato DATE,
    costo_compra DECIMAL(10,2),

    PRIMARY KEY (id_producto,id_proveedor),

    FOREIGN KEY (id_producto)
        REFERENCES productos(id_producto),

    FOREIGN KEY (id_proveedor)
        REFERENCES proveedores(id_proveedor)
);

CREATE TABLE bodegas (
    id_bodega SERIAL PRIMARY KEY,
    nombre_bodega VARCHAR(100) NOT NULL,
    ciudad VARCHAR(100),
    direccion VARCHAR(200),
    capacidad_total INT,
    telefono VARCHAR(20)
);

CREATE TABLE ubicaciones (
    id_ubicacion SERIAL PRIMARY KEY,
    id_bodega INT NOT NULL,

    codigo_ubicacion VARCHAR(20),
    pasillo VARCHAR(10),
    estante VARCHAR(10),
    nivel VARCHAR(10),
    estado VARCHAR(20),

    FOREIGN KEY (id_bodega)
        REFERENCES bodegas(id_bodega)
);

CREATE TABLE inventario (
    id_inventario SERIAL PRIMARY KEY,
    id_producto INT NOT NULL,
    id_ubicacion INT NOT NULL,

    stock INT NOT NULL,
    stock_minimo INT,
    stock_maximo INT,
    fecha_actualizacion DATE,

    FOREIGN KEY (id_producto)
        REFERENCES productos(id_producto),

    FOREIGN KEY (id_ubicacion)
        REFERENCES ubicaciones(id_ubicacion)
);

CREATE TABLE ordenes_pedido (
    id_orden SERIAL PRIMARY KEY,
    id_cliente INT NOT NULL,

    fecha_orden DATE,
    estado VARCHAR(30),
    total DECIMAL(10,2),
    prioridad VARCHAR(20),
    observaciones TEXT,

    FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente)
);

CREATE TABLE detalle_orden (
    id_detalle SERIAL PRIMARY KEY,
    id_orden INT NOT NULL,
    id_producto INT NOT NULL,

    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2),
    subtotal DECIMAL(10,2),

    FOREIGN KEY (id_orden)
        REFERENCES ordenes_pedido(id_orden),

    FOREIGN KEY (id_producto)
        REFERENCES productos(id_producto)
);

CREATE TABLE transportistas (
    id_transportista SERIAL PRIMARY KEY,
    nombre_transportista VARCHAR(100),
    telefono VARCHAR(20),
    email VARCHAR(100),
    tipo_transporte VARCHAR(50),
    ciudad_base VARCHAR(100)
);

CREATE TABLE empleados (
    id_empleado SERIAL PRIMARY KEY,

    nombre VARCHAR(100),
    apellido VARCHAR(100),
    cargo VARCHAR(100),
    telefono VARCHAR(20),
    email VARCHAR(100),
    fecha_contratacion DATE,
    sueldo DECIMAL(10,2)
);

CREATE TABLE envios (
    id_envio SERIAL PRIMARY KEY,

    id_orden INT NOT NULL,
    id_transportista INT NOT NULL,
    id_empleado INT NOT NULL,

    fecha_envio DATE,
    fecha_entrega DATE,
    estado_envio VARCHAR(30),
    destino VARCHAR(200),
    costo_envio DECIMAL(10,2),

    FOREIGN KEY (id_orden)
        REFERENCES ordenes_pedido(id_orden),

    FOREIGN KEY (id_transportista)
        REFERENCES transportistas(id_transportista),

    FOREIGN KEY (id_empleado)
        REFERENCES empleados(id_empleado)
);
