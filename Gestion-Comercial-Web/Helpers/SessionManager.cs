using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Dominio;

namespace Gestion_Comercial_Web.Helpers
{
    public static class SessionManager
    {
        private const string USER_SESSION_KEY = "UsuarioActual";

        public static Usuario UsuarioActual
        {
            get
            {
                if (HttpContext.Current.Session[USER_SESSION_KEY] != null)
                {
                    return (Usuario)HttpContext.Current.Session[USER_SESSION_KEY];
                }
                return null;
            }
            set
            {
                HttpContext.Current.Session[USER_SESSION_KEY] = value;
            }
        }

        public static bool EstaLogueado
        {
            get { return UsuarioActual != null; }
        }

        public static bool EsAdministrador
        {
            get { return UsuarioActual != null && UsuarioActual.EsAdministrador; }
        }

        public static void ValidarSesion()
        {
            if (!EstaLogueado)
            {
                HttpContext.Current.Response.Redirect("~/Login.aspx", false);
                HttpContext.Current.ApplicationInstance.CompleteRequest();
            }
        }

        public static void ValidarAdministrador()
        {
            ValidarSesion(); 

            if (!EsAdministrador)
            {
                HttpContext.Current.Response.Redirect("~/AccesoDenegado.aspx", false);
                HttpContext.Current.ApplicationInstance.CompleteRequest();
            }
        }

        public static void CerrarSesion()
        {
            if (HttpContext.Current.Session != null)
            {
                HttpContext.Current.Session.Clear();
                HttpContext.Current.Session.Abandon();
            }
        }
    }
}
