<%@ Page Title="Lista de Artículos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="ListaArticulos.aspx.cs" Inherits="Gestion_Comercial_Web.Pages.Articulos.ListaArticulos"
    EnableEventValidation="false" %>

    <asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

        <style>
            .selected-row {
                background-color: rgba(0, 123, 255, 0.1) !important;
                border-left: 4px solid var(--color-accent) !important;
            }

            .selectable-row {
                cursor: pointer;
                transition: all 0.2s;
            }

            .selectable-row:hover {
                background-color: rgba(0, 0, 0, 0.05) !important;
            }

            .gv-white-bg {
                background-color: white !important;
            }

            .table-responsive::-webkit-scrollbar {
                width: 8px;
            }

            .table-responsive::-webkit-scrollbar-thumb {
                background: var(--color-primary-dark);
                border-radius: 4px;
            }

            /* Estilo para la paginación */
            .pagination-container table {
                margin: 20px auto 20px auto;
            }

            .pagination-container td {
                padding: 0 2px;
            }

            .pagination-container a,
            .pagination-container span {
                display: block;
                padding: 6px 12px;
                border: 1px solid #dee2e6;
                text-decoration: none;
                color: var(--color-primary-dark);
                background-color: #fff;
                border-radius: 4px;
            }

            .pagination-container span {
                background-color: var(--color-primary-dark);
                color: #fff;
                border-color: var(--color-primary-dark);
            }

            .pagination-container a:hover {
                background-color: #e9ecef;
            }

            .table th,
            .table td {
                text-align: center;
                vertical-align: middle;
            }
        </style>

        <script>
            function onRowClick(row, index) {
                // Seleccion simple: limpia los demas y marca el actual
                const grid = document.getElementById('<%= gvArticulos.ClientID %>');
                const rows = grid.getElementsByTagName('tr');
                for (let i = 1; i < rows.length; i++) {
                    rows[i].classList.remove('selected-row');
                }
                row.classList.add('selected-row');

                // Disparamos el postback para que se actualice la vista previa en el servidor
                __doPostBack('<%= gvArticulos.UniqueID %>', 'Select$' + index);
            }
        </script>

        <!-- Jumbotron -->
        <div class="container my-3">
            <div class="p-5 text-center bg-body-tertiary rounded-3 border shadow">
                <div class="d-inline-block">
                    <h1 style="color: var(--color-primary-dark);">Gestión de Artículos</h1>
                    <hr
                        style="border-color: var(--color-primary-dark); opacity: 0.3; margin: 0.5rem 0; filter: blur(0.5px);" />
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
                    <div class="bg-body-secondary rounded-3 p-3 p-md-4 border shadow d-flex flex-column h-100"
                        style="background-color: var(--color-background) !important; min-height: 450px;">

                        <!-- Filtros de búsqueda -->
                        <div class="row mb-3 g-2">
                            <div class="col-12 col-md-3">
                                <label class="form-label text-light fw-semibold small mb-1">Campo:</label>
                                <asp:DropDownList ID="ddlCampo" runat="server" CssClass="form-select form-select-sm">
                                    <asp:ListItem Selected="True" Value="Nombre">Nombre</asp:ListItem>
                                    <asp:ListItem Value="Codigo">Código</asp:ListItem>
                                    <asp:ListItem Value="Categoria">Categoría</asp:ListItem>
                                    <asp:ListItem Value="Marca">Marca</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-12 col-md-3">
                                <label class="form-label text-light fw-semibold small mb-1">Criterio:</label>
                                <asp:DropDownList ID="ddlCriterio" runat="server" CssClass="form-select form-select-sm">
                                    <asp:ListItem Selected="True" Value="Comienza">Comienza con</asp:ListItem>
                                    <asp:ListItem Value="Termina">Termina con</asp:ListItem>
                                    <asp:ListItem Value="Contiene">Contiene</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-12 col-md-6">
                                <label class="form-label text-light fw-semibold small mb-1">Búsqueda rápida:</label>
                                <div class="input-group input-group-sm">
                                    <asp:TextBox ID="txtFiltro" runat="server" CssClass="form-control"
                                        placeholder="Escriba para buscar..." AutoPostBack="true"
                                        OnTextChanged="txtFiltro_TextChanged"
                                        onkeyup="if(this.value.length >= 2 || this.value.length == 0) { setTimeout(() => { __doPostBack('<%= txtFiltro.UniqueID %>', ''); }, 300); }">
                                    </asp:TextBox>
                                    <asp:LinkButton ID="btnBuscar" runat="server" OnClick="btnBuscar_Click"
                                        CssClass="btn bg-primary-dark text-light border-0">
                                        <i class="fas fa-search"></i>
                                    </asp:LinkButton>
                                </div>
                            </div>
                        </div>

                        <!-- Línea separadora superior -->
                        <hr style="border-color: var(--color-light); opacity: 0.3; filter: blur(0.5px);" />

                        <!-- GridView -->
                        <div class="table-responsive mb-3" style="height: 320px; overflow-y: auto;">
                            <asp:GridView ID="gvArticulos" runat="server"
                                CssClass="table table-hover w-100 gv-white-bg shadow-sm" GridLines="None"
                                AutoGenerateColumns="False" DataKeyNames="Id"
                                OnSelectedIndexChanged="gvArticulos_SelectedIndexChanged"
                                OnRowDataBound="gvArticulos_RowDataBound_Fix" AllowPaging="true" PageSize="5"
                                OnPageIndexChanging="gvArticulos_PageIndexChanging"
                                EmptyDataText="No hay artículos para mostrar">
                                <PagerStyle CssClass="pagination-container py-3" />
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
                                    <asp:BoundField DataField="Precio" HeaderText="Precio" DataFormatString="{0:C2}" />
                                    <asp:BoundField DataField="Stock" HeaderText="Stock" ItemStyle-CssClass="fw-bold" />
                                    <asp:BoundField DataField="estadoStock" HeaderText="Estado" />
                                </Columns>
                                <EmptyDataTemplate>
                                    <div class="text-center text-muted py-5">
                                        <i class="fas fa-box-open fa-3x mb-3 d-block" style="opacity:0.3"></i>
                                        <p class="mb-0">No se encontraron artículos con ese filtro</p>
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

        <!-- Modal de Confirmación Premium -->
        <div id="confirmModal" class="d-none"
            style="position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.6); backdrop-filter: blur(5px); z-index: 9999; display: flex; align-items: center; justify-content: center;">
            <div class="bg-primary-dark text-light p-4 rounded-3 shadow-lg text-center border border-light border-opacity-25"
                style="max-width: 400px; width: 90%;">
                <i class="fas fa-exclamation-triangle fa-3x mb-3 text-warning"></i>
                <h4 class="mb-3">¿Estás seguro?</h4>
                <p class="mb-4 opacity-75">Esta acción eliminará el artículo de forma permanente del listado activo.</p>
                <div class="d-flex gap-2 justify-content-center">
                    <button type="button" class="btn btn-outline-light px-4"
                        onclick="closeConfirmModal()">Cancelar</button>
                    <button type="button" class="btn bg-accent text-light fw-bold px-4"
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