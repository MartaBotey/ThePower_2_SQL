-- 1. Crea el esquema de la BBDD -> Diagrama adunto en fichero independiente y en el README

-- 2. Muestra los nombres de todas las películas con una clasificación por edades de ‘Rʼ:
select title
from film
where rating = 'R';

-- 3. Encuentra los nombres de los actores que tengan un “actor_idˮ entre 30 y 40.
select concat(a.first_name ,' ', a.last_name ) as nombre_actor
from actor a 
where a.actor_id between 30 and 40; 

-- 4. Obtén las películas cuyo idioma coincide con el idioma original.
select f.title 
from film f 
where f.language_id = f.original_language_id ;
	--todso los valores son Null así que no develve nada.Para verificar que solo tengo valores Null en la lengua original:
SELECT COUNT(*)
FROM film
WHERE original_language_id IS NOT NULL;
	-- para confirmar que todas las pelícuals estan en inglés:
select l.name, count(*) as Peliculas
from film f 
join "language" l
	on f.language_id = l.language_id 
group by l."name" 

-- 5. Ordena las películas por duración de forma ascendente.
select f.title , f.length 
from film f 
order by f.length ASC ;

-- 6.  Encuentra el nombre y apellido de los actores que tengan ‘Allenʼ en su apellido.
select concat(a.first_name ,' ', a.last_name ) as nombre_actor
from actor a 
where a.last_name = 'ALLEN';

-- 7. Encuentra la cantidad total de películas en cada clasificación de la tabla “filmˮ y muestra la clasificación junto con el recuento.
select f.rating as Classificacion, count(*) as recuento
from film f 
group by f.rating ;

-- 8. Encuentra el título de todas las películas que son ‘PG-13ʼ o tienen una duración mayor a 3 horas en la tabla film.
select f.title , f.rating , f.length 
from film f 
where f.rating = 'PG-13' or f.length > 180;

-- 9. Encuentra la variabilidad de lo que costaría reemplazar las películas.
select variance(f.replacement_cost) as Variabilidad
from film f ;
	--si quremos redondear a dos decimales para que sea más legible:
select round (variance(f.replacement_cost),2) as Variabilidad
from film f ;

-- 10.  Encuentra la mayor y menor duración de una película de nuestra BBDD.
select MAX(f.length) as duracion_maxima ,  MIN(length ) as duracion_minima
from film f ; 
		-- si quiero que salga el titulo de la pelicual:
select f.title , f.length 
from film f 
where f.length = (
	select MAX (f.length )
	from film f)
	or f.length  =(
	select MIN (f.length )
	from film f)
order by f.length asc ;

-- 11.  Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
select p.amount as amount_antepenultimo
from rental r 
join payment p 
	on r.rental_id = p.rental_id
order by r.rental_id desc
limit 1 offset 2 ;

-- 12. Encuentra el título de las películas en la tabla “filmˮ que no sean ni ‘NC-17ʼ ni ‘Gʼ en cuanto a su clasificación.
select f.title , f.rating 
from film f 
where f.rating not in ( 'NC-17' , 'G' );

-- 13.  Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración. (he redondeado el resultado a 2 decimales)
select round(AVG(f.length ),2) as promedio_duracion , f.rating  as clasificacion
from film f 
group by f.rating ;

-- 14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.
select f.title
from film f
where f.length > 180;

-- 15. ¿Cuánto dinero ha generado en total la empresa?
select SUM( p.amount ) as ingresos_totales
from payment p;

-- 16. Muestra los 10 clientes con mayor valor de id.
select concat( c.first_name , ' ', c.last_name ) as clientes
from customer c 
order by c.customer_id desc
limit 10;

-- 17.  Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igbyʼ.
select a.first_name , a.last_name
from actor a 
inner join film_actor fa
	on a.actor_id = fa.actor_id 
inner join film f
	on fa.film_id = f.film_id
where f.title  = 'EGG IGBY';
	-- si queremos verlos nombre y apellido junto más la pelcula
select concat( a.first_name , ' ', a.last_name) as Actores, f.title 
from actor a 
inner join film_actor fa
	on a.actor_id = fa.actor_id 
inner join film f
	on fa.film_id = f.film_id
where f.title  = 'EGG IGBY';

-- 18. Selecciona todos los nombres de las películas únicos.
select distinct f.title 
from film f ;

-- 19.  Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “filmˮ.
select f.title
from film f 
inner join film_category fc 
	on f.film_id = fc.film_id 
