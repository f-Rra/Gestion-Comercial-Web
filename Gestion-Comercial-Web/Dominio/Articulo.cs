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
        public int id { get; set; }

        [DisplayName("Codigo")]
        public string codigo { get; set;}

        [DisplayName(" Nombre")]
        public string nombre { get; set; }

        public string descripcion { get; set; }

        [DisplayName(" Categoria")]
        public Categoria categoria { get; set; }

        [DisplayName(" Marca")]
        public Marca marca { get; set; }

        public string urlImagen { get; set; }

        private decimal _precio;

        public decimal precio 
        {
            get { return _precio; }
            set { _precio = value; }
        }

        [DisplayName(" Precio")]
        public string precioF
        {
            get { return _precio.ToString("C", CultureInfo.CreateSpecificCulture("es-AR"));}
        }

        private int _stock;

        [DisplayName(" Stock")]
        public int stock
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
