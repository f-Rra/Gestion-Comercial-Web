<%@ Page Title="Nueva Venta" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="NuevaVenta.aspx.cs" Inherits="Gestion_Comercial_Web.Pages.Ventas.NuevaVenta" %>

    <asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
        <%-- Recompilación Forzada v2 --%>



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

            <!-- Grid principal -->
            <div class="container-fluid pb-3">
                <div class="row g-3 align-items-stretch justify-content-center">

                    <div class="col-12 col-lg-7">
                        <div class="bg-body-secondary rounded-3 p-3 p-md-4 border shadow d-flex flex-column h-100"
                            style="background-color: var(--color-background) !important;">

                            <!-- Fila de botones -->
                            <div class="row g-2 align-items-end">
                                <div class="col">
                                    <label class="text-light-custom fw-semibold small mb-1 d-block ms-1">Artículos
                                        Disponibles</label>
                                    <div class="input-group shadow-sm">
                                        <asp:TextBox ID="txtBuscar" runat="server" CssClass="form-control"
                                            placeholder="Buscar por nombre o marca..." AutoPostBack="true"
                                            OnTextChanged="btnBuscar_Click"></asp:TextBox>
                                        <asp:LinkButton ID="btnBuscar" runat="server" OnClick="btnBuscar_Click"
                                            CssClass="btn bg-primary-dark text-light-custom border-0">
                                            <i class="fas fa-search"></i>
                                        </asp:LinkButton>
                                    </div>
                                </div>
                                <div class="col-auto">
                                    <asp:LinkButton ID="btnMostrarTodos" runat="server" OnClick="btnMostrarTodos_Click"
                                        CssClass="btn bg-primary-dark text-light-custom border-0 shadow-sm">
                                        Mostrar Todos
                                    </asp:LinkButton>
                                </div>
                                <div class="col-auto">
                                    <asp:LinkButton ID="btnAgregarSeleccion" runat="server"
                                        OnClick="btnAgregarSeleccion_Click"
                                        CssClass="btn bg-accent text-light-custom fw-semibold px-4 shadow-sm d-flex align-items-center"
                                        style="height: 38px;">
                                        <i class="fas fa-plus me-2"></i>Agregar al Carrito
                                    </asp:LinkButton>
                                </div>
                            </div>
                            <!-- Línea separadora superior -->
                            <hr class="w-100"
                                style="border-color: var(--color-light); opacity: 0.3; filter: blur(0.5px);" />

                            <!-- Tabla de artículos -->
                            <div class="table-responsive flex-grow-1 mb-3" style="overflow-y: auto;">
                                <asp:GridView ID="gvArticulos" runat="server" AutoGenerateColumns="False"
                                    CssClass="table table-hover w-100 gv-principal shadow-sm" GridLines="None"
                                    DataKeyNames="Id" AllowPaging="true" PageSize="7"
                                    OnPageIndexChanging="gvArticulos_PageIndexChanging"
                                    OnRowDataBound="gvArticulos_RowDataBound"
                                    EmptyDataText="No hay artículos para mostrar">
                                    <HeaderStyle />
                                    <RowStyle CssClass="selectable-row" />
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
                                        <asp:BoundField DataField="Precio" HeaderText="Precio" DataFormatString="{0:C}"
                                            ItemStyle-CssClass="currency-cell" />
                                        <asp:BoundField DataField="Stock" HeaderText="Stock" />
                                    </Columns>
                                    <PagerStyle CssClass="paginacion py-2" />
                                    <EmptyDataTemplate>
                                        <div class="estado-vacio">
                                            <i class="fas fa-inbox"></i>
                                            <p>No hay artículos para mostrar</p>
                                        </div>
                                    </EmptyDataTemplate>
                                </asp:GridView>
                            </div>

                            <!-- Línea separadora inferior -->
                            <hr style="border-color: var(--color-light); opacity: 0.3; filter: blur(0.5px);" />

                        </div>
                    </div>

                    <div class="col-12 col-lg-3">
                        <div id="pnlDerecho" runat="server"
                            class="bg-body-secondary rounded-3 p-3 p-md-4 border shadow d-flex flex-column h-100"
                            style="background-color: var(--color-background) !important;">

                            <!-- Tabla Carrito -->
                            <div class="flex-grow-1 mt-2 mb-3 d-flex flex-column">
                                <asp:GridView ID="gvCarrito" runat="server" AutoGenerateColumns="False"
                                    CssClass="table gv-principal gv-carrito w-100 mb-0"
                                    OnRowCommand="gvCarrito_RowCommand" GridLines="None" DataKeyNames="IdArticulo"
                                    AllowPaging="true" PageSize="5" OnPageIndexChanging="gvCarrito_PageIndexChanging"
                                    ShowHeaderWhenEmpty="false">
                                    <HeaderStyle />
                                    <Columns>
                                        <asp:BoundField DataField="NombreArticulo" HeaderText="Articulo"
                                            ItemStyle-CssClass="text-start" />
                                        <asp:TemplateField HeaderText="Cant.">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtCantidadItem" runat="server"
                                                    Text='<%# Bind("Cantidad") %>' AutoPostBack="true"
                                                    OnTextChanged="txtCantidadItem_TextChanged"
                                                    CssClass="form-control form-control-sm text-center mx-auto"
                                                    style="width: 45px; padding: 2px;" type="number" min="1">
                                                </asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="PrecioUnitario" HeaderText="Precio"
                                            DataFormatString="{0:C}" ItemStyle-CssClass="currency-cell" />
                                        <asp:BoundField DataField="Subtotal" HeaderText="Total" DataFormatString="{0:C}"
                                            ItemStyle-CssClass="currency-cell" />
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="btnQuitarFila" runat="server" CssClass="btn-remove"
                                                    CommandName="Quitar"
                                                    CommandArgument='<%# Container.DataItemIndex %>'>
                                                    <i class="fas fa-trash-alt"></i>
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <PagerStyle CssClass="paginacion py-2" />
                                    <EmptyDataTemplate>
                                        <div class="estado-vacio">
                                            <i class="fas fa-shopping-cart"></i>
                                            <p>El carrito está vacío</p>
                                        </div>
                                    </EmptyDataTemplate>
                                </asp:GridView>
                            </div>
                            <!-- Línea separadora inferior (Opcional, ya está el borde del div arriba) -->
                            <!-- Acciones del carrito -->
                            <asp:PlaceHolder ID="phAccionesCarrito" runat="server">
                                <div class="mt-2 d-grid gap-2">
                                    <asp:LinkButton ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click"
                                        CssClass="btn btn-danger w-100 py-2 fw-semibold shadow-sm">
                                        <i class="fas fa-trash me-2"></i>Limpiar Carrito
                                    </asp:LinkButton>

                                    <div class="bg-primary-dark text-light-custom rounded-3 p-3 text-center shadow-sm">
                                        <div class="small opacity-75 mb-1">Total a Pagar</div>
                                        <div class="fw-bold h4 mb-0">
                                            <asp:Label ID="lblTotal" runat="server" Text="$0.00"></asp:Label>
                                        </div>
                                    </div>

                                    <asp:LinkButton ID="btnProcesarVenta" runat="server"
                                        OnClick="btnFinalizarVenta_Click"
                                        CssClass="btn bg-accent btn-lg text-light-custom fw-bold w-100 shadow-sm border-0 py-3">
                                        <i class="fas fa-cash-register me-2"></i>Finalizar Venta
                                    </asp:LinkButton>
                                </div>
                            </asp:PlaceHolder>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Notificación Flotante (Overlay) Personalizada -->
            <div id="notificationOverlay" class="d-none"
                style="position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.6); backdrop-filter: blur(5px); z-index: 10000; display: flex; align-items: center; justify-content: center;">
                <div class="bg-primary-dark text-light-custom p-4 rounded-3 shadow-lg text-center border border-light border-opacity-25"
                    style="min-width: 300px; max-width: 450px;">
                    <i id="notifIcon" class="fas fa-check-circle fa-3x mb-3 text-success"></i>
                    <h4 id="notifTitle" class="mb-2">¡Éxito!</h4>
                    <p id="notifMessage" class="mb-3"></p>
                    <button type="button" class="btn bg-accent text-light-custom fw-bold px-5"
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
                        titleEl.className = 'text-light-custom mb-2';
                    }

                    overlay.classList.remove('d-none');
                    overlay.style.display = 'flex';
                }
            </script>



    </asp:Content>