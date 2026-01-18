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
            Usuario usuario = null;
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SP_VerificarUsuario");
                datos.setearTipoComando(CommandType.StoredProcedure);
                datos.setearParametro("@NombreUsuario", nombreUsuario);
                datos.setearParametro("@Contrasena", contrasena);
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    usuario = DataMapper.MapUsuario(datos.Lector);
                }

                return usuario;
            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
        #endregion

        #region Listar
        public List<Usuario> listar()
        {
            List<Usuario> lista = new List<Usuario>();
            AccesoDatos datos = new AccesoDatos();

            try
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
            catch (Exception)
            {
                throw;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
        #endregion
    }
}
