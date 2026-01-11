using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Articulo
    {
        public int Id { get; set; }

        [DisplayName("Codigo")]
        public string Codigo { get; set;}

        [DisplayName(" Nombre")]
        public string Nombre { get; set; }

        public string Descripcion { get; set; }

        [DisplayName(" Categoria")]
        public Categoria Categoria { get; set; }

        [DisplayName(" Marca")]
        public Marca Marca { get; set; }

        public string UrlImagen { get; set; }

        private decimal _precio;

        public decimal Precio 
        {
            get { return _precio; }
            set { _precio = value; }
        }

        [DisplayName(" Precio")]
        public string PrecioF
        {
            get { return _precio.ToString("C", CultureInfo.CreateSpecificCulture("es-AR"));}
        }

        private int _stock;

        [DisplayName(" Stock")]
        public int Stock
        {
            get { return _stock; }
            set { _stock = value; }
        }

        [DisplayName(" Estado")]
        public string estadoStock
        {
            get 
            { 
                return _stock > 0 ? "Disponible" : "Sin Stock";
            }
        }

        // Método para verificar si hay stock disponible
        public bool tieneStock()
        {
            return _stock > 0;
        }

        // Método para verificar si el stock es suficiente para una cantidad
        public bool stockSuficiente(int cantidad)
        {
            return _stock >= cantidad;
        }
    }
}
