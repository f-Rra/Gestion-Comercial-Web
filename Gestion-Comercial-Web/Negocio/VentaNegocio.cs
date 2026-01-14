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
                datos.abrirTransaccion();

                // 1. Registrar la venta principal
                datos.setearConsulta("SP_RegistrarVenta");
                datos.setearTipoComando(CommandType.StoredProcedure);
                datos.setearParametro("@NumeroVenta", venta.NumeroVenta);
                datos.setearParametro("@Vendedor", venta.Vendedor);
                datos.setearParametro("@Cliente", venta.Cliente ?? "Consumidor Final");
                datos.setearParametro("@Total", venta.Total);
                
                datos.ejecutarLectura();
                if(datos.Lector.Read())
                {
                    idVenta = Convert.ToInt32(datos.Lector[0]);
                }
                
                // IMPORTANTE: Cerrar el lector para poder ejecutar el siguiente comando
                datos.Lector.Close();

                if (idVenta == 0)
                    throw new Exception("No se pudo obtener el ID de la venta");

                // 2. Registrar cada detalle
                foreach (var detalle in venta.Detalles)
                {
                    // Limpiamos los parámetros del comando anterior antes de setear los nuevos
                    // NOTA: En AccesoDatos ya se hace Clear en ejecutarAccion, 
                    // pero aquí usamos ejecutarLectura arriba, así que hay que limpiar.
                    datos.setearConsulta("SP_RegistrarDetalleVenta");
                    datos.setearTipoComando(CommandType.StoredProcedure);
                    datos.setearParametro("@IdVenta", idVenta);
                    datos.setearParametro("@IdArticulo", detalle.IdArticulo);
                    datos.setearParametro("@Cantidad", detalle.Cantidad);
                    datos.setearParametro("@PrecioUnitario", detalle.PrecioUnitario);
                    datos.setearParametro("@Subtotal", detalle.Subtotal);
                    
                    datos.ejecutarAccion();
                }

                datos.commitTransaccion();
            }
            catch (Exception ex)
            {
                datos.rollbackTransaccion();
                throw new Exception("Venta cancelada: " + ex.Message, ex);
            }
            finally
            {
                datos.cerrarConexion();
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
