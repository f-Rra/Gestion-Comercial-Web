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
            using (AccesoDatos datos = new AccesoDatos())
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
        }
        #endregion

        #region CRUD
        public void agregar(Marca nueva)
        {
            using (AccesoDatos datos = new AccesoDatos())
            {
                datos.setearConsulta("SP_AltaMarca");
                datos.setearTipoComando(CommandType.StoredProcedure);
                datos.setearParametro("@Descripcion", nueva.Descripcion);
                datos.ejecutarAccion();
            }
        }

        public void modificar(Marca existente)
        {
            using (AccesoDatos datos = new AccesoDatos())
            {
                datos.setearConsulta("SP_ModificarMarca");
                datos.setearTipoComando(CommandType.StoredProcedure);
                datos.setearParametro("@Id", existente.Id);
                datos.setearParametro("@Descripcion", existente.Descripcion);
                datos.ejecutarAccion();
            }
        }

        public void eliminar(int id)
        {
            using (AccesoDatos datos = new AccesoDatos())
            {
                datos.setearConsulta("SP_BajaMarca");
                datos.setearTipoComando(CommandType.StoredProcedure);
                datos.setearParametro("@Id", id);
                datos.ejecutarAccion();
            }
        }
        #endregion

        #region Búsqueda
        public bool buscarMarca(string descripcion)
        {
            using (AccesoDatos datos = new AccesoDatos())
            {
                datos.setearConsulta("SP_BuscarMarcaPorDescripcion");
                datos.setearTipoComando(CommandType.StoredProcedure);
                datos.setearParametro("@Descripcion", descripcion);
                datos.ejecutarLectura();
                return datos.Lector.Read();
            }
        }
        #endregion
    }
}
