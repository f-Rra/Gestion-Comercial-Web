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
        protected void Page_Load(object sender, EventArgs e)
        {
            // TODO: Implementar carga inicial si es necesario
        }

        private void CargarCategorias()
        {
            // TODO: Implementar lógica de carga
        }

        private void CargarMarcas()
        {
            // TODO: Implementar lógica de carga
        }

        #region Categorías Handlers

        protected void txtBuscarCategoria_TextChanged(object sender, EventArgs e)
        {
            // TODO: Implementar filtro
        }

        protected void gvCategorias_SelectedIndexChanged(object sender, EventArgs e)
        {
            // TODO: Implementar selección
        }

        protected void btnAgregarCategoria_Click(object sender, EventArgs e)
        {
            // TODO: Implementar agregar
        }

        protected void btnEditarCategoria_Click(object sender, EventArgs e)
        {
            // TODO: Implementar editar
        }

        protected void btnEliminarCategoria_Click(object sender, EventArgs e)
        {
             // TODO: Implementar eliminar
        }

        protected void gvCategorias_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            // TODO: Implementar comando
        }

        #endregion

        #region Marcas Handlers

        protected void txtBuscarMarca_TextChanged(object sender, EventArgs e)
        {
             // TODO: Implementar filtro
        }

        protected void gvMarcas_SelectedIndexChanged(object sender, EventArgs e)
        {
            // TODO: Implementar selección
        }

        protected void btnAgregarMarca_Click(object sender, EventArgs e)
        {
             // TODO: Implementar agregar
        }

        protected void btnEditarMarca_Click(object sender, EventArgs e)
        {
             // TODO: Implementar editar
        }

        protected void btnEliminarMarca_Click(object sender, EventArgs e)
        {
             // TODO: Implementar eliminar
        }

        protected void gvMarcas_RowCommand(object sender, GridViewCommandEventArgs e)
        {
             // TODO: Implementar comando
        }

        #endregion

        #region Modal Shared Handlers

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
             // TODO: Implementar guardado modal
        }

        #endregion
    }
}
