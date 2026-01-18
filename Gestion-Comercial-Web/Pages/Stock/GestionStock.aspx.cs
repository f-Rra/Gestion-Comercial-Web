#pragma warning disable IDE1006 // Naming Styles
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio;
using Negocio;

namespace Gestion_Comercial_Web.Pages.Stock
{
    public partial class GestionStock : System.Web.UI.Page
    {
        #region Propiedades
        public List<Articulo> ListaArticulos { get; set; }

        private int ArticuloSeleccionadoId
        {
            get { return ViewState["ArticuloSeleccionadoId"] != null ? (int)ViewState["ArticuloSeleccionadoId"] : 0; }
            set { ViewState["ArticuloSeleccionadoId"] = value; }
        }
        #endregion

        #region Page Events
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ((SiteMaster)this.Master).PageTitle = "Gestión de Stock";
                ((SiteMaster)this.Master).PageSubtitle = "Gestione el inventario y movimientos de stock";

                CargarArticulos();
                LimpiarPanel();
            }
        }
        #endregion

        #region Carga de Datos
        private void CargarArticulos()
        {
            try
            {
                ArticuloNegocio negocio = new ArticuloNegocio();
                ListaArticulos = negocio.listar();
                Session["ListaStock"] = ListaArticulos;
                gvStock.DataSource = ListaArticulos;
                gvStock.DataBind();
            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());
                Response.Redirect("~/Error.aspx", false);
            }
        }

        protected void gvStock_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvStock.PageIndex = e.NewPageIndex;

            // Mantener filtro actual si existe
            if (Session["ListaStockFiltrada"] != null)
            {
                gvStock.DataSource = (List<Articulo>)Session["ListaStockFiltrada"];
            }
            else
            {
                gvStock.DataSource = (List<Articulo>)Session["ListaStock"];
            }

            gvStock.DataBind();
        }

        protected void gvStock_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onclick"] = string.Format("onRowClick(this, {0})", e.Row.RowIndex);
                e.Row.Style["cursor"] = "pointer";
            }
        }
        #endregion

        #region Filtros
        protected void btnStockBajo_Click(object sender, EventArgs e)
        {
            try
            {
                if (Session["ListaStock"] == null)
                {
                    CargarArticulos();
                }

                List<Articulo> listaOriginal = (List<Articulo>)Session["ListaStock"];
                List<Articulo> listaFiltrada = listaOriginal.Where(x => x.Stock > 0 && x.Stock <= 5).ToList();

                Session["ListaStockFiltrada"] = listaFiltrada;
                gvStock.PageIndex = 0;
                gvStock.DataSource = listaFiltrada;
                gvStock.DataBind();

                if (listaFiltrada.Count == 0)
                {
                    string script = "showNotification('Información', 'No hay artículos con stock bajo.', false);";
                    ClientScript.RegisterStartupScript(this.GetType(), "InfoStockBajo", script, true);
                }
            }
            catch (Exception ex)
            {
                string msg = ex.Message.Replace("'", "").Replace("\n", " ");
                string errorScript = "showNotification('Error', '" + msg + "', true);";
                ClientScript.RegisterStartupScript(this.GetType(), "ErrorFiltro", errorScript, true);
            }
        }

        protected void btnSinStock_Click(object sender, EventArgs e)
        {
            try
            {
                if (Session["ListaStock"] == null)
                {
                    CargarArticulos();
                }

                List<Articulo> listaOriginal = (List<Articulo>)Session["ListaStock"];
                List<Articulo> listaFiltrada = listaOriginal.Where(x => x.Stock == 0).ToList();

                Session["ListaStockFiltrada"] = listaFiltrada;
                gvStock.PageIndex = 0;
                gvStock.DataSource = listaFiltrada;
                gvStock.DataBind();

                if (listaFiltrada.Count == 0)
                {
                    string script = "showNotification('Información', 'No hay artículos sin stock.', false);";
                    ClientScript.RegisterStartupScript(this.GetType(), "InfoSinStock", script, true);
                }
            }
            catch (Exception ex)
            {
                string msg = ex.Message.Replace("'", "").Replace("\n", " ");
                string errorScript = "showNotification('Error', '" + msg + "', true);";
                ClientScript.RegisterStartupScript(this.GetType(), "ErrorFiltro", errorScript, true);
            }
        }

        protected void btnMostrarTodo_Click(object sender, EventArgs e)
        {
            Session["ListaStockFiltrada"] = null;
            gvStock.PageIndex = 0;
            CargarArticulos();
        }
        #endregion

        #region Selección de Artículo
        protected void btnSeleccionar_Click(object sender, EventArgs e)
        {
            string indiceStr = hfSelectedIndex.Value;

            if (!string.IsNullOrEmpty(indiceStr))
            {
                int indice = int.Parse(indiceStr);

                if (indice >= 0 && indice < gvStock.DataKeys.Count)
                {
                    int idArticulo = Convert.ToInt32(gvStock.DataKeys[indice].Value);
                    CargarArticuloSeleccionado(idArticulo);
                }
            }
            else
            {
                string script = "showNotification('Atención', 'Seleccione un artículo de la lista.', true);";
                ClientScript.RegisterStartupScript(this.GetType(), "WarnSelect", script, true);
            }
        }

        private void CargarArticuloSeleccionado(int idArticulo)
        {
            try
            {
                List<Articulo> lista = Session["ListaStock"] != null
                    ? (List<Articulo>)Session["ListaStock"]
                    : new ArticuloNegocio().listar();

                Articulo seleccionado = lista.Find(x => x.Id == idArticulo);

                if (seleccionado != null)
                {
                    ArticuloSeleccionadoId = seleccionado.Id;
                    txtArticuloSeleccionado.Text = seleccionado.Nombre;
                    txtStockActual.Text = seleccionado.Stock.ToString();
                    txtArticuloSeleccionado.ReadOnly = true;
                    txtStockActual.ReadOnly = true;

                    // Habilitar controles
                    ddlOperacion.Enabled = true;
                    txtCantidad.Enabled = true;
                    btnEjecutar.Enabled = true;
                }
            }
            catch (Exception ex)
            {
                string msg = ex.Message.Replace("'", "").Replace("\n", " ");
                string errorScript = "showNotification('Error', '" + msg + "', true);";
                ClientScript.RegisterStartupScript(this.GetType(), "ErrorCargar", errorScript, true);
            }
        }
        #endregion

        #region Operaciones de Stock
        protected void btnEjecutar_Click(object sender, EventArgs e)
        {
            try
            {
                // Validaciones
                if (ArticuloSeleccionadoId == 0)
                {
                    string script = "showNotification('Atención', 'Seleccione un artículo primero.', true);";
                    ClientScript.RegisterStartupScript(this.GetType(), "WarnNoArticulo", script, true);
                    return;
                }

                if (string.IsNullOrWhiteSpace(txtCantidad.Text))
                {
                    string script = "showNotification('Atención', 'Ingrese una cantidad válida.', true);";
                    ClientScript.RegisterStartupScript(this.GetType(), "WarnCantidad", script, true);
                    return;
                }

                int cantidad;
                if (!int.TryParse(txtCantidad.Text, out cantidad) || cantidad <= 0)
                {
                    string script = "showNotification('Error', 'La cantidad debe ser un número mayor a cero.', true);";
                    ClientScript.RegisterStartupScript(this.GetType(), "ErrorCantidad", script, true);
                    return;
                }

                int stockActual = int.Parse(txtStockActual.Text);
                string operacion = ddlOperacion.SelectedValue;
                ArticuloNegocio negocio = new ArticuloNegocio();
                int nuevoStock = 0;

                // Ejecutar operación
                if (operacion == "Sumar")
                {
                    nuevoStock = negocio.sumarStock(ArticuloSeleccionadoId, cantidad);
                }
                else if (operacion == "Restar")
                {
                    if (cantidad > stockActual)
                    {
                        string script = "showNotification('Error', 'No puede restar más unidades del stock disponible.', true);";
                        ClientScript.RegisterStartupScript(this.GetType(), "ErrorRestar", script, true);
                        return;
                    }
                    nuevoStock = negocio.restarStock(ArticuloSeleccionadoId, cantidad);
                }

                // Actualizar vista
                txtStockActual.Text = nuevoStock.ToString();
                CargarArticulos();

                string successScript = string.Format(
                    "showNotification('¡Hecho!', 'Stock actualizado correctamente. Nuevo stock: {0}', false);",
                    nuevoStock
                );
                ClientScript.RegisterStartupScript(this.GetType(), "SuccessStock", successScript, true);

                txtCantidad.Text = "";
            }
            catch (Exception ex)
            {
                string msg = ex.Message.Replace("'", "").Replace("\n", " ");
                string errorScript = "showNotification('Error', '" + msg + "', true);";
                ClientScript.RegisterStartupScript(this.GetType(), "ErrorEjecutar", errorScript, true);
            }
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            LimpiarPanel();
            hfSelectedIndex.Value = "";
        }

        private void LimpiarPanel()
        {
            ArticuloSeleccionadoId = 0;
            txtArticuloSeleccionado.Text = "";
            txtStockActual.Text = "";
            txtCantidad.Text = "";
            ddlOperacion.SelectedIndex = 0;

            txtArticuloSeleccionado.ReadOnly = false;
            txtStockActual.ReadOnly = false;
            ddlOperacion.Enabled = false;
            txtCantidad.Enabled = false;
            btnEjecutar.Enabled = false;
        }
        #endregion
    }
}