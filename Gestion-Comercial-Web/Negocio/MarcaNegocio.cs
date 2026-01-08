using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;

namespace Negocio
{
    public class MarcaNegocio
    {
        public List<Marca> listar()
        {
            List<Marca> lista = new List<Marca>();
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("SP_ListarMarcas");
                datos.setearTipoComando(System.Data.CommandType.StoredProcedure);
                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                   Marca aux = new Marca();
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

        public void agregar(Marca nueva)
        {
            AccesoDatos datos = new AccesoDatos();
            datos.setearConsulta("SP_AltaMarca");
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

        public void modificar(Marca existente)
        {
            AccesoDatos datos = new AccesoDatos();
            datos.setearConsulta("SP_ModificarMarca");
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
            datos.setearConsulta("SP_BajaMarca");
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

        public bool buscarMarca(string descripcion)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("SP_BuscarMarcaPorDescripcion");
                datos.setearTipoComando(System.Data.CommandType.StoredProcedure);
                datos.setearParametro("@Descripcion", descripcion);
                datos.ejecutarLectura();
                return datos.Lector.Read();
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
