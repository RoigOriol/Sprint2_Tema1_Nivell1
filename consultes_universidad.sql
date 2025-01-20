-- 1. Llistat d'alumnes ordenats alfabèticament per cognoms i nom
SELECT apellido1, apellido2, nombre
FROM persona
WHERE tipo = 'alumno'
ORDER BY apellido1, apellido2, nombre;

-- 2. Alumnes sense número de telèfon
SELECT nombre, apellido1, apellido2
FROM persona
WHERE tipo = 'alumno' AND telefono IS NULL;

-- 3. Alumnes nascuts el 1999
SELECT nombre, apellido1, apellido2
FROM persona
WHERE tipo = 'alumno' AND YEAR(fecha_nacimiento) = 1999;

-- 4. Professors sense telèfon i amb NIF acabat en 'K'
SELECT nombre, apellido1, apellido2
FROM persona
WHERE tipo = 'profesor' AND telefono IS NULL AND nif LIKE '%K';

-- 5. Assignatures del primer quadrimestre del tercer curs del grau amb identificador 7
SELECT nombre
FROM asignatura
WHERE id_grado = 7 AND curso = 3 AND cuatrimestre = 1;

-- 6. Llistat de professors amb el seu departament
SELECT p.apellido1, p.apellido2, p.nombre, d.nombre AS departamento
FROM persona p
JOIN profesor prof ON p.id = prof.id_profesor
JOIN departamento d ON prof.id_departamento = d.id
ORDER BY p.apellido1, p.apellido2, p.nombre;

/*TO DO-- 7. Assignatures, any d'inici i fi del curs de l'alumne amb NIF 26902806M*/
SELECT a.nombre, c.any_inici, c.any_fi
FROM asignatura a
JOIN matricula m ON a.id = m.id_asignatura
JOIN curso_escolar c ON m.id_curso_escolar = c.id
JOIN persona p ON m.id_alumno = p.id
WHERE p.nif = '26902806M';

/*TO DO-- 8. Departaments amb professors que imparteixen assignatures en el Grau en Enginyeria Informàtica (Pla 2015)*/
SELECT DISTINCT d.nombre
FROM departamento d
JOIN profesor prof ON d.id = prof.id_departamento
JOIN imparte i ON prof.id_profesor = i.id_profesor
JOIN asignatura a ON i.id_asignatura = a.id
JOIN grado g ON a.id_grado = g.id
WHERE g.nombre = 'Enginyeria Informàtica' AND g.pla = '2015';

/*TO DO-- 9. Alumnes matriculats durant el curs 2018/2019*/
SELECT DISTINCT persona.nombre, persona.apellido1, persona.apellido2
FROM persona p
JOIN matricula m ON p.id = m.id_alumno
JOIN curso_escolar c ON m.id_curso_escolar = c.id
WHERE c.any_inici = 2018 AND c.any_fi = 2019;

-- 10. Professors i departaments, incloent aquells sense departament associat
SELECT d.nombre AS departamento, p.apellido1, p.apellido2, p.nombre
FROM departamento d
LEFT JOIN profesor prof ON d.id = prof.id_departamento
LEFT JOIN persona p ON prof.id_profesor = p.id
ORDER BY departamento, p.apellido1, p.apellido2, p.nombre;

/*TO DO-- 11. Professors sense departament associat*/
SELECT persona.nombre, persona.apellido1, persona.apellido2
FROM persona p
JOIN profesor prof ON p.id = prof.id_profesor
LEFT JOIN departamento d ON prof.id_departamento = d.id
WHERE departamento.id IS NULL;

-- 12. Departaments sense professors associats
SELECT d.nombre
FROM departamento d
LEFT JOIN profesor prof ON d.id = prof.id_departamento
WHERE prof.id_profesor IS NULL;

/*TO DO-- 13. Professors que no imparteixen cap assignatura*/
SELECT p.nombre, p.apellido1, p.apellido2
FROM persona p
JOIN profesor prof ON p.id = prof.id_profesor
LEFT JOIN imparte i ON prof.id_profesor = i.id_profesor
WHERE i.id_asignatura IS NULL;

