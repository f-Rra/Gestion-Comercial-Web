<%@ Page Title="Detalles del Artículo" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeFile="DetallesArticulos.aspx.cs" Inherits="Gestion_Comercial_Web.Pages.Articulos.DetallesArticulos" %>

    <asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">


        <!-- Contenedor de Detalles del Artículo -->
        <div class="container my-4 border shadow rounded-3 p-4"
            style="background-color: var(--color-background) !important;">
            <div class="row">
                <!-- COLUMNA IZQUIERDA: Formulario -->
                <div class="col-md-8">
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="MainContent_txtIdArticulo" class="form-label"
                                style="color: var(--color-light);">ID del Artículo</label>
                            <asp:TextBox ID="txtIdArticulo" runat="server" CssClass="form-control" TextMode="Number"
                                ReadOnly="true"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label for="MainContent_txtNombre" class="form-label"
                                style="color: var(--color-light);">Nombre</label>
                            <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="MainContent_txtCodigo" class="form-label"
                                style="color: var(--color-light);">Código</label>
                            <asp:TextBox ID="txtCodigo" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label for="MainContent_txtPrecio" class="form-label"
                                style="color: var(--color-light);">Precio</label>
                            <div class="input-group">
                                <span class="input-group-text">$</span>
                                <asp:TextBox ID="txtPrecio" runat="server" CssClass="form-control" placeholder="0.00">
                                </asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="MainContent_ddlMarca" class="form-label"
                                style="color: var(--color-light);">Marca</label>
                            <asp:DropDownList ID="ddlMarca" runat="server" CssClass="form-select"></asp:DropDownList>
                        </div>
                        <div class="col-md-6">
                            <label for="MainContent_ddlCategoria" class="form-label"
                                style="color: var(--color-light);">Categoría</label>
                            <asp:DropDownList ID="ddlCategoria" runat="server" CssClass="form-select">
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="MainContent_txtUrlImagen" class="form-label"
                                style="color: var(--color-light);">URL Imagen</label>
                            <asp:TextBox ID="txtUrlImagen" runat="server" CssClass="form-control"
                                onchange="updatePreview(this.value)"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label for="MainContent_txtStock" class="form-label"
                                style="color: var(--color-light);">Stock Actual</label>
                            <asp:TextBox ID="txtStock" runat="server" CssClass="form-control" TextMode="Number">
                            </asp:TextBox>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-12">
                            <label for="MainContent_txtDescripcion" class="form-label"
                                style="color: var(--color-light);">Descripción</label>
                            <asp:TextBox ID="txtDescripcion" runat="server" CssClass="form-control" TextMode="MultiLine"
                                Rows="2"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <!-- COLUMNA DERECHA: Imagen y Botones -->
                <div class="col-md-4">
                    <div style="height: 32px;"></div>
                    <div class="mb-3 p-3 rounded border d-flex align-items-center justify-content-center"
                        style="background-color: var(--color-accent); height: 350px;">
                        <asp:Image ID="imgArticulo" runat="server" ImageUrl="~/Content/Images/not-available.png"
                            AlternateText="Imagen del artículo" CssClass="img-fluid rounded"
                            Style="max-height: 100%; max-width: 100%; object-fit: contain;"
                            onerror="this.src='/Content/Images/not-available.png';" />
                    </div>
                    <div class="d-grid gap-2">
                        <asp:Button ID="btnGuardar" runat="server" Text="Guardar Datos"
                            CssClass="btn bg-primary-dark text-light-custom fw-semibold px-4"
                            OnClick="btnGuardar_Click" />

                        <asp:Button ID="btnEditar" runat="server" Text="Habilitar Edición"
                            CssClass="btn bg-primary-dark text-light-custom fw-semibold px-4" OnClick="btnEditar_Click"
                            Visible="false" />

                        <asp:Button ID="btnVolver" runat="server" Text="Volver al Listado"
                            CssClass="btn bg-accent text-light-custom fw-semibold px-4" OnClick="btnRegresar_Click" />
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
            function updatePreview(url) {
                const img = document.getElementById('<%= imgArticulo.ClientID %>');
                img.src = url ? url : '/Content/Images/not-available.png';
            }

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