inner join category c 
	on fc.category_id = c.category_id 
where c."name" = 'Comedy'and f.length > 180;

-- 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.
select c."name" , round(AVG(f.length )) as promedio_duracion
from category c 
inner join film_category fc 
	on c.category_id = fc.category_id 
inner join film f 
	on fc.film_id = f.film_id 
group by c."name" 
having AVG(f.length ) > 110;

-- 21.  ¿Cuál es la media de duración del alquiler de las películas?
select AVG (f.rental_duration) as media_duracion_alquiler
from film f ;

-- 22. Crea una columna con el nombre y apellidos de todos los actores y actrices.
select concat(a.first_name ,' ', a.last_name ) as nombre_actor
from actor a ;

-- 23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.
select date (r.rental_date ) as dia,
	count(*) as numero_alquileres
from rental r
group by date (r.rental_date )
order by numero_alquileres desc;

-- 24. Encuentra las películas con una duración superior al promedio.
select f.title 
from film f 
where f.length  > (
	select AVG(f2.length)
	from film f2  
);

-- 25. Averigua el número de alquileres registrados por mes.
select extract (month from rental_date) as mes,
	count(*) as n_alquileres
from rental
group by extract(month from rental_date)
order by mes;

-- 26.  Encuentra el promedio, la desviación estándar y varianza del total pagado.
select ROUND(AVG(p.amount ),2) as promedio, 
	   ROUND(stddev(p.amount ),2) as desviacion_std, 
	   Round(variance(p.amount ),2) as varianza
from payment p ;

-- 27.  ¿Qué películas se alquilan por encima del precio medio?
select f.title 
from film f 
where f.rental_rate  > (
	select AVG(rental_rate )
	from film
);

-- 28. Muestra el id de los actores que hayan participado en más de 40 películas.
select fa.actor_id 
from film_actor fa 
group by actor_id 
having count(fa.film_id )>40;

-- 29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.
select f.title , count(i.inventory_id ) as cantidad_disponible
from film f 
left join inventory i 
	on f.film_id = i.film_id 
group by f.film_id , f.title 
order by f.title;

-- 30. Obtener los actores y el número de películas en las que ha actuado.
select concat(a.first_name ,' ', a.last_name ) as nombre_actor ,
	count(fa.film_id ) as numero_peliculas
from actor a 
inner join film_actor fa 
	on a.actor_id = fa.actor_id
group by a.actor_id , nombre_actor 
order by numero_peliculas desc ;
	-- he añadido el order by para poder ver mejor los resultados, con este enunciado no se pide.

-- 31. Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.
select f.title , 
	concat(a.first_name ,' ', a.last_name ) as nombre_actor 
from film f 
left join film_actor fa 
	on f.film_id = fa.film_id 
left join actor a 
	on fa.actor_id = a.actor_id 
order by f.title ;

-- 32. Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.
select f.title ,
	concat(a.first_name ,' ', a.last_name ) as nombre_actor 
from film f  
right join film_actor fa
	on f.film_id = fa.film_id
right join actor a 
	on fa.actor_id = a.actor_id
order by nombre_actor ;

-- 33. Obtener todas las películas que tenemos y todos los registros de alquiler.
select f.title , r.rental_id as registro_alquiler
from film f 
full join inventory i 
	on f.film_id = i.film_id 
full join rental r 
	on i.inventory_id = r.inventory_id ;

-- 34.  Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.
select concat(c.first_name ,' ', c.last_name ) as cliente,
	SUM(p.amount ) as total_gastado
from customer c 
inner join payment p 
	on c.customer_id = p.customer_id
group by cliente
order by total_gastado desc
limit 5;

-- 35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.
select a.first_name , a.last_name 
from actor a
where a.first_name = 'JOHNNY';

-- 36. Renombra la columna “first_nameˮ como Nombre y “last_nameˮ como Apellido.
select a.first_name as nombre , a.last_name as apellido
from actor a;

-- 37.  Encuentra el ID del actor más bajo y más alto en la tabla actor.
select MIN(a.actor_id ) as id_minimo,
	   MAX(a.actor_id  ) as id_maximo
from actor a ;

-- 38. Cuenta cuántos actores hay en la tabla “actorˮ.
select count(*) as actores_totales
from actor a ;

-- 39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.
select *
from actor a 
order by a.last_name asc ;
		-- si solo queremos mostrar nombre i apellido
