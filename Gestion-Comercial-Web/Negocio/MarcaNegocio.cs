using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;
using System.Data;

namespace Negocio
{
    public class MarcaNegocio
    {
        #region Listar
        public List<Marca> listar()
        {
            List<Marca> lista = new List<Marca>();
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("SP_ListarMarcas");
                datos.setearTipoComando(CommandType.StoredProcedure);
                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    lista.Add(DataMapper.MapMarca(datos.Lector));
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

        #region CRUD
        public void agregar(Marca nueva)
        {
            AccesoDatos datos = new AccesoDatos();
            datos.setearConsulta("SP_AltaMarca");
            datos.setearTipoComando(CommandType.StoredProcedure);
            try
            {
                datos.setearParametro("@Descripcion", nueva.Descripcion);
                datos.ejecutarAccion();
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

        public void modificar(Marca existente)
        {
            AccesoDatos datos = new AccesoDatos();
            datos.setearConsulta("SP_ModificarMarca");
            datos.setearTipoComando(CommandType.StoredProcedure);
            try
            {
                datos.setearParametro("@Id", existente.Id);
                datos.setearParametro("@Descripcion", existente.Descripcion);
                datos.ejecutarAccion();
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

        public void eliminar(int id)
        {
            AccesoDatos datos = new AccesoDatos();
            datos.setearConsulta("SP_BajaMarca");
            datos.setearTipoComando(CommandType.StoredProcedure);
            try
            {
                datos.setearParametro("@Id", id);
                datos.ejecutarAccion();
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

        #region Búsqueda
        public bool buscarMarca(string descripcion)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("SP_BuscarMarcaPorDescripcion");
                datos.setearTipoComando(CommandType.StoredProcedure);
                datos.setearParametro("@Descripcion", descripcion);
                datos.ejecutarLectura();
                return datos.Lector.Read();
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
