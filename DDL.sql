-- Creación de la Base de Datos
CREATE DATABASE IF NOT EXISTS COWORKING_DB;
USE COWORKING_DB;

-- Creación de Tablas Independientes
CREATE TABLE Roles(
    Id_Rol INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Nombre_Rol VARCHAR(75) NOT NULL,
    Descripcion TEXT NULL
);

CREATE TABLE Empresas(
    Id_Empresa INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Nombre_Empresa VARCHAR(120) UNIQUE NOT NULL,
    NIT VARCHAR(25) UNIQUE NOT NULL,
    Telefono VARCHAR(25) NOT NULL,
    Email VARCHAR(75) UNIQUE NOT NULL
);

CREATE TABLE Tipos_Membresia(
    Id_TipoMembresia INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Nombre_Tipo VARCHAR(60) UNIQUE NOT NULL,
    Descripcion TEXT NULL,
    Precio DECIMAL(10,2) NOT NULL CHECK (Precio > 0),
    Duracion_Dias INT NOT NULL
);

CREATE TABLE Tipos_Espacio(
    Id_TipoEspacio INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Nombre_Espacio VARCHAR(75) NOT NULL,
    Descripcion TEXT NULL
);

CREATE TABLE Servicios_Adicionales(
    Id_Servicio INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Nombre_Servicio VARCHAR(100) NOT NULL,
    Descripcion TEXT NULL,
    Precio_Unitario DECIMAL(10,2) CHECK (Precio_Unitario > 0) NOT NULL
);

CREATE TABLE Metodos_Pago(
    Id_Metodo INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Nombre_Metodo VARCHAR(75) UNIQUE NOT NULL
);

-- Creación de Tablas con Dependencias
CREATE TABLE Clientes(
    Id_Cliente INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Empresa_Id INT NULL,
    Nombre VARCHAR(200) NOT NULL,
    Apellidos VARCHAR(200) NOT NULL,
    No_Identificacion BIGINT UNIQUE NOT NULL,
    Fecha_Nacimiento DATE NOT NULL,
    Telefono VARCHAR(25) NOT NULL,
    Email VARCHAR(75) UNIQUE NOT NULL,
    CodigoQR INT UNIQUE NOT NULL,
    Fecha_Registro DATE NOT NULL,
    FOREIGN KEY (Empresa_Id) REFERENCES Empresas(Id_Empresa)
);

CREATE TABLE Empleados(
    Id_Empleado INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Rol_Id INT NULL,
    Nombre VARCHAR(200) NOT NULL,
    Apellidos VARCHAR(200) NOT NULL,
    No_Identificacion BIGINT UNIQUE NOT NULL,
    Fecha_Nacimiento DATE NOT NULL,
    Telefono VARCHAR(25) NOT NULL,
    Email VARCHAR(75) UNIQUE NOT NULL,
    CodigoQR INT UNIQUE NOT NULL,
    Fecha_Contratacion DATE NOT NULL,
    FOREIGN KEY (Rol_Id) REFERENCES Roles(Id_Rol)
);

CREATE TABLE Membresias(
    Id_Membresia INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Cliente_Id INT NOT NULL,
    TipoMembresia_Id INT NOT NULL,
    Fecha_Inicio DATE NOT NULL,
    Fecha_Vencimiento DATE NOT NULL,
    Estado ENUM('Activa','Suspendida','Vencida') NOT NULL DEFAULT 'Activa',
    FOREIGN KEY (Cliente_Id) REFERENCES Clientes(Id_Cliente),
    FOREIGN KEY (TipoMembresia_Id) REFERENCES Tipos_Membresia(Id_TipoMembresia)
);

CREATE TABLE Espacios(
    Id_Espacio INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    TipoEspacio_Id INT NOT NULL,
    Nombre_Espacio VARCHAR(75) NOT NULL,
    Capacidad INT CHECK (Capacidad > 0) NOT NULL,
    Horario_Disponibilidad VARCHAR(75) NOT NULL,
    Estado ENUM('Disponible', 'Mantenimiento', 'Ocupado') NOT NULL DEFAULT 'Disponible',
    FOREIGN KEY (TipoEspacio_Id) REFERENCES Tipos_Espacio(Id_TipoEspacio)
);

CREATE TABLE Reservas(
    Id_Reserva INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Cliente_Id INT NOT NULL,
    Espacio_Id INT NOT NULL,
    Fecha_Reserva DATE NOT NULL,
    Hora_Inicio TIME NOT NULL,
    Hora_Fin TIME NOT NULL,
    Estado ENUM('Pendiente','Cancelada','Confirmada','Ausente') NOT NULL DEFAULT 'Pendiente',
    FOREIGN KEY (Cliente_Id) REFERENCES Clientes(Id_Cliente),
    FOREIGN KEY (Espacio_Id) REFERENCES Espacios(Id_Espacio)
);

CREATE TABLE Reservas_Servicios(
    Id_ReservaServicio INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Servicio_Id INT NOT NULL,
    Reserva_Id INT NOT NULL,
    Cantidad INT NOT NULL,
    Subtotal DECIMAL(10,2) CHECK (Subtotal > 0) NOT NULL,
    FOREIGN KEY (Servicio_Id) REFERENCES Servicios_Adicionales(Id_Servicio),
    FOREIGN KEY (Reserva_Id) REFERENCES Reservas(Id_Reserva)
);

CREATE TABLE Facturas(
    Id_Factura INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Cliente_Id INT NULL,
    Empresa_Id INT NULL,
    Fecha_Emision DATE NOT NULL,
    Fecha_Vencimiento DATE NOT NULL,
    Monto_Total DECIMAL(10,2) CHECK (Monto_Total > 0) NOT NULL,
    Saldo_Pendiente DECIMAL(10,2) CHECK (Saldo_Pendiente >= 0) NOT NULL,
    Estado ENUM('Emitida','Pagada','Anulada','Pendiente') NOT NULL DEFAULT 'Emitida',
    FOREIGN KEY (Cliente_Id) REFERENCES Clientes(Id_Cliente),
    FOREIGN KEY (Empresa_Id) REFERENCES Empresas(Id_Empresa)
);

CREATE TABLE Pagos(
    Id_Pago INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Factura_Id INT NOT NULL,
    Metodo_Id INT NOT NULL,
    Monto_Pagado DECIMAL(10,2) NOT NULL,
    Fecha_Pago DATETIME NOT NULL,
    Estado ENUM('Pagado','Pendiente', 'Cancelado') NOT NULL DEFAULT 'Pagado',
    Motivo_Anulacion TEXT NULL,
    FOREIGN KEY (Factura_Id) REFERENCES Facturas(Id_Factura),
    FOREIGN KEY (Metodo_Id) REFERENCES Metodos_Pago(Id_Metodo)
);

CREATE TABLE Accesos(
    Id_Acceso INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Cliente_Id INT NULL,
    Empleado_Id INT NULL,
    FechaHora_Entrada DATETIME NOT NULL,
    FechaHora_Salida DATETIME NULL,
    Estado_Acceso ENUM('Aprobado','Denegado') NOT NULL,
    Motivo_Rechazo VARCHAR(150) NULL,
    FOREIGN KEY (Cliente_Id) REFERENCES Clientes(Id_Cliente),
    FOREIGN KEY (Empleado_Id) REFERENCES Empleados(Id_Empleado)
);

-- Tabla para Control de Triggers
CREATE TABLE logs_sistema(
    Id_Sistema INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Tabla_Afectada VARCHAR(100) NOT NULL,
    Accion VARCHAR(100) NOT NULL,
    Detalles TEXT NULL,
    Fecha_Hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);