select a.last_name as apellido, a.first_name as nombre
from actor a 
order by a.last_name asc ;
	
-- 40.  Selecciona las primeras 5 películas de la tabla “filmˮ. (Estas no tiene un orden garantizado, tal y como esten en la table)
select f.title 
from film f 
limit 5;

-- 41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?
select a.first_name as nombre,
		count(*) as num_actores
from actor a 
group by a.first_name
order by num_actores DESC;
	-- no puedo añadir limit 1 porque existen 3 nombres con el mismo numero máximo de repeticiones (4 veces). Para mostrar los nombres más repetidos:
select a.first_name as nombre,
		count(*) as num_actores
from actor a 
group by a.first_name
having count (*) = (
	select max(repeticiones)
	from (
		select count(*) as repeticiones
		from actor a2 
		group by a2.first_name 
	)
);

-- 42.  Encuentra todos los alquileres y los nombres de los clientes que los realizaron.
select r.rental_id , r.rental_date ,
	   concat ( c.first_name , ' ', c.last_name ) as nombre_cliente
from rental r 
inner join customer c
	on r.customer_id = c.customer_id
order by r.rental_id ;

-- 43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.
select  c.customer_id  , concat ( c.first_name , ' ', c.last_name ) as nombre_cliente,
		r.rental_id , r.rental_date
from customer c 
left join rental r 
	on c.customer_id = r.customer_id
order by c.customer_id ;

-- 44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.
select f.title , c."name" 
from film f 
cross join category c ;
/*	No aporta mucho valor práctico, ya que no utiliza la tabla film_category, que es la que almacena la relación real entre películas y categorías.
 Por ello, el CROSS JOIN genera todas las combinaciones posibles entre ambas tablas, creando muchos resultados que no representan información real de la base de datos.*/

-- 45. Encuentra los actores que han participado en películas de la categoría 'Action'.
select distinct concat(a.first_name ,' ', a.last_name ) as nombre_actor , c."name" 
from actor a 
inner join film_actor fa 
	on a.actor_id = fa.actor_id 
inner join film f
	on fa.film_id = f.film_id 
inner join film_category fc 
	on f.film_id = fc.film_id 
inner join category c
	on fc.category_id = c.category_id 
where c."name" = 'Action'
order by nombre_actor;
	-- añadimos distinct porque un mismo autor puede participar en distinta peliculas de accion.

-- 46.  Encuentra todos los actores que no han participado en películas.
select concat(a.first_name ,' ', a.last_name ) as nombre_actor
from actor a 
left join film_actor fa 
	on a.actor_id = fa.actor_id
where fa.actor_id is null;
	--El Join no llega a film porque actor_id y film_id de la tabla film_actor son primary key, tienen valor. Un actor sin películas no aparece en la tabla film_actor, no esxite film_id.

-- 47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.
select concat(a.first_name ,' ', a.last_name ) as nombre_actor,
		count( fa.film_id ) as num_peliculas
from actor a 
inner join film_actor fa 
	on a.actor_id = fa.actor_id 
group by a.actor_id , nombre_actor 
order by num_peliculas desc ;
	-- Inner join porque obtenemos solo los actores que tienen peliculas
	-- esta es igual que la pregunta 30, no veo la diferencia. En la 30 Havia añadido ordre by para facilitar la lecutra de resultados.
	-- si interpretamos solo por nombre, y que queremos todos los actores independientemente de si tiene pelilcula o no, left join en lugar de inner join.
select a.first_name as solo_nombre_actor,
		count( fa.film_id ) as num_peliculas
from actor a 
left join film_actor fa 
	on a.actor_id = fa.actor_id 
group by a.actor_id , solo_nombre_actor ;

-- 48. Crea una vista llamada “actor_num_peliculasˮ que muestre los nombres de los actores y el número de películas en las que han participado.
create view actor_num_peliculas as
select a.first_name as nombre ,
		a.last_name as apellido,
		count( fa.film_id ) as num_peliculas
from actor a 
inner join film_actor fa 
	on a.actor_id = fa.actor_id 
group by a.actor_id , a.first_name , a.last_name ;
	-- DROP VIEW actor_num_peliculas; si debo modificar algun campo debo primero eliminarla y luego volver a crearla.
	-- para verificar que funciona la vista:
select *
from actor_num_peliculas;

