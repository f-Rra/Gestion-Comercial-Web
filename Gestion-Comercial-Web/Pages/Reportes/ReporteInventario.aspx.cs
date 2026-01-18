#pragma warning disable IDE1006 // Naming Styles
using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Negocio;
using System.Data;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.IO;

namespace Gestion_Comercial_Web.Pages.Reportes
{
    public partial class ReporteInventario : Page
    {
        private readonly ReporteNegocio negocio = new ReporteNegocio();

        #region Page Events
        protected void Page_Load(object sender, EventArgs e)
        {
            Helpers.SessionManager.ValidarAdministrador();
            if (!IsPostBack)
            {
                ((SiteMaster)this.Master).PageTitle = "Reportes y Estadísticas";
                ((SiteMaster)this.Master).PageSubtitle = "Genere informes detallados del inventario y analice estadísticas";

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
                MostrarError("No se pudieron cargar los datos: " + ex.Message);
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
                MostrarError("Error: " + ex.Message);
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
                MostrarError("Error: " + ex.Message);
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
            catch (Exception ex) { MostrarError("Error: " + ex.Message); }
        }

        protected void btnInventarioCompleto_Click(object sender, EventArgs e)
        {
            try
            {
                gvReporte.DataSource = negocio.obtenerInventarioCompleto();
                gvReporte.DataBind();
                ActualizarTituloReporte("Inventario Completo");
            }
            catch (Exception ex) { MostrarError("Error: " + ex.Message); }
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
            catch (Exception ex) { MostrarError("Error: " + ex.Message); }
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
            catch (Exception ex) { MostrarError("Error: " + ex.Message); }
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
            if (gvReporte.Rows.Count == 0)
            {
                MostrarError("No hay datos para exportar.");
                return;
            }

            try
            {
                string tituloReporte = lblTituloReporte.Text;
                string nombreArchivo = "Reporte_" + tituloReporte.Replace(" ", "_") + "_" + DateTime.Now.ToString("yyyyMMdd_HHmmss") + ".pdf";

                using (MemoryStream ms = new MemoryStream())
                {
                    // Crear documento (A4, horizontal si tiene muchas columnas)
                    Document doc = new Document(PageSize.A4.Rotate(), 10f, 10f, 10f, 0f);
                    PdfWriter writer = PdfWriter.GetInstance(doc, ms);
                    doc.Open();

                    // Fuentes
                    BaseFont bf = BaseFont.CreateFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
                    Font fontTitulo = new Font(bf, 18, Font.BOLD, BaseColor.DARK_GRAY);
                    Font fontSubtitulo = new Font(bf, 12, Font.NORMAL, BaseColor.GRAY);
                    Font fontHeader = new Font(bf, 10, Font.BOLD, BaseColor.WHITE);
                    Font fontRows = new Font(bf, 9, Font.NORMAL, BaseColor.BLACK);

                    // Título
                    Paragraph pTitulo = new Paragraph(tituloReporte, fontTitulo);
                    pTitulo.Alignment = Element.ALIGN_CENTER;
                    doc.Add(pTitulo);

                    // Fecha y Usuario
                    string usuario = Helpers.SessionManager.UsuarioActual != null ? Helpers.SessionManager.UsuarioActual.NombreUsuario : "Sistema";
                    Paragraph pInfo = new Paragraph($"Generado el: {DateTime.Now:dd/MM/yyyy HH:mm} | Usuario: {usuario}", fontSubtitulo);
                    pInfo.Alignment = Element.ALIGN_CENTER;
                    pInfo.SpacingAfter = 20f;
                    doc.Add(pInfo);

                    // Crear Tabla PDF según GridView
                    int columnasCount = gvReporte.HeaderRow.Cells.Count;
                    PdfPTable pdfTable = new PdfPTable(columnasCount);
                    pdfTable.WidthPercentage = 100;

                    // Encabezados
                    foreach (TableCell headerCell in gvReporte.HeaderRow.Cells)
                    {
                        string headerText = Server.HtmlDecode(headerCell.Text).Trim();
                        PdfPCell cell = new PdfPCell(new Phrase(headerText, fontHeader));
                        cell.BackgroundColor = new BaseColor(1, 46, 64); // #012E40 (Primary Dark)
                        cell.HorizontalAlignment = Element.ALIGN_CENTER;
                        cell.VerticalAlignment = Element.ALIGN_MIDDLE;
                        cell.Padding = 5f;
                        pdfTable.AddCell(cell);
                    }

                    // Filas
                    foreach (GridViewRow gvRow in gvReporte.Rows)
                    {
                        foreach (TableCell tableCell in gvRow.Cells)
                        {
                            string cellText = Server.HtmlDecode(tableCell.Text).Trim();
                            
                            // Si el texto está vacío (por controles o templates), intentamos obtener el texto de los controles
                            if (string.IsNullOrEmpty(cellText) && tableCell.Controls.Count > 0)
                            {
                                foreach (Control c in tableCell.Controls)
                                {
                                    if (c is Label) cellText = ((Label)c).Text;
                                    else if (c is LiteralControl) cellText = ((LiteralControl)c).Text.Trim();
                                }
                            }

                            PdfPCell cell = new PdfPCell(new Phrase(cellText, fontRows));
                            cell.HorizontalAlignment = Element.ALIGN_CENTER;
                            cell.VerticalAlignment = Element.ALIGN_MIDDLE;
                            cell.Padding = 4f;
                            pdfTable.AddCell(cell);
                        }
                    }

                    doc.Add(pdfTable);
                    doc.Close();

                    byte[] bytes = ms.ToArray();
                    ms.Close();

                    // Limpiar respuesta y enviar PDF
                    Response.Clear();
                    Response.ContentType = "application/pdf";
                    Response.AddHeader("Content-Disposition", "attachment; filename=" + nombreArchivo);
                    Response.Buffer = true;
                    Response.Cache.SetCacheability(HttpCacheability.NoCache);
                    Response.BinaryWrite(bytes);
                    Response.End();
                }
            }
            catch (Exception ex)
            {
                // Si falla Response.End (que lanza ThreadAbortException), lo ignoramos si es esa excepción específica
                if (!(ex is System.Threading.ThreadAbortException))
                    MostrarError("Error al exportar PDF: " + ex.Message);
            }
        }
        #endregion

        #region Helpers
        private void ActualizarTituloReporte(string titulo)
        {
            lblTituloReporte.Text = titulo;
        }

        private void MostrarExito(string mensaje)
        {
            string msg = mensaje.Replace("'", "").Replace("\n", " ");
            string script = $"showNotification('¡Listo!', '{msg}', false);";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ExitoRepo", script, true);
        }

        private void MostrarError(string mensaje)
        {
            string msg = mensaje.Replace("'", "").Replace("\n", " ");
            string script = $"showNotification('Error', '{msg}', true);";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ErrorRepo", script, true);
        }
        #endregion
    }
}