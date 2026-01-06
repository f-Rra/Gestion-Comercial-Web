using System;
using System.Web.UI;
using Gestion_Comercial_Web.Helpers;

namespace Gestion_Comercial_Web
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!SessionManager.EstaLogueado)
                {
                    Response.Redirect("~/Login.aspx");
                    return;
                }

                lblUsuario.Text = SessionManager.UsuarioActual.NombreUsuario;
                menuAdmin.Visible = SessionManager.EsAdministrador;
            }
        }

        protected void btnCerrarSesion_Click(object sender, EventArgs e)
        {
            SessionManager.CerrarSesion();
            Response.Redirect("~/Login.aspx");
        }
    }
}