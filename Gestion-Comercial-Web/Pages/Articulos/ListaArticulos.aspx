<%@ Page Title="Lista de Artículos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ListaArticulos.aspx.cs" Inherits="Gestion_Comercial_Web.Pages.Articulos.ListaArticulos" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Jumbotron -->
    <div class="container my-3">
        <div class="p-5 text-center bg-body-tertiary rounded-3 border shadow">
            <div class="d-inline-block">
                <h1 style="color: var(--color-primary-dark);">Gestión de Artículos</h1>
                <hr style="border-color: var(--color-primary-dark); opacity: 0.3; margin: 0.5rem 0; filter: blur(0.5px);" />
            </div>
            <p class="lead mb-0">
                Administre el inventario de productos del sistema
            </p>
        </div>
    </div>

    <!-- Grid principal: 3/4 izquierda - 1/4 derecha -->
    <div class="container-fluid pb-3">
        <div class="row g-3 align-items-stretch justify-content-center">
            
            <!-- Panel Izquierdo (3/4) -->
            <div class="col-12 col-lg-7">
                <div class="bg-body-secondary rounded-3 p-3 p-md-4 border shadow d-flex flex-column h-100" style="background-color: var(--color-background) !important; min-height: 450px;">
                    
                    <!-- Filtros de búsqueda -->
                    <div class="row mb-3 g-2 ms-3">
                        <div class="col-12 col-md-2">
                            <label class="form-label text-light fw-semibold mb-1">Campo:</label>
                            <asp:DropDownList ID="ddlCampo" runat="server" CssClass="form-select">
                                <asp:ListItem Selected="True" Value="Nombre">Nombre</asp:ListItem>
                                <asp:ListItem Value="Codigo">Código</asp:ListItem>
                                <asp:ListItem Value="Categoria">Categoría</asp:ListItem>
                                <asp:ListItem Value="Marca">Marca</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-12 col-md-2">
                            <label class="form-label text-light fw-semibold mb-1">Criterio:</label>
                            <asp:DropDownList ID="ddlCriterio" runat="server" CssClass="form-select">
                                <asp:ListItem Selected="True" Value="Comienza">Comienza con</asp:ListItem>
                                <asp:ListItem Value="Termina">Termina con</asp:ListItem>
                                <asp:ListItem Value="Contiene">Contiene</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-12 col-md-2">
                            <label class="form-label text-light fw-semibold mb-1">Filtro:</label>
                            <div class="input-group">
                                <asp:TextBox ID="txtFiltro" runat="server" CssClass="form-control" placeholder="Buscar..."></asp:TextBox>
                                <asp:Button ID="btnBuscar" runat="server" Text="Buscar" CssClass="btn btn-light" OnClick="btnBuscar_Click" />
                            </div>
                        </div>
                    </div>

                    <!-- Línea separadora superior -->
                    <hr style="border-color: var(--color-light); opacity: 0.3; filter: blur(0.5px);" />

                    <!-- GridView -->
                    <div class="table-responsive mb-3" style="height: 280px; overflow-y: auto;">
                        <asp:GridView ID="dgvArticulos" runat="server" 
                            CssClass="table table-striped table-hover" 
                            AutoGenerateColumns="False"
                            DataKeyNames="Id"
                            OnSelectedIndexChanged="dgvArticulos_SelectedIndexChanged"
                            EmptyDataText="No hay artículos para mostrar"
                            HeaderStyle-BackColor="#012E40"
                            HeaderStyle-ForeColor="White"
                            Style="background-color: var(--color-light);">
                            <Columns>
                                <asp:BoundField DataField="Codigo" HeaderText="Código" />
                                <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                                <asp:BoundField DataField="Categoria.Descripcion" HeaderText="Categoría" />
                                <asp:BoundField DataField="Marca.Descripcion" HeaderText="Marca" />
                                <asp:BoundField DataField="Precio" HeaderText="Precio" DataFormatString="{0:C2}" />
                                <asp:BoundField DataField="Stock" HeaderText="Stock" />
                                <asp:BoundField DataField="Activo" HeaderText="Estado" />
                                <asp:CommandField ShowSelectButton="True" SelectText="Seleccionar" ButtonType="Link" />
                            </Columns>
                            <EmptyDataTemplate>
                                <div class="text-center text-muted py-4">
                                    <i class="fas fa-inbox fa-3x mb-3 d-block"></i>
                                    <p class="mb-0">No hay artículos para mostrar</p>
                                </div>
                            </EmptyDataTemplate>
                        </asp:GridView>
                    </div>

                    <!-- Línea separadora inferior -->
                    <hr style="border-color: var(--color-light); opacity: 0.3; filter: blur(0.5px);" />

                    <!-- Botones de acción -->
                    <div class="d-flex flex-column flex-md-row justify-content-between mt-auto gap-2">
                        <div class="d-flex gap-2">
                            <asp:Button ID="btnEditar" runat="server" Text="Editar" CssClass="btn btn-light flex-fill flex-md-grow-0 px-4" 
                                style="color: var(--color-primary-dark);" OnClick="btnEditar_Click" />
                            <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" CssClass="btn btn-light flex-fill flex-md-grow-0 px-4" 
                                style="color: var(--color-primary-dark);" OnClick="btnEliminar_Click" 
                                OnClientClick="return confirm('¿Está seguro de eliminar este artículo?');" />
                        </div>
                        <div>
                            <asp:Button ID="btnAgregar" runat="server" Text="Agregar" CssClass="btn btn-light w-100 px-4" 
                                style="color: var(--color-primary-dark);" OnClick="btnAgregar_Click" />
                        </div>
                    </div>

                </div>
            </div>

            <!-- Panel Derecho (1/4) -->
            <div class="col-12 col-lg-3">
                <div class="rounded-3 p-3 p-md-4 text-center border shadow d-flex flex-column h-100" style="background-color: var(--color-background) !important; min-height: 450px;">
                    
                    <!-- Imagen del artículo -->
                    <div class="mb-3 p-3 rounded flex-grow-1 d-flex align-items-center justify-content-center" style="background-color: var(--color-accent);">
                        <asp:Image ID="imgArticulo" runat="server" 
                            ImageUrl="~/Content/Images/not-available.png" 
                            AlternateText="Imagen no disponible"
                            CssClass="img-fluid rounded"
                            Style="max-height: 100%; max-width: 100%; object-fit: contain;" />
                    </div>

                    <!-- Botón Detalles -->
                    <asp:Button ID="btnDetalles" runat="server" Text="Detalles del Artículo" CssClass="btn btn-light w-100" 
                        style="color: var(--color-primary-dark);" OnClick="btnDetalles_Click" />

                </div>
            </div>

        </div>
    </div>

    <!-- Footer -->
    <footer class="container-fluid">
        <div class="d-flex flex-wrap justify-content-between align-items-center py-3 border-top">
            <div class="col-md-6 d-flex align-items-center">
                <span style="color: var(--color-primary-dark); font-weight: 500;">&copy; <%: DateTime.Now.Year %> - Sistema de Gestion Comercial</span>
            </div>
            <ul class="nav col-md-4 justify-content-end list-unstyled d-flex">
                <li class="ms-3">
                    <a href="https://github.com/f-Rra" target="_blank" aria-label="GitHub" style="color: var(--color-primary-dark);">
                        <i class="fab fa-github" style="font-size: 24px;"></i>
                    </a>
                </li>
                <li class="ms-3">
                    <a href="https://linkedin.com/in/f-rra" target="_blank" aria-label="LinkedIn" style="color: var(--color-primary-dark);">
                        <i class="fab fa-linkedin" style="font-size: 24px;"></i>
                    </a>
                </li>
            </ul>
        </div>
    </footer>

</asp:Content>
