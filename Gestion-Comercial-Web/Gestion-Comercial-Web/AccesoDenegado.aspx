<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AccesoDenegado.aspx.cs" Inherits="Gestion_Comercial_Web.AccesoDenegado" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Acceso Denegado - Sistema Gestión Comercial</title>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <link href="Content/Site.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-md-6 text-center">
                    <h1 class="display-1 text-danger">403</h1>
                    <h2 class="text-light-custom">Acceso Denegado</h2>
                    <p class="lead text-light-custom">No tienes permisos suficientes para acceder a esta página.</p>
                    <a href="Default.aspx" class="btn btn-primary mt-3">Volver al Inicio</a>
                </div>
            </div>
        </div>
    </form>
    <script src="Scripts/jquery-3.7.0.min.js"></script>
    <script src="Scripts/bootstrap.bundle.min.js"></script>
</body>
</html>
