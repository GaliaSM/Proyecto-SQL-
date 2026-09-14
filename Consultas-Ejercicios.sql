/** Ejercicio 1. Crea el esquema de la BBDD. **/
/** Se ejecuto en una nuva base de datos el archivo sql suministrado en la definición del
 proyecto, creando las tablas y llenando con los datos suministrados **/

/** Ejercicio 2. Muestra los nombres de todas las películas con una clasificación por
edades de ‘R’. **/
select title from film
where rating='R';

/** Ejercicio 3. Encuentra los nombres de los actores que tengan un “actor_id” entre 30
y 40. **/
select first_name, last_name from actor a
where a.ACTOR_ID>=30 and a.ACTOR_ID <= 40

/** Ejercicio 4. Obtén las películas cuyo idioma coincide con el idioma original. **/
select * from film f
where f.ORIGINAL_LANGUAGE_ID = language_id
-- No hubo respuesta porque el idioma original está en NULL

/** Ejercicio 5. Ordena las películas por duración de forma ascendente.**/
select * from film
order by film.LENGTH asc

/** Ejercicio 6. Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su
apellido. **/
SELECT a.FIRST_NAME, a.LAST_NAME from ACTOR a 
where a.LAST_NAME = 'ALLEN'

/** Ejercicio 7. Encuentra la cantidad total de películas en cada clasificación de la tabla
“film” y muestra la clasificación junto con el recuento. **/
select F.RATING, count(*) as cantidad_total from FILM F 
group by F.RATING

/** Ejercicio 8. Encuentra el título de todas las películas que son ‘PG-13’ o tienen una
duración mayor a 3 horas en la tabla film.**/
SELECT F.TITLE  from FILM F 
where F.RATING = 'PG-13' or F.LENGTH > 180

/** Ejercicio 9. Encuentra la variabilidad de lo que costaría reemplazar las películas.**/
SELECT variance(f.REPLACEMENT_COST) as Varianza, stddev(f.REPLACEMENT_COST) as Desviación_Estandar
from FILM F

/** Ejercicio 10. Encuentra la mayor y menor duración de una película de nuestra BBDD. **/
SELECT min(f.LENGTH) as Menor_Duración, max(f.LENGTH) as Mayor_Duración from FILM F

/** Ejercicio 11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día. **/
SELECT  p.amount AS costo, r.rental_date AS fecha_alquiler
FROM rental r
JOIN payment p ON r.rental_id = p.rental_id
ORDER BY r.rental_date DESC
LIMIT 1 OFFSET 2; 

/** Ejercicio 12. Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC-
17’ ni ‘G’ en cuanto a su clasificación.**/
select F.TITLE from FILM F 
where f.RATING not in ('NC-17', 'G')

/** Ejercicio 13. Encuentra el promedio de duración de las películas para cada
clasificación de la tabla film y muestra la clasificación junto con el
promedio de duración. **/
select f.rating as clasificacion, avg(f.length) from film f
group by f.rating

/** Ejercicio 14. Encuentra el título de todas las películas que tengan una duración mayor
a 180 minutos **/
select f.title from film f
where f.LENGTH > 180

/** Ejercicio 15 ¿Cuánto dinero ha generado en total la empresa? **/
select sum(p.amount) from payment p

/** Ejercicio 16. Muestra los 10 clientes con mayor valor de id. **/
select c.CUSTOMER_ID, c.FIRST_NAME, c.LAST_NAME from CUSTOMER c
order by c.CUSTOMER_ID desc 
limit 10

/** Ejercicio 17. Encuentra el nombre y apellido de los actores que aparecen en la
película con título ‘Egg Igby’ **/
SELECT  
FROM ACTOR a 
INNER JOIN FILM_ACTOR fa on a.ACTOR_ID = fa.ACTOR_ID 
INNER JOIN FILM f on fa.FILM_ID = f.FILM_ID 
WHERE f.TITLE = 'Egg Igby'

/** Ejercicio 18. Selecciona todos los nombres de las películas únicos **/
SELECT DISTINCT title 
FROM film;

