using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;

namespace Negocio
{
    public class ReporteNegocio
    {
        #region Inventario
        public DataSet obtenerReporteInventarioGeneral()
        {
            AccesoDatos datos = new AccesoDatos();
            DataSet dataSet = new DataSet();
            string[] nombresTablas = { 
                "Estadisticas", "CabeceraCat", "InventarioCat", "CabeceraMarca", "InventarioMarca" 
            };

            try
            {
                datos.setearConsulta("SP_ReporteInventarioGeneral");
                datos.setearTipoComando(CommandType.StoredProcedure);
                datos.ejecutarLectura();

                int i = 0;
                do {
                    DataTable tabla = new DataTable(nombresTablas[i]);
                    tabla.Load(datos.Lector);
                    dataSet.Tables.Add(tabla);
                    i++;
                } while (i < nombresTablas.Length && !datos.Lector.IsClosed);

                return dataSet;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public DataTable obtenerInventarioCompleto()
        {
            AccesoDatos datos = new AccesoDatos();
            DataTable tabla = new DataTable();
            try
            {
                datos.setearConsulta(@"SELECT 
                    Codigo AS [Código], 
                    Nombre AS [Artículo], 
                    Descripcion AS [Descripción], 
                    Marca, 
                    Categoria AS [Categoría], 
                    Precio, 
                    Stock AS [Stock Actual]
                FROM vw_ArticulosCompletos 
                ORDER BY Nombre");
                datos.ejecutarLectura();
                tabla.Load(datos.Lector);
                return tabla;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public DataTable obtenerInventarioPorCategoria()
        {
            AccesoDatos datos = new AccesoDatos();
            DataTable tabla = new DataTable();
            try
            {
                datos.setearConsulta(@"SELECT 
                    Categoria AS [Categoría], 
                    CantidadArticulos AS [Total Artículos]
                FROM vw_InventarioPorCategoria 
                ORDER BY CantidadArticulos DESC");
                datos.ejecutarLectura();
                tabla.Load(datos.Lector);
                return tabla;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public DataTable obtenerInventarioPorMarca()
        {
            AccesoDatos datos = new AccesoDatos();
            DataTable tabla = new DataTable();
            try
            {
                datos.setearConsulta(@"SELECT 
                    Marca, 
                    CantidadArticulos AS [Total Artículos]
                FROM vw_InventarioPorMarca 
                ORDER BY CantidadArticulos DESC");
                datos.ejecutarLectura();
                tabla.Load(datos.Lector);
                return tabla;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public DataTable obtenerArticulosBajoStock(int stockMinimo = 5)
        {
            AccesoDatos datos = new AccesoDatos();
            DataTable tabla = new DataTable();
            try
            {
                datos.setearConsulta(@"SELECT 
                    Codigo AS [Código], 
                    Nombre AS [Artículo], 
                    Marca, 
                    Categoria AS [Categoría], 
                    Stock AS [Stock Disponible]
                FROM vw_ArticulosCompletos
                WHERE Stock <= @StockMinimo AND Stock > 0
                ORDER BY Stock ASC");
                datos.setearParametro("@StockMinimo", stockMinimo);
                datos.ejecutarLectura();
                tabla.Load(datos.Lector);
                return tabla;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public DataTable obtenerArticulosSinStock()
        {
            AccesoDatos datos = new AccesoDatos();
            DataTable tabla = new DataTable();
            try
            {
                datos.setearConsulta(@"SELECT 
                    Codigo AS [Código], 
                    Nombre AS [Artículo], 
                    Marca, 
                    Categoria AS [Categoría], 
                    Stock AS [Stock Actual]
                FROM vw_ArticulosCompletos
                WHERE Stock = 0
                ORDER BY Nombre");
                datos.ejecutarLectura();
                tabla.Load(datos.Lector);
                return tabla;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
        #endregion

        #region Ventas
        public DataTable obtenerVentasPorFecha(DateTime fechaInicio, DateTime fechaFin)
        {
            AccesoDatos datos = new AccesoDatos();
            DataTable tabla = new DataTable();
            try
            {
                datos.setearConsulta(@"SELECT 
                    NumeroVenta AS [N° Venta], 
                    Fecha, 
                    Vendedor, 
                    Cliente, 
                    Total AS [Monto Total]
                FROM VENTAS
                WHERE Fecha >= @FechaInicio AND Fecha <= @FechaFin
                ORDER BY Fecha DESC");
                datos.setearParametro("@FechaInicio", fechaInicio);
                datos.setearParametro("@FechaFin", fechaFin);
                datos.ejecutarLectura();
                tabla.Load(datos.Lector);
                return tabla;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public DataTable obtenerVentasDetalladas(DateTime fechaInicio, DateTime fechaFin)
        {
            AccesoDatos datos = new AccesoDatos();
            DataTable tabla = new DataTable();
            try
            {
                datos.setearConsulta(@"SELECT 
                    v.NumeroVenta AS [N° Venta], 
                    v.Fecha, 
                    a.Nombre AS [Artículo], 
                    dv.Cantidad, 
                    dv.PrecioUnitario AS [Precio Unit.], 
                    dv.Subtotal
                FROM VENTAS v
                INNER JOIN DETALLE_VENTAS dv ON v.Id = dv.IdVenta
                INNER JOIN ARTICULOS a ON dv.IdArticulo = a.Id
                WHERE v.Fecha >= @FechaInicio AND v.Fecha <= @FechaFin
                ORDER BY v.Fecha DESC");
                datos.setearParametro("@FechaInicio", fechaInicio);
                datos.setearParametro("@FechaFin", fechaFin);
                datos.ejecutarLectura();
                tabla.Load(datos.Lector);
                return tabla;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public DataTable obtenerResumenVentasDiarias(DateTime fechaInicio, DateTime fechaFin)
        {
            AccesoDatos datos = new AccesoDatos();
            DataTable tabla = new DataTable();
            try
            {
                datos.setearConsulta(@"SELECT 
                    CAST(Fecha AS DATE) AS [Fecha],
                    COUNT(*) AS [Cant. Ventas],
                    SUM(Total) AS [Recaudación Total],
                    AVG(Total) AS [Ticket Promedio]
                FROM VENTAS
                WHERE Fecha >= @FechaInicio AND Fecha <= @FechaFin
                GROUP BY CAST(Fecha AS DATE)
                ORDER BY Fecha DESC");
                datos.setearParametro("@FechaInicio", fechaInicio);
                datos.setearParametro("@FechaFin", fechaFin);
                datos.ejecutarLectura();
                tabla.Load(datos.Lector);
                return tabla;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
        #endregion

        #region Rankings y Estadísticas
        public DataTable obtenerTopVendedores(DateTime fechaInicio, DateTime fechaFin)
        {
            AccesoDatos datos = new AccesoDatos();
            DataTable tabla = new DataTable();
            try
            {
                datos.setearConsulta(@"SELECT 
                    Vendedor,
                    COUNT(*) AS [Ventas Realizadas],
                    SUM(Total) AS [Total Facturado],
                    AVG(Total) AS [Promedio por Venta]
                FROM VENTAS
                WHERE Fecha >= @FechaInicio AND Fecha <= @FechaFin
                GROUP BY Vendedor
                ORDER BY [Total Facturado] DESC");
                datos.setearParametro("@FechaInicio", fechaInicio);
                datos.setearParametro("@FechaFin", fechaFin);
                datos.ejecutarLectura();
                tabla.Load(datos.Lector);
                return tabla;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public DataTable obtenerArticulosMasVendidos(DateTime fechaInicio, DateTime fechaFin)
        {
            AccesoDatos datos = new AccesoDatos();
            DataTable tabla = new DataTable();
            try
            {
                datos.setearConsulta(@"SELECT TOP 10
                    a.Nombre AS [Artículo],
                    m.Descripcion AS Marca,
                    SUM(dv.Cantidad) AS [Unid. Vendidas],
                    SUM(dv.Subtotal) AS [Total Generado]
                FROM DETALLE_VENTAS dv
                INNER JOIN VENTAS v ON dv.IdVenta = v.Id
                INNER JOIN ARTICULOS a ON dv.IdArticulo = a.Id
                INNER JOIN MARCAS m ON a.IdMarca = m.Id
                WHERE v.Fecha >= @FechaInicio AND v.Fecha <= @FechaFin
                GROUP BY a.Nombre, m.Descripcion
                ORDER BY [Unid. Vendidas] DESC");
                datos.setearParametro("@FechaInicio", fechaInicio);
                datos.setearParametro("@FechaFin", fechaFin);
                datos.ejecutarLectura();
                tabla.Load(datos.Lector);
                return tabla;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public DataTable obtenerEstadisticasStockPorCategoria()
        {
            AccesoDatos datos = new AccesoDatos();
            DataTable tabla = new DataTable();
            try
            {
                datos.setearConsulta(@"SELECT 
                    c.Descripcion AS [Categoría],
                    COUNT(a.Id) AS [Variedad Art.],
                    SUM(a.Stock) AS [Stock Total],
                    COUNT(CASE WHEN a.Stock = 0 THEN 1 END) AS [Sin Stock]
                FROM ARTICULOS a
                INNER JOIN CATEGORIAS c ON a.IdCategoria = c.Id
                GROUP BY c.Descripcion
                ORDER BY [Stock Total] DESC");
                datos.ejecutarLectura();
                tabla.Load(datos.Lector);
                return tabla;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public DataTable obtenerEstadisticasStockPorMarca()
        {
            AccesoDatos datos = new AccesoDatos();
            DataTable tabla = new DataTable();
            try
            {
                datos.setearConsulta(@"SELECT 
                    m.Descripcion AS Marca,
                    COUNT(a.Id) AS [Variedad Art.],
                    SUM(a.Stock) AS [Stock Total],
                    COUNT(CASE WHEN a.Stock = 0 THEN 1 END) AS [Sin Stock]
                FROM ARTICULOS a
                INNER JOIN MARCAS m ON a.IdMarca = m.Id
                GROUP BY m.Descripcion
                ORDER BY [Stock Total] DESC");
                datos.ejecutarLectura();
                tabla.Load(datos.Lector);
                return tabla;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
        #endregion
    }
}
