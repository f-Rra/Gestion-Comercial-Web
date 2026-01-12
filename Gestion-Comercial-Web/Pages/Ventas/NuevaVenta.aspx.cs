#pragma warning disable IDE1006 // Naming Styles
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio;
using Negocio;

namespace Gestion_Comercial_Web.Pages.Ventas
{
    public partial class NuevaVenta : System.Web.UI.Page
    {
        public List<Articulo> ListaArticulos { get; set; }
        
        public List<DetalleVenta> Carrito 
        { 
            get 
            {
                if (Session["Carrito"] == null)
                {
                    Session["Carrito"] = new List<DetalleVenta>();
                }
                return (List<DetalleVenta>)Session["Carrito"];
            }
            set 
            {
                Session["Carrito"] = value;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarArticulos();
                ActualizarCarrito();
            }
        }

        private void CargarArticulos()
        {
            try
            {
                ArticuloNegocio negocio = new ArticuloNegocio();
                // Solo cargamos los artículos que tienen stock disponible para la venta
                ListaArticulos = negocio.listar().Where(x => x.Stock > 0).ToList();
                Session["ListaArticulos"] = ListaArticulos;
                gvArticulos.DataSource = ListaArticulos;
                gvArticulos.DataBind();
            }
            catch (Exception ex)
            {
                Session.Add("error", ex.ToString());
                Response.Redirect("~/Error.aspx", false);
            }
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            FiltrarArticulos();
        }

        private void FiltrarArticulos()
        {
            string filtro = txtBuscar.Text.Trim().ToLower();
            if (Session["ListaArticulos"] != null)
            {
                List<Articulo> listaOriginal = (List<Articulo>)Session["ListaArticulos"];
                List<Articulo> listaFiltrada = listaOriginal.Where(x => 
                    x.Nombre.ToLower().Contains(filtro) || 
                    x.Codigo.ToLower().Contains(filtro) ||
                    x.Marca.Descripcion.ToLower().Contains(filtro) ||
                    x.Categoria.Descripcion.ToLower().Contains(filtro)
                ).ToList();
                
                gvArticulos.DataSource = listaFiltrada;
                gvArticulos.DataBind();
            }
        }

        protected void btnMostrarTodos_Click(object sender, EventArgs e)
        {
            txtBuscar.Text = "";
            CargarArticulos();
        }

        protected void gvArticulos_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvArticulos.PageIndex = e.NewPageIndex;
            FiltrarArticulos();
        }

