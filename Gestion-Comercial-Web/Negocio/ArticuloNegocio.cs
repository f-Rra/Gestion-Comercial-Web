using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;
using System.Data;

namespace Negocio
{
    public class ArticuloNegocio
    {
        #region Consultas e IDs
        public List<Articulo> listar()
        {
            List<Articulo> lista = new List<Articulo>();
            using (AccesoDatos datos = new AccesoDatos())
            {
                datos.setearConsulta("SELECT * FROM vw_ArticulosCompletos");
                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    lista.Add(DataMapper.MapArticulo(datos.Lector));
                }
                return lista;
            }
        }

        public List<Articulo> filtrar(string campo, string criterio, string filtro)
        {
            List<Articulo> lista = new List<Articulo>();
            using (AccesoDatos datos = new AccesoDatos())
            {
                string consulta = "SELECT * FROM vw_ArticulosCompletos WHERE ";
                string columna = "";

                switch (campo)
                {
                    case "Nombre": columna = "Nombre"; break;
                    case "Codigo": columna = "Codigo"; break;
                    case "Categoria": columna = "Categoria"; break;
                    case "Marca": columna = "Marca"; break;
                    default: columna = "Nombre"; break;
                }

                switch (criterio)
                {
                    case "Comienza":
                        consulta += columna + " LIKE @filtro + '%'";
                        break;
                    case "Termina":
                        consulta += columna + " LIKE '%' + @filtro";
                        break;
                    default:
                        consulta += columna + " LIKE '%' + @filtro + '%'";
                        break;
                }

                datos.setearConsulta(consulta);
                datos.setearParametro("@filtro", filtro);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    lista.Add(DataMapper.MapArticulo(datos.Lector));
                }
                return lista;
            }
        }

        public int ultimoID()
        {
            using (AccesoDatos datos = new AccesoDatos())
            {
                datos.setearConsulta("SELECT MAX(Id) AS UltimoID FROM Articulos");
                datos.ejecutarLectura();
                if (datos.Lector.Read())
                {
                    return (int)datos.Lector["UltimoID"];
                }
                else
                {
                    throw new Exception("No se pudo obtener el ultimo ID");
                }
            }
        }

        public Articulo buscarPorId(int id)
        {
            using (AccesoDatos datos = new AccesoDatos())
            {
                datos.setearConsulta("SELECT * FROM vw_ArticulosCompletos WHERE Id = @Id");
                datos.setearParametro("@Id", id);
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    return DataMapper.MapArticulo(datos.Lector);
                }
                return null;
            }
        }
        #endregion

        #region CRUD (Alta, Modificación, Baja)
        public void agregar(Articulo nuevo)
        {
            using (AccesoDatos datos = new AccesoDatos())
            {
                datos.setearConsulta("SP_AltaArticulo");
                datos.setearTipoComando(CommandType.StoredProcedure);
                datos.setearParametro("@Codigo", nuevo.Codigo);
                datos.setearParametro("@Nombre", nuevo.Nombre);
                datos.setearParametro("@Descripcion", nuevo.Descripcion);
                datos.setearParametro("@IdMarca", nuevo.Marca.Id);
                datos.setearParametro("@IdCategoria", nuevo.Categoria.Id);
                datos.setearParametro("@ImagenUrl", nuevo.UrlImagen);
                datos.setearParametro("@Precio", nuevo.Precio);
                datos.setearParametro("@Stock", nuevo.Stock);
                datos.ejecutarAccion();
            }
        }

        public void modificar(Articulo existente)
        {
            using (AccesoDatos datos = new AccesoDatos())
            {
                datos.setearConsulta("SP_ModificarArticulo");
                datos.setearTipoComando(CommandType.StoredProcedure);
                datos.setearParametro("@Codigo", existente.Codigo);
                datos.setearParametro("@Nombre", existente.Nombre);
                datos.setearParametro("@Descripcion", existente.Descripcion);
                datos.setearParametro("@IdMarca", existente.Marca.Id);
                datos.setearParametro("@IdCategoria", existente.Categoria.Id);
                datos.setearParametro("@ImagenUrl", existente.UrlImagen);
                datos.setearParametro("@Precio", existente.Precio);
                datos.setearParametro("@Stock", existente.Stock);
                datos.setearParametro("@Id", existente.Id);
                datos.ejecutarAccion();
            }
        }

        public void bajaFisica(int id)
        {
            using (AccesoDatos datos = new AccesoDatos())
            {
                datos.setearConsulta("DELETE FROM Articulos WHERE Id = @ID");
                datos.setearParametro("@ID", id);
                datos.ejecutarAccion();
            }
        }

        public void bajaLogica(int id)
        {
            using (AccesoDatos datos = new AccesoDatos())
            {
                datos.setearConsulta("SP_BajaArticulo");
                datos.setearTipoComando(CommandType.StoredProcedure);
                datos.setearParametro("@Id", id);
                datos.ejecutarAccion();
            }
        }
        #endregion

        #region Gestión de Stock e Inventario
        public void actualizarStock(int idArticulo, int nuevoStock)
        {
            using (AccesoDatos datos = new AccesoDatos())
            {
                datos.setearConsulta("SP_ActualizarStock");
                datos.setearTipoComando(CommandType.StoredProcedure);
                datos.setearParametro("@Id", idArticulo);
                datos.setearParametro("@NuevoStock", nuevoStock);
                datos.ejecutarAccion();
            }
        }

        public int sumarStock(int idArticulo, int cantidad)
        {
            using (AccesoDatos datos = new AccesoDatos())
            {
                datos.setearConsulta("SP_SumarStock");
                datos.setearTipoComando(CommandType.StoredProcedure);
                datos.setearParametro("@Id", idArticulo);
                datos.setearParametro("@Cantidad", cantidad);
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    return Convert.ToInt32(datos.Lector["Stock"]);
                }
                return 0;
            }
        }

        public int restarStock(int idArticulo, int cantidad)
        {
            using (AccesoDatos datos = new AccesoDatos())
            {
                datos.setearConsulta("SP_RestarStock");
                datos.setearTipoComando(CommandType.StoredProcedure);
                datos.setearParametro("@Id", idArticulo);
                datos.setearParametro("@Cantidad", cantidad);
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    return Convert.ToInt32(datos.Lector["Stock"]);
                }
                return 0;
            }
        }

        public List<Articulo> obtenerArticulosBajoStock(int stockMinimo = 5)
        {
            List<Articulo> lista = new List<Articulo>();
            using (AccesoDatos datos = new AccesoDatos())
            {
                datos.setearConsulta("SP_ArticulosBajoStock");
                datos.setearTipoComando(CommandType.StoredProcedure);
                datos.setearParametro("@StockMinimo", stockMinimo);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    lista.Add(DataMapper.MapArticulo(datos.Lector));
                }
                return lista;
            }
        }

        public List<Articulo> obtenerArticulosSinStock()
        {
            List<Articulo> lista = new List<Articulo>();
            using (AccesoDatos datos = new AccesoDatos())
            {
                datos.setearConsulta("SP_ArticulosSinStock");
                datos.setearTipoComando(CommandType.StoredProcedure);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    lista.Add(DataMapper.MapArticulo(datos.Lector));
                }
                return lista;
            }
        }
        #endregion
    }
}
