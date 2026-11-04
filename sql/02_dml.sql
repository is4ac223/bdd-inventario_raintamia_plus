-- ============================================================
-- SCRIPT 02: INSERCIÓN DE DATOS DE EJEMPLO (DML)
-- Asignatura: Base de datos
-- Proyecto: Registro de inventario - RainTamia Plus
-- Motor de BD: PostgreSQL
-- Estudiante: Isaac David Ramón Tinoco
-- ============================================================

-- 1. Inserción en Bodega
INSERT INTO Bodega (nombre, descripcion)
VALUES
    ('Bodega de envases y tapas', 'Almacena envases PET y tapas'),
    ('Bodega de producto terminado', 'Almacena botellas listas para la venta'),
    ('Bodega de insumos de empaque', 'Almacena sellos y etiquetas'),
    ('Área de despacho', 'Productos listos para entrega y botellones'),
    ('Área de producción', 'Insumos en uso en la línea de embotellado');

-- 2. Inserción en ItemInventario
INSERT INTO ItemInventario (id_item, nombre, descripcion, stock_actual, stock_minimo, id_bodega)
VALUES
    (1, 'Envase PET 600 ml', 'Envase plástico para agua de 600 ml', 450, 500, 1),
    (2, 'Tapa plástica 28 mm', 'Tapa rosca para envases PET', 3200, 1000, 1),
    (3, 'Sello de seguridad', 'Sello termoencogible para tapa', 900, 1000, 3),
    (4, 'Etiqueta adhesiva 600 ml', 'Etiqueta impresa RainTamia 600 ml', 5200, 1500, 3),
    (5, 'Funda termoencogible', 'Funda para armar pacas', 150, 100, 5),
    (6, 'Agua RainTamia 600 ml', 'Botella de agua de 600 ml', 1200, 400, 2),
    (7, 'Agua RainTamia 1 L', 'Botella de agua de 1 L', 300, 360, 2),
    (8, 'Agua RainTamia 2 L', 'Botella de agua de 2 L', 480, 200, 2),
    (9, 'Botellón RainTamia 20 L', 'Botellón retornable de 20 L', 60, 30, 4),
    (10, 'Agua RainTamia 330 ml', 'Botella de agua de 330 ml', 90, 120, 4);

-- Ajustar secuencia del id_item por inserción explícita
SELECT setval('iteminventario_id_item_seq', (SELECT MAX(id_item) FROM ItemInventario));

-- 3. Inserción en MateriaPrima
INSERT INTO MateriaPrima (id_item, costo_unitario)
VALUES 
    (1, 0.08), 
    (2, 0.03), 
    (3, 0.01), 
    (4, 0.02), 
    (5, 0.25);

-- 4. Inserción en Producto
INSERT INTO Producto (id_item, precio_unitario)
VALUES 
    (6, 0.35), 
    (7, 0.55), 
    (8, 0.85), 
    (9, 2.50), 
    (10, 0.25);

-- 5. Inserción en EncargadoInventario
INSERT INTO EncargadoInventario (nombre_completo, cedula, fecha_contrato)
VALUES
    ('Marcos Villavicencio', '1104567891', '2022-03-01'),
    ('Lucía Armijos',        '1105678902', '2023-06-15'),
    ('Carlos Jaramillo',     '1106789013', '2021-09-10'),
    ('Andrea Ordóñez',       '1107890124', '2024-01-08'),
    ('Pablo Sarango',        '1108901235', '2025-02-20');

-- 6. Inserción en MovimientoInventario
INSERT INTO MovimientoInventario (fecha, tipo_movimiento, cantidad, motivo, id_item, id_encargado)
VALUES
    ('2026-10-05 08:15:00', 'ENTRADA', 5000, 'Compra de envases PET a proveedor', 1, 1),
    ('2026-10-05 08:40:00', 'ENTRADA', 4000, 'Compra de tapas plásticas', 2, 1),
    ('2026-10-12 14:20:00', 'SALIDA',  4550, 'Consumo en línea de producción', 1, 2),
    ('2026-10-14 09:05:00', 'PERDIDA', 100,  'Envases deformados por calor en bodega', 1, 2),
    ('2026-10-14 17:30:00', 'ENTRADA', 1500, 'Producción terminada lote L-1014', 6, 3),
    ('2026-10-16 10:10:00', 'SALIDA',  60,   'Venta a distribuidor', 6, 3),
    ('2026-10-19 11:45:00', 'PERDIDA', 30,   'Botellas rotas durante la distribución', 10, 4),
    ('2026-10-21 16:00:00', 'AJUSTE',  -5,   'Faltante en inventario físico', 9, 4),
    ('2026-10-23 09:30:00', 'AJUSTE',  200,  'Corrección de conteo de etiquetas', 4, 5),
    ('2026-10-26 13:15:00', 'SALIDA',  120,  'Venta a mayorista', 8, 5);
