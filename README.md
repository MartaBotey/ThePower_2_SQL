# ThePower_2_SQL

# 📖 Análisis de la base de datos de Sakila

### 📌 Descripción

Este proyecto consiste en la realización de consultas SQL sobre una base de datos de una tienda ficticia de alquiler de películas.

### 🎯 Objetivos

- Practicar consultas SQL.
- Utilizar filtros, ordenaciones y funciones de agregación.
- Analizar la información almacenada en la base de datos.

### 📂 Estructura del proyecto

- README.md: descripción del proyecto.
- Base de datos original: BBDD_Proyecto_shakila_sinuser.
- Esquema de la BBDD: Proyecto_SQL_Diagrama.
- Archivo SQL con las consultas resueltas: Proyecto_SQL_Consultas.

### 🛠️ Instalación y requisitos

- PostgreSQL
- DBeaver

### 📊 Resultados y conclusiones

Diagrama del proyecto:
<img width="1356" height="862" alt="image" src="https://github.com/user-attachments/assets/e9fde128-5b37-4496-9f77-9777088199fa" />

Todas las consultas realizadas se encuentran recogidas en el archivo SQL adjunto: LógicaConsultasSQL. Además, se han incorporado comentarios explicativos y justificaciones de los resultados con el objetivo de documentar el proceso de análisis realizado.

Durante el desarrollo del proyecto se han trabajado distintas herramientas y funcionalidades de SQL para el análisis de datos: 
  - INNER JOIN 
  - LEFT JOIN
  - RIGHT JOIN
  - FULL JOIN
  - CROSS JOIN
  - Subconsultas
  - CTE (Common Table Expressions)
  - Vistas
  - Tablas temporales
  - Funciones de agregación (COUNT, AVG, SUM, STDDEV y VARIANCE) 

Las funciones de agregación han permitido obtener información estadística sobre la base de datos, facilitando el análisis de distribuciones, medias y niveles de dispersión de los datos.

Se ha comprobado la importancia de elegir el tipo de JOIN adecuado en función de los datos que se desean conservar, ya que distintas estrategias pueden producir resultados diferentes aun siendo consultas aparentemente similares.

También se ha observado que una tabla puede eliminarse de una consulta si no se utiliza ninguna de sus columnas y existe otro camino válido para realizar las relaciones necesarias. Como se observa en la consulta 55 que pasamos de 'film_category a 'inventary' sin pasar por la tabla 'film' porque los dos comparten 'film_id', y no usamos ninguna columna de 'film'. 

En algunos casos se ha utilizado ORDER BY para facilitar la lectura e interpretación de los resultados. 

Un aspecto destacable es que la columna original_language_id no contiene valores, ya que todos sus registros son NULL (consulta 4). 

Por último, se ha observado que algunas consultas comparten la misma lógica y únicamente difieren en la presentación de los resultados, como sucede en las consultas 49 y 64. En cuanto a las consultas 30 y 47, se han considerado diferentes interpretaciones del enunciado, por lo que en la consulta 47 se incluye una segunda propuesta de solución. 
 

En conjunto, este proyecto ha permitido afianzar los conceptos fundamentales de SQL y comprender mejor el funcionamiento de una base de datos relacional, así como las distintas técnicas de consulta y análisis de datos. 

### 🤝 Contribuciones

Cualquier sugerencia o propuesta de mejora será bienvenida. 

### ✒️ Autor

Marta Botey <br>
Base de datos proporcionada por The Power. 
