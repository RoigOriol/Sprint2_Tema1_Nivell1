/*1.	Llista el nom de tots els productes que hi ha en la taula "producto".*/
SELECT nombre FROM producto;
/*2.	Llista els noms i els preus de tots els productes de la taula "producto".*/
SELECT nombre, precio FROM producto;
/*3.	Llista totes les columnes de la taula "producto".*/
SELECT * FROM producto;
/*4.	Llista el nom dels "productos", el preu en euros i el preu en dòlars nord-americans (USD). (Assumint que 1 EUR = 1.1 USD)*/
SELECT nombre, precio, precio * 1.1 AS precio_usd FROM producto;
/*5.	Llista el nom dels "productos", el preu en euros i el preu en dòlars nord-americans amb àlies.*/
SELECT nombre AS "nom de producto", precio AS euros, precio * 1.1 AS "dòlars nord-americans" FROM producto;
/*6.	Llista els noms i els preus de tots els productes, convertint els noms a majúscula.*/
SELECT UPPER(nombre) AS nom, precio FROM producto;
/*7.	Llista els noms i els preus de tots els productes, convertint els noms a minúscula.*/
SELECT LOWER(nombre) AS nom, precio FROM producto;
/*8.	Llista el nom de tots els fabricants amb els dos primers caràcters en majúscules.*/
SELECT nombre, UPPER(LEFT(nombre, 2)) AS inicials FROM fabricante;
/*9.	Llista els noms i els preus de tots els productes arrodonint el valor del preu.*/
SELECT nombre, ROUND(precio) AS preu_arrodonit FROM producto;
/*10.	Llista els noms i els preus de tots els productes truncant el valor del preu.*/
SELECT nombre, TRUNCATE(precio, 0) AS preu_truncat FROM producto;
/*11.	Llista el codi dels fabricants que tenen productes a la taula "producto".*/
SELECT codigo_fabricante FROM producto;
/*12.	Llista el codi dels fabricants que tenen productes a la taula "producto", eliminant els codis repetits.*/
SELECT DISTINCT codigo_fabricante FROM producto;
/*13.	Llista els noms dels fabricants ordenats de manera ascendent.*/
SELECT nombre FROM fabricante ORDER BY nombre ASC;
/*14.	Llista els noms dels fabricants ordenats de manera descendent.*/
SELECT nombre FROM fabricante ORDER BY nombre DESC;
/*15.	Llista els noms dels productes ordenats primer pel nom de manera ascendent i després pel preu de manera descendent.*/
SELECT nombre, precio FROM producto ORDER BY nombre ASC, precio DESC;
/*16.	Retorna una llista amb les 5 primeres files de la taula "fabricante".*/
SELECT * FROM fabricante LIMIT 5;
/*17.	Retorna una llista amb 2 files a partir de la quarta fila de la taula "fabricante".*/
SELECT * FROM fabricante LIMIT 3, 2;
/*18.	Llista el nom i el preu del producte més barat (utilitzant ORDER BY i LIMIT).*/
SELECT nombre, precio FROM producto ORDER BY precio ASC LIMIT 1;
/*19.	Llista el nom i el preu del producte més car (utilitzant ORDER BY i LIMIT).*/
SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1;
/*20.	Llista el nom de tots els productes del fabricant el codi de fabricant del qual és igual a 2.*/
SELECT nombre FROM producto WHERE codigo_fabricante = 2;
/*21.	Retorna una llista amb el nom del producte, preu i nom de fabricant de tots els productes de la base de dades.*/
SELECT producto.nombre, producto.precio, fabricante.nombre AS fabricant 
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo;
/*22.	Retorna una llista amb el nom del producte, preu i nom de fabricant de tots els productes, ordenat pel nom del fabricant.*/
SELECT producto.nombre, producto.precio, fabricante.nombre AS fabricant 
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
ORDER BY fabricante.nombre ASC;
/*23.	Retorna una llista amb el codi del producte, nom del producte, codi del fabricant i nom del fabricant de tots els productes.*/
SELECT producto.codigo, producto.nombre, producto.codigo_fabricante, fabricante.nombre AS fabricant 
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo;
/*24.	Retorna el nom del producte, el seu preu i el nom del seu fabricant, del producte més barat.*/
SELECT producto.nombre, producto.precio, fabricante.nombre AS fabricant 
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
ORDER BY producto.precio ASC LIMIT 1;
/*25.	Retorna el nom del producte, el seu preu i el nom del seu fabricant, del producte més car.*/
SELECT producto.nombre, producto.precio, fabricante.nombre AS fabricant 
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
ORDER BY producto.precio DESC LIMIT 1;
/*26.	Retorna una llista de tots els productes del fabricant Lenovo.*/
SELECT producto.nombre 
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'Lenovo';
/*27.	Retorna una llista de tots els productes del fabricant Crucial amb un preu major que 200 €.*/
SELECT producto.nombre 
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'Crucial' AND producto.precio > 200;
/*28.	Retorna una llista amb tots els productes dels fabricants Asus, Hewlett-Packard i Seagate (sense utilitzar IN).*/
SELECT producto.nombre 
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'Asus' OR fabricante.nombre = 'Hewlett-Packard' OR fabricante.nombre = 'Seagate';
/*29.	Retorna un llistat amb tots els productes dels fabricants Asus, Hewlett-Packard i Seagate (utilitzant IN).*/
SELECT producto.nombre 
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre IN ('Asus', 'Hewlett-Packard', 'Seagate');
/*30.	Retorna un llistat amb el nom i el preu de tots els productes dels fabricants el nom dels quals acabi per la vocal e.*/
SELECT producto.nombre, producto.precio 
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre LIKE '%e';
/*31.	Retorna un llistat amb el nom i el preu de tots els productes dels fabricants que continguin el caràcter w en el seu nom.*/
SELECT producto.nombre, producto.precio 
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre LIKE '%w%';
/*32.	Retorna un llistat amb el nom de producte, preu i nom de fabricant, de tots els productes amb un preu major o igual a 180 €, ordenat pel preu i després pel nom.*/
SELECT producto.nombre, producto.precio, fabricante.nombre AS fabricant 
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE producto.precio >= 180
ORDER BY producto.precio DESC, producto.nombre ASC;
/*33.	Retorna un llistat amb el codi i el nom de fabricant només d'aquells fabricants que tenen productes associats.*/
SELECT DISTINCT fabricante.codigo, fabricante.nombre 
FROM fabricante
JOIN producto ON fabricante.codigo = producto.codigo_fabricante;
/*34.	Retorna un llistat de tots els fabricants, juntament amb els productes que té cadascun d'ells, incloent aquells que no tenen productes associats.*/
SELECT fabricante.codigo, fabricante.nombre, producto.nombre AS producte 
FROM fabricante
LEFT JOIN producto ON fabricante.codigo = producto.codigo_fabricante;
/*35.	Retorna un llistat on només apareguin aquells fabricants que no tenen cap producte associat.*/
SELECT fabricante.codigo, fabricante.nombre 
FROM fabricante
LEFT JOIN producto ON fabricante.codigo = producto.codigo_fabricante
WHERE producto.codigo IS NULL;
/*36.	Retorna tots els productes del fabricant Lenovo (sense utilitzar INNER JOIN).*/
SELECT producto.nombre 
FROM producto, fabricante 
WHERE producto.codigo_fabricante = fabricante.codigo AND fabricante.nombre = 'Lenovo';
/*37.	Retorna totes les dades dels productes que tenen el mateix preu que el producte més car del fabricant Lenovo (sense fer servir INNER JOIN).*/
SELECT p.* 
FROM producto p, fabricante f
WHERE p.codigo_fabricante = f.codigo AND f.nombre = 'Lenovo' AND p.precio = (
    SELECT MAX(precio) FROM producto WHERE codigo_fabricante = f.codigo
);
/*38.	Llista el nom del producte més car del fabricant Lenovo.*/
SELECT producto.nombre 
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'Lenovo'
ORDER BY producto.precio DESC LIMIT 1;
/*39.	Llista el nom del producte més barat del fabricant Hewlett-Packard.*/
SELECT producto.nombre 
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'Hewlett-Packard'
ORDER BY producto.precio ASC LIMIT 1;
/*40.	Retorna tots els productes de la base de dades que tenen un preu major o igual al producte més car del fabricant Lenovo.*/
SELECT p.nombre 
FROM producto p
WHERE p.precio >= (
    SELECT MAX(precio) 
    FROM producto 
    JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
    WHERE fabricante.nombre = 'Lenovo'
);
/*41.	Llesta tots els productes del fabricant Asus que tenen un preu superior al preu mitjà de tots els seus productes.*/
SELECT p.nombre 
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre = 'Asus' AND p.precio > (
    SELECT AVG(precio) 
    FROM producto 
    WHERE codigo_fabricante = f.codigo
);
