<%@ Page Title="Nueva Venta" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="NuevaVenta.aspx.cs" Inherits="Gestion_Comercial_Web.Pages.Ventas.NuevaVenta" %>

    <asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

        <!-- Jumbotron -->
        <div class="container my-3">
            <div class="p-5 text-center bg-body-tertiary rounded-3 border shadow">
                <div class="d-inline-block">
                    <h1 style="color: var(--color-primary-dark);">Gestión de Ventas</h1>
                    <hr
                        style="border-color: var(--color-primary-dark); opacity: 0.3; margin: 0.5rem 0; filter: blur(0.5px);" />
                </div>
                <p class="lead mb-0">
                    Realice sus ventas de manera eficiente y sencilla
                </p>
            </div>
        </div>

        <!-- Grid principal: 3/4 izquierda - 1/4 derecha -->
        <div class="container-fluid pb-3">
            <div class="row g-3 align-items-stretch justify-content-center">

                <!-- Panel Izquierdo (3/4) -->
                <div class="col-12 col-lg-7">
                    <div class="bg-body-secondary rounded-3 p-3 p-md-4 border shadow d-flex flex-column h-100"
                        style="background-color: var(--color-background) !important; min-height: 450px;">

                        <!-- Filtros de búsqueda -->
                        <div class="row mb-3 g-2 ms-3 align-items-end">
                            <div class="col-12 col-md-3">
                                <div class="input-group">
                                    <asp:TextBox ID="txtBuscar" runat="server" CssClass="form-control flex-grow-1"
                                        placeholder="Artículos Disponibles"></asp:TextBox>
                                    <asp:LinkButton ID="btnBuscar" runat="server"
                                        CssClass="btn bg-primary-dark text-light-custom fw-semibold">Buscar
                                    </asp:LinkButton>
                                </div>
                            </div>
                            <div class="col-12 col-md-2 d-flex align-items-end">
                                <asp:LinkButton ID="btnMostrarTodos" runat="server"
                                    CssClass="btn bg-primary-dark text-light-custom w-100 text-nowrap fw-semibold">
                                    Mostrar Todos</asp:LinkButton>
                            </div>
                            <div class="col-12 col-md-2">
                            </div>
                        </div>

                        <!-- Línea separadora superior -->
                        <hr class="w-100"
                            style="border-color: var(--color-light); opacity: 0.3; filter: blur(0.5px);" />

                        <!-- Tabla de artículos -->
                        <div class="table-responsive flex-grow-1 mb-3" style="min-height: 320px; overflow-y: auto;">
                            <ContentTemplate>
                                <asp:GridView ID="gvArticulos" runat="server" AutoGenerateColumns="False"
                                    CssClass="table table-striped table-hover w-100"
                                    EmptyDataText="No hay artículos para mostrar">
                                    <Columns>
                                        <asp:BoundField DataField="Codigo" HeaderText="Código" />
                                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                                        <asp:BoundField DataField="Categoria" HeaderText="Categoría" />
                                        <asp:BoundField DataField="Marca" HeaderText="Marca" />
                                        <asp:BoundField DataField="Precio" HeaderText="Precio"
                                            DataFormatString="{0:C}" />
                                        <asp:BoundField DataField="Stock" HeaderText="Stock" />
                                    </Columns>
                                    <EmptyDataTemplate>
                                        <div class="text-center text-muted py-4">
                                            <i class="fas fa-inbox fa-3x mb-3 d-block"></i>
                                            <p class="mb-0">No hay artículos para mostrar</p>
                                        </div>
                                    </EmptyDataTemplate>
                                </asp:GridView>
                            </ContentTemplate>
                        </div>

                        <!-- Línea separadora inferior -->
                        <hr style="border-color: var(--color-light); opacity: 0.3; filter: blur(0.5px);" />

                        <!-- Botones de acción -->
                        <div class="d-flex flex-column flex-md-row justify-content-end mt-auto gap-2">
                            <div class="d-flex gap-2">
                                <asp:LinkButton ID="btnAgregarSeleccion" runat="server"
                                    CssClass="btn bg-primary-dark text-light-custom w-100 ms-auto fw-semibold">Agregar
                                    al carrito</asp:LinkButton>
                            </div>
                        </div>

                    </div>
                </div>

                <!-- Panel Derecho (1/4) -->
                <div class="col-12 col-lg-3">
                    <div class="bg-body-secondary rounded-3 p-3 p-md-4 border shadow d-flex flex-column h-100"
                        style="background-color: var(--color-background) !important; min-height: 450px;">
                        <!-- Línea separadora superior -->
                        <hr style="border-color: var(--color-light); opacity: 0.3; filter: blur(0.5px);" />
                        <!-- Tabla del carrito -->
                        <div class="table-responsive flex-grow-1 mb-3" style="min-height: 160px; overflow-y: auto;">
                            <ContentTemplate>
                                <asp:GridView ID="gvCarrito" runat="server" AutoGenerateColumns="False"
                                    CssClass="table table-striped table-hover w-100"
                                    EmptyDataText="No hay datos para mostrar">
                                    <Columns>
                                        <asp:BoundField DataField="Articulo" HeaderText="Artículo" />
                                        <asp:TemplateField HeaderText="Cantidad">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtCantidadItem" runat="server"
                                                    Text='<%# Bind("Cantidad") %>'
                                                    CssClass="form-control form-control-sm"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="Precio" HeaderText="Precio"
                                            DataFormatString="{0:C}" />
                                        <asp:BoundField DataField="Subtotal" HeaderText="Subtotal"
                                            DataFormatString="{0:C}" />
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="btnQuitarFila" runat="server"
                                                    CssClass="btn btn-outline-info btn-sm" CommandName="Quitar"
                                                    CommandArgument='<%# Container.DataItemIndex %>'>Quitar
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <EmptyDataTemplate>
                                        <div class="text-center text-muted py-2">
                                            <i class="fas fa-inbox fa-2x mb-2 d-block"></i>
                                            <p class="mb-0">No hay datos para mostrar</p>
                                        </div>
                                    </EmptyDataTemplate>
                                </asp:GridView>
                            </ContentTemplate>
                        </div>
                        <!-- Línea separadora inferior -->
                        <hr class="w-100"
                            style="border-color: var(--color-light); opacity: 0.3; filter: blur(0.5px);" />
                        <!-- Botones debajo -->
                        <div class="d-flex flex-row gap-2 mt-auto mb-2">
                            <asp:LinkButton ID="btnQuitar" runat="server"
                                CssClass="btn text-light-custom fw-semibold w-50"
                                Style="background-color: var(--color-accent); border: none;">Quitar</asp:LinkButton>
                            <asp:LinkButton ID="btnLimpiar" runat="server"
                                CssClass="btn text-light-custom fw-semibold w-50"
                                Style="background-color: var(--color-accent); border: none;">Limpiar</asp:LinkButton>
                        </div>
                        <div class="text-center mb-2">
                            <span class="fw-bold" style="font-size: 1.2rem; color: var(--color-light);">Total:
                                $0.00</span>
                        </div>
                        <div class="d-flex justify-content-center">
                            <asp:LinkButton ID="btnProcesarVenta" runat="server"
                                CssClass="btn bg-primary-dark btn-lg text-light-custom fw-semibold">Procesar Venta
                            </asp:LinkButton>
                        </div>
                    </div>
                </div>

            </div>
        </div>

        <!-- Footer -->
        <footer class="container-fluid">
            <div class="d-flex flex-wrap justify-content-between align-items-center py-3 border-top">
                <div class="col-md-6 d-flex align-items-center">
                    <span style="color: var(--color-primary-dark); font-weight: 500;">&copy; <%: DateTime.Now.Year %> -
                            Sistema de Gestion Comercial</span>
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