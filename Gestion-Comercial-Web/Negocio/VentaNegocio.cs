using System;
using System.Data;
using System.Collections.Generic;
using Dominio;

namespace Negocio
{
    public class VentaNegocio
    {
        #region Ventas
        public void registrarVenta(Venta venta)
        {
            using (AccesoDatos datos = new AccesoDatos())
            {
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
                    if (datos.Lector.Read())
                    {
                        idVenta = Convert.ToInt32(datos.Lector[0]);
                    }

                    datos.Lector.Close();

                    if (idVenta == 0)
                        throw new Exception("No se pudo obtener el ID de la venta");

                    // 2. Registrar cada detalle
                    foreach (var detalle in venta.Detalles)
                    {
                        datos.limpiarParametros();
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
            }
        }

        public DataTable obtenerVentasPorVendedor(string vendedor)
        {
            using (AccesoDatos datos = new AccesoDatos())
            {
                DataTable tabla = new DataTable();
                datos.setearConsulta("SP_ObtenerVentasPorVendedor");
                datos.setearTipoComando(CommandType.StoredProcedure);
                datos.setearParametro("@Vendedor", vendedor);
                datos.ejecutarLectura();
                tabla.Load(datos.Lector);
                return tabla;
            }
        }
        #endregion

        #region Carrito y Stock
        public DataTable buscarArticulosParaVenta(string filtro = "")
        {
            using (AccesoDatos datos = new AccesoDatos())
            {
                DataTable tabla = new DataTable();
                datos.setearConsulta("SP_BuscarArticulosParaVenta");
                datos.setearTipoComando(CommandType.StoredProcedure);
                datos.setearParametro("@Filtro", filtro ?? "");
                datos.ejecutarLectura();
                tabla.Load(datos.Lector);
                return tabla;
            }
        }

        public bool validarStockDisponible(int idArticulo, int cantidadSolicitada)
        {
            using (AccesoDatos datos = new AccesoDatos())
            {
                datos.setearConsulta("SP_ValidarStockDisponible");
                datos.setearTipoComando(CommandType.StoredProcedure);
                datos.setearParametro("@IdArticulo", idArticulo);
                datos.setearParametro("@CantidadSolicitada", cantidadSolicitada);
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    return Convert.ToBoolean(datos.Lector["StockSuficiente"]);
                }
                return false;
            }
        }
        #endregion

        #region Detalles
        public DataTable obtenerDetallesVenta(int idVenta)
        {
            using (AccesoDatos datos = new AccesoDatos())
            {
                DataTable tabla = new DataTable();
                datos.setearConsulta("SP_ObtenerDetallesVenta");
                datos.setearTipoComando(CommandType.StoredProcedure);
                datos.setearParametro("@IdVenta", idVenta);
                datos.ejecutarLectura();
                tabla.Load(datos.Lector);
                return tabla;
            }
        }
        #endregion
    }
}
