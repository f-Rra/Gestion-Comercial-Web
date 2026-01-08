<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Gestion_Comercial_Web.Login" ResponseEncoding="utf-8" %>

<!DOCTYPE html>
<html data-bs-theme="light" lang="es">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no" />
    <title>Login - Sistema Gestión Comercial</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- FontAwesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <!-- Custom CSS -->
    <link href="Content/Site.css" rel="stylesheet" />
</head>
<body class="login-page">
    <form id="form1" runat="server">
        <div class="container">
            <div class="row justify-content-center align-items-center" style="min-height: 100vh; font-size: 18px;">
                <div class="col-md-5 col-lg-4 col-xxl-4">
                    <!-- Card de Login -->
                    <div class="card shadow-lg">
                        <div class="card-body p-5">
                            <!-- Logo y Título -->
                            <div class="text-center mb-4">
                                <img class="img-fluid mb-3" src="Content/Images/login.png" alt="Logo" style="width: 120px;" />
                                <h3 class="fs-2 fw-bold text-primary-dark">Gestión Comercial</h3>
                            </div>

                            <!-- Panel de error -->
                            <asp:Panel ID="pnlError" runat="server" CssClass="alert alert-danger" Visible="false">
                                <i class="fas fa-exclamation-triangle me-2"></i>
                                <asp:Label ID="lblError" runat="server"></asp:Label>
                            </asp:Panel>

                            <!-- Campo Usuario -->
                            <div class="mb-3">
                                <label class="form-label text-primary-dark" for="txtUsuario">
                                    <i class="fas fa-user me-1"></i> Usuario
                                </label>
                                <asp:TextBox ID="txtUsuario" runat="server" 
                                             CssClass="form-control form-control-lg" 
                                             placeholder="Ingresa tu usuario" 
                                             MaxLength="50"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvUsuario" runat="server" 
                                    ControlToValidate="txtUsuario"
                                    ErrorMessage="El usuario es requerido"
                                    CssClass="text-danger small"
                                    Display="Dynamic">
                                </asp:RequiredFieldValidator>
                            </div>

                            <!-- Campo Contraseña -->
                            <div class="mb-3">
                                <label class="form-label text-primary-dark" for="txtContrasena">
                                    <i class="fas fa-lock me-1"></i> Contraseña
                                </label>
                                <asp:TextBox ID="txtContrasena" runat="server" 
                                             TextMode="Password"
                                             CssClass="form-control form-control-lg" 
                                             placeholder="Ingresa tu contraseña" 
                                             MaxLength="50"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvContrasena" runat="server" 
                                    ControlToValidate="txtContrasena"
                                    ErrorMessage="La contraseña es requerida"
                                    CssClass="text-danger small"
                                    Display="Dynamic">
                                </asp:RequiredFieldValidator>
                            </div>

                            <!-- Botón Ingresar -->
                            <div class="d-grid mt-5">
                                <asp:Button ID="btnIngresar" runat="server" 
                                            Text="Ingresar" 
                                            CssClass="btn btn-lg bg-primary-dark text-white" 
                                            OnClick="btnIngresar_Click" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <!-- jQuery -->
    <script src="Scripts/jquery-3.7.0.min.js"></script>
    <!-- Bootstrap JS -->
    <script src="Scripts/bootstrap.bundle.min.js"></script>
</body>
</html>