        protected void gvArticulos_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onclick"] = string.Format("onRowClick(this, {0})", e.Row.RowIndex);
            }
        }

        protected void btnAgregarSeleccion_Click(object sender, EventArgs e)
        {
            string indicesStr = hfSelectedIndices.Value;
            if (!string.IsNullOrEmpty(indicesStr))
            {
                string[] indices = indicesStr.Split(',');
                foreach (string index in indices)
                {
                    int idx = int.Parse(index);
                    if (idx >= 0 && idx < gvArticulos.DataKeys.Count)
                    {
                        int idArticulo = Convert.ToInt32(gvArticulos.DataKeys[idx].Value);
                        AgregarAlCarrito(idArticulo);
                    }
                }
                hfSelectedIndices.Value = ""; // Limpiar seleccion
                ActualizarCarrito();
            }
        }

        private void AgregarAlCarrito(int idArticulo)
        {
            List<Articulo> lista = (List<Articulo>)Session["ListaArticulos"];
            Articulo seleccionado = lista.Find(x => x.Id == idArticulo);

            if (seleccionado != null)
            {
                var cart = Carrito;
                var itemExistente = cart.Find(x => x.IdArticulo == idArticulo);

                if (itemExistente != null)
                {
                    if (itemExistente.Cantidad + 1 > seleccionado.Stock)
                    {
                        string script = "showNotification('Stock Insuficiente', 'No puedes agregar más unidades de " + seleccionado.Nombre + ".', true);";
                        ClientScript.RegisterStartupScript(this.GetType(), "WarnStock", script, true);
                        return;
                    }
                    itemExistente.Cantidad++;
                    itemExistente.CalcularSubtotal();
                }
                else
                {
                    DetalleVenta nuevo = new DetalleVenta();
                    nuevo.IdArticulo = seleccionado.Id;
                    nuevo.NombreArticulo = seleccionado.Nombre;
                    nuevo.PrecioUnitario = seleccionado.Precio;
                    nuevo.Cantidad = 1;
                    nuevo.StockDisponible = seleccionado.Stock;
                    nuevo.CalcularSubtotal();
                    cart.Add(nuevo);
                }
                Carrito = cart;
            }
        }

        private void ActualizarCarrito()
        {
            gvCarrito.DataSource = Carrito;
            gvCarrito.DataBind();
            
            decimal total = Carrito.Sum(x => x.Subtotal);
            lblTotal.Text = total.ToString("C", System.Globalization.CultureInfo.CreateSpecificCulture("es-AR"));
        }

        public void gvCarrito_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvCarrito.PageIndex = e.NewPageIndex;
            ActualizarCarrito();
        }

        protected void gvCarrito_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Quitar")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                var cart = Carrito;
                if (index >= 0 && index < cart.Count)
                {
                    cart.RemoveAt(index);
                    Carrito = cart;
                    ActualizarCarrito();
                }
            }
        }

        protected void txtCantidadItem_TextChanged(object sender, EventArgs e)
        {
            TextBox txt = (TextBox)sender;
            GridViewRow row = (GridViewRow)txt.NamingContainer;
            int idArticulo = Convert.ToInt32(gvCarrito.DataKeys[row.RowIndex].Value);
            
            int cantidad;
            if(int.TryParse(txt.Text, out cantidad) && cantidad > 0)
            {
                var cart = Carrito;
                var item = cart.Find(x => x.IdArticulo == idArticulo);
                if (item != null)
                {
                    if (cantidad > item.StockDisponible)
                    {
                        string script = "showNotification('Stock Insuficiente', 'La cantidad ingresada supera el stock disponible (" + item.StockDisponible + ").', true);";
                        ClientScript.RegisterStartupScript(this.GetType(), "WarnQty", script, true);
                        txt.Text = item.Cantidad.ToString(); 
                        return;
                    }

                    item.Cantidad = cantidad;
                    item.CalcularSubtotal();
                    Carrito = cart;
                    ActualizarCarrito();
                }
            }
            else
            {
                ActualizarCarrito(); 
            }
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Session["Carrito"] = null;
            ActualizarCarrito();
        }

        protected void btnFinalizarVenta_Click(object sender, EventArgs e)
        {
            try
            {
                if (Carrito.Count == 0)
                {
                    string script = "showNotification('Atención', 'El carrito está vacío', true);";
                    ClientScript.RegisterStartupScript(this.GetType(), "WarnCart", script, true);
                    return;
                }

                Venta nuevaVenta = new Venta();
                nuevaVenta.NumeroVenta = nuevaVenta.GenerarNumeroVenta();
                nuevaVenta.Fecha = DateTime.Now;
                nuevaVenta.Vendedor = "Admin"; 
                nuevaVenta.Cliente = "Consumidor Final";
                nuevaVenta.Detalles = Carrito;
                nuevaVenta.CalcularTotal();

                VentaNegocio negocio = new VentaNegocio();
                negocio.registrarVenta(nuevaVenta);

                Session["Carrito"] = null;
                CargarArticulos();
                ActualizarCarrito();

                string successScript = "showNotification('¡Venta Exitosa!', 'La venta se ha registrado correctamente y el stock fue actualizado.', false);";
                ClientScript.RegisterStartupScript(this.GetType(), "SuccessSale", successScript, true);
            }
            catch (Exception ex)
            {
                string errorScript = "showNotification('Error', 'No se pudo completar la operación. Revisa el stock.', true);";
                ClientScript.RegisterStartupScript(this.GetType(), "ErrorSale", errorScript, true);
            }
        }
    }
}