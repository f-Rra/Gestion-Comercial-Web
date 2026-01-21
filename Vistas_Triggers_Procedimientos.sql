
-- =====================================================
-- SISTEMA DE GESTIÓN COMERCIAL - VISTAS, TRIGGERS Y PROCEDIMIENTOS
-- =====================================================

USE SISTEMA_GESTION_COMERCIAL;
GO

-- Crear secuencia para números de venta
CREATE SEQUENCE SecVentas
    START WITH 1
    INCREMENT BY 1;
GO

-- =====================================================
-- VISTAS
-- =====================================================

-- Vista de Artículos Completos con Stock
CREATE OR ALTER VIEW vw_ArticulosCompletos AS
SELECT 
    a.Id,
    a.Codigo,
    a.Nombre,
    a.Descripcion,
    a.ImagenUrl,
    a.Precio,
    '$' + CAST(a.Precio AS VARCHAR(20)) AS PrecioFormateado,
    a.Stock,
    CASE 
        WHEN a.Stock > 0 THEN 'Disponible'
        ELSE 'Sin Stock'
    END AS EstadoStock,
    m.Id AS IdMarca,
    m.Descripcion AS Marca,
    c.Id AS IdCategoria,
    c.Descripcion AS Categoria,
    CASE a.Estado WHEN 1 THEN 'Activo' ELSE 'Inactivo' END AS EstadoTexto,
    a.Estado
FROM ARTICULOS a
INNER JOIN MARCAS m ON a.IdMarca = m.Id
INNER JOIN CATEGORIAS c ON a.IdCategoria = c.Id
WHERE a.Estado = 1 AND m.Estado = 1 AND c.Estado = 1;
GO

-- Vista de Inventario por Categoría
CREATE OR ALTER VIEW vw_InventarioPorCategoria AS
SELECT 
    c.Id AS IdCategoria,
    c.Descripcion AS Categoria,
    COUNT(a.Id) AS CantidadArticulos,
    AVG(a.Precio) AS PrecioPromedio,
    MIN(a.Precio) AS PrecioMinimo,
    MAX(a.Precio) AS PrecioMaximo
FROM CATEGORIAS c
LEFT JOIN ARTICULOS a ON c.Id = a.IdCategoria AND a.Estado = 1
WHERE c.Estado = 1
GROUP BY c.Id, c.Descripcion;
GO

-- Vista de Inventario por Marca
CREATE OR ALTER VIEW vw_InventarioPorMarca AS
SELECT 
    m.Id AS IdMarca,
    m.Descripcion AS Marca,
    COUNT(a.Id) AS CantidadArticulos,
    AVG(a.Precio) AS PrecioPromedio,
    MIN(a.Precio) AS PrecioMinimo,
    MAX(a.Precio) AS PrecioMaximo
FROM MARCAS m
LEFT JOIN ARTICULOS a ON m.Id = a.IdMarca AND a.Estado = 1
WHERE m.Estado = 1
GROUP BY m.Id, m.Descripcion;
GO

-- Vista de Estadísticas Generales
CREATE OR ALTER VIEW vw_EstadisticasGenerales AS
SELECT 
    (SELECT COUNT(*) FROM ARTICULOS WHERE Estado = 1) AS TotalArticulos,
    (SELECT COUNT(*) FROM CATEGORIAS WHERE Estado = 1) AS TotalCategorias,
    (SELECT COUNT(*) FROM MARCAS WHERE Estado = 1) AS TotalMarcas,
    (SELECT AVG(Precio) FROM ARTICULOS WHERE Estado = 1) AS PrecioPromedio,
    (SELECT COUNT(*) FROM Usuarios WHERE Estado = 1) AS TotalUsuarios;
GO

-- =====================================================
-- PROCEDIMIENTOS ALMACENADOS - USUARIOS
-- =====================================================

-- Verificar Usuario para Login
CREATE OR ALTER PROCEDURE SP_VerificarUsuario
    @NombreUsuario VARCHAR(50),
    @Contrasena VARCHAR(50)
AS
BEGIN
    SELECT 
        IdUsuario,
        NombreUsuario,
        EsAdministrador,
        Estado
    FROM Usuarios
    WHERE NombreUsuario = @NombreUsuario 
      AND Contrasena = @Contrasena 
      AND Estado = 1;
