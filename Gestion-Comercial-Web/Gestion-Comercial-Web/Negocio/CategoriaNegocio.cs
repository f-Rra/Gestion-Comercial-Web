using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;

namespace Negocio
{
    public class CategoriaNegocio
    {
        public List<Categoria> listar()
        {
            List<Categoria> lista = new List<Categoria>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SP_ListarCategorias");
                datos.setearTipoComando(System.Data.CommandType.StoredProcedure);
                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    Categoria aux = new Categoria();
                    aux.id = (int)datos.Lector["Id"];
                    aux.descripcion = (string)datos.Lector["Descripcion"];
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

        public void agregar(Categoria nueva)
        {
            AccesoDatos datos = new AccesoDatos();
            datos.setearConsulta("SP_AltaCategoria");
            datos.setearTipoComando(System.Data.CommandType.StoredProcedure);
            try
            {
                datos.setearParametro("@Descripcion", nueva.descripcion);
                datos.ejecutarAccion();
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

        public void modificar(Categoria existente)
        {
            AccesoDatos datos = new AccesoDatos();
            datos.setearConsulta("SP_ModificarCategoria");
            datos.setearTipoComando(System.Data.CommandType.StoredProcedure);
            try
            {
                datos.setearParametro("@Id", existente.id);
                datos.setearParametro("@Descripcion", existente.descripcion);
                datos.ejecutarAccion();
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

        public void eliminar(int id)
        {
            AccesoDatos datos = new AccesoDatos();
            datos.setearConsulta("SP_BajaCategoria");
            datos.setearTipoComando(System.Data.CommandType.StoredProcedure);
            try
            {
                datos.setearParametro("@Id", id);
                datos.ejecutarAccion();
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

        public bool buscarCategoria(string descripcion)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("SELECT COUNT(*) FROM Categorias WHERE Descripcion = @Descripcion");
                datos.setearParametro("@Descripcion", descripcion);
                datos.ejecutarLectura();
                
                if (datos.Lector.Read())
                {
                    return Convert.ToInt32(datos.Lector[0]) > 0;
                }
                
                return false;
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
    }
}
