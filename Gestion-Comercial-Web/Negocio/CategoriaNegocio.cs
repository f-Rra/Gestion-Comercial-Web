using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;
using System.Data;

namespace Negocio
{
    public class CategoriaNegocio
    {
        #region Listar
        public List<Categoria> listar()
        {
            List<Categoria> lista = new List<Categoria>();
            using (AccesoDatos datos = new AccesoDatos())
            {
                datos.setearConsulta("SP_ListarCategorias");
                datos.setearTipoComando(CommandType.StoredProcedure);
                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    lista.Add(DataMapper.MapCategoria(datos.Lector));
                }
                return lista;
            }
        }
        #endregion

        #region CRUD
        public void agregar(Categoria nueva)
        {
            using (AccesoDatos datos = new AccesoDatos())
            {
                datos.setearConsulta("SP_AltaCategoria");
                datos.setearTipoComando(CommandType.StoredProcedure);
                datos.setearParametro("@Descripcion", nueva.Descripcion);
                datos.ejecutarAccion();
            }
        }

        public void modificar(Categoria existente)
        {
            using (AccesoDatos datos = new AccesoDatos())
            {
                datos.setearConsulta("SP_ModificarCategoria");
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
                datos.setearConsulta("SP_BajaCategoria");
                datos.setearTipoComando(CommandType.StoredProcedure);
                datos.setearParametro("@Id", id);
                datos.ejecutarAccion();
            }
        }
        #endregion

        #region Validaciones
        public bool buscarCategoria(string descripcion)
        {
            using (AccesoDatos datos = new AccesoDatos())
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
        }
        #endregion
    }
}
