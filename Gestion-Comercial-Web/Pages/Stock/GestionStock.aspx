<%@ Page Title="Gestión de Stock" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="GestionStock.aspx.cs" Inherits="Gestion_Comercial_Web.Pages.Stock.GestionStock" %>

    <asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">



        <!-- Grid principal: 3/4 izquierda - 1/4 derecha -->
        <div class="container-fluid pb-3">
            <div class="row g-3 align-items-stretch justify-content-center">

                <!-- Panel Izquierdo (3/4) -->
                <div class="col-12 col-lg-7">
                    <div class="bg-body-secondary rounded-3 p-3 p-md-4 border shadow d-flex flex-column h-100"
                        style="background-color: var(--color-background) !important; min-height: 450px;">
                        <!-- Línea separadora superior -->
                        <hr class="w-100"
                            style="border-color: var(--color-light); opacity: 0.3; filter: blur(0.5px);" />

                        <!-- GridView -->
                        <div class="table-responsive flex-grow-1 mb-3" style="min-height: 320px; overflow-y: auto;">
                            <asp:GridView ID="gvStock" runat="server" AutoGenerateColumns="False"
                                CssClass="table table-hover w-100 gv-principal shadow-sm"
                                EmptyDataText="No hay artículos para mostrar" GridLines="None">
                                <HeaderStyle />
                                <RowStyle CssClass="selectable-row" />
                                <Columns>
                                    <asp:BoundField DataField="Codigo" HeaderText="Código" />
                                    <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                                    <asp:BoundField DataField="Categoria" HeaderText="Categoría" />
                                    <asp:BoundField DataField="Marca" HeaderText="Marca" />
                                    <asp:BoundField DataField="Precio" HeaderText="Precio" DataFormatString="{0:C}" />
                                    <asp:BoundField DataField="Stock" HeaderText="Stock" />
                                    <asp:BoundField DataField="Estado" HeaderText="Estado" />
                                </Columns>
                                <EmptyDataTemplate>
                                    <div class="estado-vacio">
                                        <i class="fas fa-inbox"></i>
                                        <p>No hay artículos para mostrar</p>
                                    </div>
                                </EmptyDataTemplate>
                            </asp:GridView>
                        </div>

                        <!-- Línea separadora inferior -->
                        <hr style="border-color: var(--color-light); opacity: 0.3; filter: blur(0.5px);" />

                        <!-- Botones de acción -->
                        <div class="d-flex flex-column flex-md-row justify-content-end mt-auto gap-2">
                            <div class="d-flex gap-2">
                                <asp:LinkButton ID="btnStockBajo" runat="server"
                                    CssClass="btn bg-primary-dark text-light-custom w-100 ms-auto fw-semibold">Stock
                                    Bajo</asp:LinkButton>
                            </div>
                            <div class="d-flex gap-2">
                                <asp:LinkButton ID="btnSinStock" runat="server"
                                    CssClass="btn bg-primary-dark text-light-custom w-100 ms-auto fw-semibold">Sin Stock
                                </asp:LinkButton>
                            </div>
                            <div class="d-flex gap-2">
                                <asp:LinkButton ID="btnMostrarTodo" runat="server"
                                    CssClass="btn bg-primary-dark text-light-custom w-100 ms-auto fw-semibold text-nowrap">
                                    Mostrar Todo</asp:LinkButton>
                            </div>
                        </div>

                    </div>
                </div>

                <!-- Panel Derecho (1/4) -->
                <div class="col-12 col-lg-3">
                    <div class="bg-body-secondary rounded-3 p-3 p-md-4 border shadow d-flex flex-column h-100"
                        style="background-color: var(--color-background) !important; min-height: 450px;">

                        <!-- Línea separadora superior -->
                        <hr style="border-color: var(--color-light); opacity: 0.3; filter: blur(0.5px);" />

                        <div class="row mb-3">
                            <div class="col-md-12">
                                <label for="MainContent_txtArticuloSeleccionado" class="form-label fw-semibold"
                                    style="color: var(--color-light);">Artículo Seleccionado</label>
                                <asp:TextBox ID="txtArticuloSeleccionado" runat="server" CssClass="form-control">
                                </asp:TextBox>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="MainContent_txtStockActual" class="form-label fw-semibold"
                                    style="color: var(--color-light);">Stock Actual</label>
                                <asp:TextBox ID="txtStockActual" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="MainContent_ddlOperacion" class="form-label fw-semibold"
                                    style="color: var(--color-light);">Tipo de Operación</label>
                                <asp:DropDownList ID="ddlOperacion" runat="server" CssClass="form-select">
                                    <asp:ListItem Text="Sumar" Value="Sumar" />
                                    <asp:ListItem Text="Restar" Value="Restar" />
                                </asp:DropDownList>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label for="MainContent_txtCantidad" class="form-label fw-semibold"
                                    style="color: var(--color-light);">Cantidad</label>
                                <asp:TextBox ID="txtCantidad" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>

                        <!-- Línea separadora inferior -->
                        <hr class="w-100"
                            style="border-color: var(--color-light); opacity: 0.3; filter: blur(0.5px);" />

                        <!-- Botones debajo -->
                        <div class="d-flex flex-row gap-2 mt-auto mb-2">
                            <asp:LinkButton ID="btnEjecutar" runat="server"
                                CssClass="btn text-light-custom fw-semibold w-50"
                                Style="background-color: var(--color-accent); border: none;">Ejecutar</asp:LinkButton>
                            <asp:LinkButton ID="btnLimpiar" runat="server"
                                CssClass="btn text-light-custom fw-semibold w-50"
                                Style="background-color: var(--color-accent); border: none;">Limpiar</asp:LinkButton>
                        </div>
                    </div>
                </div>

            </div>
        </div>



    </asp:Content>