END;
GO

-- Listar Usuarios
CREATE OR ALTER PROCEDURE SP_ListarUsuarios
AS
BEGIN
    SELECT 
        IdUsuario,
        NombreUsuario,
        EsAdministrador,
        CASE Estado WHEN 1 THEN 'Activo' ELSE 'Inactivo' END AS EstadoTexto,
        FechaCreacion
    FROM Usuarios
    WHERE Estado = 1
    ORDER BY NombreUsuario;
END;
GO

-- =====================================================
-- PROCEDIMIENTOS ALMACENADOS - ARTÍCULOS
-- =====================================================

-- Listar Artículos
CREATE OR ALTER PROCEDURE SP_ListarArticulos
AS
BEGIN
    SELECT * FROM vw_ArticulosCompletos
    ORDER BY Nombre;
END;
GO

-- Buscar Artículo por ID
CREATE OR ALTER PROCEDURE SP_BuscarArticuloPorId
    @Id INT
AS
BEGIN
    SELECT * FROM vw_ArticulosCompletos
    WHERE Id = @Id;
END;
GO

-- Alta Artículo con Stock
CREATE OR ALTER PROCEDURE SP_AltaArticulo
    @Codigo VARCHAR(50),
    @Nombre VARCHAR(50),
    @Descripcion VARCHAR(150),
    @IdMarca INT,
    @IdCategoria INT,
    @ImagenUrl VARCHAR(1000),
    @Precio MONEY,
    @Stock INT = 0
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        
        INSERT INTO ARTICULOS (Codigo, Nombre, Descripcion, IdMarca, IdCategoria, ImagenUrl, Precio, Stock)
        VALUES (@Codigo, @Nombre, @Descripcion, @IdMarca, @IdCategoria, @ImagenUrl, @Precio, @Stock);
        
        SELECT SCOPE_IDENTITY() AS NuevoId;
        
        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        RAISERROR('Error al crear el artículo', 16, 1);
    END CATCH
END;
GO

-- Modificar Artículo con Stock
CREATE OR ALTER PROCEDURE SP_ModificarArticulo
    @Id INT,
    @Codigo VARCHAR(50),
    @Nombre VARCHAR(50),
    @Descripcion VARCHAR(150),
    @IdMarca INT,
    @IdCategoria INT,
    @ImagenUrl VARCHAR(1000),
    @Precio MONEY,
    @Stock INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        
        UPDATE ARTICULOS
        SET Codigo = @Codigo,
            Nombre = @Nombre,
            Descripcion = @Descripcion,
            IdMarca = @IdMarca,
            IdCategoria = @IdCategoria,
            ImagenUrl = @ImagenUrl,
            Precio = @Precio,
            Stock = @Stock
        WHERE Id = @Id AND Estado = 1;
        
        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        RAISERROR('Error al modificar el artículo', 16, 1);
    END CATCH
END;
GO

-- Baja Artículo
CREATE OR ALTER PROCEDURE SP_BajaArticulo
    @Id INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        
        UPDATE ARTICULOS 
        SET Estado = 0 
        WHERE Id = @Id;
        
        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        RAISERROR('Error al dar de baja el artículo', 16, 1);
    END CATCH
END;
GO

-- Buscar Artículos con Filtros
CREATE OR ALTER PROCEDURE SP_BuscarArticulos
    @Campo VARCHAR(50),
    @Criterio VARCHAR(50),
    @Filtro VARCHAR(100)
