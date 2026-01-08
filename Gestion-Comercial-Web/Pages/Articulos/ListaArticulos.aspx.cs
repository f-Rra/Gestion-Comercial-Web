using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Gestion_Comercial_Web.Pages.Articulos
{
    public partial class ListaArticulos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // TODO: Cargar artículos
            }
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            // TODO: Implementar búsqueda
        }

        protected void btnEditar_Click(object sender, EventArgs e)
        {
            // TODO: Implementar edición
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            // TODO: Implementar eliminación
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            // TODO: Implementar agregar
        }

        protected void btnDetalles_Click(object sender, EventArgs e)
        {
            // TODO: Implementar detalles
        }

        protected void dgvArticulos_SelectedIndexChanged(object sender, EventArgs e)
        {
            // TODO: Implementar selección de artículo
        }
    }
}