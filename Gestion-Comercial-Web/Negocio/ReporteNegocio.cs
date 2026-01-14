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
                    Codigo, Nombre, Descripcion, Marca, Categoria, Precio, Stock
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

        public DataTable obtenerArticulosBajoStock(int stockMinimo = 5)
        {
            AccesoDatos datos = new AccesoDatos();
            DataTable tabla = new DataTable();
            try
            {
                datos.setearConsulta("SP_ArticulosBajoStock");
                datos.setearTipoComando(CommandType.StoredProcedure);
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
                datos.setearConsulta("SP_ArticulosSinStock");
                datos.setearTipoComando(CommandType.StoredProcedure);
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
                    v.Id, v.NumeroVenta, v.Fecha, v.Vendedor, v.Cliente, v.Total, v.Estado
                FROM VENTAS v
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
                    CAST(v.Fecha AS DATE) as Fecha,
                    COUNT(*) as CantidadVentas,
                    SUM(v.Total) as TotalVentas,
                    AVG(v.Total) as PromedioVenta,
                    COUNT(DISTINCT v.Vendedor) as VendedoresActivos
                FROM VENTAS v
                WHERE v.Fecha >= @FechaInicio AND v.Fecha <= @FechaFin
                GROUP BY CAST(v.Fecha AS DATE)
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
                    v.Vendedor,
                    COUNT(*) as CantidadVentas,
                    SUM(v.Total) as TotalVentas,
                    AVG(v.Total) as PromedioVenta
                FROM VENTAS v
                WHERE v.Fecha >= @FechaInicio AND v.Fecha <= @FechaFin
                GROUP BY v.Vendedor
                ORDER BY TotalVentas DESC");
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
                datos.setearConsulta(@"SELECT 
                    a.Nombre,
                    m.Descripcion as Marca,
                    SUM(dv.Cantidad) as CantidadVendida,
                    SUM(dv.Subtotal) as TotalVentas
                FROM DETALLE_VENTAS dv
                INNER JOIN VENTAS v ON dv.IdVenta = v.Id
                INNER JOIN ARTICULOS a ON dv.IdArticulo = a.Id
                INNER JOIN MARCAS m ON a.IdMarca = m.Id
                WHERE v.Fecha >= @FechaInicio AND v.Fecha <= @FechaFin
                GROUP BY a.Nombre, m.Descripcion
                ORDER BY CantidadVendida DESC");
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
    }
}
