<%@ Page Title="Plantilla Base" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ScriptManager ID="smMain" runat="server" />

    <div class="container-xxl py-3">
        <div class="bg-primary-subtle border rounded-3 p-3 p-md-4 mb-4 d-flex align-items-center gap-3">
            <div class="bg-primary text-white rounded-2 p-2 d-inline-flex fs-3">
                <i class="fa-solid fa-file-lines"></i>
            </div>
            <div>
                <h2 class="mb-0 fw-semibold">Título de la Página</h2>
                <p class="lead text-body-secondary mb-0">Subtítulo o descripción breve</p>
            </div>
        </div>

        <div class="mb-4"></div>

        <footer class="border-top pt-3 mt-5 small text-body-secondary d-flex justify-content-between align-items-center">
            <span>Versión 1.0 • Sistema de Gestión Comercial</span>
            <span>
                <a href="https://github.com/" class="text-decoration-none me-2"><i class="fab fa-github"></i></a>
                <a href="#" class="text-decoration-none"><i class="fab fa-linkedin"></i></a>
            </span>
        </footer>
    </div>
</asp:Content>

<asp:Content ID="ScriptsContent" ContentPlaceHolderID="scripts" runat="server">
</asp:Content>
