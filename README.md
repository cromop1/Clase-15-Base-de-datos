<p align="center">
  <img src="https://img.shields.io/badge/Trabajo%20Acad%C3%A9mico-ITS%20Villada-blue?style=for-the-badge&logo=graduation-cap">
  <img src="https://img.shields.io/badge/Clase-15-6366F1?style=for-the-badge">
  <img src="https://img.shields.io/badge/Estado-Completo-22C55E?style=for-the-badge">
</p>

<p align="center">
  <img src="https://i.imgur.com/RVGaecC.png" width="100%">
</p>

<h1 align="center">🎬 Sakila DB — Clase 15</h1>
<h3 align="center">Vistas (Views) · CREATE OR REPLACE VIEW · GROUP_CONCAT · Agregaciones</h3>

<p align="center">
  <img src="https://img.shields.io/badge/MySQL-8.0-4479A1?style=flat-square&logo=mysql&logoColor=white">
  <img src="https://img.shields.io/badge/MariaDB-Compatible-003545?style=flat-square&logo=mariadb&logoColor=white">
  <img src="https://img.shields.io/badge/Dataset-Sakila-0F766E?style=flat-square">
  <img src="https://img.shields.io/badge/Lenguaje-SQL-F97316?style=flat-square&logo=databricks&logoColor=white">
</p>

<p align="center">
  <img src="https://i.imgur.com/zDTIHyR.png" width="100%">
</p>

---

<h2 align="center">📑 Índice</h2>

<div align="center">

