<%@ Page Title="Gestión de Stock" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="GestionStock.aspx.cs" Inherits="Gestion_Comercial_Web.Pages.Stock.GestionStock" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <script>
        let lastSelectedIndex = -1;

        function onRowClick(row, index) {
            const grid = document.getElementById('<%= gvStock.ClientID %>');
            const rows = grid.getElementsByTagName('tr');

            // Limpiar selección anterior
            for (let i = 1; i < rows.length; i++) {
                rows[i].classList.remove('selected-row');
            }

            // Marcar fila seleccionada
            row.classList.add('selected-row');
            lastSelectedIndex = index;

            // Guardar índice seleccionado
            document.getElementById('<%= hfSelectedIndex.ClientID %>').value = index;

            // Llamar automáticamente al servidor para cargar datos
            <%= Page.ClientScript.GetPostBackEventReference(btnSeleccionar, null) %>;
        }
    </script>

    <asp:HiddenField ID="hfSelectedIndex" runat="server" />

    <!-- Grid principal: 3/4 izquierda - 1/4 derecha -->
    <div class="container-fluid pb-3">
        <div class="row g-3 align-items-start justify-content-center">

            <!-- Panel Izquierdo (Tabla) -->
            <div class="col-12 col-lg-7">
                <div class="bg-body-secondary rounded-3 p-3 p-md-4 border shadow d-flex flex-column"
                    style="background-color: var(--color-background) !important; min-height: 450px;">
                    
                    <!-- Línea separadora superior -->
                    <hr class="w-100" style="border-color: var(--color-light); opacity: 0.3; filter: blur(0.5px);" />

                    <!-- GridView -->
                    <div class="table-responsive flex-grow-1 mb-3" style="overflow-y: auto;">
                        <asp:GridView ID="gvStock" runat="server" AutoGenerateColumns="False"
                            CssClass="table table-hover w-100 gv-principal shadow-sm"
                            GridLines="None" DataKeyNames="Id"
                            AllowPaging="true" PageSize="7"
                            OnPageIndexChanging="gvStock_PageIndexChanging"
                            OnRowDataBound="gvStock_RowDataBound"
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
                                <asp:BoundField DataField="EstadoStock" HeaderText="Estado" />
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

                    <!-- Botones de acción -->
                    <div class="d-flex flex-column flex-md-row justify-content-end mt-auto gap-2">
                        <asp:LinkButton ID="btnStockBajo" runat="server" OnClick="btnStockBajo_Click"
                            CssClass="btn bg-primary-dark text-light-custom fw-semibold px-4 shadow-sm">
                            <i class="fas fa-exclamation-triangle me-2"></i>Stock Bajo
                        </asp:LinkButton>
                        <asp:LinkButton ID="btnSinStock" runat="server" OnClick="btnSinStock_Click"
                            CssClass="btn bg-primary-dark text-light-custom fw-semibold px-4 shadow-sm">
                            <i class="fas fa-ban me-2"></i>Sin Stock
                        </asp:LinkButton>
                        <asp:LinkButton ID="btnMostrarTodo" runat="server" OnClick="btnMostrarTodo_Click"
                            CssClass="btn bg-primary-dark text-light-custom fw-semibold px-4 shadow-sm text-nowrap">
                            <i class="fas fa-list me-2"></i>Mostrar Todo
                        </asp:LinkButton>
                    </div>

                </div>
            </div>

            <!-- Panel Derecho (Formulario) -->
            <div class="col-12 col-lg-4">
                <div class="bg-body-secondary rounded-3 p-3 p-md-4 border shadow d-flex flex-column"
                    style="background-color: var(--color-background) !important;">

                    <!-- Línea separadora superior -->
                    <hr style="border-color: var(--color-light); opacity: 0.3; filter: blur(0.5px);" />

                    <div class="mb-3">
                        <label for="MainContent_txtArticuloSeleccionado" class="form-label fw-semibold small"
                            style="color: var(--color-light);">Artículo Seleccionado</label>
                        <asp:TextBox ID="txtArticuloSeleccionado" runat="server" 
                            CssClass="form-control form-control-sm" ReadOnly="true"></asp:TextBox>
                    </div>

                    <div class="row mb-3">
                        <div class="col-6">
                            <label for="MainContent_txtStockActual" class="form-label fw-semibold small"
                                style="color: var(--color-light);">Stock Actual</label>
                            <asp:TextBox ID="txtStockActual" runat="server" 
                                CssClass="form-control form-control-sm text-center" ReadOnly="true"></asp:TextBox>
                        </div>
                        <div class="col-6">
                            <label for="MainContent_txtCantidad" class="form-label fw-semibold small"
                                style="color: var(--color-light);">Cantidad</label>
                            <asp:TextBox ID="txtCantidad" runat="server" 
                                CssClass="form-control form-control-sm text-center" TextMode="Number" 
                                Enabled="false" min="1"></asp:TextBox>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="MainContent_ddlOperacion" class="form-label fw-semibold small"
                            style="color: var(--color-light);">Tipo de Operación</label>
                        <asp:DropDownList ID="ddlOperacion" runat="server" 
                            CssClass="form-select form-select-sm" Enabled="false">
                            <asp:ListItem Text="Sumar" Value="Sumar" Selected="True" />
                            <asp:ListItem Text="Restar" Value="Restar" />
                        </asp:DropDownList>
                    </div>

                    <!-- Línea separadora inferior -->
                    <hr style="border-color: var(--color-light); opacity: 0.3; filter: blur(0.5px);" />

                    <!-- Botones debajo -->
                    <div class="d-grid gap-2">
                        <asp:LinkButton ID="btnEjecutar" runat="server" OnClick="btnEjecutar_Click"
                            CssClass="btn text-light-custom fw-semibold"
                            Style="background-color: var(--color-accent); border: none;" Enabled="false">
                            <i class="fas fa-check me-2"></i>Ejecutar
                        </asp:LinkButton>
                        <asp:LinkButton ID="btnLimpiar" runat="server" OnClick="btnLimpiar_Click"
                            CssClass="btn btn-outline-light text-light-custom fw-semibold">
                            <i class="fas fa-eraser me-2"></i>Limpiar
                        </asp:LinkButton>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <!-- Botón oculto para postback automático -->
    <asp:LinkButton ID="btnSeleccionar" runat="server" 
        OnClick="btnSeleccionar_Click" Style="display:none;">
    </asp:LinkButton>

    <!-- Notificación Flotante -->
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