/** Ejercidio 19. Encuentra el título de las películas que son comedias y tienen una
duración mayor a 180 minutos en la tabla “film”. **/
SELECT f.TITLE FROM FILM f
inner join FILM_CATEGORY fc on f.FILM_ID  = fc.FILM_ID 
inner join CATEGORY c on fc.CATEGORY_ID = c.CATEGORY_ID 
WHERE c."name"  = 'Comedy' AND f.LENGTH > 180

/** Ejercicio 20.  Encuentra las categorías de películas que tienen un promedio de
duración superior a 110 minutos y muestra el nombre de la categoría
junto con el promedio de duración. **/
SELECT c."name", avg(f.LENGTH) FROM FILM f
inner join FILM_CATEGORY fc on f.FILM_ID  = fc.FILM_ID 
inner join CATEGORY c on fc.CATEGORY_ID = c.CATEGORY_ID 
group by c."name"
HAVING AVG(f.LENGTH)>110

/** Ejercicio 21. ¿Cuál es la media de duración del alquiler de las películas? **/
select avg(f.RENTAL_DURATION) as media_renta(dias) from film f 

/** Ejercicio 22. Crea una columna con el nombre y apellidos de todos los actores y
actrices. **/

select concat(a.FIRST_NAME,' ', a.last_name) as Actores from ACTOR a

/** Ejercicio 23. Números de alquiler por día, ordenados por cantidad de alquiler de
forma descendente. **/
select r.rental_date, count(r.RENTAL_DATE) from rental r
group by r.RENTAL_DATE 
order by count(r.RENTAL_DATE) DESC 

/** Ejercicio 24. Encuentra las películas con una duración superior al promedio. **/
select f.title, f.LENGTH 
from FILM f 
where f.LENGTH > (select avg(length) from film)

/** Ejercicio 25. Averigua el número de alquileres registrados por mes **/
SELECT  DATE_TRUNC('month', rental_date) AS mes, COUNT(*) AS total_alquileres
FROM rental
GROUP BY mes
ORDER BY mes

/** Ejercicio 26. Encuentra el promedio, la desviación estándar y varianza del total
pagado. **/
SELECT avg(AMOUNT) as promedio, stddev(AMOUNT) as Desviación_Estandar, variance(AMOUNT)
FROM PAYMENT

/** Ejercicio 27. ¿Qué películas se alquilan por encima del precio medio? **/
SELECT f.TITLE from FILM f
inner join INVENTORY i on f.FILM_ID = i.FILM_ID
inner join RENTAL r on i.INVENTORY_ID = r.INVENTORY_ID
inner join PAYMENT p on r.RENTAL_ID = p.RENTAL_ID
where p.AMOUNT > (select avg(amount) from PAYMENT)

/** Ejercicio 28. Muestra el id de los actores que hayan participado en más de 40
películas. **/
SELECT a.ACTOR_ID FROM ACTOR a
inner join FILM_ACTOR fa ON fa.ACTOR_ID = a.ACTOR_ID 
GROUP BY a.ACTOR_ID 
HAVING count(fa.ACTOR_ID) > 40

/** Ejercicio 29.Obtener todas las películas y, si están disponibles en el inventario,
mostrar la cantidad disponible. **/
SELECT f.film_id, f.title, COUNT(i.inventory_id) AS cantidad_disponible
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
GROUP BY f.film_id, f.title
ORDER BY f.title;

/** Ejercicio 30. Obtener los actores y el número de películas en las que ha actuado. **/
SELECT a.ACTOR_ID, a.FIRST_NAME, a.LAST_NAME, COUNT(fa.ACTOR_ID) as cantidad_de_peliculas  
FROM ACTOR a
inner join FILM_ACTOR fa ON fa.ACTOR_ID = a.ACTOR_ID 
GROUP BY a.ACTOR_ID 

/** Ejercicio 31. Obtener todas las películas y mostrar los actores que han actuado en
ellas, incluso si algunas películas no tienen actores asociados. **/
SELECT f.TITLE, a.FIRST_NAME, a.LAST_NAME  
from FILM f
left join FILM_ACTOR fa on f.FILM_ID = fa.FILM_ID
left join ACTOR a on fa.ACTOR_ID = a.ACTOR_ID 

