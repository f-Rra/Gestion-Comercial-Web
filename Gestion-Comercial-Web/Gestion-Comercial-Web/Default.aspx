<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Gestion_Comercial_Web._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="container mt-5">
        <!-- Encabezado de bienvenida -->
        <div class="row mb-5">
            <div class="col-md-8 col-xl-6 text-center mx-auto">
                <h2 class="text-primary-dark fw-bold">Panel de Administrador</h2>
            </div>
        </div>

        <!-- Grid de Cards de navegación -->
        <div class="row gy-4 row-cols-1 row-cols-md-5 align-items-start">
            
            <!-- Card 1: Artículos -->
            <div class="col">
                <div class="card shadow-sm border-0 mb-3" style="background: linear-gradient(135deg, var(--color-primary-dark) 0%, var(--color-background) 50%, var(--color-secondary) 100%); transition: all 0.3s;">
                    <a href="~/Pages/Articulos/ListaArticulos.aspx" runat="server" class="text-decoration-none">
                        <div class="card-body text-center p-4">
                            <i class="fas fa-box fa-4x mb-3" style="color: #F5EBE0;"></i>
                            <h4 class="card-title fw-bold text-light">Artículos</h4>
                        </div>
                    </a>
                </div>
                <!-- Card de items -->
                <div class="card border-0 shadow-sm align-items-start" style="background-color: var(--color-light);">
                    <div class="card-body p-3">
                        <p class="mb-2 fw-semibold">Gestión de productos</p>
                        <ul class="list-unstyled mb-0">
                            <li class="d-flex mb-2">
                                <i class="fas fa-check-circle me-2 mt-1" style="color: var(--color-primary-dark);"></i>
                                <span>Alta, baja y modificación</span>
                            </li>
                            <li class="d-flex mb-2">
                                <i class="fas fa-check-circle me-2 mt-1" style="color: var(--color-primary-dark);"></i>
                                <span>Búsqueda y filtros</span>
                            </li>
                            <li class="d-flex mb-0">
                                <i class="fas fa-check-circle me-2 mt-1" style="color: var(--color-primary-dark);"></i>
                                <span>Importar imágenes</span>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>

            <!-- Card 2: Ventas -->
            <div class="col">
                <div class="card shadow-sm border-0 mb-3" style="background: linear-gradient(135deg, var(--color-primary-dark) 0%, var(--color-background) 50%, var(--color-secondary) 100%); transition: all 0.3s;">
                    <a href="~/Pages/Ventas/NuevaVenta.aspx" runat="server" class="text-decoration-none">
                        <div class="card-body text-center p-4">
                            <i class="fas fa-shopping-cart fa-4x mb-3" style="color: #F0E5D8;"></i>
                            <h4 class="card-title fw-bold text-light">Ventas</h4>
                        </div>
                    </a>
                </div>
                <!-- Card de items -->
                <div class="card border-0 shadow-sm align-items-start" style="background-color: var(--color-light);">
                    <div class="card-body p-3">
                        <p class="mb-2 fw-semibold">Registrar nuevas ventas</p>
                        <ul class="list-unstyled mb-0">
                            <li class="d-flex mb-2">
                                <i class="fas fa-check-circle me-2 mt-1" style="color: var(--color-primary-dark);"></i>
                                <span>Nueva venta rápida</span>
                            </li>
                            <li class="d-flex mb-2">
                                <i class="fas fa-check-circle me-2 mt-1" style="color: var(--color-primary-dark);"></i>
                                <span>Historial de ventas</span>
                            </li>
                            <li class="d-flex mb-0">
                                <i class="fas fa-check-circle me-2 mt-1" style="color: var(--color-primary-dark);"></i>
                                <span>Generar tickets PDF</span>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>

            <!-- Card 3: Stock -->
            <div class="col">
                <div class="card shadow-sm border-0 mb-3" style="background: linear-gradient(135deg, var(--color-primary-dark) 0%, var(--color-background) 50%, var(--color-secondary) 100%); transition: all 0.3s;">
                    <a href="~/Pages/Stock/ControlStock.aspx" runat="server" class="text-decoration-none">
                        <div class="card-body text-center p-4">
                            <i class="fas fa-boxes fa-4x mb-3" style="color: #EDDFD0;"></i>
                            <h4 class="card-title fw-bold text-light">Stock</h4>
                        </div>
                    </a>
                </div>
                <!-- Card de items -->
                <div class="card border-0 shadow-sm align-items-start" style="background-color: var(--color-light);">
                    <div class="card-body p-3">
                        <p class="mb-2 fw-semibold">Control de inventario</p>
                        <ul class="list-unstyled mb-0">
                            <li class="d-flex mb-2">
                                <i class="fas fa-check-circle me-2 mt-1" style="color: var(--color-primary-dark);"></i>
                                <span>Consultar disponibilidad</span>
                            </li>
                            <li class="d-flex mb-2">
                                <i class="fas fa-check-circle me-2 mt-1" style="color: var(--color-primary-dark);"></i>
                                <span>Alertas de stock bajo</span>
                            </li>
                            <li class="d-flex mb-0">
                                <i class="fas fa-check-circle me-2 mt-1" style="color: var(--color-primary-dark);"></i>
                                <span>Ajustes de inventario</span>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>

            <!-- Card 4: Reportes -->
            <div class="col">
                <div class="card shadow-sm border-0 mb-3" style="background: linear-gradient(135deg, var(--color-primary-dark) 0%, var(--color-background) 50%, var(--color-secondary) 100%); transition: all 0.3s;">
                    <a href="~/Pages/Reportes/Reportes.aspx" runat="server" class="text-decoration-none">
                        <div class="card-body text-center p-4">
                            <i class="fas fa-chart-bar fa-4x mb-3" style="color: #F8F0E5;"></i>
                            <h4 class="card-title fw-bold text-light">Reportes</h4>
                        </div>
                    </a>
                </div>
                <!-- Card de items -->
                <div class="card border-0 shadow-sm align-items-start" style="background-color: var(--color-light);">
                    <div class="card-body p-3">
                        <p class="mb-2 fw-semibold">Informes y estadísticas</p>
                        <ul class="list-unstyled mb-0">
                            <li class="d-flex mb-2">
                                <i class="fas fa-check-circle me-2 mt-1" style="color: var(--color-primary-dark);"></i>
                                <span>Ventas por período</span>
                            </li>
                            <li class="d-flex mb-2">
                                <i class="fas fa-check-circle me-2 mt-1" style="color: var(--color-primary-dark);"></i>
                                <span>Productos más vendidos</span>
                            </li>
                            <li class="d-flex mb-0">
                                <i class="fas fa-check-circle me-2 mt-1" style="color: var(--color-primary-dark);"></i>
                                <span>Exportar a Excel</span>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>

            <!-- Card 5: Admin -->
            <div class="col">
                <div class="card shadow-sm border-0 mb-3" style="background: linear-gradient(135deg, var(--color-primary-dark) 0%, var(--color-background) 50%, var(--color-secondary) 100%); transition: all 0.3s;">
                    <a href="~/Pages/Admin/Usuarios.aspx" runat="server" class="text-decoration-none">
                        <div class="card-body text-center p-4">
                            <i class="fas fa-cog fa-4x mb-3" style="color: #F2E3D5;"></i>
                            <h4 class="card-title fw-bold text-light">Admin</h4>
                        </div>
                    </a>
                </div>
                <!-- Card de items -->
                <div class="card border-0 shadow-sm align-items-start" style="background-color: var(--color-light);">
                    <div class="card-body p-3">
                        <p class="mb-2 fw-semibold">Administración de usuarios</p>
                        <ul class="list-unstyled mb-0">
                            <li class="d-flex mb-2">
                                <i class="fas fa-check-circle me-2 mt-1" style="color: var(--color-primary-dark);"></i>
                                <span>Gestión de usuarios</span>
                            </li>
                            <li class="d-flex mb-2">
                                <i class="fas fa-check-circle me-2 mt-1" style="color: var(--color-primary-dark);"></i>
                                <span>Categorías y marcas</span>
                            </li>
                            <li class="d-flex mb-0">
                                <i class="fas fa-check-circle me-2 mt-1" style="color: var(--color-primary-dark);"></i>
                                <span>Configuración sistema</span>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <style>
        /* Hover effect para las cards */
        .card:hover {
            transform: translateY(-10px);
            box-shadow: 0 1rem 3rem rgba(0,0,0,.3) !important;
        }

        .card:hover i {
            transform: scale(1.15);
            transition: transform 0.3s;
            filter: brightness(1.2);
        }
    </style>

</asp:Content>