AS
BEGIN
    IF @Campo = 'Precio'
    BEGIN
        IF @Criterio = 'Mayor a'
            SELECT * FROM vw_ArticulosCompletos WHERE Precio > CAST(@Filtro AS DECIMAL(10,2)) ORDER BY Nombre;
        ELSE IF @Criterio = 'Menor a'
            SELECT * FROM vw_ArticulosCompletos WHERE Precio < CAST(@Filtro AS DECIMAL(10,2)) ORDER BY Nombre;
        ELSE
            SELECT * FROM vw_ArticulosCompletos WHERE Precio = CAST(@Filtro AS DECIMAL(10,2)) ORDER BY Nombre;
    END
    ELSE IF @Campo = 'Nombre'
    BEGIN
        IF @Criterio = 'Comienza con'
            SELECT * FROM vw_ArticulosCompletos WHERE Nombre LIKE @Filtro + '%' ORDER BY Nombre;
        ELSE IF @Criterio = 'Termina con'
            SELECT * FROM vw_ArticulosCompletos WHERE Nombre LIKE '%' + @Filtro ORDER BY Nombre;
        ELSE
            SELECT * FROM vw_ArticulosCompletos WHERE Nombre LIKE '%' + @Filtro + '%' ORDER BY Nombre;
    END
    ELSE -- Código por defecto
    BEGIN
        IF @Criterio = 'Comienza con'
            SELECT * FROM vw_ArticulosCompletos WHERE Codigo LIKE @Filtro + '%' ORDER BY Nombre;
        ELSE IF @Criterio = 'Termina con'
            SELECT * FROM vw_ArticulosCompletos WHERE Codigo LIKE '%' + @Filtro ORDER BY Nombre;
        ELSE
            SELECT * FROM vw_ArticulosCompletos WHERE Codigo LIKE '%' + @Filtro + '%' ORDER BY Nombre;
    END
END;
GO

-- =====================================================
-- PROCEDIMIENTOS ALMACENADOS - CATEGORÍAS
-- =====================================================

-- Listar Categorías
CREATE OR ALTER PROCEDURE SP_ListarCategorias
AS
BEGIN
    SELECT 
        Id,
        Descripcion,
        CASE Estado WHEN 1 THEN 'Activo' ELSE 'Inactivo' END AS EstadoTexto
    FROM CATEGORIAS
    WHERE Estado = 1
    ORDER BY Descripcion;
END;
GO

-- Alta Categoría
CREATE OR ALTER PROCEDURE SP_AltaCategoria
    @Descripcion VARCHAR(50)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        
        INSERT INTO CATEGORIAS (Descripcion)
        VALUES (@Descripcion);
        
        SELECT SCOPE_IDENTITY() AS NuevoId;
        
        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        RAISERROR('Error al crear la categoría', 16, 1);
    END CATCH
END;
GO

-- Modificar Categoría
CREATE OR ALTER PROCEDURE SP_ModificarCategoria
    @Id INT,
    @Descripcion VARCHAR(50)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        
        UPDATE CATEGORIAS
        SET Descripcion = @Descripcion
        WHERE Id = @Id AND Estado = 1;
        
        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        RAISERROR('Error al modificar la categoría', 16, 1);
    END CATCH
END;
GO

-- Baja Categoría
CREATE OR ALTER PROCEDURE SP_BajaCategoria
    @Id INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Verificar si hay artículos asociados
        IF EXISTS (SELECT 1 FROM ARTICULOS WHERE IdCategoria = @Id AND Estado = 1)
        BEGIN
            RAISERROR('No se puede eliminar la categoría porque tiene artículos asociados', 16, 1);
            RETURN;
        END
        
        UPDATE CATEGORIAS 
        SET Estado = 0 
        WHERE Id = @Id;
        
        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        RAISERROR('Error al dar de baja la categoría', 16, 1);
    END CATCH
END;
GO

-- =====================================================
-- PROCEDIMIENTOS ALMACENADOS - MARCAS
-- =====================================================

-- Listar Marcas
CREATE OR ALTER PROCEDURE SP_ListarMarcas
AS
BEGIN
    SELECT 
        Id,
        Descripcion,
        CASE Estado WHEN 1 THEN 'Activo' ELSE 'Inactivo' END AS EstadoTexto
    FROM MARCAS
    WHERE Estado = 1
    ORDER BY Descripcion;
END;
GO

-- Alta Marca
CREATE OR ALTER PROCEDURE SP_AltaMarca
    @Descripcion VARCHAR(50)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        
        INSERT INTO MARCAS (Descripcion)
        VALUES (@Descripcion);
        
        SELECT SCOPE_IDENTITY() AS NuevoId;
        
        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        RAISERROR('Error al crear la marca', 16, 1);
    END CATCH
END;
GO

