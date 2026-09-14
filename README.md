# Proyecto SQL

# 🗄️ Ejercicios Resueltos de SQL - Base de Datos Shakila

Este repositorio contiene la resolución de una serie de ejercicios prácticos de SQL enfocados en la base de datos de prueba **Shakila** que fue proporcionada. El objetivo principal es ejercitar la construcción de consultas complejas, el manejo de uniones de tablas, funciones de agregación y lógica condicional.


## 📋 Contenido

Los ejercicios abarcan los siguientes temas y conceptos de SQL:

- **Consultas básicas y filtrado:** `SELECT`, `WHERE`, `LIKE`, `IN`, `BETWEEN`.
- **Uniones de tablas (JOINs):** `INNER JOIN`, `LEFT JOIN` y `CROSS JOIN`.
- **Agregación y agrupación:** `GROUP BY`, `HAVING`, `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`.
- **Concatenación de resultados:** `STRING_AGG` / `GROUP_CONCAT`.
- **Manejador de fechas y temporales:** Cálculo de diferencias entre fechas (`DATEDIFF`, resta de timestamps) y filtrado por estado de retorno (`IS NULL`).
- **Subconsultas:** Filtrado mediante `NOT EXISTS`, `NOT IN` y comparación con valores agregados escalares.
- **Vistas y tablas temporales**

## 🛠️ Requisitos

Para ejecutar estas consultas se requiere:

1. Un motor de base de datos relacional compatible **PostgreSQL**.
2. La base de datos **Sakila**.
3. El cliente SQL DBeaver.

## 📂 Estructura del Repositorio

```text
.
├── README.md
└── ejercicios_sakila.sql    # Archivo con todas las consultas comentadas y ordenadas
└── 2.2-ADJ 1-BBDD_Proyecto_shakila_sinuser.sql #Archivo con el esquema de la base de datos proporcionado
├── Shakila_Dia.erd  #Diagrama entidad relacion 
