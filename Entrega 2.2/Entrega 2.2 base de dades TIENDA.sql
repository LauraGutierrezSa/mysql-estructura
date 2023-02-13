DROP DATABASE IF EXISTS tienda;
CREATE DATABASE tienda CHARACTER SET utf8mb4;
USE tienda;

CREATE TABLE fabricante (
  codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL
);

CREATE TABLE producto (
  codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  precio DOUBLE NOT NULL,
  codigo_fabricante INT UNSIGNED NOT NULL,
  FOREIGN KEY (codigo_fabricante) REFERENCES fabricante(codigo)
);

INSERT INTO fabricante VALUES(1, 'Asus');
INSERT INTO fabricante VALUES(2, 'Lenovo');
INSERT INTO fabricante VALUES(3, 'Hewlett-Packard');
INSERT INTO fabricante VALUES(4, 'Samsung');
INSERT INTO fabricante VALUES(5, 'Seagate');
INSERT INTO fabricante VALUES(6, 'Crucial');
INSERT INTO fabricante VALUES(7, 'Gigabyte');
INSERT INTO fabricante VALUES(8, 'Huawei');
INSERT INTO fabricante VALUES(9, 'Xiaomi');

INSERT INTO producto VALUES(1, 'Disco duro SATA3 1TB', 86.99, 5);
INSERT INTO producto VALUES(2, 'Memoria RAM DDR4 8GB', 120, 6);
INSERT INTO producto VALUES(3, 'Disco SSD 1 TB', 150.99, 4);
INSERT INTO producto VALUES(4, 'GeForce GTX 1050Ti', 185, 7);
INSERT INTO producto VALUES(5, 'GeForce GTX 1080 Xtreme', 755, 6);
INSERT INTO producto VALUES(6, 'Monitor 24 LED Full HD', 202, 1);
INSERT INTO producto VALUES(7, 'Monitor 27 LED Full HD', 245.99, 1);
INSERT INTO producto VALUES(8, 'Portátil Yoga 520', 559, 2);
INSERT INTO producto VALUES(9, 'Portátil Ideapd 320', 444, 2);
INSERT INTO producto VALUES(10, 'Impresora HP Deskjet 3720', 59.99, 3);
INSERT INTO producto VALUES(11, 'Impresora HP Laserjet Pro M26nw', 180, 3);

/* 1- Llista el nom de tots els productes que hi ha en la taula producto*/
SELECT nombre FROM producto;

/* 2- Llista els noms i els preus de tots els productes de la taula producto*/
SELECT nombre, precio FROM producto;

/* 3- Llista totes les columnes de la taula producto*/
SELECT * FROM producto;

/* 4- Llista el nom dels productes, el preu en euros i el preu en dòlars (USD)*/


/* 5- Llista el nom dels productes, el preu en euros y el preu en dòlars.  Utilitza els següents àlies per a les columnes: nom de producto, euros, dòlars. */
SELECT nombre as "Nombre de producto", precio as "Euros", precio * 1.2 as "Dólares" FROM producto;

/* 6 -Llista els noms i els preus de tots els productes de la taula producto, convertint els noms a majúscula. */
SELECT UPPER(nombre) as "NOMBRE", precio as "PRECIO" FROM producto;

/* 7- Llista els noms i els preus de tots els productes de la taula producto, convertint els noms a minúscula. */
SELECT LOWER(nombre) as "nombre", precio as "precio" FROM producto;

/* 8- Llista el nom de tots els fabricants en una columna, i en una altra columna obtingui en majúscules els dos primers caràcters del nom del fabricant. */
SELECT nombre as "Nombre", UPPER(LEFT(nombre,2)) as "Iniciales" FROM fabricante;

/* 9-  Llista els noms i els preus de tots els productes de la taula producto, arrodonint el valor del preu. */
SELECT nombre as "Nombre", ROUND(precio, 2) as "Precio" FROM producto;

/* 10 - Llista els noms i els preus de tots els productes de la taula producto, truncant el valor del preu per a mostrar-lo sense cap xifra decimal. */
SELECT nombre as "Nombre", TRUNCATE(precio, 0) as "Precio" FROM producto;

/* 11- Llista el codi dels fabricants que tenen productes en la taula producto. */
SELECT DISTINCT codigo_fabricante as "Código de Fabricante" FROM producto;

/* 12- Llista el codi dels fabricants que tenen productes en la taula producto, eliminant els codis que apareixen repetits. */
SELECT DISTINCT codigo_fabricante as "Código de Fabricante" FROM producto GROUP BY codigo_fabricante;

/* 13- Llista els noms dels fabricants ordenats de manera ascendent. */
SELECT nombre as "Nombre" FROM fabricante ORDER BY nombre ASC;

/* 14- Llista els noms dels fabricants ordenats de manera descendent. */
SELECT nombre as "Nombre" FROM fabricante ORDER BY nombre DESC;

/* 15- Llista els noms dels productes ordenats, en primer lloc, pel nom de manera ascendent i, en segon lloc, pel preu de manera descendent. */
SELECT nombre as "Nombre" FROM fabricante ORDER BY nombre, nombre DESC;

/* 16- Retorna una llista amb les 5 primeres files de la taula fabricante. */
SELECT * FROM fabricante LIMIT 5;

/* 17- Retorna una llista amb 2 files a partir de la quarta fila de la taula fabricante. La quarta fila també s'ha d'incloure en la resposta. */
SELECT * FROM fabricante LIMIT 3, 2;