-- Modificar Marca
CREATE OR ALTER PROCEDURE SP_ModificarMarca
    @Id INT,
    @Descripcion VARCHAR(50)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        
        UPDATE MARCAS
        SET Descripcion = @Descripcion
        WHERE Id = @Id AND Estado = 1;
        
        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        RAISERROR('Error al modificar la marca', 16, 1);
    END CATCH
END;
GO

-- Baja Marca
CREATE OR ALTER PROCEDURE SP_BajaMarca
    @Id INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Verificar si hay artículos asociados
        IF EXISTS (SELECT 1 FROM ARTICULOS WHERE IdMarca = @Id AND Estado = 1)
        BEGIN
            RAISERROR('No se puede eliminar la marca porque tiene artículos asociados', 16, 1);
            RETURN;
        END
        
        UPDATE MARCAS 
        SET Estado = 0 
        WHERE Id = @Id;
        
        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        RAISERROR('Error al dar de baja la marca', 16, 1);
    END CATCH
END;
GO

-- Buscar Marca por Descripción
CREATE OR ALTER PROCEDURE SP_BuscarMarcaPorDescripcion
    @Descripcion VARCHAR(50)
AS
BEGIN
    SELECT 
        Id,
        Descripcion,
        CASE Estado WHEN 1 THEN 'Activo' ELSE 'Inactivo' END AS EstadoTexto,
        Estado
    FROM MARCAS
    WHERE Descripcion = @Descripcion AND Estado = 1;
END;
GO

-- =====================================================
-- PROCEDIMIENTOS ALMACENADOS - STOCK
-- =====================================================

-- Actualizar Stock de Artículo
CREATE OR ALTER PROCEDURE SP_ActualizarStock
    @Id INT,
    @NuevoStock INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        
        IF @NuevoStock < 0
        BEGIN
            RAISERROR('El stock no puede ser negativo', 16, 1);
            RETURN;
        END
        
        UPDATE ARTICULOS
        SET Stock = @NuevoStock
        WHERE Id = @Id AND Estado = 1;
        
        IF @@ROWCOUNT = 0
        BEGIN
            RAISERROR('No se encontró el artículo o está inactivo', 16, 1);
            RETURN;
        END
        
        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        RAISERROR('Error al actualizar el stock', 16, 1);
    END CATCH
END;
GO

-- Sumar Stock 
CREATE OR ALTER PROCEDURE SP_SumarStock
    @Id INT,
    @Cantidad INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        
        IF @Cantidad <= 0
        BEGIN
            RAISERROR('La cantidad debe ser mayor a cero', 16, 1);
            RETURN;
        END
        
        UPDATE ARTICULOS
        SET Stock = Stock + @Cantidad
        WHERE Id = @Id AND Estado = 1;
        
        IF @@ROWCOUNT = 0
        BEGIN
            RAISERROR('No se encontró el artículo o está inactivo', 16, 1);
            RETURN;
        END
        
        SELECT Stock FROM ARTICULOS WHERE Id = @Id;
        
        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        RAISERROR('Error al sumar stock', 16, 1);
    END CATCH
END;
GO

-- Restar Stock 
CREATE OR ALTER PROCEDURE SP_RestarStock
    @Id INT,
    @Cantidad INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        
        IF @Cantidad <= 0
        BEGIN
            RAISERROR('La cantidad debe ser mayor a cero', 16, 1);
            RETURN;
        END
        
        DECLARE @StockActual INT;
        SELECT @StockActual = Stock FROM ARTICULOS WHERE Id = @Id AND Estado = 1;
        
        IF @StockActual IS NULL
        BEGIN
            RAISERROR('No se encontró el artículo o está inactivo', 16, 1);
            RETURN;
        END
        
        IF @StockActual < @Cantidad
        BEGIN
            RAISERROR('Stock insuficiente. Stock actual: %d, Cantidad solicitada: %d', 16, 1, @StockActual, @Cantidad);
            RETURN;
        END
        
        UPDATE ARTICULOS
        SET Stock = Stock - @Cantidad
        WHERE Id = @Id AND Estado = 1;
        
        SELECT Stock FROM ARTICULOS WHERE Id = @Id;
        
        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        RAISERROR('Error al restar stock', 16, 1);
    END CATCH
