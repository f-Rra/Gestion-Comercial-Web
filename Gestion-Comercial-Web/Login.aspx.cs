using System;
using System.Web.UI;
using System.Web.Security;
using Negocio;
using Dominio;
using Gestion_Comercial_Web.Helpers;

namespace Gestion_Comercial_Web
{
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (SessionManager.EstaLogueado)
                {
                    Response.Redirect("Default.aspx");
                }
            }
        }

        protected void btnIngresar_Click(object sender, EventArgs e)
        {
            UsuarioNegocio negocio = new UsuarioNegocio();
            Usuario usuario = null;

            try
            {
                // Validar campos vacíos
                if (string.IsNullOrWhiteSpace(txtUsuario.Text) ||
                    string.IsNullOrWhiteSpace(txtContrasena.Text))
                {
                    MostrarError("Por favor, complete todos los campos.");
                    return;
                }

                // Validar credenciales contra la BD
                usuario = negocio.validarCredenciales(
                    txtUsuario.Text.Trim(),
                    txtContrasena.Text.Trim()
                );

                if (usuario != null)
                {
                    // Verificar usuario activo
                    if (!usuario.Estado)
                    {
                        MostrarError("Usuario inactivo. Contacte al administrador.");
                        return;
                    }

                    // Guardar en sesión
                    SessionManager.UsuarioActual = usuario;

                    // Crear cookie de autenticación
                    FormsAuthentication.SetAuthCookie(usuario.NombreUsuario, false);

                    // Redirigir según rol
                    if (usuario.EsAdministrador)
                    {
                        Response.Redirect("Default.aspx", false);
                    }
                    else
                    {
                        Response.Redirect("Pages/Ventas/NuevaVenta.aspx", false);
                    }
                }
                else
                {
                    MostrarError("Usuario o contraseña incorrectos.");
                    LimpiarCampos();
                }
            }
            catch (Exception ex)
            {
                MostrarError("Error al intentar iniciar sesión.");
                System.Diagnostics.Debug.WriteLine($"Error: {ex.Message}");
            }
        }

        private void MostrarError(string mensaje)
        {
            pnlError.Visible = true;
            lblError.Text = mensaje;
        }

        private void LimpiarCampos()
        {
            txtContrasena.Text = string.Empty;
            txtUsuario.Focus();
        }
    }
}
