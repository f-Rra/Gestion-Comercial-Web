<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Error.aspx.cs" Inherits="Gestion_Comercial_Web.Error" %>

    <!DOCTYPE html>
    <html lang="es">

    <head runat="server">
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Error - Sistema Gestión Comercial</title>

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" />
        <!-- FontAwesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
        <!-- Custom CSS -->
        <link href="~/Content/Site.css" rel="stylesheet" type="text/css" runat="server" />

        <style>
            body {
                background: linear-gradient(135deg, #4b1212 0%, #1a0505 50%, #000000 100%);
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
                background: rgba(255, 255, 255, 0.05);
                backdrop-filter: blur(20px);
                border: 1px solid rgba(255, 255, 255, 0.1);
                border-radius: 24px;
                box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.7);
                max-width: 800px;
                width: 90%;
                animation: slideIn 0.6s cubic-bezier(0.16, 1, 0.3, 1);
            }

            @keyframes slideIn {
                from {
                    opacity: 0;
                    transform: scale(0.9) translateY(30px);
                }

                to {
                    opacity: 1;
                    transform: scale(1) translateY(0);
                }
            }

            .error-icon {
                font-size: 5rem;
                color: #ff4d4d;
                margin-bottom: 1.5rem;
                filter: drop-shadow(0 0 15px rgba(255, 77, 77, 0.4));
            }

            .error-title {
                font-size: 2.5rem;
                font-weight: 800;
                margin-bottom: 1rem;
                color: #ffffff;
            }

            .error-subtitle {
                font-size: 1.25rem;
                color: rgba(255, 255, 255, 0.7);
                margin-bottom: 2rem;
            }

            .error-details-box {
                background: rgba(0, 0, 0, 0.3);
                border-left: 4px solid #ff4d4d;
                padding: 20px;
                border-radius: 8px;
                text-align: left;
                margin-bottom: 2.5rem;
                font-family: 'Consolas', 'Monaco', monospace;
                max-height: 250px;
                overflow-y: auto;
                font-size: 0.9rem;
                color: #eccaca;
                box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.5);
            }

            .error-details-box::-webkit-scrollbar {
                width: 6px;
            }

            .error-details-box::-webkit-scrollbar-thumb {
                background: rgba(255, 77, 77, 0.3);
                border-radius: 3px;
            }

            .btn-retry {
                background: linear-gradient(135deg, #ff4d4d 0%, #cc0000 100%);
                color: white;
                border: none;
                padding: 14px 35px;
                font-weight: 700;
                border-radius: 12px;
                text-transform: uppercase;
                letter-spacing: 1px;
                transition: all 0.3s ease;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 12px;
                box-shadow: 0 10px 20px -5px rgba(255, 77, 77, 0.4);
            }

            .btn-retry:hover {
                transform: translateY(-3px);
                box-shadow: 0 15px 30px -10px rgba(255, 77, 77, 0.6);
                color: white;
            }

            .background-glow {
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                width: 600px;
                height: 600px;
                background: radial-gradient(circle, rgba(255, 77, 77, 0.15) 0%, transparent 70%);
                z-index: 0;
                pointer-events: none;
            }
        </style>
    </head>

    <body>
        <div class="background-glow"></div>
        <form id="form1" runat="server">
            <div class="error-container">
                <div class="error-icon">
                    <i class="fas fa-exclamation-triangle"></i>
                </div>
                <h1 class="error-title">¡Ups! Algo salió mal</h1>
                <p class="error-subtitle">Se ha producido un error inesperado en el sistema.</p>

                <div class="error-details-box">
                    <i class="fas fa-bug me-2"></i><strong>Detalles técnicos:</strong>
                    <hr style="opacity: 0.2; margin: 10px 0;" />
                    <asp:Label ID="lblMensaje" runat="server" Text="No hay detalles disponibles."></asp:Label>
                </div>

                <div class="d-flex justify-content-center gap-3">
                    <a href="Default.aspx" class="btn-retry">
                        <i class="fas fa-sync-alt"></i> Intentar de nuevo
                    </a>
                    <a href="mailto:soporte@tuempresa.com" class="btn btn-outline-light p-3"
                        style="border-radius: 12px; font-weight: 600; opacity: 0.8;">
                        <i class="fas fa-envelope"></i> Contactar Soporte
                    </a>
                </div>
            </div>
        </form>
    </body>

    </html>