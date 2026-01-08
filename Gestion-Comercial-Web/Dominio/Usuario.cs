using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Dominio
{
    public class Usuario
    {
        public int IdUsuario { get; set; }
        public string NombreUsuario { get; set; }
        public string Contrasena { get; set; }
        public bool EsAdministrador { get; set; }
        public bool Estado { get; set; }

        public Usuario()
        {
            Estado = true;
            EsAdministrador = false;
        }
    }
}