-- 49. Calcula el número total de alquileres realizados por cada cliente.
select concat ( c.first_name , ' ', c.last_name ) as nombre_cliente,
	count (r.rental_id ) as total_alquileres
from customer c 
inner join rental r 
	on c.customer_id = r.customer_id 
group by c.customer_id , nombre_cliente ;
order by total_alquileres DESC; -- esta parte se puede añadir para facilitar la lectura de los resultados pero no haria falta. Para utilizar elimnar ; de la fila de arriba.

-- 50. Calcula la duración total de las películas en la categoría 'Action'.
select SUM(f.length ) as duracion_total, c."name" as categoria
from film f 
inner join film_category fc 
	on f.film_id = fc.film_id 
inner join category c 
	on fc.category_id = c.category_id
where c."name" = 'Action'
group by c."name" ;
	-- añado categoria y group by para poder ver que corresponden a Action. Verificar como se escribe action para que el resultado sea correcto (mayusculas/minusculas).

	
-- 51. Crea una tabla temporal llamada “cliente_rentas_temporalˮ para almacenar el total de alquileres por cliente.
create temporary table cliente_rentas_temporales as
select c.first_name , c.last_name,
	count (r.rental_id ) as total_alquileres
from customer c 
inner join rental r 
	on c.customer_id = r.customer_id 
group by c.customer_id , c.first_name , c.last_name ; 

-- 52. Crea una tabla temporal llamada “peliculas_alquiladasˮ que almacene las películas que han sido alquiladas al menos 10 veces.
create temporary table peliculas_alquiladas as
select 	f.title ,
		count(r.rental_id ) as num_alquileres
from film f 
inner join inventory i 
	on f.film_id = i.film_id 
inner join rental r 
	on i.inventory_id = r.inventory_id 
group by f.film_id , f.title 
having count(r.rental_id )>=10;

-- 53.  Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sandersʼ y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película.
select f.title 
from customer c 
inner join rental r 
	on c.customer_id = r.customer_id
inner join inventory i 
	on r.inventory_id = i.inventory_id
inner join film f 
	on i.film_id = f.film_id 
where c.first_name = 'TAMMY'
	and c.last_name = 'SANDERS'
	and r.return_date is null
order by f.title ;

-- 54. Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fiʼ. Ordena los resultados alfabéticamente por apellido.
select distinct a.first_name as nombre, a.last_name as apellido
from actor a 
inner join film_actor fa
    on a.actor_id = fa.actor_id
inner join film f
    on fa.film_id = f.film_id
inner join film_category fc
    on f.film_id = fc.film_id
inner join category c
    on fc.category_id = c.category_id
where c.name = 'Sci-Fi'
ORDER by a.last_name ASC;
	-- añadimos distinct para que el actor aparezca una sola vez y no en todas las de Sci-Fi que haya realizado
	-- otra opcion seria:
select a.first_name as nombre,
       a.last_name as apellido
from actor a
where exists (
    select *
    from film_actor fa
    join film_category fc
        on fa.film_id = fc.film_id
    join category c
        on fc.category_id = c.category_id
    where fa.actor_id = a.actor_id
      and c.name = 'Sci-Fi'
)
order by apellido ASC;

-- 55.  Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus Cheaperʼ se alquilara por primera vez. 
	-- Ordena los resultados alfabéticamente por apellido.
with primera_fecha_spartacus as (
	select MIN(r.rental_date ) as fecha_primera
	from film f 
	inner join inventory i 
		on f.film_id = i.film_id
	inner join rental r 
		on i.inventory_id  = r.inventory_id
	where f.title = 'SPARTACUS CHEAPER'
)
select distinct a.first_name as nombre , a.last_name as apellido
from actor a 
inner join film_actor fa 
	on a.actor_id = fa.actor_id
inner join inventory i 
	on fa.film_id = i.film_id 
inner join rental r 
	on i.inventory_id = r.inventory_id
where r.rental_date  > (
	select fecha_primera
	from primera_fecha_spartacus
)
order by apellido ;
		/* CTE primera_fecha_spartacus calcula la primera vez que se alquilo ‘Spartacus Cheaperʼ. La consulta principal busca los actores de la películas que se han alquilado despues de esa
		fecha. Distinct evita que los actores aparezcan repetidos varias veces. Inner join para todas las relaciones entre actor y rental date. Nos hemos saltado la tabla film porque no usamos 
		ninguan columan de esta en la consulta y el primary key film_id esta en inventory y film_actor. */