END;
GO

-- Artículos con Bajo Stock
CREATE OR ALTER PROCEDURE SP_ArticulosBajoStock
    @StockMinimo INT = 5
AS
BEGIN
    SELECT 
        Id,
        Codigo,
        Nombre,
        Marca,
        Categoria,
        Stock,
        EstadoStock,
        PrecioFormateado
    FROM vw_ArticulosCompletos
    WHERE Stock <= @StockMinimo
    ORDER BY Stock ASC, Nombre;
END;
GO

-- Artículos Sin Stock
CREATE OR ALTER PROCEDURE SP_ArticulosSinStock
AS
BEGIN
    SELECT 
        Id,
        Codigo,
        Nombre,
        Marca,
        Categoria,
        Stock,
        EstadoStock,
        PrecioFormateado
    FROM vw_ArticulosCompletos
    WHERE Stock = 0
    ORDER BY Nombre;
END;
GO

-- =====================================================
-- PROCEDIMIENTOS ALMACENADOS - REPORTES
-- =====================================================

-- Reporte de Inventario General
CREATE OR ALTER PROCEDURE SP_ReporteInventarioGeneral
AS
BEGIN
    SELECT * FROM vw_EstadisticasGenerales;
    
    SELECT 'Por Categoría' AS TipoReporte;
    SELECT * FROM vw_InventarioPorCategoria ORDER BY CantidadArticulos DESC;
    
    SELECT 'Por Marca' AS TipoReporte;
    SELECT * FROM vw_InventarioPorMarca ORDER BY CantidadArticulos DESC;
END;
GO

-- Reporte de Artículos por Rango de Precios
CREATE OR ALTER PROCEDURE SP_ReporteArticulosPorPrecio
    @PrecioMinimo MONEY,
    @PrecioMaximo MONEY
AS
BEGIN
    SELECT 
        Codigo,
        Nombre,
        Marca,
        Categoria,
        PrecioFormateado,
        Precio
    FROM vw_ArticulosCompletos
    WHERE Precio BETWEEN @PrecioMinimo AND @PrecioMaximo
    ORDER BY Precio;
END;
GO
-- =====================================================
-- TRIGGERS
-- =====================================================

-- validar código único de artículo
CREATE OR ALTER TRIGGER tr_ValidarCodigoUnicoArticulo
ON ARTICULOS
INSTEAD OF INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Para INSERT
    IF EXISTS (SELECT * FROM inserted) AND NOT EXISTS (SELECT * FROM deleted)
    BEGIN
        IF EXISTS (
            SELECT 1 FROM inserted i
            INNER JOIN ARTICULOS a ON i.Codigo = a.Codigo 
            WHERE a.Estado = 1 AND i.Codigo IS NOT NULL AND i.Codigo != ''
        )
        BEGIN
            RAISERROR('Ya existe un artículo con ese código', 16, 1);
            RETURN;
        END
        
        INSERT INTO ARTICULOS (Codigo, Nombre, Descripcion, IdMarca, IdCategoria, ImagenUrl, Precio, Stock, Estado)
        SELECT Codigo, Nombre, Descripcion, IdMarca, IdCategoria, ImagenUrl, Precio, 
               ISNULL(Stock, 0), ISNULL(Estado, 1)
        FROM inserted;
    END
    
    -- Para UPDATE
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        IF EXISTS (
            SELECT 1 FROM inserted i
            INNER JOIN ARTICULOS a ON i.Codigo = a.Codigo 
            WHERE a.Estado = 1 AND a.Id != i.Id AND i.Codigo IS NOT NULL AND i.Codigo != ''
        )
        BEGIN
            RAISERROR('Ya existe un artículo con ese código', 16, 1);
            RETURN;
        END
        
        UPDATE a
        SET Codigo = i.Codigo,
            Nombre = i.Nombre,
            Descripcion = i.Descripcion,
            IdMarca = i.IdMarca,
            IdCategoria = i.IdCategoria,
            ImagenUrl = i.ImagenUrl,
            Precio = i.Precio,
            Stock = i.Stock,
            Estado = i.Estado
        FROM ARTICULOS a
        INNER JOIN inserted i ON a.Id = i.Id;
    END
END;
GO

