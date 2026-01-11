<%@ Page Title="Gestión de Categorías y Marcas" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Catalogos.aspx.cs" Inherits="Gestion_Comercial_Web.Pages.Admin.Catalogos" ResponseEncoding="utf-8" %>

    <asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" />

        <!-- Jumbotron -->
        <div class="container my-3">
            <div class="p-5 text-center bg-body-tertiary rounded-3 border shadow">
                <div class="d-inline-block">
                    <h1 style="color: var(--color-primary-dark);">Gestión de Catálogos</h1>
                    <hr
                        style="border-color: var(--color-primary-dark); opacity: 0.3; margin: 0.5rem 0; filter: blur(0.5px);" />
                </div>
                <p class="lead mb-0">
                    Administre las Categorías y Marcas del sistema en un solo lugar
                </p>
            </div>
        </div>

        <div class="container-fluid pb-5">
            <div class="row g-4 justify-content-center">

                <!-- Columna Categorías -->
                <div class="col-12 col-md-6">
                    <div class="bg-body-secondary rounded-3 p-3 p-md-4 border shadow h-100 d-flex flex-column"
                        style="background-color: var(--color-background) !important;">
                        <h4 class="mb-1 text-center fw-bold" style="color: var(--color-light);">
                            <i class="fas fa-folder me-2"></i>Categorías
                        </h4>

                        <!-- Línea separadora superior -->
                        <hr class="w-100"
                            style="border-color: var(--color-light); opacity: 0.3; filter: blur(0.5px);" />

                        <!-- Inputs (Top: Buscar y Agregar) -->
                        <div class="d-flex justify-content-between mb-3 align-items-end">
                            <div class="w-45">
                                <div class="input-group">
                                    <asp:TextBox ID="txtBuscarCategoria" runat="server"
                                        CssClass="form-control flex-grow-1" Placeholder="Buscar Categoría..."
                                        AutoPostBack="true" OnTextChanged="txtBuscarCategoria_TextChanged">
                                    </asp:TextBox>
                                    <asp:Button ID="btnBuscarCategoria" runat="server" Text="Buscar"
                                        CssClass="btn bg-primary-dark text-light-custom fw-semibold"
                                        OnClick="txtBuscarCategoria_TextChanged" />
                                </div>
                            </div>
                            <div class="w-45">
                                <div class="input-group">
                                    <asp:TextBox ID="txtNuevaCategoria" runat="server"
                                        CssClass="form-control flex-grow-1" Placeholder="Nueva Categoría...">
                                    </asp:TextBox>
                                    <asp:Button ID="btnAgregarCategoria" runat="server" Text="Agregar"
                                        CssClass="btn bg-primary-dark text-light-custom fw-semibold"
                                        OnClick="btnAgregarCategoria_Click" />
                                </div>
                            </div>
                        </div>

                        <!-- GridView -->
                        <div class="table-responsive flex-grow-1 mb-3 rounded-2"
                            style="max-height: 400px; overflow-y: auto;">
                            <asp:GridView ID="gvCategorias" runat="server"
                                CssClass="table table-striped table-hover text-center mb-0" AutoGenerateColumns="False"
                                DataKeyNames="Id" OnSelectedIndexChanged="gvCategorias_SelectedIndexChanged"
                                OnRowCommand="gvCategorias_RowCommand" EmptyDataText="No hay datos"
                                ShowHeaderWhenEmpty="true" HeaderStyle-BackColor="#012E40"
                                HeaderStyle-ForeColor="White">
                                <Columns>
                                    <asp:CommandField ShowSelectButton="True" SelectText="<i class='fas fa-check'></i>"
                                        ControlStyle-CssClass="text-secondary" />
                                    <asp:BoundField DataField="Id" HeaderText="ID" ItemStyle-Width="50px" />
                                    <asp:BoundField DataField="descripcion" HeaderText="Descripción" />
                                </Columns>
                            </asp:GridView>
                        </div>

                        <!-- Línea separadora inferior -->
                        <hr class="w-100"
                            style="border-color: var(--color-light); opacity: 0.3; filter: blur(0.5px);" />

                        <!-- Botones de Acción (Editar/Eliminar - Bottom) -->
                        <div class="d-flex justify-content-center mt-auto gap-2">
                            <asp:Button ID="btnEditarCategoria" runat="server" Text="Editar"
                                CssClass="btn text-light-custom fw-semibold"
                                Style="background-color: var(--color-accent); width: 25%; border: none;"
                                OnClick="btnEditarCategoria_Click" />
                            <asp:Button ID="btnEliminarCategoria" runat="server" Text="Eliminar"
                                CssClass="btn text-light-custom fw-semibold"
                                Style="background-color: var(--color-accent); width: 25%; border: none;"
                                OnClick="btnEliminarCategoria_Click"
                                OnClientClick="return confirm('¿Eliminar selección?');" />
                        </div>

                    </div>
                </div>

                <!-- Columna Marcas -->
                <div class="col-12 col-md-6">
                    <div class="bg-body-secondary rounded-3 p-3 p-md-4 border shadow h-100 d-flex flex-column"
                        style="background-color: var(--color-background) !important;">
                        <h4 class="mb-1 text-center fw-bold" style="color: var(--color-light);">
                            <i class="fas fa-tag me-2"></i>Marcas
                        </h4>

                        <!-- Línea separadora superior -->
                        <hr class="w-100"
                            style="border-color: var(--color-light); opacity: 0.3; filter: blur(0.5px);" />

                        <!-- Inputs (Top: Buscar y Agregar) -->
                        <div class="d-flex justify-content-between mb-3 align-items-end">
                            <div class="w-45">
                                <div class="input-group">
                                    <asp:TextBox ID="txtBuscarMarca" runat="server" CssClass="form-control flex-grow-1"
                                        Placeholder="Buscar Marca..." AutoPostBack="true"
                                        OnTextChanged="txtBuscarMarca_TextChanged"></asp:TextBox>
                                    <asp:Button ID="btnBuscarMarca" runat="server" Text="Buscar"
                                        CssClass="btn bg-primary-dark text-light-custom fw-semibold"
                                        OnClick="txtBuscarMarca_TextChanged" />
                                </div>
                            </div>
                            <div class="w-45">
                                <div class="input-group">
                                    <asp:TextBox ID="txtNuevaMarca" runat="server" CssClass="form-control flex-grow-1"
                                        Placeholder="Nueva Marca..."></asp:TextBox>
                                    <asp:Button ID="btnAgregarMarca" runat="server" Text="Agregar"
                                        CssClass="btn bg-primary-dark text-light-custom fw-semibold"
                                        OnClick="btnAgregarMarca_Click" />
                                </div>
                            </div>
                        </div>

                        <!-- GridView -->
                        <div class="table-responsive flex-grow-1 mb-3 rounded-2"
                            style="max-height: 400px; overflow-y: auto;">
                            <asp:GridView ID="gvMarcas" runat="server"
                                CssClass="table table-striped table-hover text-center mb-0" AutoGenerateColumns="False"
                                DataKeyNames="Id" OnSelectedIndexChanged="gvMarcas_SelectedIndexChanged"
                                OnRowCommand="gvMarcas_RowCommand" EmptyDataText="No hay datos"
                                ShowHeaderWhenEmpty="true" HeaderStyle-BackColor="#012E40"
                                HeaderStyle-ForeColor="White">
                                <Columns>
                                    <asp:CommandField ShowSelectButton="True" SelectText="<i class='fas fa-check'></i>"
                                        ControlStyle-CssClass="text-secondary" />
                                    <asp:BoundField DataField="Id" HeaderText="ID" ItemStyle-Width="50px" />
                                    <asp:BoundField DataField="descripcion" HeaderText="Descripción" />
                                </Columns>
                            </asp:GridView>
                        </div>

                        <!-- Línea separadora inferior -->
                        <hr class="w-100"
                            style="border-color: var(--color-light); opacity: 0.3; filter: blur(0.5px);" />

                        <!-- Botones de Acción (Editar/Eliminar - Bottom) -->
                        <div class="d-flex justify-content-center mt-auto gap-2">
                            <asp:Button ID="btnEditarMarca" runat="server" Text="Editar"
                                CssClass="btn text-light-custom fw-semibold"
                                Style="background-color: var(--color-accent); width: 25%; border: none;"
                                OnClick="btnEditarMarca_Click" />
                            <asp:Button ID="btnEliminarMarca" runat="server" Text="Eliminar"
                                CssClass="btn text-light-custom fw-semibold"
                                Style="background-color: var(--color-accent); width: 25%; border: none;"
                                OnClick="btnEliminarMarca_Click"
                                OnClientClick="return confirm('¿Eliminar selección?');" />
                        </div>
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
                    <div class="modal-body p-4 bg-light">
                        <asp:UpdatePanel ID="upModal" runat="server">
                            <ContentTemplate>
                                <asp:HiddenField ID="hfTipoEntidad" runat="server" /> <!-- Categoria o Marca -->
                                <asp:HiddenField ID="hfIdEntidad" runat="server" />

                                <div class="mb-3">
                                    <label for="txtNombre" class="form-label fw-semibold">Nombre</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-white"><i class="fas fa-pen"></i></span>
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
                    <div class="modal-footer bg-light border-top-0">
                        <button type="button" class="btn btn-outline-secondary"
                            data-bs-dismiss="modal">Cancelar</button>
                        <asp:Button ID="btnGuardar" runat="server" Text="Guardar Cambios"
                            CssClass="btn bg-primary-dark text-light-custom shadow-sm" OnClick="btnGuardar_Click"
                            ValidationGroup="ABM" />
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

        <!-- Script para abrir modal desde backend -->
        <script type="text/javascript">
            function showModal() {
                var myModal = new bootstrap.Modal(document.getElementById('modalABM'));
                myModal.show();
            }
        </script>

    </asp:Content>