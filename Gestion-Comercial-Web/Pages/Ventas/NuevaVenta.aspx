<%@ Page Title="Nueva Venta" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="NuevaVenta.aspx.cs" Inherits="Gestion_Comercial_Web.Pages.Ventas.NuevaVenta" %>

    <asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
        <%-- Recompilación Forzada v2 --%>

            <style>
                /* Centrar encabezados y celdas */
                .table th,
                .table td {
                    text-align: center;
                    vertical-align: middle;
                }

                /* Fondo blanco para la grilla y celdas */
                .gv-white-bg,
                .gv-white-bg td {
                    background-color: white !important;
                    color: var(--color-primary-dark) !important;
                }

                .gv-white-bg th {
                    background-color: var(--color-primary-dark) !important;
                    color: white !important;
                }

                /* Estilo para la paginación de Bootstrap */
                .pagination-container table {
                    margin: 20px auto 20px auto;
                    /* Margen de 20px arriba y abajo */
                }

                .pagination-container td {
                    padding: 0 2px;
                }

                .pagination-container a,
                .pagination-container span {
                    display: block;
                    padding: 4px 10px;
                    /* Reducido un poco */
                    border: 1px solid #dee2e6;
                    text-decoration: none;
                    color: var(--color-primary-dark);
                    background-color: #fff;
                }

                .pagination-container span {
                    background-color: var(--color-primary-dark);
                    color: #fff;
                    border-color: var(--color-primary-dark);
                }

                .pagination-container a:hover {
                    background-color: #e9ecef;
                }

                /* Garantizar centrado en tablas */
                .table-hover td,
                .table-hover th {
                    text-align: center !important;
                    vertical-align: middle !important;
                }

                /* Filas seleccionables */
                .selected-row td {
                    background-color: var(--color-primary-dark) !important;
                    color: white !important;
                }

                .selectable-row {
                    cursor: pointer;
                    user-select: none;
                }

                .selectable-row:hover td {
                    background-color: #f8f9fa !important;
                }

                .selected-row:hover td {
                    background-color: var(--color-primary-dark) !important;
                }

                /* Color primario para el carrito vacio (sobre fondo blanco) */
                .empty-cart-container {
                    background-color: white !important;
                    color: var(--color-primary-dark) !important;
                }

                .empty-cart-container i {
                    color: var(--color-primary-dark) !important;
                }

                /* Forzar eliminación de bordes en el carrito */
                .gv-no-border,
                .gv-no-border tr,
                .gv-no-border td,
                .gv-no-border th {
                    border: none !important;
                    border-bottom: none !important;
                    border-top: none !important;
                    box-shadow: none !important;
                }

                .gv-no-border th {
                    border-bottom: 2px solid rgba(var(--color-primary-dark-rgb), 0.1) !important;
                    /* Línea sutil bajo header si queres, o nada */
                    border-bottom: none !important;
                }

                /* Estilo para los encabezados del carrito - Ahora coincide con el principal */
                .gv-header-custom {
                    background-color: var(--color-primary-dark) !important;
                    color: white !important;
                    font-weight: bold !important;
                }

                /* Input de cantidad pequeño */
                .txt-cantidad {
                    width: 60px;
                    text-align: center;
                    border: 1px solid #ddd;
                    border-radius: 4px;
                }
            </style>

            <script>
                let lastSelectedIndex = -1;

                function onRowClick(row, index) {
                    const isCtrl = window.event.ctrlKey;
                    const isShift = window.event.shiftKey;
                    const grid = document.getElementById('<%= gvArticulos.ClientID %>');
                    const rows = grid.getElementsByTagName('tr');

                    if (isShift && lastSelectedIndex !== -1) {
                        // Seleccion de rango (Shift)
                        const start = Math.min(lastSelectedIndex, index);
                        const end = Math.max(lastSelectedIndex, index);
                        // Limpiar otras si no hay Ctrl
                        if (!isCtrl) {
                            for (let i = 1; i < rows.length; i++) rows[i].classList.remove('selected-row');
                        }
                        for (let i = 1; i < rows.length; i++) {
                            if (i >= start + 1 && i <= end + 1) rows[i].classList.add('selected-row');
                        }
                    } else if (isCtrl) {
                        // Toggle individual (Ctrl)
                        row.classList.toggle('selected-row');
                    } else {
                        // Seleccion simple: limpia los demas y marca el actual
                        for (let i = 1; i < rows.length; i++) {
                            rows[i].classList.remove('selected-row');
                        }
                        row.classList.add('selected-row');
                    }
                    lastSelectedIndex = index;
                    updateSelectedIds();
                }

                function updateSelectedIds() {
                    const grid = document.getElementById('<%= gvArticulos.ClientID %>');
                    const rows = grid.getElementsByTagName('tr');
                    let selectedIds = [];
                    for (let i = 1; i < rows.length; i++) {
                        if (rows[i].classList.contains('selected-row')) {
                            selectedIds.push(i - 1);
                        }
                    }
                    document.getElementById('<%= hfSelectedIndices.ClientID %>').value = selectedIds.join(',');
                }
            </script>

            <asp:HiddenField ID="hfSelectedIndices" runat="server" />

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

            <!-- Grid principal -->
            <div class="container-fluid pb-3">
                <div class="row g-3 align-items-stretch justify-content-center">

                    <!-- Panel Izquierdo (3/4) -->
                    <div class="col-12 col-lg-7">
                        <div class="bg-body-secondary rounded-3 p-3 p-md-4 border shadow d-flex flex-column h-100"
                            style="background-color: var(--color-background) !important; min-height: 450px;">

                            <!-- Fila de botones -->
                            <div class="row g-2 align-items-end">
                                <div class="col">
                                    <label class="text-light fw-semibold small mb-1 d-block ms-1">Artículos
                                        Disponibles</label>
                                    <div class="input-group shadow-sm">
                                        <asp:TextBox ID="txtBuscar" runat="server" CssClass="form-control"
                                            placeholder="Buscar por nombre o marca..."></asp:TextBox>
                                        <asp:LinkButton ID="btnBuscar" runat="server" OnClick="btnBuscar_Click"
                                            CssClass="btn bg-primary-dark text-light border-0">
                                            <i class="fas fa-search"></i>
                                        </asp:LinkButton>
                                    </div>
                                </div>
                                <div class="col-auto">
                                    <asp:LinkButton ID="btnMostrarTodos" runat="server" OnClick="btnMostrarTodos_Click"
                                        CssClass="btn bg-primary-dark text-light border-0 shadow-sm">
                                        Mostrar Todos
                                    </asp:LinkButton>
                                </div>
                                <div class="col-auto">
                                    <asp:LinkButton ID="btnAgregarSeleccion" runat="server"
                                        OnClick="btnAgregarSeleccion_Click"
                                        CssClass="btn bg-accent text-light fw-semibold px-4 shadow-sm d-flex align-items-center"
                                        style="height: 38px;">
                                        <i class="fas fa-plus me-2"></i>Agregar al Carrito
                                    </asp:LinkButton>
                                </div>
                            </div>
                            <!-- Línea separadora superior -->
                            <hr class="w-100"
                                style="border-color: var(--color-light); opacity: 0.3; filter: blur(0.5px);" />

                            <!-- Tabla de artículos -->
                            <div class="table-responsive flex-grow-1 mb-3" style="min-height: 320px; overflow-y: auto;">
                                <asp:GridView ID="gvArticulos" runat="server" AutoGenerateColumns="False"
                                    CssClass="table table-hover w-100 gv-white-bg shadow-sm" GridLines="None"
                                    DataKeyNames="Id" AllowPaging="true" PageSize="10"
                                    OnPageIndexChanging="gvArticulos_PageIndexChanging"
                                    OnRowDataBound="gvArticulos_RowDataBound"
                                    EmptyDataText="No hay artículos para mostrar">
                                    <HeaderStyle CssClass="bg-primary-dark text-light" />
                                    <RowStyle CssClass="text-dark selectable-row" />
                                    <Columns>
                                        <asp:BoundField DataField="Codigo" HeaderText="Código" />
                                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                                        <asp:TemplateField HeaderText="Categoría">
                                            <ItemTemplate>
                                                <%# Eval("Categoria.Descripcion") %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Marca">
                                            <ItemTemplate>
                                                <%# Eval("Marca.Descripcion") %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="Precio" HeaderText="Precio"
                                            DataFormatString="{0:C}" />
                                        <asp:BoundField DataField="Stock" HeaderText="Stock" />
                                    </Columns>
                                    <PagerStyle CssClass="pagination-container py-3" />
                                    <EmptyDataTemplate>
                                        <div class="text-center gv-white-bg py-5">
                                            <i class="fas fa-inbox fa-3x mb-3 d-block"></i>
                                            <p class="mb-0">No hay artículos para mostrar</p>
                                        </div>
                                    </EmptyDataTemplate>
                                </asp:GridView>
                            </div>

                            <!-- Línea separadora inferior -->
                            <hr style="border-color: var(--color-light); opacity: 0.3; filter: blur(0.5px);" />

                        </div>
                    </div>

                    <!-- Panel Derecho (1/4) -->
                    <div class="col-12 col-lg-3">
                        <div class="bg-body-secondary rounded-3 p-3 p-md-4 border shadow d-flex flex-column h-100"
                            style="background-color: var(--color-background) !important; min-height: 450px;">
                            <!-- Línea separadora superior -->
                            <hr style="border-color: var(--color-light); opacity: 0.3; filter: blur(0.5px);" />
                            <!-- Tabla del carrito -->
                            <div class="table-responsive flex-grow-1 my-3 d-flex flex-column"
                                style="overflow-y: auto; background-color: white !important;">
                                <asp:GridView ID="gvCarrito" runat="server" AutoGenerateColumns="False"
                                    CssClass="table w-100 mb-0 gv-carrito-custom gv-no-border"
                                    OnRowCommand="gvCarrito_RowCommand" GridLines="None" DataKeyNames="IdArticulo"
                                    AllowPaging="true" PageSize="5" OnPageIndexChanging="gvCarrito_PageIndexChanging"
                                    EmptyDataText="El carrito está vacío">
                                    <HeaderStyle CssClass="bg-primary-dark text-light gv-header-custom" />
                                    <Columns>
                                        <asp:BoundField DataField="NombreArticulo" HeaderText="Articulo" />
                                        <asp:TemplateField HeaderText="Cantidad">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtCantidadItem" runat="server"
                                                    Text='<%# Bind("Cantidad") %>' AutoPostBack="true"
                                                    OnTextChanged="txtCantidadItem_TextChanged" CssClass="txt-cantidad"
                                                    type="number" min="1"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="PrecioUnitario" HeaderText="Precio"
                                            DataFormatString="{0:C}" />
                                        <asp:BoundField DataField="Subtotal" HeaderText="Total"
                                            DataFormatString="{0:C}" />
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="btnQuitarFila" runat="server" CssClass="text-danger"
                                                    CommandName="Quitar"
                                                    CommandArgument='<%# Container.DataItemIndex %>'>
                                                    <i class="fas fa-times"></i>
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <PagerStyle CssClass="pagination-container py-3" />
                                    <EmptyDataTemplate>
                                        <div class="text-center empty-cart-container d-flex flex-column align-items-center justify-content-center flex-grow-1 py-5"
                                            style="min-height: 335px;">
                                            <i class="fas fa-shopping-cart fa-3x mb-3"></i>
                                            <p class="fw-semibold text-primary-dark">El carrito está vacío</p>
                                        </div>
                                    </EmptyDataTemplate>
                                </asp:GridView>
                            </div>
                            <!-- Línea separadora inferior -->
                            <hr class="w-100"
                                style="border-color: var(--color-light); opacity: 0.3; filter: blur(0.5px);" />
                            <!-- Acciones del carrito -->
                            <div class="mt-auto">
                                <asp:LinkButton ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click"
                                    CssClass="btn bg-primary-dark text-light w-100 mb-2 shadow-sm border-0">
                                    <i class="fas fa-trash-alt me-2"></i>Limpiar Carrito
                                </asp:LinkButton>

                                <div class="bg-primary-dark text-light rounded-2 p-2 mb-2 text-center shadow-sm">
                                    <span class="fw-bold h5 mb-0">Total:
                                        <asp:Label ID="lblTotal" runat="server" Text="$0.00"></asp:Label>
                                    </span>
                                </div>

                                <div class="d-flex justify-content-center">
                                    <asp:LinkButton ID="btnProcesarVenta" runat="server"
                                        OnClick="btnFinalizarVenta_Click"
                                        CssClass="btn bg-accent btn-lg text-light fw-bold w-100 shadow border-0">
                                        <i class="fas fa-cash-register me-2"></i>Finalizar Venta
                                    </asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Notificación Flotante (Overlay) Premium -->
            <div id="notificationOverlay" class="d-none"
                style="position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.6); backdrop-filter: blur(5px); z-index: 10000; display: flex; align-items: center; justify-content: center;">
                <div class="bg-primary-dark text-light p-4 rounded-3 shadow-lg text-center border border-light border-opacity-25"
                    style="min-width: 300px; max-width: 450px;">
                    <i id="notifIcon" class="fas fa-check-circle fa-3x mb-3 text-success"></i>
                    <h4 id="notifTitle" class="mb-2">¡Éxito!</h4>
                    <p id="notifMessage" class="mb-3"></p>
                    <button type="button" class="btn bg-accent text-light fw-bold px-5"
                        onclick="document.getElementById('notificationOverlay').classList.add('d-none'); document.getElementById('notificationOverlay').style.display = 'none';">Aceptar</button>
                </div>
            </div>

            <script>
                function showNotification(title, message, isError) {
                    const overlay = document.getElementById('notificationOverlay');
                    const titleEl = document.getElementById('notifTitle');
                    const messageEl = document.getElementById('notifMessage');
                    const iconEl = document.getElementById('notifIcon');

                    titleEl.innerText = title;
                    messageEl.innerText = message;

                    if (isError) {
                        iconEl.className = 'fas fa-exclamation-circle fa-3x mb-3 text-danger';
                        titleEl.className = 'text-danger mb-2';
                    } else {
                        iconEl.className = 'fas fa-check-circle fa-3x mb-3 text-success';
                        titleEl.className = 'text-light mb-2';
                    }

                    overlay.classList.remove('d-none');
                    overlay.style.display = 'flex';
                }
            </script>

            <!-- Footer -->
            <footer class="container-fluid">
                <div class="d-flex flex-wrap justify-content-between align-items-center py-3 border-top">
                    <div class="col-md-6 d-flex align-items-center">
                        <span style="color: var(--color-primary-dark); font-weight: 500;">&copy; <%: DateTime.Now.Year
                                %> -
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