-- =====================================================
-- PROCEDIMIENTOS PARA VENTAS
-- =====================================================

-- 1. Buscar artículos disponibles para venta 
CREATE OR ALTER PROCEDURE SP_BuscarArticulosParaVenta
    @Filtro VARCHAR(100) = ''
AS
BEGIN
    SELECT 
        a.Id,
        a.Codigo,
        a.Nombre,
        a.Descripcion,
        a.Precio,
        a.Stock,
        m.Descripcion AS Marca,
        c.Descripcion AS Categoria,
        CASE 
            WHEN a.Stock > 0 THEN 'Disponible'
            ELSE 'Sin Stock'
        END AS EstadoStock
    FROM ARTICULOS a
    INNER JOIN MARCAS m ON a.IdMarca = m.Id
    INNER JOIN CATEGORIAS c ON a.IdCategoria = c.Id
    WHERE a.Estado = 1 
      AND a.Stock > 0
      AND (@Filtro = '' OR 
           a.Codigo LIKE '%' + @Filtro + '%' OR 
           a.Nombre LIKE '%' + @Filtro + '%' OR 
           a.Descripcion LIKE '%' + @Filtro + '%')
    ORDER BY a.Nombre;
END;
GO

-- 2. Registrar venta principal
CREATE OR ALTER PROCEDURE SP_RegistrarVenta
    @NumeroVenta VARCHAR(20),
    @Vendedor VARCHAR(100),
    @Cliente VARCHAR(200),
    @Total DECIMAL(10,2)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        
        DECLARE @IdVenta INT;
        
        -- Insertar venta principal
        INSERT INTO VENTAS (NumeroVenta, Vendedor, Cliente, Total)
        VALUES (@NumeroVenta, @Vendedor, @Cliente, @Total);
        
        SET @IdVenta = SCOPE_IDENTITY();
        
        -- Devolver el ID como resultado
        SELECT @IdVenta AS IdVenta;
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO

-- 3. Registrar detalle de venta
CREATE OR ALTER PROCEDURE SP_RegistrarDetalleVenta
    @IdVenta INT,
    @IdArticulo INT,
    @Cantidad INT,
    @PrecioUnitario DECIMAL(10,2),
    @Subtotal DECIMAL(10,2)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validar que la venta existe
        IF NOT EXISTS (SELECT 1 FROM VENTAS WHERE Id = @IdVenta)
        BEGIN
            THROW 50000, 'La venta especificada no existe', 1;
        END
        
        -- Validar stock suficiente
        DECLARE @StockActual INT;
        SELECT @StockActual = Stock FROM ARTICULOS WHERE Id = @IdArticulo AND Estado = 1;
        
        IF @StockActual IS NULL
        BEGIN
            THROW 50000, 'El artículo no existe o está inactivo', 1;
        END
        
        IF @StockActual < @Cantidad
        BEGIN
            THROW 50000, 'Stock insuficiente para completar la venta', 1;
        END
        
        -- Insertar detalle (el trigger se encarga de actualizar el stock)
        INSERT INTO DETALLE_VENTAS (IdVenta, IdArticulo, Cantidad, PrecioUnitario, Subtotal)
        VALUES (@IdVenta, @IdArticulo, @Cantidad, @PrecioUnitario, @Subtotal);
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO

-- 3. Obtener ventas por vendedor

CREATE OR ALTER PROCEDURE SP_ObtenerVentasPorVendedor
    @Vendedor VARCHAR(100)
AS
BEGIN
    SELECT 
        v.Id,
        v.NumeroVenta,
        v.Fecha,
        v.Cliente,
        v.Total,
        v.Estado,
        COUNT(d.Id) AS CantidadArticulos
    FROM VENTAS v
    LEFT JOIN DETALLE_VENTAS d ON v.Id = d.IdVenta
    WHERE v.Vendedor = @Vendedor
    GROUP BY v.Id, v.NumeroVenta, v.Fecha, v.Cliente, v.Total, v.Estado
    ORDER BY v.Fecha DESC;
END;
GO

-- 4. Validar stock disponible
CREATE OR ALTER PROCEDURE SP_ValidarStockDisponible
    @IdArticulo INT,
    @CantidadSolicitada INT
