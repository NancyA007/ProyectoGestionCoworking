# 🏢 Sistema de Gestión de Coworking (COWORKING_DB)

Un sistema de gestión relacional robusto desarrollado en MySQL, diseñado y optimizado para la operación de espacios de trabajo compartido (Coworking) en la Ciudad de Guatemala y municipios aledaños.

El proyecto abarca desde la definición de arquitectura lógica (DDL) y la seguridad de motor (DCL), hasta la simulación transaccional e histórica con datos reales de la región en Quetzales (Q) desde el año 2022 al presente (DML).

## 📌 Tabla de Contenidos

Características Principales

Arquitectura de la Base de Datos

Seguridad y Roles (DCL)

Script DML Completo

Instalación y Despliegue

Tecnologías Utilizadas

## 🚀 Características Principales

Contextualización Local: Precios expresados en Quetzales ($Q$), datos fiscales ajustados a la SAT (NIT) y ubicaciones en la Ciudad de Guatemala, Mixco, Santa Catarina Pinula y áreas metropolitanas.

Control Operativo Multidimensional: Gestión completa de clientes independientes y cuentas corporativas, membresías, espacios físicos (escritorios, oficinas, salas) y reservas de servicios adicionales.

Auditoría y Control de Accesos: Registro dinámico de entradas y salidas aprobadas y denegadas mediante simulación de códigos QR.

Integridad de Datos: Restricciones de verificación (CHECK), claves foráneas en cascada/restringidas y consistencia de transacciones financieras.

## 📐 Arquitectura de la Base de Datos

El modelo relacional está compuesto por 15 tablas altamente normalizadas:

Roles: 5 roles operativos del sistema (Administrador, Recepcionista, Contador, Soporte Técnico, Gerente Corporativo).

Empresas: Registro de entidades corporativas aliadas.

Tipos_Membresia: Planes configurados (Diaria, Mensual, Corporativa, Premium).

Tipos_Espacio: Categorías de instalaciones (Escritorios flexibles, Oficinas privadas, Salas de reuniones, Salas de eventos).

Servicios_Adicionales: Adicionales facturables (Internet premium, Lockers, Café ilimitado, Impresiones, Uso de proyector).

Metodos_Pago: Métodos aceptados (Efectivo, Tarjeta, Transferencia, PayPal).

Clientes: Catálogo de usuarios principales (50 clientes individuales y corporativos).

Empleados: Personal administrativo vinculado a roles lógicos.

Espacios: Inventario de áreas físicas y capacidades.

Membresias: Histórico de estados (Activa, Suspendida, Vencida).

Reservas: Solicitudes de espacios con fechas y duraciones.

Reservas_Servicios: Relación M:N entre reservas y servicios contratados.

Facturas: Registro contable y saldos pendientes.

Pagos: Liquidaciones financieras registradas.

Accesos: Bitácora de marcajes QR (entradas/salidas).

## 🛠️ Instalación y Despliegue

Clonar el repositorio:

```
git clone https://github.com/NancyA007/ProyectoGestionCoworking.git
cd coworking-management-db
```



## 🛠️ Tecnologías Utilizadas

SGBD: MySQL 8.0+

Modelado: UML / Diagramas Entidad-Relación

Lenguajes: SQL (DDL, DCL, DML)

Herramientas recomendadas: MySQL Workbench, DBeaver o VS Code.
