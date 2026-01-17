using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Negocio;
using Dominio;

namespace Gestion_Comercial_Web.Pages.Admin
{
    public partial class Catalogos : System.Web.UI.Page
    {
        #region Atributos
        private readonly CategoriaNegocio categoriaNegocio = new CategoriaNegocio();
        private readonly MarcaNegocio marcaNegocio = new MarcaNegocio();
        #endregion

        #region Eventos de Página
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ((SiteMaster)this.Master).PageTitle = "Gestión de Catálogos";
                ((SiteMaster)this.Master).PageSubtitle = "Administre las Categorías y Marcas del sistema en un solo lugar";
                CargarCategorias();
                CargarMarcas();
            }
        }
        #endregion

        #region Métodos de Carga
        private void CargarCategorias()
        {
            try
            {
                List<Categoria> lista = categoriaNegocio.listar();
                gvCategorias.DataSource = lista;
                gvCategorias.DataBind();
            }
            catch (Exception ex)
            {
                MostrarNotificacion("Error", "No se pudieron cargar las categorías: " + ex.Message, true);
            }
        }

        private void CargarMarcas()
        {
            try
            {
                List<Marca> lista = marcaNegocio.listar();
                gvMarcas.DataSource = lista;
                gvMarcas.DataBind();
            }
            catch (Exception ex)
            {
                MostrarNotificacion("Error", "No se pudieron cargar las marcas: " + ex.Message, true);
            }
        }
        #endregion

        #region Categorías - Handlers
        protected void txtBuscarCategoria_TextChanged(object sender, EventArgs e)
        {
            try
            {
                string filtro = txtBuscarCategoria.Text.Trim().ToLower();
                
                if (string.IsNullOrEmpty(filtro))
                {
                    CargarCategorias();
                    return;
                }

                List<Categoria> lista = categoriaNegocio.listar();
                var filtrada = lista.Where(c => c.Descripcion.ToLower().Contains(filtro)).ToList();
                
                gvCategorias.DataSource = filtrada;
                gvCategorias.DataBind();
            }
            catch (Exception ex)
            {
                MostrarNotificacion("Error", "Error al buscar categoría: " + ex.Message, true);
            }
        }

        protected void gvCategorias_SelectedIndexChanged(object sender, EventArgs e)
        {
            foreach (GridViewRow row in gvCategorias.Rows)
            {
                if (row.RowIndex == gvCategorias.SelectedIndex)
                    row.CssClass = "selectable-row selected-row";
                else
                    row.CssClass = "selectable-row";
            }
        }

        protected void btnAgregarCategoria_Click(object sender, EventArgs e)
        {
            try
            {
                string nombre = txtNuevaCategoria.Text.Trim();
                
                if (string.IsNullOrWhiteSpace(nombre))
                {
                    MostrarNotificacion("Validación", "Debe ingresar un nombre para la categoría.", true);
                    return;
                }

                // Validar duplicados
                if (categoriaNegocio.buscarCategoria(nombre))
                {
                    MostrarNotificacion("Validación", "Ya existe una categoría con ese nombre.", true);
                    txtNuevaCategoria.Text = "";
                    return;
                }

                Categoria nueva = new Categoria();
                nueva.Descripcion = nombre;
                
                categoriaNegocio.agregar(nueva);
                
                txtNuevaCategoria.Text = "";
                CargarCategorias();
                
                MostrarNotificacion("¡Listo!", "La categoría se agregó correctamente.", false);
            }
            catch (Exception ex)
            {
                MostrarNotificacion("Error", "No se pudo agregar la categoría: " + ex.Message, true);
            }
        }

        protected void btnEditarCategoria_Click(object sender, EventArgs e)
        {
            try
            {
                if (gvCategorias.SelectedDataKey == null)
                {
                    MostrarNotificacion("Validación", "Debe seleccionar una categoría para editar.", true);
                    return;
                }

                int id = (int)gvCategorias.SelectedDataKey.Value;
                GridViewRow row = gvCategorias.SelectedRow;
                string descripcion = HttpUtility.HtmlDecode(row.Cells[1].Text);

                hfTipoEntidad.Value = "Categoria";
                hfIdEntidad.Value = id.ToString();
                txtNombre.Text = descripcion;
                lblModalTitle.Text = "Editar Categoría";

                ScriptManager.RegisterStartupScript(this, this.GetType(), "showModal", "showModal();", true);
            }
            catch (Exception ex)
            {
                MostrarNotificacion("Error", "Error al preparar la edición: " + ex.Message, true);
            }
        }

        protected void btnEliminarCategoria_Click(object sender, EventArgs e)
        {
            try
            {
                if (gvCategorias.SelectedDataKey == null)
                {
                    MostrarNotificacion("Validación", "Debe seleccionar una categoría para eliminar.", true);
                    return;
                }

                int id = (int)gvCategorias.SelectedDataKey.Value;
                categoriaNegocio.eliminar(id);
                
                CargarCategorias();
                MostrarNotificacion("¡Listo!", "La categoría se eliminó correctamente.", false);
            }
            catch (Exception ex)
            {
                MostrarNotificacion("Error", "No se pudo eliminar la categoría. Puede estar en uso: " + ex.Message, true);
            }
        }

        public void gvCategorias_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onclick"] = string.Format("onRowClick('{0}', this, {1})", gvCategorias.UniqueID, e.Row.RowIndex);

                if (gvCategorias.SelectedIndex == e.Row.RowIndex)
                {
                    e.Row.CssClass += " selected-row";
                }
            }
        }

        protected void gvCategorias_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvCategorias.PageIndex = e.NewPageIndex;
            CargarCategorias();
        }
        #endregion

        #region Marcas - Handlers
        protected void txtBuscarMarca_TextChanged(object sender, EventArgs e)
        {
            try
            {
                string filtro = txtBuscarMarca.Text.Trim().ToLower();
                
                if (string.IsNullOrEmpty(filtro))
                {
                    CargarMarcas();
                    return;
                }

                List<Marca> lista = marcaNegocio.listar();
                var filtrada = lista.Where(m => m.Descripcion.ToLower().Contains(filtro)).ToList();
                
                gvMarcas.DataSource = filtrada;
                gvMarcas.DataBind();
            }
            catch (Exception ex)
            {
                MostrarNotificacion("Error", "Error al buscar marca: " + ex.Message, true);
            }
        }

        protected void gvMarcas_SelectedIndexChanged(object sender, EventArgs e)
        {
            foreach (GridViewRow row in gvMarcas.Rows)
            {
                if (row.RowIndex == gvMarcas.SelectedIndex)
                    row.CssClass = "selectable-row selected-row";
                else
                    row.CssClass = "selectable-row";
            }
        }

        protected void btnAgregarMarca_Click(object sender, EventArgs e)
        {
            try
            {
                string nombre = txtNuevaMarca.Text.Trim();
                
                if (string.IsNullOrWhiteSpace(nombre))
                {
                    MostrarNotificacion("Validación", "Debe ingresar un nombre para la marca.", true);
                    return;
                }

                // Validar duplicados
                if (marcaNegocio.buscarMarca(nombre))
                {
                    MostrarNotificacion("Validación", "Ya existe una marca con ese nombre.", true);
                    txtNuevaMarca.Text = "";
                    return;
                }

                Marca nueva = new Marca();
                nueva.Descripcion = nombre;
                
                marcaNegocio.agregar(nueva);
                
                txtNuevaMarca.Text = "";
                CargarMarcas();
                
                MostrarNotificacion("¡Listo!", "La marca se agregó correctamente.", false);
            }
            catch (Exception ex)
            {
                MostrarNotificacion("Error", "No se pudo agregar la marca: " + ex.Message, true);
            }
        }

        protected void btnEditarMarca_Click(object sender, EventArgs e)
        {
            try
            {
                if (gvMarcas.SelectedDataKey == null)
                {
                    MostrarNotificacion("Validación", "Debe seleccionar una marca para editar.", true);
                    return;
                }

                int id = (int)gvMarcas.SelectedDataKey.Value;
                GridViewRow row = gvMarcas.SelectedRow;
                string descripcion = HttpUtility.HtmlDecode(row.Cells[1].Text);

                hfTipoEntidad.Value = "Marca";
                hfIdEntidad.Value = id.ToString();
                txtNombre.Text = descripcion;
                lblModalTitle.Text = "Editar Marca";

                ScriptManager.RegisterStartupScript(this, this.GetType(), "showModal", "showModal();", true);
            }
            catch (Exception ex)
            {
                MostrarNotificacion("Error", "Error al preparar la edición: " + ex.Message, true);
            }
        }

        protected void btnEliminarMarca_Click(object sender, EventArgs e)
        {
            try
            {
                if (gvMarcas.SelectedDataKey == null)
                {
                    MostrarNotificacion("Validación", "Debe seleccionar una marca para eliminar.", true);
                    return;
                }

                int id = (int)gvMarcas.SelectedDataKey.Value;
                marcaNegocio.eliminar(id);
                
                CargarMarcas();
                MostrarNotificacion("¡Listo!", "La marca se eliminó correctamente.", false);
            }
            catch (Exception ex)
            {
                MostrarNotificacion("Error", "No se pudo eliminar la marca. Puede estar en uso: " + ex.Message, true);
            }
        }

        public void gvMarcas_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onclick"] = string.Format("onRowClick('{0}', this, {1})", gvMarcas.UniqueID, e.Row.RowIndex);

                if (gvMarcas.SelectedIndex == e.Row.RowIndex)
                {
                    e.Row.CssClass += " selected-row";
                }
            }
        }

        protected void gvMarcas_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvMarcas.PageIndex = e.NewPageIndex;
            CargarMarcas();
        }
        #endregion

        #region Modal Compartido
        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                string tipo = hfTipoEntidad.Value;
                int id = int.Parse(hfIdEntidad.Value);
                string nuevoNombre = txtNombre.Text.Trim();

                if (string.IsNullOrWhiteSpace(nuevoNombre))
                {
                    MostrarNotificacion("Validación", "El nombre no puede estar vacío.", true);
                    return;
                }

                if (tipo == "Categoria")
                {
                    Categoria cat = new Categoria();
                    cat.Id = id;
                    cat.Descripcion = nuevoNombre;
                    
                    categoriaNegocio.modificar(cat);
                    CargarCategorias();
                    MostrarNotificacion("¡Listo!", "La categoría se actualizó correctamente.", false);
                }
                else if (tipo == "Marca")
                {
                    Marca marca = new Marca();
                    marca.Id = id;
                    marca.Descripcion = nuevoNombre;
                    
                    marcaNegocio.modificar(marca);
                    CargarMarcas();
                    MostrarNotificacion("¡Listo!", "La marca se actualizó correctamente.", false);
                }

                // Limpiar y cerrar modal
                txtNombre.Text = "";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "closeModal", 
                    "$('#modalABM').modal('hide');", true);
            }
            catch (Exception ex)
            {
                MostrarNotificacion("Error", "No se pudo guardar: " + ex.Message, true);
            }
        }
        #endregion

        #region Métodos Auxiliares
        private void MostrarNotificacion(string titulo, string mensaje, bool esError)
        {
            mensaje = mensaje.Replace("'", "\\'").Replace("\n", " ");
            string script = $"showNotification('{titulo}', '{mensaje}', {esError.ToString().ToLower()});";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "NotifCatalogo", script, true);
        }
        #endregion
    }
}