AS
BEGIN
    DECLARE @StockActual INT;
    
    SELECT @StockActual = Stock 
    FROM ARTICULOS 
    WHERE Id = @IdArticulo AND Estado = 1;
    
    SELECT 
        CASE 
            WHEN @StockActual IS NULL THEN 0
            WHEN @StockActual >= @CantidadSolicitada THEN 1
            ELSE 0
        END AS StockSuficiente,
        ISNULL(@StockActual, 0) AS StockActual;
END;
GO

-- 5. Obtener detalles de una venta específica
CREATE OR ALTER PROCEDURE SP_ObtenerDetallesVenta
    @IdVenta INT
AS
BEGIN
    SELECT 
        d.Id,
        d.IdArticulo,
        a.Codigo,
        a.Nombre,
        d.Cantidad,
        d.PrecioUnitario,
        d.Subtotal
    FROM DETALLE_VENTAS d
    INNER JOIN ARTICULOS a ON d.IdArticulo = a.Id
    WHERE d.IdVenta = @IdVenta
    ORDER BY a.Nombre;
END;
GO

-- =====================================================
--  TRIGGER PARA SISTEMA DE VENTAS
-- =====================================================

-- Trigger que se ejecuta automáticamente al insertar detalles de venta
-- Actualiza el stock automáticamente
CREATE OR ALTER TRIGGER tr_ActualizarStockEnVenta
ON DETALLE_VENTAS
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Verificar stock suficiente antes de actualizar
        IF EXISTS (
            SELECT 1 
            FROM inserted i
            INNER JOIN ARTICULOS a ON i.IdArticulo = a.Id
            WHERE a.Stock < i.Cantidad OR a.Estado = 0
        )
        BEGIN
            RAISERROR('Stock insuficiente o artículo inactivo', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Actualizar stock de artículos vendidos
        UPDATE a
        SET Stock = Stock - i.Cantidad
        FROM ARTICULOS a
        INNER JOIN inserted i ON a.Id = i.IdArticulo
        WHERE a.Estado = 1;

        -- Verificar que no haya stock negativo después de la actualización
        IF EXISTS (
            SELECT 1 
            FROM ARTICULOS a
            INNER JOIN inserted i ON a.Id = i.IdArticulo
            WHERE a.Stock < 0 AND a.Estado = 1
        )
        BEGIN
            RAISERROR('Error: Stock negativo detectado', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END
    END TRY
    BEGIN CATCH
        RAISERROR('Error en trigger de actualización de stock', 16, 1);
        ROLLBACK TRANSACTION;
    END CATCH
END;
GO

/*
=====================================================
SISTEMA DE GESTIÓN COMERCIAL - DESCRIPCIÓN COMPLETA
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
- Procedimientos almacenados para todas las operaciones CRUD
- Procedimientos específicos para gestión de inventario
- Consultas de stock bajo y sin stock
- Vistas para consultas complejas con estado de stock
- Triggers para validaciones y control automático de stock
- Transacciones con manejo de errores
- Validaciones de integridad referencial y stock negativo
- Nomenclatura consistente (SP_, vw_, tr_)

PROCEDIMIENTOS DE STOCK DISPONIBLES:
- SP_ActualizarStock: Establece un stock específico
- SP_SumarStock: Suma cantidad al stock (entradas)
- SP_RestarStock: Resta cantidad del stock (salidas) con validación
- SP_ArticulosBajoStock: Lista artículos con stock menor al mínimo
- SP_ArticulosSinStock: Lista artículos sin stock disponible

PROCEDIMIENTOS DE VENTAS (FASE 14):
- SP_BuscarArticulosParaVenta: Busca artículos disponibles para venta
- SP_RegistrarVenta: Registra venta completa con transacción
- SP_ObtenerVentasPorVendedor: Obtiene historial de ventas por vendedor
- SP_ValidarStockDisponible: Valida stock antes de vender
- SP_ObtenerDetallesVenta: Obtiene detalles de una venta específica

TRIGGERS IMPLEMENTADOS:
- tr_ValidarCodigoUnicoArticulo: Valida códigos únicos de artículos
- tr_ActualizarStockEnVenta: Actualiza stock automáticamente al vender
*/
