-- Crear tabla con formato fecha
drop table if exists fecha;
create table fecha AS
SELECT timestamp,
strftime('%Y-%m-%d %H:%M:%S', timestamp, 'unixepoch') AS fecha FROM ratings

--Unir fecha a tabla ratings
drop table if exists new_ratings;
create table new_ratings AS
SELECT *
FROM fecha AS f
LEFT JOIN ratings AS r ON r.timestamp = f.timestamp;

-- Unir con movies y new_ratings
drop table if exists base_nueva;
create table base_nueva AS
SELECT movies.*,
new_ratings.userid,
new_ratings.rating,
new_ratings.fecha
FROM movies
LEFT JOIN new_ratings ON movies.movieId = new_ratings.movieId;


---crear tabla agrupada por titulo de la pelicula y con rating mayor a 3.5

drop table if exists calificacion;
create table calificacion as 
select title AS Titulo,
rating AS Calificacion
from base_nueva
WHERE rating > 3.5
group by title;

SELECT * FROM calificacion


