-- ============================================================
-- SCRIPT 03: CONSULTAS DE ÁLGEBRA RELACIONAL EN SQL
-- Asignatura: Base de datos
-- Proyecto: Registro de inventario - RainTamia Plus
-- Motor de BD: PostgreSQL
-- Estudiante: Isaac David Ramón Tinoco
-- ============================================================

-- ------------------------------------------------------------
-- Consulta 1: Selección, Proyección y Reunión (σ, π, ⋈)
-- Objetivo: Identificar los ítems cuyo stock actual está por debajo del mínimo.
-- ------------------------------------------------------------
SELECT i.nombre AS item, i.stock_actual, i.stock_minimo, b.nombre AS bodega
FROM ItemInventario i
JOIN Bodega b ON i.id_bodega = b.id_bodega
WHERE i.stock_actual < i.stock_minimo;

-- ------------------------------------------------------------
-- Consulta 2: Reunión natural de tres tablas (⋈) con selección
-- Objetivo: Listar las salidas y pérdidas registradas indicando ítem y encargado.
-- ------------------------------------------------------------
SELECT i.nombre, m.tipo_movimiento, m.cantidad, e.nombre_completo, m.fecha
FROM ItemInventario i
JOIN MovimientoInventario m ON i.id_item = m.id_item
JOIN EncargadoInventario e ON m.id_encargado = e.id_encargado
WHERE m.tipo_movimiento IN ('SALIDA', 'PERDIDA')
ORDER BY m.fecha;

-- ------------------------------------------------------------
-- Consulta 3: Diferencia (−)
-- Objetivo: Encontrar las materias primas que no han tenido ningún movimiento.
-- ------------------------------------------------------------
SELECT i.nombre
FROM ItemInventario i
JOIN MateriaPrima m ON i.id_item = m.id_item
WHERE NOT EXISTS (
    SELECT 1
    FROM MovimientoInventario mv
    WHERE mv.id_item = m.id_item
);

-- ------------------------------------------------------------
-- Consulta 4: Intersección (∩)
-- Objetivo: Productos con al menos una entrada (producción) y al menos una salida (venta).
-- ------------------------------------------------------------
SELECT i.nombre
FROM ItemInventario i
JOIN Producto p ON i.id_item = p.id_item
WHERE i.id_item IN (SELECT id_item FROM MovimientoInventario WHERE tipo_movimiento = 'ENTRADA')
  AND i.id_item IN (SELECT id_item FROM MovimientoInventario WHERE tipo_movimiento = 'SALIDA');

-- ------------------------------------------------------------
-- Consulta 5: Agrupamiento y funciones de agregación (γ)
-- Objetivo: Calcular el valor monetario de materia prima por bodega (> 100 USD).
-- ------------------------------------------------------------
SELECT b.nombre AS bodega,
       SUM(i.stock_actual * m.costo_unitario) AS valor_total
FROM Bodega b
JOIN ItemInventario i ON b.id_bodega = i.id_bodega
JOIN MateriaPrima m ON i.id_item = m.id_item
GROUP BY b.id_bodega, b.nombre
HAVING SUM(i.stock_actual * m.costo_unitario) > 100
ORDER BY valor_total DESC;