-- 56.  Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Musicʼ.
select a.first_name as nombre , a.last_name as apellido
from actor a 
where a.actor_id not in (
		select fa.actor_id 
		from film_actor fa 
		inner join film_category fc 
			on fa.film_id = fc.film_id 
		inner join category c 
			on fc.category_id = c.category_id 
		where c."name" = 'Music'
);
	
-- 57.  Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.
select distinct f.title 
from film f 
inner join inventory i 
	on f.film_id = i.film_id
inner join rental r 
	 on i.inventory_id = r.inventory_id
where extract(day from (r.return_date - r.rental_date)) > 8;
	/*dias transucrridos entre return_date y rental_date, no corresponden con los indicado en rental_duration, verificaocn abajo. 
	Distinct para que no salgan valores repetidos (una misma película puede haber sido alquilada varias veces durante más de 8 días) */
select distinct f.title ,
		f.rental_duration ,
		return_date - rental_date AS dias_alquiler
from film f 
inner join inventory i 
	on f.film_id = i.film_id
inner join rental r 
	 on i.inventory_id = r.inventory_id
where extract(day from (r.return_date - r.rental_date)) > 8;

-- 58. Encuentra el título de todas las películas que son de la misma categoría que ‘Animationʼ. 	
select f.title 
from film f 
inner join film_category fc 
	 on f.film_id = fc.film_id
where fc.category_id = (
	select c.category_id 
	from category c 
	where c.name = 'Animation'
);

-- 59. Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Feverʼ.
--Ordena los resultados alfabéticamente por título de película.
select f.title 
from film f 
where f.length = (
	select f.length 
	from film f 
	where f.title = 'DANCING FEVER'
)
order by f.title ;
	--subconsulta: primero se obtiene la duracion de ‘Dancing Feverʼ y despues se buscan todas las películas con esa duración. Tambien se podria hacer con una CTE:
with duracion_dancing as (
	select f.length 
	from film f 
	where title = 'DANCING FEVER'
)
select f.title 
from film f 
where f.length = (
	select length  -- no podemos indicar f.lenght porque la tabla duration_dancing solo tiene una columna llamada lenght.
	from duracion_dancing 
)
order by f.title ;

-- 60. Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido.
with alquileres_clientes as (
	select c.first_name as nombre, 
			c.last_name as apellido,
			count(distinct i.film_id) as num_peliculas
	from customer c 
	inner join rental r 
		on c.customer_id = r.customer_id
	inner join inventory i 
		on r.inventory_id = i.inventory_id
	group by c.customer_id , c.first_name , c.last_name 
)
select nombre , apellido , num_peliculas 
from alquileres_clientes
where num_peliculas >=7
order by apellido ;
-- CTE donde Primero se calculan las películas distintas por cliente y después se filtran los que tienen 7 o más

-- 61.  Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.
select c."name" as categoria,
	count(r.rental_id ) as recuento_alquileres
from category c 
inner join film_category fc 
	on c.category_id = fc.category_id
inner join inventory i 
	on fc.film_id  = i.film_id 
inner join rental r 
	on i.inventory_id = r.inventory_id
group by c.category_id , c."name" ;
	-- vamos de rental-inventory(-film)-film_category-categori. Podemos saltar film porque film_id esta en la tabla film_category e inventory y no lo usamos ninguna de sus columnas, idem 55.

-- 62.  Encuentra el número de películas por categoría estrenadas en 2006.
select c."name" as categoria,
	count(f.film_id ) as num_peliculas
from category c 
inner join film_category fc 
	on c.category_id = fc.category_id
inner join film f 
	on fc.film_id = f.film_id
where f.release_year  = 2006
group by c.category_id , c."name" ;
	--si quiero verificar el año en la tabla de resultados se añade release_year en select y en group by.

-- 63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.
select concat (s.first_name, ' ', s.last_name) AS trabajador,
	store.store_id 
from staff s 
cross join store ;
	-- cross join para ver todas las posibilidades 

-- 64.  Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.
select c.customer_id ,
	concat ( c.first_name , ' ', c.last_name ) as nombre_cliente,
	count (r.rental_id ) as total_alquileres
from customer c 
inner join rental r 
	on c.customer_id = r.customer_id 
group by c.customer_id , nombre_cliente 
order by total_alquileres DESC;
	-- esta consulta es como la 49, lo único que hemos añadido es customer_id