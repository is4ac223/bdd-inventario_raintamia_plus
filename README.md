# RainTamia Plus · Base de datos de inventario

Base de datos relacional para organizar y controlar el inventario de la embotelladora **RainTamia Plus**. El proyecto permite registrar los ítems almacenados, sus existencias, las bodegas, los responsables y los movimientos de inventario.

## ¿Qué gestiona?

- **Bodegas** y áreas de almacenamiento.
- **Ítems de inventario**, separados en materias primas y productos terminados.
- **Stock actual y stock mínimo** para detectar necesidades de reabastecimiento.
- **Encargados** responsables de registrar cada movimiento.
- Movimientos de tipo **entrada, salida, ajuste y pérdida**, con fecha, cantidad y motivo.

## Modelo de datos

El modelo está compuesto por seis tablas principales:

`Bodega` · `ItemInventario` · `MateriaPrima` · `Producto` · `EncargadoInventario` · `MovimientoInventario`

La especialización de `ItemInventario` permite diferenciar las materias primas mediante su costo unitario y los productos terminados mediante su precio unitario. Las relaciones y cardinalidades se encuentran en los diagramas:

- [Diagrama Entidad-Relación](docs/DER_inventario_raintamia_plus.png)
- [Diagrama relacional](docs/DR_inventario_raintamia_plus.png)

## Scripts SQL

Los scripts están preparados para **PostgreSQL** y deben ejecutarse en este orden:

1. [`01_ddl.sql`](sql/01_ddl.sql) — crea el tipo enumerado, las tablas, las claves y las restricciones.
2. [`02_dml.sql`](sql/02_dml.sql) — inserta datos de ejemplo de bodegas, ítems, encargados y movimientos.
3. [`03_consultas.sql`](sql/03_consultas.sql) — ejecuta consultas para:
   - identificar ítems con stock bajo;
   - consultar salidas y pérdidas por responsable;
   - encontrar materias primas sin movimientos;
   - revisar productos con entradas y salidas;
   - calcular el valor de materias primas por bodega.

## Documentación

El informe completo del proyecto se encuentra en [`docs/EvaluacionU1_Isaac_Ramon.pdf`](docs/EvaluacionU1_Isaac_Ramon.pdf).

## Requisitos

- PostgreSQL
- Una base de datos creada para ejecutar los scripts

## Autor

**Isaac David Ramón Tinoco**
