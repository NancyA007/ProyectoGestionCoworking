USE COWORKING_DB;

-- Consulta 1: Listar todos los usuarios con su información básica.
SELECT nombre, apellidos, no_identificacion, fecha_nacimiento FROM clientes;

-- Consulta 2: Listar los usuarios con membresía activa.
SELECT c.nombre AS "Nombre", c.apellidos AS "Apellido", estado
FROM clientes c
JOIN membresias m ON c.Id_Cliente = m.Cliente_Id
WHERE Estado = 'Activa';

-- Consulta 3: Listar los usuarios con Membresía Vencida.
SELECT c.nombre AS "Nombre", c.apellidos AS "Apellido", estado
FROM clientes c
JOIN membresias m ON c.Id_Cliente = m.Cliente_Id
WHERE Estado = 'Vencida';

-- Consulta 4: Listar los usuarios con Membresía Suspendida.
SELECT c.nombre AS "Nombre", c.apellidos AS "Apellido", estado
FROM clientes c
JOIN membresias m ON c.Id_Cliente = m.Cliente_Id
WHERE Estado = 'Suspendida';

-- Consulta 5: Contar cuántos usuarios tienen cada tipo de membresía.
SELECT nombre_tipo AS "Tipo de Membresía",
	(SELECT COUNT(Cliente_Id) FROM membresias WHERE membresias.TipoMembresia_Id = Tipos_Membresia.Id_TipoMembresia) AS "Cantidad Usuario"
FROM Tipos_Membresia;

