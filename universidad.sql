/*1. Llistat d'alumnes ordenats alfabèticament per cognoms i nom:*/
SELECT apellido1, apellido2, nombre
FROM persona
WHERE tipo = 'alumno'
ORDER BY apellido1, apellido2, nombre;

/*2. Alumnes sense número de telèfon:*/
SELECT nombre, apellido1, apellido2
FROM persona
WHERE tipo = 'alumno' AND telefono IS NULL;

/*3. Alumnes nascuts el 1999:*/
SELECT nombre, apellido1, apellido2
FROM persona
WHERE tipo = 'alumno' AND YEAR(fecha_nacimiento) = 1999;

/*4. Professors sense telèfon i amb NIF acabat en 'K':*/
SELECT nombre, apellido1, apellido2
FROM persona
WHERE tipo = 'profesor' AND telefono IS NULL AND nif LIKE '%K';

/*5. Assignatures del primer quadrimestre del tercer curs del grau amb identificador 7:*/
SELECT nombre
FROM asignatura
WHERE id_grado = 7 AND curso = 3 AND cuadrimestre = 1;

/*6. Llistat de professors amb el seu departament:*/
SELECT persona.apellido1, persona.apellido2, persona.nombre, departamento.nombre AS departamento
FROM persona
JOIN profesor ON persona.id = profesor.id_profesor
JOIN departamento ON profesor.id_departamento = departamento.id
ORDER BY persona.apellido1, persona.apellido2, persona.nombre;

/*7. Assignatures, any d'inici i fi del curs de l'alumne amb NIF 26902806M:*/
SELECT asignatura.nombre, curso_escolar.any_inici, curso_escolar.any_fi
FROM asignatura
JOIN matricula ON asignatura.id = matricula.id_asignatura
JOIN curso_escolar ON matricula.id_curso_escolar = curso_escolar.id
JOIN persona ON matricula.id_alumno = persona.id
WHERE persona.nif = '26902806M';

/*8. Departaments amb professors que imparteixen assignatures en el Grau en Enginyeria Informàtica (Pla 2015):*/
SELECT DISTINCT departamento.nombre
FROM departamento
JOIN profesor ON departamento.id = profesor.id_departamento
JOIN imparte ON profesor.id_profesor = imparte.id_profesor
JOIN asignatura ON imparte.id_asignatura = asignatura.id
JOIN grado ON asignatura.id_grado = grado.id
WHERE grado.nombre = 'Enginyeria Informàtica' AND grado.pla = '2015';

/*9. Alumnes matriculats durant el curs 2018/2019:*/
SELECT DISTINCT persona.nombre, persona.apellido1, persona.apellido2
FROM persona
JOIN matricula ON persona.id = matricula.id_alumno
JOIN curso_escolar ON matricula.id_curso_escolar = curso_escolar.id
WHERE curso_escolar.any_inici = 2018 AND curso_escolar.any_fi = 2019;

/*10. Professors i departaments, incloent aquells sense departament associat:*/
SELECT departamento.nombre AS departamento, persona.apellido1, persona.apellido2, persona.nombre
FROM departamento
LEFT JOIN profesor ON departamento.id = profesor.id_departamento
LEFT JOIN persona ON profesor.id_profesor = persona.id
ORDER BY departamento.nombre, persona.apellido1, persona.apellido2, persona.nombre;

/*11. Professors sense departament associat:*/
SELECT persona.nombre, persona.apellido1, persona.apellido2
FROM persona
JOIN profesor ON persona.id = profesor.id_profesor
LEFT JOIN departamento ON profesor.id_departamento = departamento.id
WHERE departamento.id IS NULL;

/*12. Departaments sense professors associats:*/
SELECT departamento.nombre
FROM departamento
LEFT JOIN profesor ON departamento.id = profesor.id_departamento
WHERE profesor.id_profesor IS NULL;

/*13. Professors que no imparteixen cap assignatura:*/
SELECT persona.nombre, persona.apellido1, persona.apellido2
FROM persona
JOIN profesor ON persona.id = profesor.id_profesor
LEFT JOIN imparte ON profesor.id_profesor = imparte.id_profesor
WHERE imparte.id_asignatura IS NULL;

