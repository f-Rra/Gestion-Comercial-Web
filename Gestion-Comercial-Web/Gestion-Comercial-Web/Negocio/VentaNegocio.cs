using System;
using System.Data;
using System.Collections.Generic;
using Dominio;

namespace Negocio
{
    public class VentaNegocio
    {
        public DataTable buscarArticulosParaVenta(string filtro = "")
        {
            AccesoDatos datos = new AccesoDatos();
            DataTable tabla = new DataTable();
            try
            {
                datos.setearConsulta("SP_BuscarArticulosParaVenta");
                datos.setearTipoComando(CommandType.StoredProcedure);
                datos.setearParametro("@Filtro", filtro ?? "");
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
        
        public void registrarVenta(Venta venta)
        {
            AccesoDatos datos = new AccesoDatos();
            int idVenta = 0;
            
            try
            {
                // Primero registrar la venta principal
                datos.setearConsulta("SP_RegistrarVenta");
                datos.setearTipoComando(CommandType.StoredProcedure);
                datos.setearParametro("@NumeroVenta", venta.NumeroVenta);
                datos.setearParametro("@Vendedor", venta.Vendedor);
                datos.setearParametro("@Cliente", venta.Cliente ?? "");
                datos.setearParametro("@Total", venta.Total);
                
                datos.ejecutarLectura();
                if(datos.Lector.Read())
                {
                    idVenta = Convert.ToInt32(datos.Lector[0]);
                }
                datos.cerrarConexion();

                // Validar que se obtuvo el ID de venta
                if (idVenta == 0)
                {
                    throw new Exception("No se pudo obtener el ID de la venta registrada");
                }

                // Luego registrar cada detalle de venta
                foreach (var detalle in venta.Detalles)
                {
                    AccesoDatos datosDetalle = new AccesoDatos();
                    try 
                    {
                        datosDetalle.setearConsulta("SP_RegistrarDetalleVenta");
                        datosDetalle.setearTipoComando(CommandType.StoredProcedure);
                        datosDetalle.setearParametro("@IdVenta", idVenta);
                        datosDetalle.setearParametro("@IdArticulo", detalle.IdArticulo);
                        datosDetalle.setearParametro("@Cantidad", detalle.Cantidad);
                        datosDetalle.setearParametro("@PrecioUnitario", detalle.PrecioUnitario);
                        datosDetalle.setearParametro("@Subtotal", detalle.Subtotal);
                        datosDetalle.ejecutarAccion();
                    }
                    finally
                    {
                        datosDetalle.cerrarConexion();
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al registrar la venta: " + ex.Message, ex);
            }
            finally
            {
                if (datos != null)
                {
                    datos.cerrarConexion();
                }
            }
        }

        public DataTable obtenerVentasPorVendedor(string vendedor)
        {
            AccesoDatos datos = new AccesoDatos();
            DataTable tabla = new DataTable();
            try
            {
                datos.setearConsulta("SP_ObtenerVentasPorVendedor");
                datos.setearTipoComando(CommandType.StoredProcedure);
                datos.setearParametro("@Vendedor", vendedor);
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

        public bool validarStockDisponible(int idArticulo, int cantidadSolicitada)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("SP_ValidarStockDisponible");
                datos.setearTipoComando(CommandType.StoredProcedure);
                datos.setearParametro("@IdArticulo", idArticulo);
                datos.setearParametro("@CantidadSolicitada", cantidadSolicitada);
                datos.ejecutarLectura();
                
                if (datos.Lector.Read())
                {
                    return (bool)datos.Lector["StockSuficiente"];
                }
                return false;
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

        public DataTable obtenerDetallesVenta(int idVenta)
        {
            AccesoDatos datos = new AccesoDatos();
            DataTable tabla = new DataTable();
            try
            {
                datos.setearConsulta("SP_ObtenerDetallesVenta");
                datos.setearTipoComando(CommandType.StoredProcedure);
                datos.setearParametro("@IdVenta", idVenta);
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
    }
}