/** Ejercicio 32. Obtener todos los actores y mostrar las películas en las que han
actuado, incluso si algunos actores no han actuado en ninguna película. **/
SELECT a.FIRST_NAME, a.LAST_NAME, f.TITLE 
from ACTOR a
left join FILM_ACTOR fa on a.ACTOR_ID = fa.ACTOR_ID 
left join FILM f on fa.FILM_ID  = f.FILM_ID 

/** Ejercicio 33. Obtener todas las películas que tenemos y todos los registros de
alquiler. **/
SELECT f.title, count(i.FILM_ID) as registros_alquiler from FILM f
join INVENTORY i on f.FILM_ID = i.FILM_ID 
group by f.TITLE 


/** Ejercicio 34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros. **/
SELECT c.CUSTOMER_ID, sum(p.AMOUNT) as gasto
from CUSTOMER c
inner join PAYMENT P on c.CUSTOMER_ID = P.CUSTOMER_ID
group by c.CUSTOMER_ID 
order by gasto DESC 

/** Ejercicio 35.Selecciona todos los actores cuyo primer nombre es 'Johnny'. **/
SELECT a.FIRST_NAME, a.LAST_NAME 
from ACTOR a 
where a.FIRST_NAME = UPPER('Johnny')

/** Ejercicio 36. Renombra la columna “first_name” como Nombre y “last_name” como
Apellido. **/
SELECT a.FIRST_NAME as Nombre, a.LAST_NAME as Apellido 
from ACTOR a 

/** Ejercicio 37. Encuentra el ID del actor más bajo y más alto en la tabla actor **/
SELECT MIN(ACTOR_ID) as ID_bajo, MAX(ACTOR_ID) as ID_alto
from ACTOR

SELECT ACTOR_ID, FIRST_NAME, LAST_NAME 
from ACTOR
where ACTOR_ID = (select MIN(ACTOR_ID) from ACTOR)
or ACTOR_ID = (select MAX(ACTOR_ID) from ACTOR)

/** Ejercicio 38. Cuenta cuántos actores hay en la tabla “actor”. **/
SELECT count(ACTOR_ID) as Cantidad_Actores
FROM ACTOR

/** Ejercicio 39. Selecciona todos los actores y ordénalos por apellido en orden
ascendente. **/
SELECT FIRST_NAME as Nombre, LAST_NAME as Apellido
from ACTOR
ORDER by LAST_NAME ASC

/** Ejercicio 40. Selecciona las primeras 5 películas de la tabla “film”. **/
SELECT TITLE 
FROM FILM 
LIMIT 5

/** Ejercicio 41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el
mismo nombre. ¿Cuál es el nombre más repetido? **/
SELECT FIRST_NAME, count(FIRST_NAME) as repetido
from ACTOR
group by FIRST_NAME
ORDER by repetido desc 

/** Ejercicio 42.  Encuentra todos los alquileres y los nombres de los clientes que los
realizaron. **/
SELECT c.FIRST_NAME, c.LAST_NAME, count(r.RENTAL_ID) as Cantidad_Rentas
FROM CUSTOMER c 
join RENTAL r on c.CUSTOMER_ID = r.CUSTOMER_ID 
GROUP by r.CUSTOMER_ID, c.FIRST_NAME, c.LAST_NAME  

/** Ejercicio 43. Muestra todos los clientes y sus alquileres si existen, incluyendo
aquellos que no tienen alquileres. **/
SELECT c.FIRST_NAME, c.LAST_NAME, DISTINCT(f.title) AS "Peliculas_Alquiladas"
FROM CUSTOMER c 
left join RENTAL r on c.CUSTOMER_ID = r.CUSTOMER_ID 
left join INVENTORY i on r.INVENTORY_ID = i.INVENTORY_ID 
left join FILM f on i.FILM_ID = f.FILM_ID
group by c.FIRST_NAME, c.LAST_NAME, f.TITLE 
order by c.FIRST_NAME, c.LAST_NAME 

