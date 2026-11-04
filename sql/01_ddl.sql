-- ============================================================
-- SCRIPT 01: DEFINICIÓN DE ESTRUCTURA DE DATOS (DDL)
-- Asignatura: Base de datos
-- Proyecto: Registro de inventario - RainTamia Plus
-- Motor de BD: PostgreSQL
-- Estudiante: Isaac David Ramón Tinoco
-- ============================================================

-- 1. Tipo enumerado para los tipos de movimiento de inventario
CREATE TYPE tipo_mov_enum AS ENUM ('ENTRADA', 'SALIDA', 'AJUSTE', 'PERDIDA');

-- 2. Tabla Bodega
CREATE TABLE Bodega (
    id_bodega   SERIAL,
    nombre      VARCHAR(80) NOT NULL,
    descripcion VARCHAR(200),
    PRIMARY KEY (id_bodega),
    CONSTRAINT uk_bodega_nombre UNIQUE (nombre)
);

-- 3. Tabla ItemInventario (Superentidad)
CREATE TABLE ItemInventario (
    id_item      SERIAL,
    nombre       VARCHAR(100) NOT NULL,
    descripcion  TEXT,
    stock_actual INT NOT NULL DEFAULT 0 CHECK (stock_actual >= 0),
    stock_minimo INT NOT NULL DEFAULT 0 CHECK (stock_minimo >= 0),
    id_bodega    INT NOT NULL,
    PRIMARY KEY (id_item),
    CONSTRAINT fk_item_bodega FOREIGN KEY (id_bodega) REFERENCES Bodega(id_bodega)
);

-- 4. Tabla MateriaPrima (Subentidad)
CREATE TABLE MateriaPrima (
    id_item        INT NOT NULL,
    costo_unitario DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    PRIMARY KEY (id_item),
    CONSTRAINT chk_costo_positivo CHECK (costo_unitario >= 0),
    CONSTRAINT fk_materiaprima_item FOREIGN KEY (id_item) REFERENCES ItemInventario(id_item) ON DELETE CASCADE
);

-- 5. Tabla Producto (Subentidad)
CREATE TABLE Producto (
    id_item         INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    PRIMARY KEY (id_item),
    CONSTRAINT chk_precio_positivo CHECK (precio_unitario >= 0),
    CONSTRAINT fk_producto_item FOREIGN KEY (id_item) REFERENCES ItemInventario(id_item) ON DELETE CASCADE
);

-- 6. Tabla EncargadoInventario
CREATE TABLE EncargadoInventario (
    id_encargado    SERIAL,
    nombre_completo VARCHAR(120) NOT NULL,
    cedula          VARCHAR(10) NOT NULL,
    fecha_contrato  DATE NOT NULL,
    PRIMARY KEY (id_encargado),
    CONSTRAINT uk_encargado_cedula UNIQUE (cedula)
);

-- 7. Tabla MovimientoInventario
CREATE TABLE MovimientoInventario (
    id_movimiento   SERIAL,
    fecha           TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    tipo_movimiento tipo_mov_enum NOT NULL,
    cantidad        INT NOT NULL,
    motivo          TEXT NOT NULL,
    id_item         INT NOT NULL,
    id_encargado    INT NOT NULL,
    PRIMARY KEY (id_movimiento),
    CONSTRAINT chk_cantidad_no_cero CHECK (cantidad <> 0),
    CONSTRAINT fk_movimiento_item FOREIGN KEY (id_item) REFERENCES ItemInventario(id_item),
    CONSTRAINT fk_movimiento_encargado FOREIGN KEY (id_encargado) REFERENCES EncargadoInventario(id_encargado)
);