/* 18- Llista el nom i el preu del producte més barat. (Utilitza solament les clàusules ORDER BY i LIMIT). NOTA: Aquí no podria usar MIN(preu), necessitaria GROUP BY. */

SELECT nombre_producto, precio_en_euros FROM producto GROUP BY fabricante ORDER BY precio_en_euros LIMIT 1;

/* 19 -Llista el nom i el preu del producte més car. (Utilitza solament les clàusules ORDER BY i LIMIT). NOTA: Aquí no podria usar MAX(preu), necessitaria GROUP BY. */
SELECT producto.nombre, MAX(producto.precio) as precio FROM producto GROUP BY producto.codigo ORDER BY precio DESC LIMIT 1;

/* 20 - Llista el nom de tots els productes del fabricant el codi de fabricant del qual és igual a 2. */
SELECT producto.nombre FROM producto WHERE producto.codigo_fabricante = 2;

/* 21 - Retorna una llista amb el nom del producte, preu i nom de fabricant de tots els productes de la base de dades. */ 
SELECT producto.nombre, producto.precio, fabricante.nombre as nombre_fabricante FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo ORDER BY nombre_fabricante;

/* 22 - Retorna una llista amb el nom del producte, preu i nom de fabricant de tots els productes de la base de dades. Ordena el resultat pel nom del fabricant, per ordre alfabètic. */
SELECT producto.codigo, producto.nombre, producto.codigo_fabricante, fabricante.nombre as nombre_fabricante FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo;

/* 23 - Retorna una llista amb el codi del producte, nom del producte, codi del fabricador i nom del fabricador, de tots els productes de la base de dades. */


/* 24 - Retorna el nom del producte, el seu preu i el nom del seu fabricant, del producte més barat. */
SELECT producto.nombre, MIN(producto.precio) as precio, fabricante.nombre as nombre_fabricante FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo GROUP BY producto.codigo ORDER BY precio LIMIT 1;

/* 25- Retorna el nom del producte, el seu preu i el nom del seu fabricant, del producte més car. */
SELECT producto.nombre, MAX(producto.precio) as precio, fabricante.nombre as nombre_fabricante FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo GROUP BY producto.codigo ORDER BY precio DESC LIMIT 1;

/* 26 -Retorna una llista de tots els productes del fabricant Lenovo. */
SELECT producto.nombre, producto.precio, producto.codigo_fabricante, fabricante.nombre as nombre_fabricante FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre = 'Lenovo';

/* 27 - Retorna una llista de tots els productes del fabricant Crucial que tinguin un preu major que 200 €. */
SELECT producto.nombre, producto.precio, producto.codigo_fabricante, fabricante.nombre as nombre_fabricante FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre = 'Crucial' AND producto.precio > 200;

/* 28 - Retorna un llistat amb tots els productes dels fabricants Asus, Hewlett-Packard y Seagate. Sense utilitzar l'operador IN. */
SELECT producto.nombre, producto.precio, producto.codigo_fabricante, fabricante.nombre as nombre_fabricante FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre = 'Asus' OR fabricante.nombre = 'Hewlett-Packard' OR fabricante.nombre = 'Seagate';

/* 29 - Retorna un llistat amb tots els productes dels fabricants Asus, Hewlett-Packard y Seagate. Fent servir l'operador IN. */


/* 30 - Retorna un llistat amb el nom i el preu de tots els productes dels fabricants el nom dels quals acabi per la vocal e. */
SELECT p.nombre, p.precio FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre LIKE '%e';

/* 31 - Retorna un llistat amb el nom i el preu de tots els productes el nom de fabricant dels quals contingui el caràcter w en el seu nom. */


/* 32 - Retorna un llistat amb el nom de producte, preu i nom de fabricant, de tots els productes que tinguin un preu major o igual a 180 €. Ordena el resultat, en primer lloc, pel preu (en ordre descendent) i, en segon lloc, pel nom (en ordre ascendent). */


/* 33- Retorna un llistat amb el codi i el nom de fabricant, solament d'aquells fabricants que tenen productes associats en la base de dades. */


/* 34 - Retorna un llistat de tots els fabricants que existeixen en la base de dades, juntament amb els productes que té cadascun d'ells. El llistat haurà de mostrar també aquells fabricants que no tenen productes associats. */


/* 35 - Retorna un llistat on només apareguin aquells fabricants que no tenen cap producte associat */;

SELECT nombre FROM fabricante WHERE codigo NOT IN (SELECT codigo_fabricante FROM producto);

/* 36 - Retorna tots els productes del fabricador Lenovo. (Sense utilitzar INNER JOIN). */


/* 37 - Retorna totes les dades dels productes que tenen el mateix preu que el producte més car del fabricant Lenovo. (Sense usar INNER JOIN). */


/* 38 - Llista el nom del producte més car del fabricant Lenovo.*/
SELECT p.nombre FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = 'Lenovo' ORDER BY p.precio DESC LIMIT 1;

/* 39 - Llista el nom del producte més barat del fabricant Hewlett-Packard. */
SELECT p.nombre FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = 'Hewlett-Packard' ORDER BY p.precio LIMIT 1;

/* 40 - Retorna tots els productes de la base de dades que tenen un preu major o igual al producte més car del fabricant Lenovo. */


/* 41 -  Llesta tots els productes del fabricant Asus que tenen un preu superior al preu mitjà de tots els seus productes. */