/** En esta consulta se debe combinar con diferentes tablas para llegar a la tabla que tiene
 * las peliculas alquiladas y asi poder obtener todos los clientes por eso se opto por hacer 
 * un left join para que incluya todos los clientes que tengan o no alquileres **/

/** Ejercicio 44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor
esta consulta? ¿Por qué? Deja después de la consulta la contestación. **/
select * 
from FILM f
cross join CATEGORY C 
/** Es una consulta que combina cada fila de film con todas las filas de category
  En este caso no observo que aporta valor porque no me da ninguna información que me
  ayude a saber a que categoria pertenece la pelicula, ya que las empareja con todas. **/

/** Ejercicio 45. Encuentra los actores que han participado en películas de la categoría
'Action'. **/
SELECT a.FIRST_NAME, a.LAST_NAME 
from ACTOR a
join FILM_ACTOR FA on a.ACTOR_ID = fa.ACTOR_ID 
join FILM f on fa.FILM_ID = f.FILM_ID 
join FILM_CATEGORY fc on f.FILM_ID =fc.FILM_ID 
join CATEGORY c on fc.CATEGORY_ID = c.CATEGORY_ID 
where c."name" = 'Action'

/** Ejercicio 46. Encuentra todos los actores que no han participado en películas. **/
SELECT a.FIRST_NAME, a.LAST_NAME 
from ACTOR a
left join FILM_ACTOR FA on a.ACTOR_ID = fa.ACTOR_ID 
left join FILM f on fa.FILM_ID = f.FILM_ID
where fa.FILM_ID = null

/** Ejercicio 47. Selecciona el nombre de los actores y la cantidad de películas en las
que han participado. **/
SELECT a.FIRST_NAME, a.LAST_NAME, count(fa.FILM_ID) as cantidad_peliculas
from ACTOR a
left join FILM_ACTOR FA on a.ACTOR_ID = fa.ACTOR_ID 
left join FILM f on fa.FILM_ID = f.FILM_ID
GROUP by a.ACTOR_ID, a.FIRST_NAME, a.LAST_NAME  


/** Ejercicio 48. Crea una vista llamada “actor_num_peliculas” que muestre los nombres
de los actores y el número de películas en las que han participado. **/

CREATE view actor_num_peliculas as
SELECT a.FIRST_NAME, a.LAST_NAME, count(fa.FILM_ID) as cantidad_peliculas
from ACTOR a
left join FILM_ACTOR FA on a.ACTOR_ID = fa.ACTOR_ID 
left join FILM f on fa.FILM_ID = f.FILM_ID
GROUP by a.ACTOR_ID, a.FIRST_NAME, a.LAST_NAME  

-- Consulta de la vista --
select * from actor_num_peliculas 

/** Ejercicio 49. Calcula el número total de alquileres realizados por cada cliente. **/
SELECT c.FIRST_NAME, c.LAST_NAME, count(r.RENTAL_ID) as cantidad_alquileres
FROM CUSTOMER c 
left join RENTAL r on c.CUSTOMER_ID = r.CUSTOMER_ID 
left join INVENTORY i on r.INVENTORY_ID = i.INVENTORY_ID 
left join FILM f on i.FILM_ID = f.FILM_ID
group by c.CUSTOMER_ID, c.FIRST_NAME, c.LAST_NAME 
order by c.FIRST_NAME, c.LAST_NAME 

/** Ejercicio 50. Calcula la duración total de las películas en la categoría 'Action'. **/
SELECT sum(f.LENGTH) as Duracion_total_cat_Action
from FILM f 
join FILM_CATEGORY fc on f.FILM_ID =fc.FILM_ID 
join CATEGORY c on fc.CATEGORY_ID = c.CATEGORY_ID 
where c."name" = 'Action'

