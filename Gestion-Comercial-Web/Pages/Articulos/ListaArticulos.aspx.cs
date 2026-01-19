#pragma warning disable IDE1006
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Negocio;
using Dominio;

namespace Gestion_Comercial_Web.Pages.Articulos
{
    public partial class ListaArticulos : System.Web.UI.Page
    {
        #region Atributos
        private readonly ArticuloNegocio negocio = new ArticuloNegocio();
        #endregion

        #region Eventos
        protected void Page_Load(object sender, EventArgs e)
        {
            Helpers.SessionManager.ValidarAdministrador();
            if (!IsPostBack)
            {
                ((SiteMaster)this.Master).PageTitle = "Gestión de Artículos";
                ((SiteMaster)this.Master).PageSubtitle = "Administre el inventario de productos del sistema";
                CargarArticulos();
            }
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            Filtrar();
        }

        protected void txtFiltro_TextChanged(object sender, EventArgs e)
        {
            Filtrar();
        }

        protected void gvArticulos_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvArticulos.PageIndex = e.NewPageIndex;

            if (!string.IsNullOrEmpty(txtFiltro.Text))
                Filtrar();
            else
                CargarArticulos();
        }

        protected void gvArticulos_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                int id = Convert.ToInt32(gvArticulos.SelectedDataKey.Value);
                Articulo seleccionado = negocio.buscarPorId(id);
                if (seleccionado != null)
                {
                    imgArticulo.ImageUrl = !string.IsNullOrEmpty(seleccionado.UrlImagen) ? seleccionado.UrlImagen : "~/Content/Images/not-available.png";
                }

                foreach (GridViewRow row in gvArticulos.Rows)
                {
                    if (row.RowIndex == gvArticulos.SelectedIndex)
                        row.CssClass = "selectable-row selected-row";
                    else
                        row.CssClass = "selectable-row";
                }
            }
            catch (Exception ex)
            {
                ((SiteMaster)this.Master).MostrarNotificacion("Error", "Error al intentar seleccionar el artículo: " + ex.Message, true);
            }
        }

        protected void gvArticulos_RowDataBound_Fix(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onclick"] = string.Format("onRowClick('{0}', this, {1})", gvArticulos.UniqueID, e.Row.RowIndex);
                
                if (gvArticulos.SelectedIndex == e.Row.RowIndex)
                {
                    e.Row.CssClass += " selected-row";
                }
            }
        }

        protected void btnDetalles_Click(object sender, EventArgs e)
        {
            if (gvArticulos.SelectedDataKey != null)
            {
                string id = gvArticulos.SelectedDataKey.Value.ToString();
                Response.Redirect("DetallesArticulos.aspx?id=" + id + "&modo=view", false);
                Context.ApplicationInstance.CompleteRequest();
            }
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            Response.Redirect("DetallesArticulos.aspx?modo=add", false);
            Context.ApplicationInstance.CompleteRequest();
        }

        protected void btnEditar_Click(object sender, EventArgs e)
        {
            if (gvArticulos.SelectedDataKey != null)
            {
                string id = gvArticulos.SelectedDataKey.Value.ToString();
                Response.Redirect("DetallesArticulos.aspx?id=" + id + "&modo=edit", false);
                Context.ApplicationInstance.CompleteRequest();
            }
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            try
            {
                if (gvArticulos.SelectedDataKey != null)
                {
                    int id = Convert.ToInt32(gvArticulos.SelectedDataKey.Value);
                    negocio.bajaLogica(id);
                    CargarArticulos();
                    ((SiteMaster)this.Master).MostrarNotificacion("¡Eliminado!", "El artículo ha sido dado de baja correctamente.", false);
                }
            }
            catch (Exception ex)
            {
                ((SiteMaster)this.Master).MostrarNotificacion("Error", "No se pudo eliminar el artículo: " + ex.Message, true);
            }
        }
        #endregion

        #region Métodos Auxiliares
        private void CargarArticulos()
        {
            try
            {
                gvArticulos.DataSource = negocio.listar();
                gvArticulos.DataBind();
            }
            catch (Exception ex)
            {
                ((SiteMaster)this.Master).MostrarNotificacion("Error", "Error al cargar los artículos: " + ex.Message, true);
            }
        }

        private void Filtrar()
        {
            try
            {
                string campo = ddlCampo.SelectedValue;
                string criterio = ddlCriterio.SelectedValue;
                string filtro = txtFiltro.Text.Trim();

                gvArticulos.DataSource = negocio.filtrar(campo, criterio, filtro);
                gvArticulos.SelectedIndex = -1;
                gvArticulos.DataBind();
                imgArticulo.ImageUrl = "~/Content/Images/not-available.png";
            }
            catch (Exception ex)
            {
                ((SiteMaster)this.Master).MostrarNotificacion("Error", "Error al aplicar el filtro: " + ex.Message, true);
            }
        }
        #endregion
    }
}
