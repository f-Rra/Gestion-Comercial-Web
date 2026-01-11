<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs" Inherits="Gestion_Comercial_Web._Default" %>

    <asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

        <!-- Jumbotron -->
        <div class="container my-3">
            <div class="p-5 text-center bg-body-tertiary rounded-3 border shadow">
                <div class="d-inline-block">
                    <h1 style="color: var(--color-primary-dark);">Panel de Administrador</h1>
                    <hr
                        style="border-color: var(--color-primary-dark); opacity: 0.3; margin: 0.5rem 0; filter: blur(0.5px);" />
                </div>
                <p class="lead mb-0">
                    Gestione todos los módulos del sistema desde aquí
                </p>
            </div>
        </div>

        <div class="container mt-4">
            <!-- Grid de Cards de navegación -->
            <div class="row gy-4 row-cols-1 row-cols-md-4 align-items-start">

                <!-- Card 1: Artículos -->
                <div class="col">
                    <div class="card shadow-sm border-0 mb-3"
                        style="background: linear-gradient(135deg, var(--color-primary-dark) 0%, var(--color-background) 50%, var(--color-secondary) 100%); transition: all 0.3s;">
                        <a href="~/Pages/Articulos/ListaArticulos.aspx" runat="server" class="text-decoration-none">
                            <div class="card-body text-center p-4">
                                <i class="fas fa-box fa-4x mb-3" style="color: #F5EBE0;"></i>
                                <h4 class="card-title fw-bold text-light">Artículos</h4>
                            </div>
                        </a>
                    </div>
                    <!-- Card de items -->
                    <div class="card border-0 shadow-sm align-items-start"
                        style="background-color: var(--color-light);">
                        <div class="card-body p-3">
                            <p class="mb-2 fw-semibold">Gestión de productos</p>
                            <ul class="list-unstyled mb-0">
                                <li class="d-flex mb-2">
                                    <i class="fas fa-check-circle me-2 mt-1"
                                        style="color: var(--color-primary-dark);"></i>
                                    <span>Alta, baja y modificación</span>
                                </li>
                                <li class="d-flex mb-2">
                                    <i class="fas fa-check-circle me-2 mt-1"
                                        style="color: var(--color-primary-dark);"></i>
                                    <span>Búsqueda y filtros</span>
                                </li>
                                <li class="d-flex mb-0">
                                    <i class="fas fa-check-circle me-2 mt-1"
                                        style="color: var(--color-primary-dark);"></i>
                                    <span>Importar imágenes</span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>

                <!-- Card 2: Catálogos -->
                <div class="col">
                    <div class="card shadow-sm border-0 mb-3"
                        style="background: linear-gradient(135deg, var(--color-primary-dark) 0%, var(--color-background) 50%, var(--color-secondary) 100%); transition: all 0.3s;">
                        <a href="~/Pages/Admin/Catalogos.aspx" runat="server" class="text-decoration-none">
                            <div class="card-body text-center p-4">
                                <i class="fas fa-layer-group fa-4x mb-3" style="color: #F0E5D8;"></i>
                                <h4 class="card-title fw-bold text-light">Catálogos</h4>
                            </div>
                        </a>
                    </div>
                    <!-- Card de items -->
                    <div class="card border-0 shadow-sm align-items-start"
                        style="background-color: var(--color-light);">
                        <div class="card-body p-3">
                            <p class="mb-2 fw-semibold">Gestión de catálogos</p>
                            <ul class="list-unstyled mb-0">
                                <li class="d-flex mb-2">
                                    <i class="fas fa-check-circle me-2 mt-1"
                                        style="color: var(--color-primary-dark);"></i>
                                    <span>Categorías y Marcas</span>
                                </li>
                                <li class="d-flex mb-2">
                                    <i class="fas fa-check-circle me-2 mt-1"
                                        style="color: var(--color-primary-dark);"></i>
                                    <span>Alta, baja y modificación</span>
                                </li>
                                <li class="d-flex mb-0">
                                    <i class="fas fa-check-circle me-2 mt-1"
                                        style="color: var(--color-primary-dark);"></i>
                                    <span>Organización centralizada</span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>

                <!-- Card 4: Stock -->
                <div class="col">
                    <div class="card shadow-sm border-0 mb-3"
                        style="background: linear-gradient(135deg, var(--color-primary-dark) 0%, var(--color-background) 50%, var(--color-secondary) 100%); transition: all 0.3s;">
                        <a href="~/Pages/Stock/GestionStock.aspx" runat="server" class="text-decoration-none">
                            <div class="card-body text-center p-4">
                                <i class="fas fa-boxes fa-4x mb-3" style="color: #F8F0E5;"></i>
                                <h4 class="card-title fw-bold text-light">Stock</h4>
                            </div>
                        </a>
                    </div>
                    <!-- Card de items -->
                    <div class="card border-0 shadow-sm align-items-start"
                        style="background-color: var(--color-light);">
                        <div class="card-body p-3">
                            <p class="mb-2 fw-semibold">Control de inventario</p>
                            <ul class="list-unstyled mb-0">
                                <li class="d-flex mb-2">
                                    <i class="fas fa-check-circle me-2 mt-1"
                                        style="color: var(--color-primary-dark);"></i>
                                    <span>Consultar disponibilidad</span>
                                </li>
                                <li class="d-flex mb-2">
                                    <i class="fas fa-check-circle me-2 mt-1"
                                        style="color: var(--color-primary-dark);"></i>
                                    <span>Alertas de stock bajo</span>
                                </li>
                                <li class="d-flex mb-0">
                                    <i class="fas fa-check-circle me-2 mt-1"
                                        style="color: var(--color-primary-dark);"></i>
                                    <span>Ajustes de inventario</span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>

                <!-- Card 5: Reportes -->
                <div class="col">
                    <div class="card shadow-sm border-0 mb-3"
                        style="background: linear-gradient(135deg, var(--color-primary-dark) 0%, var(--color-background) 50%, var(--color-secondary) 100%); transition: all 0.3s;">
                        <a href="~/Pages/Reportes/ReporteInventario.aspx" runat="server" class="text-decoration-none">
                            <div class="card-body text-center p-4">
                                <i class="fas fa-chart-bar fa-4x mb-3" style="color: #F2E3D5;"></i>
                                <h4 class="card-title fw-bold text-light">Reportes</h4>
                            </div>
                        </a>
                    </div>
                    <!-- Card de items -->
                    <div class="card border-0 shadow-sm align-items-start"
                        style="background-color: var(--color-light);">
                        <div class="card-body p-3">
                            <p class="mb-2 fw-semibold">Informes y estadísticas</p>
                            <ul class="list-unstyled mb-0">
                                <li class="d-flex mb-2">
                                    <i class="fas fa-check-circle me-2 mt-1"
                                        style="color: var(--color-primary-dark);"></i>
                                    <span>Artículos por categoría</span>
                                </li>
                                <li class="d-flex mb-2">
                                    <i class="fas fa-check-circle me-2 mt-1"
                                        style="color: var(--color-primary-dark);"></i>
                                    <span>Stock bajo mínimo</span>
                                </li>
                                <li class="d-flex mb-0">
                                    <i class="fas fa-check-circle me-2 mt-1"
                                        style="color: var(--color-primary-dark);"></i>
                                    <span>Exportar a Excel</span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>

            </div>

            <!-- Footer -->
            <footer class="d-flex flex-wrap justify-content-between align-items-center py-3 my-4 border-top">
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
            </footer>
        </div>

        <style>
            /* Hover effect para las cards */
            .card:hover {
                transform: translateY(-10px);
                box-shadow: 0 1rem 3rem rgba(0, 0, 0, .3) !important;
            }

            .card:hover i {
                transform: scale(1.15);
                transition: transform 0.3s;
                filter: brightness(1.2);
            }
        </style>

    </asp:Content>