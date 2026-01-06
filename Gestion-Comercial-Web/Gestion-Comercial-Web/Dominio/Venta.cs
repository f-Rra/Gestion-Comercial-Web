using System;
using System.Collections.Generic;
using System.ComponentModel;

namespace Dominio
{
    public class Venta
    {
        public int Id { get; set; }
        
        [DisplayName("Número de Venta")]
        public string NumeroVenta { get; set; }
        
        [DisplayName("Fecha")]
        public DateTime Fecha { get; set; }
        
        [DisplayName("Vendedor")]
        public string Vendedor { get; set; }
        
        [DisplayName("Cliente")]
        public string Cliente { get; set; }
        
        [DisplayName("Total")]
        public decimal Total { get; set; }
        
        [DisplayName("Estado")]
        public string Estado { get; set; }
        
        public List<DetalleVenta> Detalles { get; set; }
        
        public Venta()
        {
            Detalles = new List<DetalleVenta>();
            Fecha = DateTime.Now;
            Estado = "Pendiente";
        }
        
        // Método para generar número de venta único
        public string GenerarNumeroVenta()
        {
            return "V-" + DateTime.Now.ToString("yyyyMMdd") + "-" + DateTime.Now.ToString("HHmmss");
        }
        
        // Método para calcular total de la venta
        public decimal CalcularTotal()
        {
            decimal total = 0;
            foreach (var detalle in Detalles)
            {
                total += detalle.Subtotal;
            }
            Total = total;
            return total;
        }
    }
    
    public class DetalleVenta
    {
        public int Id { get; set; }
        public int IdVenta { get; set; }
        public int IdArticulo { get; set; }
        
        [DisplayName("Código")]
        public string CodigoArticulo { get; set; }
        
        [DisplayName("Artículo")]
        public string NombreArticulo { get; set; }
        
        [DisplayName("Cantidad")]
        public int Cantidad { get; set; }
        
        [DisplayName("Precio")]
        public decimal PrecioUnitario { get; set; }
        
        [DisplayName("Subtotal")]
        public decimal Subtotal { get; set; }
        
        [DisplayName("Stock Disp.")]
        public int StockDisponible { get; set; }
        
        public DetalleVenta()
        {
            Cantidad = 1;
        }
        
        // Método para calcular subtotal
        public decimal CalcularSubtotal()
        {
            Subtotal = Cantidad * PrecioUnitario;
            return Subtotal;
        }
        
        // Método para validar stock suficiente
        public bool StockSuficiente()
        {
            return StockDisponible >= Cantidad;
        }
    }
}