/** Ejercicio 51. Crea una tabla temporal llamada “cliente_rentas_temporal” para
almacenar el total de alquileres por cliente. **/
CREATE TEMPORARY table cliente_rentas_temporal as 
SELECT c.FIRST_NAME, c.LAST_NAME, count(r.RENTAL_ID) as cantidad_alquileres
FROM CUSTOMER c 
left join RENTAL r on c.CUSTOMER_ID = r.CUSTOMER_ID 
left join INVENTORY i on r.INVENTORY_ID = i.INVENTORY_ID 
left join FILM f on i.FILM_ID = f.FILM_ID
group by c.CUSTOMER_ID, c.FIRST_NAME, c.LAST_NAME 
order by c.FIRST_NAME, c.LAST_NAME

-- Consulta de la tabla temporal --
SELECT * from cliente_rentas_temporal

/** Ejercicio 52. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las
películas que han sido alquiladas al menos 10 veces. **/

CREATE TEMPORARY table peliculas_alquiladas as 
SELECT f.title, count(r.RENTAL_ID) as cantidad_alquileres
FROM CUSTOMER c 
left join RENTAL r on c.CUSTOMER_ID = r.CUSTOMER_ID 
left join INVENTORY i on r.INVENTORY_ID = i.INVENTORY_ID 
left join FILM f on i.FILM_ID = f.FILM_ID
group by f.FILM_ID, f.TITLE
having count(r.RENTAL_ID) >= 10
order by cantidad_alquileres desc

SELECT * from peliculas_alquiladas

/** Ejercicio 53. Encuentra el título de las películas que han sido alquiladas por el cliente
con el nombre ‘Tammy Sanders’ y que aún no se han devuelto. Ordena
los resultados alfabéticamente por título de película.. **/
SELECT f.title
FROM CUSTOMER c 
left join RENTAL r on c.CUSTOMER_ID = r.CUSTOMER_ID 
left join INVENTORY i on r.INVENTORY_ID = i.INVENTORY_ID 
left join FILM f on i.FILM_ID = f.FILM_ID
where c.FIRST_NAME='TAMMY' and c.LAST_NAME='SANDERS'
and r.RETURN_DATE is NULL 
order by f.title 

/** Ejercicio 54. Encuentra los nombres de los actores que han actuado en al menos una
película que pertenece a la categoría ‘Sci-Fi’. Ordena los resultados
alfabéticamente por apellido. **/
SELECT a.FIRST_NAME, a.LAST_NAME, count(a.ACTOR_ID) as cantidad
from ACTOR a
join FILM_ACTOR fa on a.ACTOR_ID = fa.ACTOR_ID 
join FILM f on fa.FILM_ID = f.FILM_ID 
join FILM_CATEGORY fc on f.FILM_ID =fc.FILM_ID 
join CATEGORY c on fc.CATEGORY_ID = c.CATEGORY_ID 
where c."name" = 'Sci-Fi'
GROUP by a.ACTOR_ID, a.FIRST_NAME, a.LAST_NAME 
order by a.LAST_NAME 


/**Ejercicio 55. Encuentra el nombre y apellido de los actores que han actuado en
películas que se alquilaron después de que la película ‘Spartacus
Cheaper’ se alquilara por primera vez. Ordena los resultados
alfabéticamente por apellido. **/


SELECT DISTINCT a.FIRST_NAME, a.LAST_NAME 
FROM ACTOR a
join FILM_ACTOR fa on a.ACTOR_ID = fa.ACTOR_ID 
join FILM f on fa.FILM_ID = f.FILM_ID 
join INVENTORY i on f.FILM_ID = i.FILM_ID 
join RENTAL r on i.INVENTORY_ID = r.INVENTORY_ID
where r.RENTAL_DATE > 
	(SELECT min(r2.RENTAL_DATE) as Primera_vez_rentada
	FROM FILM f2
	join INVENTORY i2 on f2.FILM_ID = i2.FILM_ID 
	join RENTAL r2 on i2.INVENTORY_ID = r2.INVENTORY_ID 
	where f2.TITLE = UPPER('Spartacus Cheaper') 
	)
order by a.LAST_NAME 
/**En esta consulta se requiere hacer una subconsulta para obtener la fecha de renta de la pelicula
 * por primera vez, alli se obtiene la fecha que se compara con la fecha de renta que se quiere 
 * que sea mayor a la obtenida en la subconsulta **/

