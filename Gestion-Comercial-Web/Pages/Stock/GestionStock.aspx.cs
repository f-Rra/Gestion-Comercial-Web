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
            Helpers.SessionManager.ValidarAdministrador();
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
                ((SiteMaster)this.Master).MostrarNotificacion("Error", "No se pudieron cargar los artículos: " + ex.Message, true);
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
                    ((SiteMaster)this.Master).MostrarNotificacion("Información", "No hay artículos con stock bajo.", false);
                }
            }
            catch (Exception ex)
            {
                ((SiteMaster)this.Master).MostrarNotificacion("Error", "Error al filtrar: " + ex.Message, true);
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
                    ((SiteMaster)this.Master).MostrarNotificacion("Información", "No hay artículos sin stock.", false);
                }
            }
            catch (Exception ex)
            {
                ((SiteMaster)this.Master).MostrarNotificacion("Error", "Error al filtrar: " + ex.Message, true);
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
                int indice = Convert.ToInt32(indiceStr);

                if (indice >= 0 && indice < gvStock.DataKeys.Count)
                {
                    int idArticulo = Convert.ToInt32(gvStock.DataKeys[indice].Value);
                    CargarArticuloSeleccionado(idArticulo);
                }
            }
            else
            {
                ((SiteMaster)this.Master).MostrarNotificacion("Atención", "Seleccione un artículo de la lista.", true);
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
                ((SiteMaster)this.Master).MostrarNotificacion("Error", "Error al cargar datos del artículo: " + ex.Message, true);
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
                    ((SiteMaster)this.Master).MostrarNotificacion("Atención", "Seleccione un artículo primero.", true);
                    return;
                }

                if (string.IsNullOrWhiteSpace(txtCantidad.Text))
                {
                    ((SiteMaster)this.Master).MostrarNotificacion("Atención", "Ingrese una cantidad válida.", true);
                    return;
                }

                int cantidad;
                if (!int.TryParse(txtCantidad.Text, out cantidad) || cantidad <= 0)
                {
                    ((SiteMaster)this.Master).MostrarNotificacion("Error", "La cantidad debe ser un número mayor a cero.", true);
                    return;
                }

                int stockActual = Convert.ToInt32(txtStockActual.Text);
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
                        ((SiteMaster)this.Master).MostrarNotificacion("Error", "No puede restar más unidades del stock disponible.", true);
                        return;
                    }
                    nuevoStock = negocio.restarStock(ArticuloSeleccionadoId, cantidad);
                }

                // Actualizar vista
                txtStockActual.Text = nuevoStock.ToString();
                CargarArticulos();

                ((SiteMaster)this.Master).MostrarNotificacion("¡Hecho!", string.Format("Stock actualizado correctamente. Nuevo stock: {0}", nuevoStock), false);

                txtCantidad.Text = "";
            }
            catch (Exception ex)
            {
                ((SiteMaster)this.Master).MostrarNotificacion("Error", "No se pudo ejecutar la operación: " + ex.Message, true);
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