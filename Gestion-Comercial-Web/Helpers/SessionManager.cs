using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Dominio;

namespace Gestion_Comercial_Web.Helpers
{

    public class ItemCarrito
    {
        public Articulo Articulo { get; set; }
        public int Cantidad { get; set; }

        public decimal Subtotal
        {
            get
            {
                return Articulo != null ? Articulo.Precio * Cantidad : 0;
            }
        }
    }

    public static class SessionManager
    {
        private const string USER_SESSION_KEY = "UsuarioActual";
        private const string CART_SESSION_KEY = "Carrito";

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

        public static List<ItemCarrito> Carrito
        {
            get
            {
                if (HttpContext.Current.Session[CART_SESSION_KEY] == null)
                {
                    HttpContext.Current.Session[CART_SESSION_KEY] = new List<ItemCarrito>();
                }
                return (List<ItemCarrito>)HttpContext.Current.Session[CART_SESSION_KEY];
            }
            set
            {
                HttpContext.Current.Session[CART_SESSION_KEY] = value;
            }
        }

        public static decimal TotalCarrito
        {
            get
            {
                return Carrito.Sum(item => item.Subtotal);
            }
        }

        public static void AgregarAlCarrito(Articulo articulo, int cantidad)
        {
            if (articulo == null || cantidad <= 0)
                return;

            var carrito = Carrito;
            var itemExistente = carrito.FirstOrDefault(x => x.Articulo.Id == articulo.Id);

            if (itemExistente != null)
            {
                itemExistente.Cantidad += cantidad;
            }
            else
            {
                carrito.Add(new ItemCarrito
                {
                    Articulo = articulo,
                    Cantidad = cantidad
                });
            }

            Carrito = carrito;
        }

        public static void EliminarDelCarrito(int articuloId)
        {
            var carrito = Carrito;
            var itemAEliminar = carrito.FirstOrDefault(x => x.Articulo.Id == articuloId);

            if (itemAEliminar != null)
            {
                carrito.Remove(itemAEliminar);
                Carrito = carrito;
            }
        }

        public static void LimpiarCarrito()
        {
            Carrito = new List<ItemCarrito>();
        }
    }
}
