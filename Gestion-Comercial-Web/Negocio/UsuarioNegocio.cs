using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;
using System.Data;

namespace Negocio
{
    public class UsuarioNegocio
    {
        #region Autenticación
        public Usuario validarCredenciales(string nombreUsuario, string contrasena)
        {
            using (AccesoDatos datos = new AccesoDatos())
            {
                datos.setearConsulta("SP_VerificarUsuario");
                datos.setearTipoComando(CommandType.StoredProcedure);
                datos.setearParametro("@NombreUsuario", nombreUsuario);
                datos.setearParametro("@Contrasena", contrasena);
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    return DataMapper.MapUsuario(datos.Lector);
                }

                return null;
            }
        }
        #endregion

        #region Listar
        public List<Usuario> listar()
        {
            List<Usuario> lista = new List<Usuario>();
            using (AccesoDatos datos = new AccesoDatos())
            {
                datos.setearConsulta("SP_ListarUsuarios");
                datos.setearTipoComando(CommandType.StoredProcedure);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    lista.Add(DataMapper.MapUsuario(datos.Lector));
                }

                return lista;
            }
        }
        #endregion
    }
}