/*TO DO-- 14. Assignatures sense professor assignat*/
SELECT a.nombre
FROM asignatura a
LEFT JOIN imparte i ON a.id = i.id_asignatura
WHERE i.id_profesor IS NULL;

/*TO DO-- 15. Departaments que no han impartit assignatures en cap curs escolar*/
SELECT d.nombre
FROM departamento d
LEFT JOIN profesor prof ON d.id = prof.id_departamento
LEFT JOIN imparte i ON prof.id_profesor = i.id_profesor
WHERE i.id_asignatura IS NULL;

-- 16. Nombre total d'alumnes
SELECT COUNT(*) AS total_alumnos
FROM persona p
JOIN persona a ON p.id = a.id;

-- 17. Alumnes nascuts el 1999
SELECT COUNT(*) AS alumnos_nacidos_1999
FROM persona p
JOIN persona a ON p.id = a.id
WHERE YEAR(p.fecha_nacimiento) = 1999;

-- 18. Nombre de professors per departament
SELECT d.nombre AS departamento, COUNT(prof.id_profesor) AS num_profesores
FROM departamento d
JOIN profesor prof ON d.id = prof.id_departamento
GROUP BY d.nombre
ORDER BY num_profesores DESC;

-- 19. Departaments amb nombre de professors, incloent departaments sense professors
SELECT d.nombre AS departamento, COUNT(prof.id_profesor) AS num_profesores
FROM departamento d
LEFT JOIN profesor prof ON d.id = prof.id_departamento
GROUP BY d.nombre;

-- 20. Grau amb nombre d'assignatures
SELECT g.nombre AS grau, COUNT(a.id) AS num_assignatures
FROM grado g
LEFT JOIN asignatura a ON g.id = a.id_grado
GROUP BY g.nombre
ORDER BY num_assignatures DESC;

-- 21. Grau amb més de 40 assignatures associades
SELECT g.nombre AS grau, COUNT(a.id) AS num_assignatures
FROM grado g
LEFT JOIN asignatura a ON g.id = a.id_grado
GROUP BY g.nombre
HAVING COUNT(a.id) > 40
ORDER BY num_assignatures DESC;

-- 22. Grau i suma de crèdits per tipus d'assignatura
SELECT g.nombre AS grau, a.tipo, SUM(a.creditos) AS suma_credits
FROM grado g
JOIN asignatura a ON g.id = a.id_grado
GROUP BY g.nombre, a.tipo;

/*TO DO-- 23. Alumnes matriculats per curs escolar*/
SELECT c.any_inici AS any_inici, COUNT(DISTINCT m.id_alumno) AS num_alumnes
FROM curso_escolar c
JOIN matricula m ON c.id = m.id_curso_escolar
GROUP BY c.any_inici;

/*TO DO-- 24. Nombre d'assignatures per professor*/
SELECT p.id, p.nombre, p.apellido1, p.apellido2, COUNT(i.id_asignatura) AS num_assignatures
FROM persona p
JOIN profesor prof ON p.id = prof.id_profesor
LEFT JOIN imparte i ON prof.id_profesor = i.id_profesor
GROUP BY p.id, p.nombre, p.apellido1, p.apellido2
ORDER BY num_assignatures DESC;

/*TO DO-- -- 25. Dades de l'alumne més jove*/
SELECT p.*
FROM persona p
JOIN alumno a ON p.id = a.id
ORDER BY p.fecha_nacimiento DESC
LIMIT 1;


/*-- 26. Professors amb departament associat que no imparteixen cap assignatura*/
SELECT p.nombre, p.apellido1, p.apellido2
FROM persona p
JOIN profesor prof ON p.id = prof.id_profesor
LEFT JOIN imparte i ON prof.id_profesor = i.id_profesor
WHERE i.id_asignatura IS NULL AND prof.id_departamento IS NOT NULL;
