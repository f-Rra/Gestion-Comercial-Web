<%@ Page Title="Lista de Artículos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ListaArticulos.aspx.cs" Inherits="Gestion_Comercial_Web.Pages.Articulos.ListaArticulos" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Jumbotron -->
    <div class="container my-2 my-md-3">
        <div class="p-3 p-md-4 p-lg-5 text-center bg-body-tertiary rounded-3 border shadow">
            <h1 class="fs-3 fs-md-2 fs-lg-1" style="color: var(--color-primary-dark);">Gestión de Artículos</h1>
            <p class="lead mb-0 d-none d-md-block">
                Administre el inventario de productos del sistema
            </p>
        </div>
    </div>

    <!-- Grid principal: 3/4 izquierda - 1/4 derecha -->
    <div class="container-fluid pb-3">
        <div class="row g-3 align-items-stretch">
            
            <!-- Panel Izquierdo (3/4) -->
            <div class="col-12 col-lg-9">
                <div class="bg-body-secondary rounded-3 p-3 p-md-4 border shadow d-flex flex-column h-100" style="background-color: var(--color-background) !important; min-height: 400px; min-height: 520px;">
                    
                    <!-- Filtros de búsqueda -->
                    <div class="row mb-3 g-2">
                        <div class="col-12 col-12 col-md-4">
                            <label class="form-label text-light fw-semibold">Campo:</label>
                            <asp:DropDownList ID="ddlCampo" runat="server" CssClass="form-select">
                                <asp:ListItem Selected="True" Value="Nombre">Nombre</asp:ListItem>
                                <asp:ListItem Value="Codigo">Código</asp:ListItem>
                                <asp:ListItem Value="Categoria">Categoría</asp:ListItem>
                                <asp:ListItem Value="Marca">Marca</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-12 col-md-4">
                            <label class="form-label text-light fw-semibold">Criterio:</label>
                            <asp:DropDownList ID="ddlCriterio" runat="server" CssClass="form-select">
                                <asp:ListItem Selected="True" Value="Comienza">Comienza con</asp:ListItem>
                                <asp:ListItem Value="Termina">Termina con</asp:ListItem>
                                <asp:ListItem Value="Contiene">Contiene</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-12 col-md-4">
                            <label class="form-label text-light fw-semibold">Filtro:</label>
                            <div class="input-group">
                                <asp:TextBox ID="txtFiltro" runat="server" CssClass="form-control" placeholder="Buscar..."></asp:TextBox>
                                <asp:Button ID="btnBuscar" runat="server" Text="Buscar" CssClass="btn btn-light" OnClick="btnBuscar_Click" />
                            </div>
                        </div>
                    </div>

                    <!-- GridView -->
                    <div class="table-responsive mb-3" style="height: 330px; overflow-y: auto;">
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

                    <!-- Botones de acción -->
                    <div class="d-flex flex-column flex-md-row justify-content-between mt-auto gap-2">
                        <div class="d-flex gap-2">
                            <asp:Button ID="btnEditar" runat="server" Text="Editar" CssClass="btn btn-light flex-fill flex-md-grow-0" 
                                style="color: var(--color-primary-dark);" OnClick="btnEditar_Click" />
                            <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" CssClass="btn btn-light flex-fill flex-md-grow-0" 
                                style="color: var(--color-primary-dark);" OnClick="btnEliminar_Click" 
                                OnClientClick="return confirm('¿Está seguro de eliminar este artículo?');" />
                        </div>
                        <div>
                            <asp:Button ID="btnAgregar" runat="server" Text="Agregar" CssClass="btn btn-light w-100" 
                                style="color: var(--color-primary-dark);" OnClick="btnAgregar_Click" />
                        </div>
                    </div>

                </div>
            </div>

            <!-- Panel Derecho (1/4) -->
            <div class="col-12 col-lg-3">
                <div class="rounded-3 p-3 p-md-4 text-center border shadow d-flex flex-column h-100" style="background-color: var(--color-background) !important; min-height: 300px; min-height: 520px;">
                    
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

</asp:Content>