| # | Sección | Descripción |
|:-:|---|---|
| 1 | 🏫 [Materia](#-materia) | Asignatura correspondiente al trabajo |
| 2 | 👨‍🏫 [Profesores](#-profesores) | Docentes a cargo |
| 3 | 👨‍🎓 [Alumno](#-alumno) | Estudiante responsable |
| 4 | 🗃️ [Base de datos](#-base-de-datos-utilizada) | Dataset utilizado |
| 5 | 🎯 [Objetivo](#-objetivo-del-trabajo) | Finalidad del trabajo |
| 6 | 🧠 [Conceptos aplicados](#-conceptos-aplicados) | Temas SQL utilizados |
| 7 | 📂 [Tablas utilizadas](#-tablas-utilizadas) | Tablas principales de Sakila |
| 8 | 📌 [Ejercicios](#-ejercicios) | Descripción de cada vista creada |
| 9 | ⚠️ [Consideraciones](#-consideraciones-importantes) | Notas técnicas y optimización |
| 10 | 📁 [Archivos del repo](#-archivos-del-repositorio) | Estructura del proyecto |
| 11 | 📚 [Fuentes](#-fuentes) | Material de referencia |
| 12 | 🧾 [Observaciones](#-observaciones-finales) | Cierre del informe |

</div>

<p align="center">
  <img src="https://i.imgur.com/zDTIHyR.png" width="100%">
</p>

## 🏫 Materia

**Base de Datos 2** — Instituto Técnico Salesiano Villada

<p align="center">
  <img src="https://i.imgur.com/zDTIHyR.png" width="100%">
</p>

## 👨‍🏫 Profesores

- Nose (cambio de profe)
- Teodoro Reyna

<p align="center">
  <img src="https://i.imgur.com/zDTIHyR.png" width="100%">
</p>

## 👨‍🎓 Alumno

- Bruno Segura

<p align="center">
  <img src="https://i.imgur.com/zDTIHyR.png" width="100%">
</p>

## 🗃️ Base de datos utilizada

**Sakila** es la base de datos de ejemplo oficial de MySQL, orientada a simular el negocio de alquiler de películas. Es ampliamente utilizada en entornos académicos para practicar modelado relacional, normalización, consultas avanzadas y definición de objetos de base de datos como vistas, triggers y procedimientos almacenados.

> 📥 Descarga oficial: [MySQL Sample Databases](https://dev.mysql.com/doc/sakila/en/)

<p align="center">
  <img src="https://i.imgur.com/zDTIHyR.png" width="100%">
</p>

## 🎯 Objetivo del trabajo

Diseñar, implementar y validar **Vistas (Views)** en MySQL mediante la instrucción `CREATE OR REPLACE VIEW`, abstrayendo la complejidad de modelos relacionales desnormalizados, agrupando métricas de negocio (como ventas por categoría y catálogos de películas) y generando representaciones estructuradas con funciones de agregación (`COUNT`, `SUM`, `GROUP_CONCAT`) y subqueries correlacionadas.

<p align="center">
  <img src="https://i.imgur.com/zDTIHyR.png" width="100%">
</p>

## 🧠 Conceptos aplicados

| Concepto | Descripción |
|---|---|
| `CREATE OR REPLACE VIEW` | Creación y actualización de tablas virtuales sin almacenar datos duplicados |
| `GROUP_CONCAT()` | Concatenación de múltiples registros en una única cadena de texto delimitada |
| `CASE WHEN` | Lógica condicional para transformación de estados booleanos a etiquetas descriptivas |
| `LEFT JOIN` / `INNER JOIN` | Cruce relacional conservando o restringiendo entidades dependientes |
| `SUM()` & `COUNT()` | Funciones de agregación para métricas cuantitativas y volumetría de datos |
| `GROUP BY` | Agrupamiento por llaves primarias y atributos dimensionales |
| Subqueries correlacionadas | Consultas anidadas evaluadas en el contexto de cada fila agrupada |

<p align="center">
  <img src="https://i.imgur.com/zDTIHyR.png" width="100%">
</p>

## 📂 Tablas utilizadas

```
sakila
├── customer             ← Datos y estado del cliente
├── address              ← Dirección física, código postal y teléfono
├── city                 ← Ciudad de residencia
├── country              ← País de ubicación
├── film                 ← Catálogo de películas (título, rating, precio, etc.)
├── category             ← Clasificación por género
├── film_category        ← Relación N:M entre films y categorías
├── actor                ← Información biográfica del elenco
├── film_actor           ← Relación N:M entre actores y films
├── inventory            ← Copias físicas/inventario en tiendas
├── rental               ← Transacciones de alquiler
└── payment              ← Registro de cobros y montos abonados
```

<p align="center">
  <img src="https://i.imgur.com/zDTIHyR.png" width="100%">
</p>

## 📌 Ejercicios

### 1 — 🧍 Vista: `list_of_customers`
Crea una vista que unifica la información personal y geográfica de cada cliente:
- `customer_id`, nombre completo (`CONCAT(first_name, ' ', last_name)`).
- Dirección (`address`), código postal (`zip_code`), teléfono (`phone`), ciudad (`city`) y país (`country`).
- Estado del cliente mediante estructura condicional `CASE` (`1` ➔ `'active'`, otro ➔ `'inactive'`).
- Identificador de la tienda asociada (`store_id`).

---

### 2 — 🎥 Vista: `film_details`
Crea una vista con los detalles esenciales de cada film, incorporando el listado consolidado de su reparto:
- Atributos directos: `film_id`, `title`, `description`, `category`, `price` (alias de `rental_rate`), `length`, `rating`.
- Elenco formateado (`actors`) obtenido mediante `GROUP_CONCAT(DISTINCT ... SEPARATOR ', ')` ordenado alfabéticamente por nombre y apellido del actor.
- Utiliza `LEFT JOIN` para contemplar films sin categoría o sin actores asignados.

---

### 3 — 💰 Vista: `sales_by_film_category`
Crea una vista analítica orientada a ventas que totaliza los ingresos por categoría:
- Relaciona el flujo transaccional: `payment` ➔ `rental` ➔ `inventory` ➔ `film` ➔ `film_category` ➔ `category`.
- Calcula el monto total recaudado (`SUM(amount) AS total_rental`) agrupado por nombre de categoría (`c.name`).
- Ordena los resultados de manera descendente por recaudación.

---

### 4 — 🎭 Vista: `actor_information`
Crea una vista de resumen para el elenco:
- Lista `actor_id`, `first_name`, `last_name`.
- Calcula la cantidad total de películas protagonizadas (`total_films`) mediante `COUNT(fa.film_id)`.
- Aplica `LEFT JOIN` para no excluir actores con cero producciones registradas.

---

### 5 — 🎞️ Vista: `actor_info`
Implementa una vista avanzada que emula y optimiza la vista estándar `actor_info` de Sakila:
- Agrupa el catálogo de cada actor por categorías con subquery correlacionada anidada.
- Genera un campo formateado `film_info` con el patrón `Categoría: Film 1, Film 2; Categoría 2: Film 3...`.
- Utiliza doble `GROUP_CONCAT` para agrupar títulos alfabéticamente dentro de cada género y géneros entre sí.

<p align="center">
  <img src="https://i.imgur.com/zDTIHyR.png" width="100%">
</p>

## ⚠️ Consideraciones importantes

> **Vistas y rendimiento:** Las vistas no almacenan datos físicamente (son consultas almacenadas). En consultas complejas con agregaciones como `sales_by_film_category` o `actor_info`, MySQL evalúa el plan de ejecución resolviendo las uniones en tiempo real (`algorithm = TEMPTABLE` / `UNDEFINED`).

> **GROUP_CONCAT Max Length:** Al concatenar grandes volúmenes de texto (como listas completas de actores o películas), tener en cuenta la variable del sistema `group_concat_max_len` de MySQL (por defecto 1024 bytes) si la cadena resultante es muy extensa.

> **LEFT JOIN vs INNER JOIN:** En `film_details` y `actor_information` se utilizó `LEFT JOIN` para asegurar que entidades sin relaciones asociadas no sean excluidas del conjunto de resultados.

<p align="center">
  <img src="https://i.imgur.com/zDTIHyR.png" width="100%">
</p>

## 📁 Archivos del repositorio

```
📦 clase-15/
 ┣ 📄 Querys.sql       → Script con todas las vistas (Views) creadas
 ┗ 📄 README.md        → Documentación técnica del proyecto
```

<p align="center">
  <img src="https://i.imgur.com/zDTIHyR.png" width="100%">
</p>

## 📚 Fuentes

- 📖 Guía de clase: [class_15.md](https://github.com/FrattinJuan/itsv-db-2/blob/master/classes/class_15.md)
- 📘 Documentación oficial MySQL Views: [MySQL 8.0 - CREATE VIEW Statement](https://dev.mysql.com/doc/refman/8.0/en/create-view.html)
- 🎬 Base de ejemplo Sakila: [MySQL Sample Databases](https://dev.mysql.com/doc/sakila/en/)

<p align="center">
  <img src="https://i.imgur.com/zDTIHyR.png" width="100%">
</p>

## 🧾 Observaciones finales

El conjunto de vistas desarrollado permite encapsular consultas con múltiples joins, cálculos y funciones de agregación complejas, facilitando el acceso a los datos tanto para capas de aplicación como para reportes analíticos, manteniendo la integridad y modularidad del diseño relacional.

<p align="center">
  <img src="https://i.imgur.com/zDTIHyR.png" width="100%">
</p>

<p align="center">
  <sub>🏫 Instituto Técnico Salesiano Villada · Base de Datos 2 · 2026</sub>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/%23sakila-%230F766E?style=flat-square">
  <img src="https://img.shields.io/badge/%23mysql-%234479A1?style=flat-square">
  <img src="https://img.shields.io/badge/%23sql-%23F97316?style=flat-square">
  <img src="https://img.shields.io/badge/%23basededatos2-%236366F1?style=flat-square">
  <img src="https://img.shields.io/badge/%23vistas-%238B5CF6?style=flat-square">
  <img src="https://img.shields.io/badge/%23trabajopractico-%2322C55E?style=flat-square">
</p>