/** Ejercicio 56. Encuentra el nombre y apellido de los actores que no han actuado en
ninguna película de la categoría ‘Music’. **/
SELECT a.last_name AS "Apellido", a.first_name AS "Nombre"
FROM actor a
WHERE NOT EXISTS (
    SELECT 1
    FROM film_actor fa
    JOIN film_category fc ON fa.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    WHERE fa.actor_id = a.actor_id
      AND c.name = 'Music'
)
ORDER BY a.last_name, a.first_name;

/** En esta consulta se uso en No Exists del resultado de una subconsulta que me trae los actores que han actuado en 
 * peliculas de la categoria music **/ 

/** Ejercicio 57. Encuentra el título de todas las películas que fueron alquiladas por más
de 8 días. **/
SELECT DISTINCT f.TITLE 
FROM FILM f
join INVENTORY i on f.FILM_ID = i.FILM_ID 
join RENTAL r on i.INVENTORY_ID = r.INVENTORY_ID 
where r.RETURN_DATE is NOT NULL and (r.RETURN_DATE::date - r.RENTAL_DATE::date) > 8
order by f.title


/** Ejercicio 58. Encuentra el título de todas las películas que son de la misma categoría
que ‘Animation’ **/
SELECT distinct f.title
from FILM f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
where c."name" ='Animation'


/** Ejercicio 59. Encuentra los nombres de las películas que tienen la misma duración
que la película con el título ‘Dancing Fever’. Ordena los resultados
alfabéticamente por título de película. **/
SELECT f.title
from FILM f
where f.LENGTH = (select f1.length
 		from FILM f1
 		where f1.TITLE =upper('Dancing Fever')
)
order by f.TITLE 


/** Ejercicio 60. Encuentra los nombres de los clientes que han alquilado al menos 7
películas distintas. Ordena los resultados alfabéticamente por apellido. **/
SELECT c.first_name AS "Nombre", c.last_name AS "Apellido", COUNT(DISTINCT i.film_id) AS total_peliculas_distintas
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT i.film_id) >= 7
ORDER BY c.last_name ASC, c.first_name ASC;

/** Ejercicio 61. Encuentra la cantidad total de películas alquiladas por categoría y
muestra el nombre de la categoría junto con el recuento de alquileres. **/
SELECT c."name", count(fc.FILM_ID)
from RENTAL r
join INVENTORY i on r.INVENTORY_ID = i.INVENTORY_ID
join FILM f on i.FILM_ID = f.FILM_ID
join FILM_CATEGORY fc on f.FILM_ID = fc.FILM_ID 
join CATEGORY c on fc.CATEGORY_ID = c.CATEGORY_ID 
group by c.CATEGORY_ID, c."name" 


/** Ejercicio 62. Encuentra el número de películas por categoría estrenadas en 2006. **/
SELECT c.name as categoria, count(f.FILM_ID) as estreno_2006
from FILM f
join FILM_CATEGORY FC on f.FILM_ID = FC.FILM_ID
join CATEGORY C on fc.CATEGORY_ID = c.CATEGORY_ID 
where f.RELEASE_YEAR = 2006
group by c."name" 

/** Ejercicio 63. Obtén todas las combinaciones posibles de trabajadores con las tiendas
que tenemos. **/
SELECT s.first_name AS "Nombre_Trabajador", s.last_name AS "Apellido_Trabajador", st.store_id AS "ID_Tienda"
FROM staff s
CROSS JOIN store st;
/** Se obtiene todas las combinaciones posibles de cada fila de trabajadores o staff con cada fila de
 la tienda o store dando como resultado una tabla de cuatro filas ya que solo se tienen dos empleados
 y dos tiendas **/

/** Ejercicio 64. Encuentra la cantidad total de películas alquiladas por cada cliente y
muestra el ID del cliente, su nombre y apellido junto con la cantidad de
películas alquiladas. **/
SELECT c.first_name AS "Nombre", c.last_name AS "Apellido", COUNT(i.film_id) AS total_peliculas_alquiladas
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY c.last_name ASC, c.first_name ASC;



