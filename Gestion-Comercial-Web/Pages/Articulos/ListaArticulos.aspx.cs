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
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarArticulos();
            }
        }

        private void CargarArticulos()
        {
            try
            {
                ArticuloNegocio negocio = new ArticuloNegocio();
                Session.Add("listaArticulos", negocio.listar());
                gvArticulos.DataSource = Session["listaArticulos"];
                gvArticulos.DataBind();
            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());
                Response.Redirect("~/Error.aspx", false);
            }
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            try
            {
                List<Articulo> lista = (List<Articulo>)Session["listaArticulos"];
                List<Articulo> listaFiltrada = new List<Articulo>();
                string filtro = txtFiltro.Text;
                string campo = ddlCampo.SelectedValue;
                string criterio = ddlCriterio.SelectedValue;

                if (campo == "Nombre")
                {
                    if (criterio == "Comienza")
                        listaFiltrada = lista.FindAll(x => x.Nombre.ToUpper().StartsWith(filtro.ToUpper()));
                    else if (criterio == "Termina")
                        listaFiltrada = lista.FindAll(x => x.Nombre.ToUpper().EndsWith(filtro.ToUpper()));
                    else
                        listaFiltrada = lista.FindAll(x => x.Nombre.ToUpper().Contains(filtro.ToUpper()));
                }
                else if (campo == "Codigo")
                {
                    // Similar logic for other fields...
                    listaFiltrada = lista.FindAll(x => x.Codigo.ToUpper().Contains(filtro.ToUpper()));
                }
                
                // Simplificado para el ejemplo, filtrar según lógica completa si es necesario
                // Por ahora recargamos si está vacío
                if (string.IsNullOrEmpty(filtro))
                {
                    listaFiltrada = lista;
                }

                gvArticulos.DataSource = listaFiltrada;
                gvArticulos.DataBind();
            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());
                Response.Redirect("~/Error.aspx", false);
            }
        }

        protected void gvArticulos_SelectedIndexChanged(object sender, EventArgs e)
        {
            string id = gvArticulos.SelectedDataKey.Value.ToString();
            // Lógica para cargar detalles en la derecha o imagen
            // Simulado:
            // imgArticulo.ImageUrl = ...
        }

        protected void btnDetalles_Click(object sender, EventArgs e)
        {
            if (gvArticulos.SelectedValue != null)
            {
                string id = gvArticulos.SelectedDataKey.Value.ToString();
                Response.Redirect("DetallesArticulo.aspx?id=" + id, false);
            }
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            Response.Redirect("DetallesArticulo.aspx", false);
        }

        protected void btnEditar_Click(object sender, EventArgs e)
        {
             if (gvArticulos.SelectedValue != null)
            {
                string id = gvArticulos.SelectedDataKey.Value.ToString();
                Response.Redirect("DetallesArticulo.aspx?id=" + id, false);
            }
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            // Lógica eliminar
        }
    }
}
