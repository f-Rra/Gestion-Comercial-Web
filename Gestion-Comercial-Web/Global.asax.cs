using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;

namespace Gestion_Comercial_Web
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Código que se ejecuta al iniciar la aplicación
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
        }

        void Session_Start(object sender, EventArgs e)
        {
            // Configurar timeout de sesión
            Session.Timeout = 60; // 60 minutos
        }

        void Session_End(object sender, EventArgs e)
        {
            // Limpieza cuando finaliza la sesión
            // (Solo funciona con InProc session state)
        }

        void Application_Error(object sender, EventArgs e)
        {
            // Capturar el último error ocurrido
            Exception exc = Server.GetLastError();

            if (exc != null)
            {
                // Guardar el mensaje en sesión para mostrarlo en Error.aspx
                // Usamos Session de forma segura
                if (HttpContext.Current.Session != null)
                {
                    Session["error"] = exc.ToString();
                }

                // Limpiar el error para que no siga propagándose y muestre la pantalla amarilla
                Server.ClearError();

                // Redirigir a la página de error
                Response.Redirect("~/Error.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
            }
        }
    }
}