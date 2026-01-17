<%@ Page Title="Reporte de Inventario" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="ReporteInventario.aspx.cs" Inherits="Gestion_Comercial_Web.Pages.Reportes.ReporteInventario"
    ResponseEncoding="utf-8" %>

    <asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">



        <!-- Parrilla de Reportes Disponibles (1 fila de 12) -->
        <div class="container mt-4 mb-4">
            <div class="row row-cols-2 row-cols-md-4 row-cols-lg-6 row-cols-xl-12 g-3">

                <!-- Card: Por Categorías -->
                <div class="col">
                    <div class="card shadow-sm border-0 h-100"
                        style="background: linear-gradient(135deg, var(--color-primary-dark) 0%, var(--color-background) 50%, var(--color-secondary) 100%); transition: all 0.3s;">
                        <asp:LinkButton ID="btnPorCategorias" runat="server" CssClass="text-decoration-none"
                            OnClick="btnPorCategorias_Click">
                            <div class="card-body text-center p-2">
                                <i class="fas fa-chart-bar fa-2x mb-1" style="color: var(--color-light);"></i>
                                <h6 class="card-title fw-bold text-light-custom mb-0" style="font-size: 0.75rem;">Por
                                    Categorías</h6>
                            </div>
                        </asp:LinkButton>
                    </div>
                </div>

                <!-- Card: Por Marcas -->
                <div class="col">
                    <div class="card shadow-sm border-0 h-100"
                        style="background: linear-gradient(135deg, var(--color-primary-dark) 0%, var(--color-background) 50%, var(--color-secondary) 100%); transition: all 0.3s;">
                        <asp:LinkButton ID="btnPorMarcas" runat="server" CssClass="text-decoration-none"
                            OnClick="btnPorMarcas_Click">
                            <div class="card-body text-center p-2">
                                <i class="fas fa-tags fa-2x mb-1" style="color: var(--color-light);"></i>
                                <h6 class="card-title fw-bold text-light-custom mb-0" style="font-size: 0.75rem;">Por
                                    Marcas
                                </h6>
                            </div>
                        </asp:LinkButton>
                    </div>
                </div>

                <!-- Card: Stock por Marcas -->
                <div class="col">
                    <div class="card shadow-sm border-0 h-100"
                        style="background: linear-gradient(135deg, var(--color-primary-dark) 0%, var(--color-background) 50%, var(--color-secondary) 100%); transition: all 0.3s;">
                        <asp:LinkButton ID="btnStockPorMarcas" runat="server" CssClass="text-decoration-none"
                            OnClick="btnStockPorMarcas_Click">
                            <div class="card-body text-center p-2">
                                <i class="fas fa-boxes fa-2x mb-1" style="color: var(--color-light);"></i>
                                <h6 class="card-title fw-bold text-light-custom mb-0" style="font-size: 0.75rem;">Stock
                                    por
                                    Marcas</h6>
                            </div>
                        </asp:LinkButton>
                    </div>
                </div>

                <!-- Card: Stock por Categorías -->
                <div class="col">
                    <div class="card shadow-sm border-0 h-100"
                        style="background: linear-gradient(135deg, var(--color-primary-dark) 0%, var(--color-background) 50%, var(--color-secondary) 100%); transition: all 0.3s;">
                        <asp:LinkButton ID="btnStockPorCategorias" runat="server" CssClass="text-decoration-none"
                            OnClick="btnStockPorCategorias_Click">
                            <div class="card-body text-center p-2">
                                <i class="fas fa-box fa-2x mb-1" style="color: var(--color-light);"></i>
                                <h6 class="card-title fw-bold text-light-custom mb-0" style="font-size: 0.75rem;">Stock
                                    por
                                    Categorías</h6>
                            </div>
                        </asp:LinkButton>
                    </div>
                </div>

                <!-- Card: Ventas Detalladas -->
                <div class="col">
                    <div class="card shadow-sm border-0 h-100"
                        style="background: linear-gradient(135deg, var(--color-primary-dark) 0%, var(--color-background) 50%, var(--color-secondary) 100%); transition: all 0.3s;">
                        <asp:LinkButton ID="btnVentasDetalladas" runat="server" CssClass="text-decoration-none"
                            OnClick="btnVentasDetalladas_Click">
                            <div class="card-body text-center p-2">
                                <i class="fas fa-clipboard-list fa-2x mb-1" style="color: var(--color-light);"></i>
                                <h6 class="card-title fw-bold text-light-custom mb-0" style="font-size: 0.75rem;">Ventas
                                    Detalladas</h6>
                            </div>
                        </asp:LinkButton>
                    </div>
                </div>

                <!-- Card: Top Vendedores -->
                <div class="col">
                    <div class="card shadow-sm border-0 h-100"
                        style="background: linear-gradient(135deg, var(--color-primary-dark) 0%, var(--color-background) 50%, var(--color-secondary) 100%); transition: all 0.3s;">
                        <asp:LinkButton ID="btnTopVendedores" runat="server" CssClass="text-decoration-none"
                            OnClick="btnTopVendedores_Click">
                            <div class="card-body text-center p-2">
                                <i class="fas fa-trophy fa-2x mb-1" style="color: var(--color-light);"></i>
                                <h6 class="card-title fw-bold text-light-custom mb-0" style="font-size: 0.75rem;">Top
                                    Vendedores</h6>
                            </div>
                        </asp:LinkButton>
                    </div>
                </div>

                <!-- Card: Sin Stock -->
                <div class="col">
                    <div class="card shadow-sm border-0 h-100"
                        style="background: linear-gradient(135deg, var(--color-primary-dark) 0%, var(--color-background) 50%, var(--color-secondary) 100%); transition: all 0.3s;">
                        <asp:LinkButton ID="btnSinStock" runat="server" CssClass="text-decoration-none"
                            OnClick="btnSinStock_Click">
                            <div class="card-body text-center p-2">
                                <i class="fas fa-times-circle fa-2x mb-1" style="color: var(--color-light);"></i>
                                <h6 class="card-title fw-bold text-light-custom mb-0" style="font-size: 0.75rem;">Sin
                                    Stock
                                </h6>
                            </div>
                        </asp:LinkButton>
                    </div>
                </div>

                <!-- Card: Bajo Stock -->
                <div class="col">
                    <div class="card shadow-sm border-0 h-100"
                        style="background: linear-gradient(135deg, var(--color-primary-dark) 0%, var(--color-background) 50%, var(--color-secondary) 100%); transition: all 0.3s;">
                        <asp:LinkButton ID="btnBajoStock" runat="server" CssClass="text-decoration-none"
                            OnClick="btnBajoStock_Click">
                            <div class="card-body text-center p-2">
                                <i class="fas fa-exclamation-triangle fa-2x mb-1"
                                    style="color: var(--color-light);"></i>
                                <h6 class="card-title fw-bold text-light-custom mb-0" style="font-size: 0.75rem;">Bajo
                                    Stock
                                </h6>
                            </div>
                        </asp:LinkButton>
                    </div>
                </div>

                <!-- Card: Más Vendidos -->
                <div class="col">
                    <div class="card shadow-sm border-0 h-100"
                        style="background: linear-gradient(135deg, var(--color-primary-dark) 0%, var(--color-background) 50%, var(--color-secondary) 100%); transition: all 0.3s;">
                        <asp:LinkButton ID="btnMasVendidos" runat="server" CssClass="text-decoration-none"
                            OnClick="btnMasVendidos_Click">
                            <div class="card-body text-center p-2">
                                <i class="fas fa-fire fa-2x mb-1" style="color: var(--color-light);"></i>
                                <h6 class="card-title fw-bold text-light-custom mb-0" style="font-size: 0.75rem;">Más
                                    Vendidos
                                </h6>
                            </div>
                        </asp:LinkButton>
                    </div>
                </div>

                <!-- Card: Ventas por Fecha -->
                <div class="col">
                    <div class="card shadow-sm border-0 h-100"
                        style="background: linear-gradient(135deg, var(--color-primary-dark) 0%, var(--color-background) 50%, var(--color-secondary) 100%); transition: all 0.3s;">
                        <asp:LinkButton ID="btnVentasPorFecha" runat="server" CssClass="text-decoration-none"
                            OnClick="btnVentasPorFecha_Click">
                            <div class="card-body text-center p-2">
                                <i class="fas fa-calendar-alt fa-2x mb-1" style="color: var(--color-light);"></i>
                                <h6 class="card-title fw-bold text-light-custom mb-0" style="font-size: 0.75rem;">Ventas
                                    por
                                    Fecha</h6>
                            </div>
                        </asp:LinkButton>
                    </div>
                </div>

                <!-- Card: Inventario Completo -->
                <div class="col">
                    <div class="card shadow-sm border-0 h-100"
                        style="background: linear-gradient(135deg, var(--color-primary-dark) 0%, var(--color-background) 50%, var(--color-secondary) 100%); transition: all 0.3s;">
                        <asp:LinkButton ID="btnInventarioCompleto" runat="server" CssClass="text-decoration-none"
                            OnClick="btnInventarioCompleto_Click">
                            <div class="card-body text-center p-2">
                                <i class="fas fa-clipboard-list fa-2x mb-1" style="color: var(--color-light);"></i>
                                <h6 class="card-title fw-bold text-light-custom mb-0" style="font-size: 0.75rem;">
                                    Inventario
                                    Completo</h6>
                            </div>
                        </asp:LinkButton>
                    </div>
                </div>

                <!-- Card: Resumen Diario -->
                <div class="col">
                    <div class="card shadow-sm border-0 h-100"
                        style="background: linear-gradient(135deg, var(--color-primary-dark) 0%, var(--color-background) 50%, var(--color-secondary) 100%); transition: all 0.3s;">
                        <asp:LinkButton ID="btnResumenDiario" runat="server" CssClass="text-decoration-none"
                            OnClick="btnResumenDiario_Click">
                            <div class="card-body text-center p-2">
                                <i class="fas fa-calendar-day fa-2x mb-1" style="color: var(--color-light);"></i>
                                <h6 class="card-title fw-bold text-light-custom mb-0" style="font-size: 0.75rem;">
                                    Resumen
                                    Diario</h6>
                            </div>
                        </asp:LinkButton>
                    </div>
                </div>

            </div>
        </div>

        <!-- Panel de Filtros y Resultados -->
        <div class="container-fluid pb-3">
            <div class="row g-3 justify-content-center">
                <div class="col-12 col-lg-10">
                    <div class="rounded-3 p-3 p-md-4 border shadow"
                        style="background-color: var(--color-background) !important;">

                        <!-- Filtros de Fecha y Exportar -->
                        <div class="row mb-3 align-items-end">
                            <div class="col-12 col-md-3">
                                <label class="form-label fw-semibold" style="color: var(--color-light);">Desde:</label>
                                <asp:TextBox ID="txtFechaDesde" runat="server" TextMode="Date" CssClass="form-control">
                                </asp:TextBox>
                            </div>
                            <div class="col-12 col-md-3">
                                <label class="form-label fw-semibold" style="color: var(--color-light);">Hasta:</label>
                                <asp:TextBox ID="txtFechaHasta" runat="server" TextMode="Date" CssClass="form-control">
                                </asp:TextBox>
                            </div>
                            <div class="col-12 col-md-6 text-end">
                                <asp:Button ID="btnExportarPDF" runat="server" Text="Exportar PDF"
                                    CssClass="btn bg-primary-dark text-light-custom fw-semibold"
                                    OnClick="btnExportarPDF_Click"
                                    OnClientClick="showNotification('¡Listo!', 'El reporte se ha generado y descargado correctamente.', false); return true;" />
                            </div>
                        </div>

                        <!-- Línea separadora superior -->
                        <hr style="border-color: var(--color-light); opacity: 0.3; filter: blur(0.5px);" />

                        <!-- Título del Reporte Actual -->
                        <div class="mb-3">
                            <h4 class="fw-bold" style="color: var(--color-light);">
                                <asp:Label ID="lblTituloReporte" runat="server" Text="Inventario Completo"></asp:Label>
                            </h4>
                        </div>

                        <!-- GridView de Resultados -->
                        <div class="table-responsive" style="max-height: 480px; overflow-y: auto;">
                            <asp:GridView ID="gvReporte" runat="server"
                                CssClass="table table-hover w-100 gv-principal shadow-sm mt-3"
                                AutoGenerateColumns="True" EmptyDataText="No hay datos para mostrar" GridLines="None">
                                <HeaderStyle />
                                <RowStyle CssClass="selectable-row" />
                                <EmptyDataTemplate>
                                    <div class="text-center text-muted py-4">
                                        <i class="fas fa-inbox fa-3x mb-3 d-block"></i>
                                        <p class="mb-0">No hay datos para mostrar. Seleccione un reporte.</p>
                                    </div>
                                </EmptyDataTemplate>
                            </asp:GridView>
                        </div>

                        <!-- Línea separadora inferior -->
                        <hr class="w-100"
                            style="border-color: var(--color-light); opacity: 0.3; filter: blur(0.5px);" />

                    </div>
                </div>
            </div>
        </div>



        <!-- Estilos para hover de cards -->
        <style>
            .card:hover {
                transform: translateY(-5px);
                box-shadow: 0 1rem 3rem rgba(0, 0, 0, .3) !important;
            }

            .card:hover i {
                transform: scale(1.1);
                transition: transform 0.3s;
                filter: brightness(1.2);
            }
        </style>

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