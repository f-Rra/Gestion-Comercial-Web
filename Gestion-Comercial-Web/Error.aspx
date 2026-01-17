<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Error.aspx.cs" Inherits="Gestion_Comercial_Web.Error" %>

    <!DOCTYPE html>
    <html>

    <head runat="server">
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Error - Sistema Gestión Comercial</title>
        <link href="Content/bootstrap.min.css" rel="stylesheet" />
        <link href="Content/Site.css" rel="stylesheet" />
    </head>

    <body>
        <form id="form1" runat="server">
            <div class="container mt-5">
                <div class="row justify-content-center">
                    <div class="col-md-10 text-center">
                        <h1 class="display-1 text-danger">Error 500</h1>
                        <h2 class="text-dark">Ha ocurrido un problema técnico</h2>
                        <hr />
                        <div
                            style="background-color: #f8d7da; color: #721c24; padding: 20px; border-radius: 5px; text-align: left; font-family: monospace; white-space: pre-wrap; margin-bottom: 20px;">
                            <asp:Label ID="lblMensaje" runat="server"></asp:Label>
                        </div>
                        <a href="Default.aspx" class="btn btn-primary">Volver al Inicio</a>
                    </div>
                </div>
            </div>
        </form>
        <script src="Scripts/jquery-3.7.0.min.js"></script>
        <script src="Scripts/bootstrap.bundle.min.js"></script>
    </body>

    </html>