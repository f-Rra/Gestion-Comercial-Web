using Gestion_Comercial_Web.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Gestion_Comercial_Web
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Validar que haya sesión activa
            SessionManager.ValidarSesion();

            if (!IsPostBack)
            {
                // Si es vendedor, redirigir directamente a Ventas
                // TEMPORALMENTE COMENTADO: La página NuevaVenta.aspx no existe aún
                //if (!SessionManager.EsAdministrador)
                //{
                //    Response.Redirect("~/Pages/Ventas/NuevaVenta.aspx");
                //    return;
                //}
            }
        }
    }
}
