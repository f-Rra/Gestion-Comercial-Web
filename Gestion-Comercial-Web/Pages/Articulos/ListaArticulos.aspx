<%@ Page Title="Lista de Artículos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="ListaArticulos.aspx.cs" Inherits="Gestion_Comercial_Web.Pages.Articulos.ListaArticulos"
    EnableEventValidation="false" %>

    <asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">


        <script>
            function onRowClick(gridUniqueId, row, index) {
                try {
                    var table = row.closest("table");
                    if (table) {
                        var rows = table.getElementsByTagName('tr');
                        for (var i = 1; i < rows.length; i++) {
                            rows[i].classList.remove('selected-row');
                        }
                    }
                    row.classList.add('selected-row');
                    if (window.__doPostBack) {
                        __doPostBack(gridUniqueId, 'Select$' + index);
                    }
                } catch (e) {
                    console.error("Error en selección:", e);
                }
            }
        </script>



        <!-- Grid principal: 3/4 izquierda - 1/4 derecha -->
        <div class="container-fluid pb-3">
            <div class="row g-3 align-items-stretch justify-content-center">

                <!-- Panel Izquierdo (3/4) -->
                <div class="col-12 col-lg-7">
                    <div class="bg-body-secondary rounded-3 p-3 p-md-4 border shadow d-flex flex-column h-100"
                        style="background-color: var(--color-background) !important; min-height: 450px;">

                        <!-- Filtros de búsqueda -->
                        <div class="row mb-0 g-2">
                            <div class="col-12 col-md-3">
                                <label class="form-label text-light-custom fw-semibold small mb-1">Campo:</label>
                                <asp:DropDownList ID="ddlCampo" runat="server" CssClass="form-select form-select-sm">
                                    <asp:ListItem Selected="True" Value="Nombre">Nombre</asp:ListItem>
                                    <asp:ListItem Value="Codigo">Código</asp:ListItem>
                                    <asp:ListItem Value="Categoria">Categoría</asp:ListItem>
                                    <asp:ListItem Value="Marca">Marca</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-12 col-md-3">
                                <label class="form-label text-light-custom fw-semibold small mb-1">Criterio:</label>
                                <asp:DropDownList ID="ddlCriterio" runat="server" CssClass="form-select form-select-sm">
                                    <asp:ListItem Selected="True" Value="Comienza">Comienza con</asp:ListItem>
                                    <asp:ListItem Value="Termina">Termina con</asp:ListItem>
                                    <asp:ListItem Value="Contiene">Contiene</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-12 col-md-6">
                                <label class="form-label text-light-custom fw-semibold small mb-1">Búsqueda
                                    rápida:</label>
                                <div class="input-group input-group-sm">
                                    <asp:TextBox ID="txtFiltro" runat="server" CssClass="form-control"
                                        placeholder="Escriba para buscar..." AutoPostBack="true"
                                        OnTextChanged="txtFiltro_TextChanged"
                                        onkeyup="if(this.value.length >= 2 || this.value.length == 0) { setTimeout(() => { __doPostBack('<%= txtFiltro.UniqueID %>', ''); }, 300); }">
                                    </asp:TextBox>
                                    <asp:LinkButton ID="btnBuscar" runat="server" OnClick="btnBuscar_Click"
                                        CssClass="btn bg-primary-dark text-light-custom border-0">
                                        <i class="fas fa-search"></i>
                                    </asp:LinkButton>
                                </div>
                            </div>
                        </div>

                        <!-- Línea separadora superior -->
                        <hr style="border-color: var(--color-light); opacity: 0.3; filter: blur(0.5px);" />

                        <!-- GridView -->
                        <div class="table-responsive">
                            <asp:GridView ID="gvArticulos" runat="server"
                                CssClass="table table-hover w-100 gv-principal shadow-sm" GridLines="None"
                                AutoGenerateColumns="False" DataKeyNames="Id"
                                OnSelectedIndexChanged="gvArticulos_SelectedIndexChanged"
                                OnRowDataBound="gvArticulos_RowDataBound_Fix" AllowPaging="true" PageSize="7"
                                OnPageIndexChanging="gvArticulos_PageIndexChanging"
                                EmptyDataText="No hay artículos para mostrar">
                                <PagerStyle CssClass="paginacion py-3" />
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
                                    <asp:BoundField DataField="Precio" HeaderText="Precio" DataFormatString="{0:C2}" />
                                    <asp:BoundField DataField="Stock" HeaderText="Stock" ItemStyle-CssClass="fw-bold" />
                                    <asp:BoundField DataField="estadoStock" HeaderText="Estado" />
                                </Columns>
                                <EmptyDataTemplate>
                                    <div class="text-center gv-white-bg py-5">
                                        <i class="fas fa-inbox fa-3x mb-3 d-block"
                                            style="color: var(--color-primary-dark);"></i>
                                        <p class="mb-0 fw-semibold" style="color: var(--color-primary-dark);">No hay
                                            artículos para mostrar</p>
                                    </div>
                                </EmptyDataTemplate>
                            </asp:GridView>
                        </div>

                        <!-- Línea separadora inferior -->
                        <hr style="border-color: var(--color-light); opacity: 0.3; filter: blur(0.5px);" />

                        <!-- Botones de acción -->
                        <div class="d-flex flex-column flex-md-row justify-content-between mt-auto gap-2">
                            <div class="d-flex gap-2">
                                <asp:Button ID="btnEditar" runat="server" Text="Editar"
                                    CssClass="btn bg-primary-dark text-light-custom fw-semibold flex-fill flex-md-grow-0 px-4"
                                    OnClick="btnEditar_Click" />
                                <asp:Button ID="btnEliminar" runat="server" Text="Eliminar"
                                    CssClass="btn bg-primary-dark text-light-custom fw-semibold flex-fill flex-md-grow-0 px-4"
                                    OnClientClick="return showConfirmModal();" OnClick="btnEliminar_Click" />
                                <asp:Button ID="btnConfirmarEliminar" runat="server" style="display:none;"
                                    OnClick="btnEliminar_Click" />
                            </div>
                            <div>
                                <asp:Button ID="btnAgregar" runat="server" Text="Agregar Artículo"
                                    CssClass="btn bg-primary-dark text-light-custom fw-semibold w-100 px-4"
                                    OnClick="btnAgregar_Click" />
                            </div>
                        </div>

                    </div>
                </div>

                <!-- Panel Derecho (1/4) -->
                <div class="col-12 col-lg-3">
                    <div class="rounded-3 p-3 p-md-4 text-center border shadow d-flex flex-column h-100"
                        style="background-color: var(--color-background) !important; min-height: 450px;">

                        <!-- Imagen del artículo -->
                        <div class="mb-3 p-3 rounded flex-grow-1 d-flex align-items-center justify-content-center"
                            style="background-color: var(--color-accent);">
                            <asp:Image ID="imgArticulo" runat="server" ImageUrl="~/Content/Images/not-available.png"
                                AlternateText="Imagen no disponible" CssClass="img-fluid rounded"
                                Style="max-height: 100%; max-width: 100%; object-fit: contain;"
                                onerror="this.src='/Content/Images/not-available.png';" />
                        </div>

                        <!-- Botón Detalles -->
                        <asp:Button ID="btnDetalles" runat="server" Text="Detalles del Artículo"
                            CssClass="btn w-100 fw-semibold text-light-custom mb-2"
                            Style="background-color: var(--color-accent); border: none;" OnClick="btnDetalles_Click" />

                    </div>
                </div>

            </div>
        </div>



        <!-- Modal de Confirmación Personalizado -->
        <div id="confirmModal" class="d-none"
            style="position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.6); backdrop-filter: blur(5px); z-index: 9999; display: flex; align-items: center; justify-content: center;">
            <div class="bg-primary-dark text-light-custom p-4 rounded-3 shadow-lg text-center border border-light border-opacity-25"
                style="max-width: 400px; width: 90%;">
                <i class="fas fa-exclamation-triangle fa-3x mb-3 text-warning"></i>
                <h4 class="mb-3">¿Estás seguro?</h4>
                <p class="mb-4 opacity-75">Esta acción eliminará el artículo de forma permanente del listado activo.</p>
                <div class="d-flex gap-2 justify-content-center">
                    <button type="button" class="btn btn-outline-light-custom px-4"
                        onclick="closeConfirmModal()">Cancelar</button>
                    <button type="button" class="btn bg-accent text-light-custom fw-bold px-4"
                        onclick="confirmDelete()">Eliminar</button>
                </div>
            </div>
        </div>

        <script>
            function showConfirmModal() {
                // Verificar si hay una fila seleccionada
                const grid = document.getElementById('<%= gvArticulos.ClientID %>');
                const selectedRow = grid.querySelector('.selected-row');

                if (!selectedRow) {
                    alert('Por favor, seleccione un artículo primero.');
                    return false;
                }

                document.getElementById('confirmModal').classList.remove('d-none');
                document.getElementById('confirmModal').style.display = 'flex';
                return false; // Evita el postback inmediato
            }

            function closeConfirmModal() {
                document.getElementById('confirmModal').classList.add('d-none');
                document.getElementById('confirmModal').style.display = 'none';
            }

            function confirmDelete() {
                closeConfirmModal();
                // Ejecutamos el postback del botón oculto para procesar la eliminación
                __doPostBack('<%= btnConfirmarEliminar.UniqueID %>', '');
            }
        </script>
    </asp:Content>