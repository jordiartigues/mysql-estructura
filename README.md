# Prácticas de Bases de Datos - MySQL Workbench

Repositorio que contiene el diseño, modelado, implementación y validación de dos bases de datos relacionales desarrolladas en MySQL Workbench: **Pizzería** y **Óptica**.

## Tecnologías

* MySQL / MySQL Workbench

## Estructura del proyecto

```text
.
├── Ejercicio Pizzeria/
│   ├── diagrama_pizzeria.png        # Esquema EER visual de la pizzería
│   └── script_pizzeria.sql          # Script SQL (Forward Engineering y datos de prueba)
├── Ejercicio Optica/
│   ├── diagrama_optica.png          # Esquema EER visual de la óptica
│   └── script_optica.sql            # Script SQL (Forward Engineering y datos de prueba)
└── README.md
```

## Descripción de los Proyectos

###  Proyecto 1: Pizzería
Gestión informatizada de una cadena de pizzerías, controlando clientes, tiendas, pedidos, repartos y tipos de productos (pizzas, bebidas, hamburguesas).
* **Modelado de datos**: Tablas para `Cliente`, `Tienda`, `Empleado`, `Producto`, `Categoria`, `Venta`, `Detalle_Venta` y `Reparto`.
* **Validaciones y consultas**: Cálculo de ventas de productos concretos por localidad y recuento de pedidos por repartidor.

###  Proyecto 2: Óptica
Gestión de clientes, proveedores, marcas y ventas de gafas para un establecimiento comercial.
* **Modelado de datos**: Proveedores, marcas, tipos de montura, control de graduaciones con `DECIMAL(4,2)` y autorrelación en `cliente` para el sistema de recomendaciones.
* **Validaciones y consultas**: Identificación de proveedores por gafa, seguimiento de recomendaciones en cadena y filtrado de ventas por empleado en un periodo determinado (`BETWEEN`).

## Instalación y Ejecución

1. Clonar el repositorio:
   ```bash
   git clone [https://github.com/jordiartigues/mysql-estructura.git]
   ```
2. Abrir **MySQL Workbench**.
3. Importar o ejecutar los scripts SQL contenidos en las carpetas `ejercicio Pizzeria/` y `ejercicio Optica/` para generar la estructura y cargar los datos de prueba.
4. Consultar los diagramas `.png` para revisar el modelado EER de cada uno de los ejercicios.

## Autor

Jordi
