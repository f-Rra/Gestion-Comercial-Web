using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using Negocio;
using System.Data;

namespace Gestion_Comercial_Web.Pages.Reportes
{
    public partial class ReporteInventario : Page
    {
        private ReporteNegocio negocio = new ReporteNegocio();

        #region Page Events
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtFechaDesde.Text = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1).ToString("yyyy-MM-dd");
                txtFechaHasta.Text = DateTime.Now.ToString("yyyy-MM-dd");
                
                btnInventarioCompleto_Click(null, null);
            }
        }
        #endregion

        #region Reportes de Inventario
        protected void btnPorCategorias_Click(object sender, EventArgs e)
        {
            try
            {
                gvReporte.DataSource = negocio.obtenerInventarioPorCategoria();
                gvReporte.DataBind();
                ActualizarTituloReporte("Artículos por Categoría");
            }
            catch (Exception ex)
            {
                MostrarError(ex.Message);
            }
        }

        protected void btnPorMarcas_Click(object sender, EventArgs e)
        {
            try
            {
                gvReporte.DataSource = negocio.obtenerInventarioPorMarca();
                gvReporte.DataBind();
                ActualizarTituloReporte("Artículos por Marca");
            }
            catch (Exception ex)
            {
                MostrarError(ex.Message);
            }
        }

        protected void btnSinStock_Click(object sender, EventArgs e)
        {
            try
            {
                gvReporte.DataSource = negocio.obtenerArticulosSinStock();
                gvReporte.DataBind();
                ActualizarTituloReporte("Artículos Sin Stock");
            }
            catch (Exception ex)
            {
                MostrarError(ex.Message);
            }
        }

        protected void btnBajoStock_Click(object sender, EventArgs e)
        {
            try
            {
                gvReporte.DataSource = negocio.obtenerArticulosBajoStock(5);
                gvReporte.DataBind();
                ActualizarTituloReporte("Artículos con Bajo Stock (<= 5)");
            }
            catch (Exception ex) { MostrarError(ex.Message); }
        }

        protected void btnInventarioCompleto_Click(object sender, EventArgs e)
        {
            try
            {
                gvReporte.DataSource = negocio.obtenerInventarioCompleto();
                gvReporte.DataBind();
                ActualizarTituloReporte("Inventario Completo");
            }
            catch (Exception ex) { MostrarError(ex.Message); }
        }
        #endregion

        #region Estadísticas de Stock
        protected void btnStockPorMarcas_Click(object sender, EventArgs e)
        {
            try
            {
                gvReporte.DataSource = negocio.obtenerEstadisticasStockPorMarca();
                gvReporte.DataBind();
                ActualizarTituloReporte("Estadísticas de Stock por Marca");
            }
            catch (Exception ex) { MostrarError(ex.Message); }
        }

        protected void btnStockPorCategorias_Click(object sender, EventArgs e)
        {
            try
            {
                gvReporte.DataSource = negocio.obtenerEstadisticasStockPorCategoria();
                gvReporte.DataBind();
                ActualizarTituloReporte("Estadísticas de Stock por Categoría");
            }
            catch (Exception ex) { MostrarError(ex.Message); }
        }
        #endregion

        #region Reportes de Ventas
        protected void btnVentasDetalladas_Click(object sender, EventArgs e)
        {
            try
            {
                DateTime desde = DateTime.Parse(txtFechaDesde.Text);
                DateTime hasta = DateTime.Parse(txtFechaHasta.Text);
                gvReporte.DataSource = negocio.obtenerVentasDetalladas(desde, hasta);
                gvReporte.DataBind();
                ActualizarTituloReporte("Ventas Detalladas");
            }
            catch (Exception ex) { MostrarError(ex.Message); }
        }

        protected void btnMasVendidos_Click(object sender, EventArgs e)
        {
            try
            {
                DateTime desde = DateTime.Parse(txtFechaDesde.Text);
                DateTime hasta = DateTime.Parse(txtFechaHasta.Text);
                gvReporte.DataSource = negocio.obtenerArticulosMasVendidos(desde, hasta);
                gvReporte.DataBind();
                ActualizarTituloReporte("Productos Más Vendidos");
            }
            catch (Exception ex) { MostrarError(ex.Message); }
        }

        protected void btnTopVendedores_Click(object sender, EventArgs e)
        {
            try
            {
                DateTime desde = DateTime.Parse(txtFechaDesde.Text);
                DateTime hasta = DateTime.Parse(txtFechaHasta.Text);
                gvReporte.DataSource = negocio.obtenerTopVendedores(desde, hasta);
                gvReporte.DataBind();
                ActualizarTituloReporte("Ranking de Vendedores");
            }
            catch (Exception ex) { MostrarError(ex.Message); }
        }

        protected void btnVentasPorFecha_Click(object sender, EventArgs e)
        {
            try
            {
                DateTime desde = DateTime.Parse(txtFechaDesde.Text);
                DateTime hasta = DateTime.Parse(txtFechaHasta.Text);
                gvReporte.DataSource = negocio.obtenerVentasPorFecha(desde, hasta);
                gvReporte.DataBind();
                ActualizarTituloReporte("Historial de Ventas");
            }
            catch (Exception ex) { MostrarError(ex.Message); }
        }

        protected void btnResumenDiario_Click(object sender, EventArgs e)
        {
            try
            {
                DateTime desde = DateTime.Parse(txtFechaDesde.Text);
                DateTime hasta = DateTime.Parse(txtFechaHasta.Text);
                gvReporte.DataSource = negocio.obtenerResumenVentasDiarias(desde, hasta);
                gvReporte.DataBind();
                ActualizarTituloReporte("Resumen Diario de Ventas");
            }
            catch (Exception ex) { MostrarError(ex.Message); }
        }
        #endregion

        #region Exportar
        protected void btnExportarPDF_Click(object sender, EventArgs e)
        {
            string script = "showNotification('Funcionalidad', 'La exportación a PDF se implementará en la siguiente fase.', false);";
            ClientScript.RegisterStartupScript(this.GetType(), "ExportPDF", script, true);
        }
        #endregion

        #region Helpers
        private void ActualizarTituloReporte(string titulo)
        {
            lblTituloReporte.Text = titulo;
        }

        private void MostrarError(string mensaje)
        {
            string msg = mensaje.Replace("'", "").Replace("\n", " ");
            string script = "showNotification('Error', '" + msg + "', true);";
            ClientScript.RegisterStartupScript(this.GetType(), "ErrorRepo", script, true);
        }
        #endregion
    }
}