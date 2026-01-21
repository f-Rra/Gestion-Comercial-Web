-- =====================================================
-- SISTEMA DE GESTIÓN COMERCIAL - ESTRUCTURA DE BASE DE DATOS
-- =====================================================

-- Creación de la base de datos
CREATE DATABASE SISTEMA_GESTION_COMERCIAL;
GO

USE SISTEMA_GESTION_COMERCIAL;
GO

-- Tabla de Categorías
CREATE TABLE CATEGORIAS (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Descripcion VARCHAR(50) NULL,
    Estado BIT NOT NULL DEFAULT 1
);

-- Tabla de Marcas
CREATE TABLE MARCAS (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Descripcion VARCHAR(50) NULL,
    Estado BIT NOT NULL DEFAULT 1
);

-- Tabla de Artículos
CREATE TABLE ARTICULOS (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Codigo VARCHAR(50) NULL,
    Nombre VARCHAR(50) NULL,
    Descripcion VARCHAR(150) NULL,
    IdMarca INT NULL,
    IdCategoria INT NULL,
    ImagenUrl VARCHAR(1000) NULL,
    Precio MONEY NULL,
    Stock INT NOT NULL DEFAULT 0,
    Estado BIT NOT NULL DEFAULT 1,
    FOREIGN KEY (IdMarca) REFERENCES MARCAS(Id),
    FOREIGN KEY (IdCategoria) REFERENCES CATEGORIAS(Id)
);

-- Tabla de Usuarios para autenticación
CREATE TABLE Usuarios (
    IdUsuario INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    NombreUsuario VARCHAR(50) NOT NULL UNIQUE,
    Contrasena VARCHAR(50) NOT NULL,
    EsAdministrador BIT NOT NULL DEFAULT 0,
    Estado BIT NOT NULL DEFAULT 1,
    FechaCreacion DATETIME NOT NULL DEFAULT GETDATE()
);

-- Tabla VENTAS
CREATE TABLE VENTAS (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    NumeroVenta VARCHAR(20) NOT NULL UNIQUE,
    Fecha DATETIME NOT NULL DEFAULT GETDATE(),
    Vendedor VARCHAR(100) NOT NULL,
    Cliente VARCHAR(200),
    Total DECIMAL(10,2) NOT NULL,
    Estado VARCHAR(20) NOT NULL DEFAULT 'Completada',
    FechaCreacion DATETIME NOT NULL DEFAULT GETDATE()
);

-- Tabla DETALLE_VENTAS
CREATE TABLE DETALLE_VENTAS (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    IdVenta INT NOT NULL,
    IdArticulo INT NOT NULL,
    Cantidad INT NOT NULL,
    PrecioUnitario DECIMAL(10,2) NOT NULL,
    Subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (IdVenta) REFERENCES VENTAS(Id) ON DELETE CASCADE,
    FOREIGN KEY (IdArticulo) REFERENCES ARTICULOS(Id)
);

GO



/*
=====================================================
SISTEMA DE GESTIÓN COMERCIAL - ESTRUCTURA DE BASE DE DATOS
=====================================================

RELACIONES DEL MODELO:
- MARCAS (1) → ARTICULOS (N)
- CATEGORIAS (1) → ARTICULOS (N)
- VENTAS (1) → DETALLE_VENTAS (N) 
- ARTICULOS (1) → DETALLE_VENTAS (N) 

DESCRIPCIÓN DE TABLAS:
- ARTICULOS: almacena la información de cada artículo con su código, nombre, descripción, marca, categoría, imagen, precio y STOCK
- CATEGORIAS: contiene los datos de las categorías de artículos
- MARCAS: contiene los datos de las marcas de los artículos
- Usuarios: almacena usuarios del sistema con autenticación
- VENTAS: registra las ventas realizadas por vendedores 
- DETALLE_VENTAS: detalla los artículos vendidos en cada venta

CARACTERÍSTICAS IMPLEMENTADAS:
- Baja lógica con campo Estado BIT
- Gestión completa de STOCK con validaciones
- Sistema de VENTAS completo 
- Estructura preparada para procedimientos almacenados, vistas y triggers

ARCHIVOS DEL SISTEMA:
1. Script_Sistema_Gestion_Comercial.sql - Estructura de tablas (ESTE ARCHIVO)
2. Vistas_Triggers_Procedimientos.sql - Vistas, triggers y procedimientos almacenados
3. Datos_Iniciales.sql - Datos de prueba (opcional)

NOTA: Para completar la instalación, ejecutar también:
- Vistas_Triggers_Procedimientos.sql (contiene toda la lógica de negocio)
- Datos_Iniciales.sql (opcional, para datos de prueba)
*/

