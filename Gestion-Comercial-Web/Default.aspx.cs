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
            // Validar que haya sesión activa y que sea administrador
            SessionManager.ValidarAdministrador();

            if (!IsPostBack)
            {
                ((SiteMaster)this.Master).PageTitle = "Panel de Administrador";
                ((SiteMaster)this.Master).PageSubtitle = "Gestione todos los módulos del sistema desde aquí";
            }
        }
    }
}
