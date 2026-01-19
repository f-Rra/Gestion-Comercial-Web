using System;
using System.Collections.Generic;
using Negocio;
using Dominio;
using System.Web.UI;

namespace Gestion_Comercial_Web.Pages.Articulos
{
    public partial class DetallesArticulos : Page
    {
        #region Atributos
        private readonly ArticuloNegocio articuloNegocio = new ArticuloNegocio();
        private readonly MarcaNegocio marcaNegocio = new MarcaNegocio();
        private readonly CategoriaNegocio categoriaNegocio = new CategoriaNegocio();
        #endregion

        #region Eventos
        protected void Page_Load(object sender, EventArgs e)
        {
            Helpers.SessionManager.ValidarAdministrador();
            if (!IsPostBack)
            {
                ((SiteMaster)this.Master).PageTitle = "Detalles del Artículo";
                ((SiteMaster)this.Master).PageSubtitle = "Gestione la información técnica y comercial del artículo seleccionado";
                CargarDesplegables();
                ConfigurarModo();
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                if (!ValidarFormulario()) return;

                Articulo articulo = ObtenerDatosDeInterfaz();
                string idStr = Request.QueryString["id"];

                if (!string.IsNullOrEmpty(idStr))
                {
                    articulo.Id = Convert.ToInt32(idStr);
                    articuloNegocio.modificar(articulo);
                    ((SiteMaster)this.Master).MostrarNotificacion("¡Hecho!", "El artículo se ha modificado correctamente.", false);
                }
                else
                {
                    articuloNegocio.agregar(articulo);
                    ((SiteMaster)this.Master).MostrarNotificacion("¡Registrado!", "El nuevo artículo ha sido agregado al catálogo.", false);
                    txtIdArticulo.Text = articuloNegocio.ultimoID().ToString();
                }

                BloquearControles(true);
                btnGuardar.Visible = false;
                btnEditar.Visible = true;
            }
            catch (Exception ex)
            {
                ((SiteMaster)this.Master).MostrarNotificacion("Error", "No se pudo guardar: " + ex.Message, true);
            }
        }

        protected void btnEditar_Click(object sender, EventArgs e)
        {
            BloquearControles(false);
            btnEditar.Visible = false;
            btnGuardar.Visible = true;
            ((SiteMaster)this.Master).PageTitle = "Editando Artículo";
        }

        public void btnRegresar_Click(object sender, EventArgs e)
        {
            Response.Redirect("ListaArticulos.aspx", false);
            Context.ApplicationInstance.CompleteRequest();
        }
        #endregion

        #region Métodos Auxiliares
        private void ConfigurarModo()
        {
            string idStr = Request.QueryString["id"];
            string modo = Request.QueryString["modo"];

            if (!string.IsNullOrEmpty(idStr))
            {
                int id = Convert.ToInt32(idStr);
                CargarArticulo(id);

                if (modo == "view")
                {
                    BloquearControles(true);
                    btnGuardar.Visible = false;
                    btnEditar.Visible = true;
                    ((SiteMaster)this.Master).PageTitle = "Detalles de Artículo";
                }
                else
                {
                    BloquearControles(false);
                    btnGuardar.Visible = true;
                    btnEditar.Visible = false;
                    ((SiteMaster)this.Master).PageTitle = "Editar Artículo";
                }
            }
            else
            {
                ((SiteMaster)this.Master).PageTitle = "Nuevo Artículo";
                BloquearControles(false);
                btnGuardar.Visible = true;
                btnEditar.Visible = false;
                btnGuardar.Text = "Agregar Artículo";
                
                // Pre-cargar el ID sugerido (Ultimo + 1)
                try {
                    txtIdArticulo.Text = (articuloNegocio.ultimoID() + 1).ToString();
                } catch {
                    txtIdArticulo.Text = "1";
                }
            }
        }

