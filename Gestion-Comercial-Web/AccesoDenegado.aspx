<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AccesoDenegado.aspx.cs"
    Inherits="Gestion_Comercial_Web.AccesoDenegado" %>

    <!DOCTYPE html>
    <html lang="es">

    <head runat="server">
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Acceso Denegado - Sistema Gestión Comercial</title>

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" />
        <!-- FontAwesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
        <!-- Custom CSS -->
        <link href="~/Content/Site.css" rel="stylesheet" type="text/css" runat="server" />

        <style>
            body {
                background: linear-gradient(135deg, var(--color-primary-dark) 0%, var(--color-background) 50%, var(--color-secondary) 100%);
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                color: var(--color-light);
                margin: 0;
                overflow: hidden;
            }

            .error-container {
                position: relative;
                z-index: 1;
                text-align: center;
                padding: 3rem;
                background: rgba(242, 227, 213, 0.1);
                backdrop-filter: blur(15px);
                border: 1px solid rgba(242, 227, 213, 0.2);
                border-radius: 24px;
                box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
                max-width: 600px;
                width: 90%;
                animation: fadeIn 0.8s ease-out;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }

                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .error-code {
                font-size: 8rem;
                font-weight: 800;
                line-height: 1;
                margin-bottom: 1rem;
                background: linear-gradient(to bottom, var(--color-light) 30%, var(--color-accent) 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                opacity: 0.9;
            }

            .error-icon {
                font-size: 4rem;
                color: var(--color-accent);
                margin-bottom: 1.5rem;
                animation: pulse 2s infinite;
            }

            @keyframes pulse {
                0% {
                    transform: scale(1);
                    opacity: 1;
                }

                50% {
                    transform: scale(1.1);
                    opacity: 0.7;
                }

                100% {
                    transform: scale(1);
                    opacity: 1;
                }
            }

            .error-title {
                font-size: 2rem;
                font-weight: 700;
                margin-bottom: 1rem;
                color: var(--color-light);
            }

            .error-message {
                font-size: 1.1rem;
                margin-bottom: 2.5rem;
                color: rgba(242, 227, 213, 0.8);
                line-height: 1.6;
            }

            .btn-premium {
                background-color: var(--color-accent);
                color: var(--color-primary-dark);
                border: none;
                padding: 12px 30px;
                font-weight: 700;
                border-radius: 12px;
                text-transform: uppercase;
                letter-spacing: 1px;
                transition: all 0.3s ease;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 10px;
            }

            .btn-premium:hover {
                background-color: var(--color-light);
                color: var(--color-primary-dark);
                transform: translateY(-3px);
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
            }

            .background-blob {
                position: absolute;
                width: 500px;
                height: 500px;
                background: var(--color-accent);
                filter: blur(80px);
                border-radius: 50%;
                z-index: 0;
                opacity: 0.15;
                animation: move 20s infinite alternate;
            }

            @keyframes move {
                from {
                    transform: translate(-10%, -10%);
                }

                to {
                    transform: translate(10%, 10%);
                }
            }
        </style>
    </head>

    <body>
        <div class="background-blob"></div>
        <form id="form1" runat="server">
            <div class="error-container">
                <div class="error-icon">
                    <i class="fas fa-shield-alt"></i>
                </div>
                <div class="error-code">403</div>
                <h1 class="error-title">Acceso Restringido</h1>
                <p class="error-message">
                    Lo sentimos, no tienes los permisos necesarios para visualizar este contenido.
                    Si crees que esto es un error, por favor contacta al administrador del sistema.
                </p>
                <div class="d-grid gap-3 d-sm-flex justify-content-sm-center">
                    <asp:HyperLink ID="hlBack" runat="server" NavigateUrl="~/Default.aspx" CssClass="btn-premium">
                        <i class="fas fa-home"></i> Volver al Inicio
                    </asp:HyperLink>
                    <asp:LinkButton ID="btnCerrarSesion" runat="server" CssClass="btn btn-outline-light-custom p-3"
                        OnClick="btnCerrarSesion_Click" style="border-radius: 12px; font-weight: 600;">
                        <i class="fas fa-sign-out-alt"></i> Cerrar Sesión
                    </asp:LinkButton>
                </div>
            </div>
        </form>
    </body>

    </html>