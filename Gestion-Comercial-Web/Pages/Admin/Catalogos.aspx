<%@ Page Title="Gestión de Categorías y Marcas" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeFile="Catalogos.aspx.cs" Inherits="Gestion_Comercial_Web.Pages.Admin.Catalogos" ResponseEncoding="utf-8"
    EnableEventValidation="false" %>

    <asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" />


        <script>
            function onRowClick(gridUniqueId, row, index) {
                try {
                    var table = row.closest("table");
                    if (table) {
                        var rows = table.getElementsByTagName('tr');
                        for (var i = 0; i < rows.length; i++) {
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



        <div class="container-fluid pb-5">
            <div class="row g-4 justify-content-center">

                <!-- Columna Categorías -->
                <div class="col-12 col-md-6">
                    <div class="bg-body-secondary rounded-3 p-3 p-md-4 border shadow h-100 d-flex flex-column"
                        style="background-color: var(--color-background) !important;">
                        <h4 class="mb-1 text-center fw-bold" style="color: var(--color-light);">
                            <i class="fas fa-folder me-2 text-light-custom"></i>Categorías
                        </h4>

                        <!-- Línea separadora superior -->
                        <hr class="w-100"
                            style="border-color: var(--color-light); opacity: 0.3; filter: blur(0.5px);" />

                        <asp:UpdatePanel ID="upCategorias" runat="server" UpdateMode="Conditional"
                            ChildrenAsTriggers="true">
                            <ContentTemplate>
                                <!-- Inputs (Top: Buscar y Agregar) -->
                                <div class="d-flex justify-content-between mb-3 align-items-end">
                                    <div class="w-45">
                                        <div class="input-group input-group-sm">
                                            <asp:TextBox ID="txtBuscarCategoria" runat="server" CssClass="form-control"
                                                Placeholder="Buscar categoría..." AutoPostBack="true"
                                                OnTextChanged="txtBuscarCategoria_TextChanged">
                                            </asp:TextBox>
                                            <asp:LinkButton ID="btnBuscarCategoria" runat="server"
                                                CssClass="btn bg-primary-dark text-light-custom border-0"
                                                OnClick="txtBuscarCategoria_TextChanged">
                                                <i class="fas fa-search"></i>
                                            </asp:LinkButton>
                                        </div>
                                    </div>
                                    <div class="w-45">
                                        <div class="input-group input-group-sm">
                                            <asp:TextBox ID="txtNuevaCategoria" runat="server" CssClass="form-control"
                                                Placeholder="Agregar categoría...">
                                            </asp:TextBox>
                                            <asp:LinkButton ID="btnAgregarCategoria" runat="server"
                                                CssClass="btn bg-primary-dark text-light-custom border-0"
                                                OnClick="btnAgregarCategoria_Click">
                                                <i class="fas fa-plus"></i>
                                            </asp:LinkButton>
                                        </div>
                                    </div>
                                </div>

                                <!-- GridView -->
                                <div class="table-responsive flex-grow-1 rounded-2">
                                    <asp:GridView ID="gvCategorias" runat="server"
                                        CssClass="table table-hover w-100 gv-principal shadow-sm mb-0" GridLines="None"
                                        AutoGenerateColumns="False" DataKeyNames="Id"
                                        OnSelectedIndexChanged="gvCategorias_SelectedIndexChanged"
                                        OnRowDataBound="gvCategorias_RowDataBound" EmptyDataText="No hay datos"
                                        ShowHeaderWhenEmpty="true" AllowPaging="true" PageSize="6"
                                        OnPageIndexChanging="gvCategorias_PageIndexChanging">
                                        <HeaderStyle />
                                        <RowStyle CssClass="selectable-row" />
                                        <Columns>
                                            <asp:BoundField DataField="Id" HeaderText="ID" ItemStyle-Width="50px" />
                                            <asp:BoundField DataField="descripcion" HeaderText="Descripción" />
                                        </Columns>
                                        <PagerStyle CssClass="paginacion py-2" />
                                    </asp:GridView>
                                </div>
                                <!-- Línea separadora inferior -->
                                <hr class="w-100"
                                    style="border-color: var(--color-light); opacity: 0.3; filter: blur(0.5px);" />

                                <!-- Botones de Acción (Editar/Eliminar - Bottom) -->
                                <div class="d-flex justify-content-center mt-auto gap-2">
                                    <asp:Button ID="btnEditarCategoria" runat="server" Text="Editar"
                                        CssClass="btn text-light-custom fw-semibold bg-accent"
                                        Style="width: 25%; border: none;" OnClick="btnEditarCategoria_Click" />
                                    <asp:Button ID="btnEliminarCategoria" runat="server" Text="Eliminar"
                                        CssClass="btn text-light-custom fw-semibold bg-accent"
                                        Style="width: 25%; border: none;"
                                        OnClientClick="return showConfirmModal('Categoria');" />
                                    <asp:Button ID="btnConfirmarEliminarCat" runat="server" style="display:none;"
                                        OnClick="btnEliminarCategoria_Click" />
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>

                    </div>
                </div>

                <!-- Columna Marcas -->
                <div class="col-12 col-md-6">
                    <div class="bg-body-secondary rounded-3 p-3 p-md-4 border shadow h-100 d-flex flex-column"
                        style="background-color: var(--color-background) !important;">
                        <h4 class="mb-1 text-center fw-bold" style="color: var(--color-light);">
                            <i class="fas fa-tag me-2 text-light-custom"></i>Marcas
                        </h4>

                        <!-- Línea separadora superior -->
                        <hr class="w-100"
                            style="border-color: var(--color-light); opacity: 0.3; filter: blur(0.5px);" />

                        <asp:UpdatePanel ID="upMarcas" runat="server" UpdateMode="Conditional"
                            ChildrenAsTriggers="true">
                            <ContentTemplate>
                                <!-- Inputs (Top: Buscar y Agregar) -->
                                <div class="d-flex justify-content-between mb-3 align-items-end">
                                    <div class="w-45">
                                        <div class="input-group input-group-sm">
                                            <asp:TextBox ID="txtBuscarMarca" runat="server" CssClass="form-control"
                                                Placeholder="Buscar marca..." AutoPostBack="true"
                                                OnTextChanged="txtBuscarMarca_TextChanged"></asp:TextBox>
                                            <asp:LinkButton ID="btnBuscarMarca" runat="server"
                                                CssClass="btn bg-primary-dark text-light-custom border-0"
                                                OnClick="txtBuscarMarca_TextChanged">
                                                <i class="fas fa-search"></i>
                                            </asp:LinkButton>
                                        </div>
                                    </div>
                                    <div class="w-45">
                                        <div class="input-group input-group-sm">
                                            <asp:TextBox ID="txtNuevaMarca" runat="server" CssClass="form-control"
                                                Placeholder="Agregar marca..."></asp:TextBox>
                                            <asp:LinkButton ID="btnAgregarMarca" runat="server"
                                                CssClass="btn bg-primary-dark text-light-custom border-0"
                                                OnClick="btnAgregarMarca_Click">
                                                <i class="fas fa-plus"></i>
                                            </asp:LinkButton>
                                        </div>
                                    </div>
                                </div>

                                <!-- GridView -->
                                <div class="table-responsive flex-grow-1 rounded-2">
                                    <asp:GridView ID="gvMarcas" runat="server"
                                        CssClass="table table-hover w-100 gv-principal shadow-sm mb-0" GridLines="None"
                                        AutoGenerateColumns="False" DataKeyNames="Id"
                                        OnSelectedIndexChanged="gvMarcas_SelectedIndexChanged"
                                        OnRowDataBound="gvMarcas_RowDataBound" EmptyDataText="No hay datos"
                                        ShowHeaderWhenEmpty="true" AllowPaging="true" PageSize="6"
                                        OnPageIndexChanging="gvMarcas_PageIndexChanging">
                                        <HeaderStyle />
                                        <RowStyle CssClass="selectable-row" />
                                        <Columns>
                                            <asp:BoundField DataField="Id" HeaderText="ID" ItemStyle-Width="50px" />
                                            <asp:BoundField DataField="descripcion" HeaderText="Descripción" />
                                        </Columns>
                                        <PagerStyle CssClass="paginacion py-2" />
                                    </asp:GridView>
                                </div>
                                <!-- Línea separadora inferior -->
                                <hr class="w-100"
                                    style="border-color: var(--color-light); opacity: 0.3; filter: blur(0.5px);" />

                                <!-- Botones de Acción (Editar/Eliminar - Bottom) -->
                                <div class="d-flex justify-content-center mt-auto gap-2">
                                    <asp:Button ID="btnEditarMarca" runat="server" Text="Editar"
                                        CssClass="btn text-light-custom fw-semibold bg-accent"
                                        Style="width: 25%; border: none;" OnClick="btnEditarMarca_Click" />
                                    <asp:Button ID="btnEliminarMarca" runat="server" Text="Eliminar"
                                        CssClass="btn text-light-custom fw-semibold bg-accent"
                                        Style="width: 25%; border: none;"
                                        OnClientClick="return showConfirmModal('Marca');" />
                                    <asp:Button ID="btnConfirmarEliminarMar" runat="server" style="display:none;"
                                        OnClick="btnEliminarMarca_Click" />
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </div>

            </div>
        </div>

        <!-- Modal Unificado ABM -->
        <div class="modal fade" id="modalABM" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true"
            data-bs-backdrop="static">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content border-0 shadow-lg">
                    <div class="modal-header bg-primary-dark text-light-custom">
                        <h5 class="modal-title fw-bold" id="modalLabel">
                            <asp:Label ID="lblModalTitle" runat="server" Text="Gestión"></asp:Label>
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                            aria-label="Close"></button>
                    </div>
                    <div class="modal-body p-4 bg-light-custom">
                        <asp:UpdatePanel ID="upModal" runat="server">
                            <ContentTemplate>
                                <asp:HiddenField ID="hfTipoEntidad" runat="server" /> <!-- Categoria o Marca -->
                                <asp:HiddenField ID="hfIdEntidad" runat="server" />

                                <div class="mb-3">
                                    <label for="txtNombre" class="form-label fw-semibold">Nombre</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-pen"></i></span>
                                        <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control"
                                            placeholder="Ingrese el nombre..."></asp:TextBox>
                                    </div>
                                    <asp:RequiredFieldValidator ID="rfvNombre" runat="server"
                                        ControlToValidate="txtNombre" ErrorMessage="El nombre es obligatorio."
                                        CssClass="text-danger small fw-bold" Display="Dynamic" ValidationGroup="ABM">
                                    </asp:RequiredFieldValidator>
                                </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                    <div class="modal-footer bg-light-custom border-top-0">
                        <button type="button" class="btn btn-outline-secondary"
                            data-bs-dismiss="modal">Cancelar</button>
                        <asp:Button ID="btnGuardar" runat="server" Text="Guardar Cambios"
                            CssClass="btn bg-primary-dark text-light-custom shadow-sm" OnClick="btnGuardar_Click"
                            ValidationGroup="ABM" />
                    </div>
                </div>
            </div>
        </div>



        <%-- Notificaciones ahora centralizadas en Site.Master --%>

            <!-- Modal de Confirmación ABM -->
            <div id="confirmModalABM" class="d-none"
                style="position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.6); backdrop-filter: blur(5px); z-index: 9999; display: flex; align-items: center; justify-content: center;">
                <div class="bg-primary-dark text-light-custom p-4 rounded-3 shadow-lg text-center border border-light border-opacity-25"
                    style="max-width: 400px; width: 90%;">
                    <i class="fas fa-exclamation-triangle fa-3x mb-3 text-warning"></i>
                    <h4 class="mb-3">¿Estás seguro?</h4>
                    <p class="mb-4 opacity-75">Esta acción eliminará el elemento seleccionado de forma permanente.</p>
                    <div class="d-flex gap-2 justify-content-center">
                        <button type="button" class="btn btn-outline-light-custom px-4"
                            onclick="closeConfirmModal()">Cancelar</button>
                        <button type="button" class="btn bg-accent text-light-custom fw-bold px-4"
                            onclick="confirmDelete()">Eliminar</button>
                    </div>
                </div>
            </div>

            <asp:HiddenField ID="hfConfirmDeleteType" runat="server" />
            <script type="text/javascript">
                let deleteType = '';

                function showModal() {
                    var myModal = new bootstrap.Modal(document.getElementById('modalABM'));
                    myModal.show();
                }

                function showConfirmModal(type) {
                    deleteType = type;
                    // Verificar seleccion
                    const gridId = type === 'Categoria' ? '<%= gvCategorias.ClientID %>' : '<%= gvMarcas.ClientID %>';
                    const grid = document.getElementById(gridId);
                    const selectedRow = grid.querySelector('.selected-row');

                    if (!selectedRow) {
                        showNotification('Validación', 'Por favor, seleccione un elemento primero.', true);
                        return false;
                    }

                    document.getElementById('confirmModalABM').classList.remove('d-none');
                    document.getElementById('confirmModalABM').style.display = 'flex';
                    return false;
                }

                function closeConfirmModal() {
                    document.getElementById('confirmModalABM').classList.add('d-none');
                    document.getElementById('confirmModalABM').style.display = 'none';
                }

                function confirmDelete() {
                    closeConfirmModal();
                    if (deleteType === 'Categoria') {
                        __doPostBack('<%= btnConfirmarEliminarCat.UniqueID %>', '');
                    } else {
                        __doPostBack('<%= btnConfirmarEliminarMar.UniqueID %>', '');
                    }
                }
            </script>

    </asp:Content>