/*14. Assignatures sense professor assignat:*/
SELECT asignatura.nombre
FROM asignatura
LEFT JOIN imparte ON asignatura.id = imparte.id_asignatura
WHERE imparte.id_profesor IS NULL;

/*15. Departaments que no han impartit assignatures en cap curs escolar:*/
SELECT departamento.nombre
FROM departamento
LEFT JOIN profesor ON departamento.id = profesor.id_departamento
LEFT JOIN imparte ON profesor.id_profesor = imparte.id_profesor
WHERE imparte.id_asignatura IS NULL;

/*16. Nombre total d'alumnes:*/
SELECT COUNT(*) AS total_alumnos
FROM persona
JOIN alumno ON persona.id = alumno.id;

/*17. Alumnes nascuts el 1999:*/
SELECT COUNT(*) AS alumnos_nacidos_1999
FROM persona
JOIN alumno ON persona.id = alumno.id
WHERE YEAR(persona.fecha_nacimiento) = 1999;

/*18. Nombre de professors per departament:*/
SELECT departamento.nombre AS departamento, COUNT(profesor.id_profesor) AS num_profesores
FROM departamento
JOIN profesor ON departamento.id = profesor.id_departamento
GROUP BY departamento.nombre
ORDER BY num_profesores DESC;

/*19. Departaments amb nombre de professors, incloent departaments sense professors:*/
SELECT departamento.nombre AS departamento, COUNT(profesor.id_profesor) AS num_profesores
FROM departamento
LEFT JOIN profesor ON departamento.id = profesor.id_departamento
GROUP BY departamento.nombre;

/*20. Grau amb nombre d'assignatures:*/
SELECT grado.nombre AS grau, COUNT(asignatura.id) AS num_assignatures
FROM grado
LEFT JOIN asignatura ON grado.id = asignatura.id_grado
GROUP BY grado.nombre
ORDER BY num_assignatures DESC;

/*21. Grau amb més de 40 assignatures associades:*/
SELECT grado.nombre AS grau, COUNT(asignatura.id) AS num_assignatures
FROM grado
LEFT JOIN asignatura ON grado.id = asignatura.id_grado
GROUP BY grado.nombre
HAVING COUNT(asignatura.id) > 40
ORDER BY num_assignatures DESC;

/*22. Grau i suma de crèdits per tipus d'assignatura:*/
SELECT grado.nombre AS grau, asignatura.tipo, SUM(asignatura.creditos) AS suma_credits
FROM grado
JOIN asignatura ON grado.id = asignatura.id_grado
GROUP BY grado.nombre, asignatura.tipo;

/*23. Alumnes matriculats per curs escolar:*/
SELECT curso_escolar.any_inici AS any_inici, COUNT(DISTINCT matricula.id_alumno) AS num_alumnes
FROM curso_escolar
JOIN matricula ON curso_escolar.id = matricula.id_curso_escolar
GROUP BY curso_escolar.any_inici;

/*24. Nombre d'assignatures per professor:*/
SELECT persona.id, persona.nombre, persona.apellido1, persona.apellido2, COUNT(imparte.id_asignatura) AS num_assignatures
FROM persona
JOIN profesor ON persona.id = profesor.id_profesor
LEFT JOIN imparte ON profesor.id_profesor = imparte.id_profesor
GROUP BY persona.id, persona.nombre, persona.apellido1, persona.apellido2
ORDER BY num_assignatures DESC;

/*25. Dades de l'alumne més jove:*/
SELECT persona.*
FROM persona
JOIN alumno ON persona.id = alumno.id
ORDER BY persona.fecha_nacimiento DESC
LIMIT 1;

/*26. Professors amb departament associat que no imparteixen cap assignatura:*/
SELECT persona.nombre, persona.apellido1, persona.apellido2
FROM persona
JOIN profesor ON persona.id = profesor.id_profesor
LEFT JOIN imparte ON profesor.id_profesor = imparte.id_profesor
WHERE imparte.id_asignatura IS NULL AND profesor.id_departamento IS NOT NULL;