        private void CargarDesplegables()
        {
            try
            {
                ddlMarca.DataSource = marcaNegocio.listar();
                ddlMarca.DataValueField = "Id";
                ddlMarca.DataTextField = "Descripcion";
                ddlMarca.DataBind();
                ddlMarca.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Seleccione Marca...", "0"));

                ddlCategoria.DataSource = categoriaNegocio.listar();
                ddlCategoria.DataValueField = "Id";
                ddlCategoria.DataTextField = "Descripcion";
                ddlCategoria.DataBind();
                ddlCategoria.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Seleccione Categoría...", "0"));
            }
            catch (Exception ex)
            {
                ((SiteMaster)this.Master).MostrarNotificacion("Error", "Error al cargar listas: " + ex.Message, true);
            }
        }

        private void CargarArticulo(int id)
        {
            try
            {
                Articulo art = articuloNegocio.buscarPorId(id);
                if (art != null)
                {
                    txtIdArticulo.Text = art.Id.ToString();
                    txtCodigo.Text = art.Codigo;
                    txtNombre.Text = art.Nombre;
                    txtDescripcion.Text = art.Descripcion;
                    txtPrecio.Text = art.Precio.ToString("F2");
                    txtStock.Text = art.Stock.ToString();
                    txtUrlImagen.Text = art.UrlImagen;
                    
                    if (art.Marca != null)
                        ddlMarca.SelectedValue = art.Marca.Id.ToString();
                    
                    if (art.Categoria != null)
                        ddlCategoria.SelectedValue = art.Categoria.Id.ToString();

                    imgArticulo.ImageUrl = string.IsNullOrEmpty(art.UrlImagen) ? "~/Content/Images/not-available.png" : art.UrlImagen;
                }
            }
            catch (Exception ex)
            {
                ((SiteMaster)this.Master).MostrarNotificacion("Error", "Error al cargar el artículo: " + ex.Message, true);
            }
        }

        private void BloquearControles(bool bloqueo)
        {
            txtCodigo.ReadOnly = bloqueo;
            txtNombre.ReadOnly = bloqueo;
            txtDescripcion.ReadOnly = bloqueo;
            txtPrecio.ReadOnly = bloqueo;
            txtStock.ReadOnly = bloqueo;
            txtUrlImagen.ReadOnly = bloqueo;
            ddlMarca.Enabled = !bloqueo;
            ddlCategoria.Enabled = !bloqueo;
        }

        private bool ValidarFormulario()
        {
            if (string.IsNullOrWhiteSpace(txtNombre.Text))
            {
                ((SiteMaster)this.Master).MostrarNotificacion("Validación", "El nombre es obligatorio.", true);
                return false;
            }

            if (ddlMarca.SelectedValue == "0" || ddlCategoria.SelectedValue == "0")
            {
                ((SiteMaster)this.Master).MostrarNotificacion("Validación", "Debe seleccionar Marca y Categoría.", true);
                return false;
            }

            if (!decimal.TryParse(txtPrecio.Text, out _))
            {
                ((SiteMaster)this.Master).MostrarNotificacion("Validación", "Precio inválido.", true);
                return false;
            }

            return true;
        }

        private Articulo ObtenerDatosDeInterfaz()
        {
            Articulo aux = new Articulo();
            aux.Codigo = txtCodigo.Text;
            aux.Nombre = txtNombre.Text;
            aux.Descripcion = txtDescripcion.Text;
            aux.Precio = Convert.ToDecimal(txtPrecio.Text);
            aux.Stock = string.IsNullOrEmpty(txtStock.Text) ? 0 : Convert.ToInt32(txtStock.Text);
            aux.UrlImagen = txtUrlImagen.Text;
            
            aux.Marca = new Marca();
            aux.Marca.Id = Convert.ToInt32(ddlMarca.SelectedValue);
            
            aux.Categoria = new Categoria();
            aux.Categoria.Id = Convert.ToInt32(ddlCategoria.SelectedValue);

            return aux;
        }
        #endregion
    }
}
