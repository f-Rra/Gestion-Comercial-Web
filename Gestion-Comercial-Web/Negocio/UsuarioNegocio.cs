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
                    usuario = new Usuario();
                    usuario.IdUsuario = (int)datos.Lector["IdUsuario"];
                    usuario.NombreUsuario = (string)datos.Lector["NombreUsuario"];
                    usuario.EsAdministrador = (bool)datos.Lector["EsAdministrador"];
                    usuario.Estado = (bool)datos.Lector["Estado"];
                }

                return usuario;
            }
            catch (Exception ex)
            {
                throw ex;
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
                    Usuario aux = new Usuario();
                    aux.IdUsuario = (int)datos.Lector["IdUsuario"];
                    aux.NombreUsuario = (string)datos.Lector["NombreUsuario"];
                    aux.EsAdministrador = (bool)datos.Lector["EsAdministrador"];
                    // aux.Estado = (bool)datos.Lector["Estado"]; // Nota: No está en el SP sugerido por el SQL pero lo mantenemos por consistencia
                    lista.Add(aux);
                }

                return lista;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
        #endregion
    }
}
