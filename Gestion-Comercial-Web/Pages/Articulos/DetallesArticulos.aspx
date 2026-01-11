<%@ Page Title="Detalles del Artículo" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="DetallesArticulos.aspx.cs" Inherits="Gestion_Comercial_Web.Pages.Articulos.DetallesArticulos" %>

    <asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
        <!-- Jumbotron -->
        <div class="container my-3">
            <div class="p-5 text-center bg-body-tertiary rounded-3 border shadow">
                <div class="d-inline-block">
                    <h1 style="color: var(--color-primary-dark);">Detalles del Artículo</h1>
                    <hr
                        style="border-color: var(--color-primary-dark); opacity: 0.3; margin: 0.5rem 0; filter: blur(0.5px);" />
                </div>
                <p class="lead mb-0">
                    Visualice los detalles completos del artículo seleccionado de la lista
                </p>
            </div>
        </div>

        <!-- Contenedor de Detalles del Artículo -->
        <div class="container my-4 border shadow rounded-3 p-4"
            style="background-color: var(--color-background) !important;">
            <div class="row">
                <!-- COLUMNA IZQUIERDA: Formulario -->
                <div class="col-md-8">
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="MainContent_txtIdArticulo" class="form-label"
                                style="color: var(--color-light);">ID del Artículo</label>
                            <asp:TextBox ID="txtIdArticulo" runat="server" CssClass="form-control" TextMode="Number"
                                ReadOnly="true"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label for="MainContent_txtNombre" class="form-label"
                                style="color: var(--color-light);">Nombre</label>
                            <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="MainContent_txtCodigo" class="form-label"
                                style="color: var(--color-light);">Código</label>
                            <asp:TextBox ID="txtCodigo" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label for="MainContent_txtPrecio" class="form-label"
                                style="color: var(--color-light);">Precio</label>
                            <div class="input-group">
                                <span class="input-group-text">$</span>
                                <asp:TextBox ID="txtPrecio" runat="server" CssClass="form-control" TextMode="Number"
                                    step="0.01"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="MainContent_ddlMarca" class="form-label"
                                style="color: var(--color-light);">Marca</label>
                            <asp:DropDownList ID="ddlMarca" runat="server" CssClass="form-control"></asp:DropDownList>
                        </div>
                        <div class="col-md-6">
                            <label for="MainContent_ddlCategoria" class="form-label"
                                style="color: var(--color-light);">Categoría</label>
                            <asp:DropDownList ID="ddlCategoria" runat="server" CssClass="form-control">
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-12">
                            <label for="MainContent_txtUrlImagen" class="form-label"
                                style="color: var(--color-light);">URL Imagen</label>
                            <asp:TextBox ID="txtUrlImagen" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-12">
                            <label for="MainContent_txtDescripcion" class="form-label"
                                style="color: var(--color-light);">Descripción</label>
                            <asp:TextBox ID="txtDescripcion" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <!-- COLUMNA DERECHA: Imagen y Botón -->
                <div class="col-md-4">
                    <div style="height: 32px;"></div>
                    <div class="mb-3 p-3 rounded border d-flex align-items-center justify-content-center"
                        style="background-color: var(--color-accent); height: 330px;">
                        <asp:Image ID="imgArticulo" runat="server" ImageUrl="~/Content/Images/not-available.png"
                            AlternateText="Imagen del artículo" CssClass="img-fluid rounded"
                            Style="max-height: 100%; max-width: 100%; object-fit: contain;" />
                    </div>
                    <asp:Button ID="btnVolver" runat="server" Text="Volver al Listado"
                        CssClass="btn w-100 fw-semibold text-light-custom"
                        style="background-color: var(--color-accent); border: none;" />
                </div>
            </div>
        </div>

        <!-- Footer -->
        <footer class="container-fluid">
            <div class="d-flex flex-wrap justify-content-between align-items-center py-3 border-top">
                <div class="col-md-6 d-flex align-items-center">
                    <span style="color: var(--color-primary-dark); font-weight: 500;">&copy; <%: DateTime.Now.Year %> -
                            Sistema de Gestión Comercial</span>
                </div>
                <ul class="nav col-md-4 justify-content-end list-unstyled d-flex">
                    <li class="ms-3">
                        <a href="https://github.com/f-Rra" target="_blank" aria-label="GitHub"
                            style="color: var(--color-primary-dark);">
                            <i class="fab fa-github" style="font-size: 24px;"></i>
                        </a>
                    </li>
                    <li class="ms-3">
                        <a href="https://linkedin.com/in/f-rra" target="_blank" aria-label="LinkedIn"
                            style="color: var(--color-primary-dark);">
                            <i class="fab fa-linkedin" style="font-size: 24px;"></i>
                        </a>
                    </li>
                </ul>
            </div>
        </footer>

    </asp:Content>