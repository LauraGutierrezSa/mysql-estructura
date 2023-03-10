SELECT apellido1, apellido2, nombre FROM alumnos ORDER BY apellido1, apellido2, nombre;
SELECT nombre, apellido1, apellido2 FROM alumnos WHERE telefono IS NULL;
SELECT nombre, apellido1, apellido2 FROM alumnos WHERE YEAR(fecha_nacimiento) = 1999;
SELECT nombre, apellido1, apellido2 FROM profesores WHERE telefono IS NULL AND RIGHT(nif, 1) = 'K';
SELECT Nombre_Asignatura FROM Asignaturas WHERE Cuadrimestre = 1 AND ID_Curso = 7;
SELECT Nombre_Profesor, Nombre_Departamento FROM Profesores JOIN Departamentos ON Profesores.ID_Departamento = Departamentos.ID_Departamento;
SELECT Nombre_Asignatura, Anio_Inicio, Anio_Fin FROM Asignaturas;
SELECT D.department_name FROM departments D INNER JOIN professors P ON D.department_id = P.department_id LEFT JOIN courses C ON P.professor_id = C.professor_id WHERE C.degree_name = 'Grau Enginyeria informàtica (Pla 2015)' GROUP BY D.department_name;
SELECT Nombre_Alumno FROM Matriculas JOIN Cursos ON Matriculas.ID_Curso = Cursos.ID_Curso WHERE Anyo_Inicio = 2018 AND Anyo_Fin = 2019;
SELECT profesores.nombre AS Nombre_del_Profesor, departamentos.nombre AS Nombre_del_Departamento FROM profesores LEFT JOIN departamentos ON profesores.id_departamento = departamentos.id;
SELECT profesores.nombre AS Nombre_del_Profesor, departamentos.nombre AS Nombre_del_Departamento FROM profesores LEFT JOIN departamentos ON profesores.id_departamento = departamentos.id WHERE departamentos.nombre IS NULL;
SELECT profesores.nombre AS Nombre_del_Profesor, departamentos.nombre AS Nombre_del_Departamento FROM profesores RIGHT JOIN departamentos ON profesores.id_departamento = departamentos.id WHERE profesores.nombre IS NULL;
SELECT profesores.nombre AS Nombre_del_Profesor, asignaturas.nombre AS Nombre_de_la_Asignatura FROM profesores LEFT JOIN asignaturas ON profesores.id = asignaturas.id_profesor WHERE asignaturas.nombre IS NULL;
SELECT profesores.nombre AS Nombre_del_Profesor, asignaturas.nombre AS Nombre_de_la_Asignatura FROM profesores RIGHT JOIN asignaturas ON profesores.id = asignaturas.id_profesor WHERE profesores.nombre IS NULL;
SELECT departamentos.nombre AS Nombre_del_Departamento, asignaturas.nombre AS Nombre_de_la_Asignatura FROM departamentos LEFT JOIN asignaturas ON departamentos.id = asignaturas.id_departamento WHERE asignaturas.nombre IS NULL;
SELECT COUNT(*) FROM Alumnos;
SELECT COUNT(*) FROM Alumnos WHERE YEAR(fechaNacimiento) = 1999;
SELECT Nombre_Departamento, COUNT(*) FROM Profesores JOIN Departamentos ON Profesores.ID_Departamento = Departamentos.ID_Departamento GROUP BY Nombre_Departamento;
SELECT d.nombre AS 'departamento', count(p.id) AS Total FROM persona p RIGHT JOIN profesor pr ON p.id = pr.id_profesor RIGHT JOIN departamento d ON d.id = pr.id_departamento GROUP BY d.nombre ORDER BY Total DESC;
SELECT g.id, g.nombre AS 'Grado', COUNT(a.id) AS 'Total'FROM grado g LEFT JOIN asignatura a ON a.id_grado = g.id GROUP BY g.id ORDER BY total DESC;
SELECT * FROM Alumnos WHERE fechaNacimiento = (SELECT MIN(fechaNacimiento) FROM Alumnos);
SELECT nombre_profesor FROM profesores WHERE id_departamento IS NOT NULL AND id_profesor NOT IN (SELECT id_profesor FROM imparte);
