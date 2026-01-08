using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;

namespace Negocio
{
    public class ArticuloNegocio
    {
        public List<Articulo> listar()
        {
            List<Articulo> lista = new List<Articulo>();
            AccesoDatos datos = new AccesoDatos();
            String consulta = "SELECT * FROM vw_ArticulosCompletos";
            try
            {
                datos.setearConsulta(consulta);
                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    Articulo aux = new Articulo();
                    aux.id = (int)datos.Lector["Id"]; 
                    aux.codigo = (string)datos.Lector["Codigo"];
                    aux.nombre = (string)datos.Lector["Nombre"];
                    aux.descripcion = (string)datos.Lector["Descripcion"];
                    aux.marca = new Marca();
                    aux.marca.id = (int)datos.Lector["IdMarca"];
                    aux.marca.descripcion = (string)datos.Lector["Marca"];
                    aux.categoria = new Categoria();
                    aux.categoria.id = (int)datos.Lector["IdCategoria"];
                    aux.categoria.descripcion = (string)datos.Lector["Categoria"];
                    aux.urlImagen = (string)datos.Lector["ImagenUrl"];
                    aux.precio = (decimal)datos.Lector["Precio"];
                    aux.stock = (int)datos.Lector["Stock"];
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

        public void agregar(Articulo nuevo)
        {
            AccesoDatos datos = new AccesoDatos();
            datos.setearConsulta("SP_AltaArticulo");
            datos.setearTipoComando(System.Data.CommandType.StoredProcedure);
            try
            {
                datos.setearParametro("@Codigo", nuevo.codigo);
                datos.setearParametro("@Nombre", nuevo.nombre);
                datos.setearParametro("@Descripcion", nuevo.descripcion);
                datos.setearParametro("@IdMarca", nuevo.marca.id);
                datos.setearParametro("@IdCategoria", nuevo.categoria.id);
                datos.setearParametro("@ImagenUrl", nuevo.urlImagen);
                datos.setearParametro("@Precio", nuevo.precio);
                datos.setearParametro("@Stock", nuevo.stock);
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

        public void modificar(Articulo existente)
        {
            AccesoDatos datos = new AccesoDatos();
            datos.setearConsulta("SP_ModificarArticulo");
            datos.setearTipoComando(System.Data.CommandType.StoredProcedure);
            try
            {
                datos.setearParametro("@Codigo", existente.codigo);
                datos.setearParametro("@Nombre", existente.nombre);
                datos.setearParametro("@Descripcion", existente.descripcion);
                datos.setearParametro("@IdMarca", existente.marca.id);
                datos.setearParametro("@IdCategoria", existente.categoria.id);
                datos.setearParametro("@ImagenUrl", existente.urlImagen);
                datos.setearParametro("@Precio", existente.precio);
                datos.setearParametro("@Stock", existente.stock);
                datos.setearParametro("@Id", existente.id); 
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

        public void bajaFisica(int id)
        {
            try
            {
                AccesoDatos datos = new AccesoDatos();
                datos.setearConsulta("DELETE FROM Articulos WHERE Id = @ID");
                datos.setearParametro("@ID", id);
                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public void bajaLogica(int id)
        {
            try
            {
                AccesoDatos datos = new AccesoDatos();
                datos.setearConsulta("SP_BajaArticulo");
                datos.setearTipoComando(System.Data.CommandType.StoredProcedure);
                datos.setearParametro("@Id", id);
                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<Articulo> filtrar(string campo, string criterio, string filtro)
        {
            List<Articulo> lista = new List<Articulo>();
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("SP_BuscarArticulos");
                datos.setearTipoComando(System.Data.CommandType.StoredProcedure);
                datos.setearParametro("@Campo", campo);
                datos.setearParametro("@Criterio", criterio);
                datos.setearParametro("@Filtro", filtro);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Articulo aux = new Articulo();
                    aux.id = Convert.ToInt32(datos.Lector["Id"]);
                    aux.codigo = datos.Lector["Codigo"].ToString();
                    aux.nombre = datos.Lector["Nombre"].ToString();
                    aux.descripcion = datos.Lector["Descripcion"].ToString();
                    aux.marca = new Marca();
                    aux.marca.id = Convert.ToInt32(datos.Lector["IdMarca"]);
                    aux.marca.descripcion = datos.Lector["Marca"].ToString();
                    aux.categoria = new Categoria();
                    aux.categoria.id = Convert.ToInt32(datos.Lector["IdCategoria"]);
                    aux.categoria.descripcion = datos.Lector["Categoria"].ToString();
                    aux.urlImagen = datos.Lector["ImagenUrl"].ToString();
                    aux.precio = Convert.ToDecimal(datos.Lector["Precio"]);
                    aux.stock = Convert.ToInt32(datos.Lector["Stock"]);
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

        public int ultimoID()
        {
            AccesoDatos datos = new AccesoDatos();
            String consulta = "SELECT MAX(Id) AS UltimoID FROM Articulos";
            try
            {
                datos.setearConsulta(consulta);
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
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void actualizarStock(int idArticulo, int nuevoStock)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("SP_ActualizarStock");
                datos.setearTipoComando(System.Data.CommandType.StoredProcedure);
                datos.setearParametro("@Id", idArticulo);
                datos.setearParametro("@NuevoStock", nuevoStock);
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

        public int sumarStock(int idArticulo, int cantidad)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("SP_SumarStock");
                datos.setearTipoComando(System.Data.CommandType.StoredProcedure);
                datos.setearParametro("@Id", idArticulo);
                datos.setearParametro("@Cantidad", cantidad);
                datos.ejecutarLectura();
                
                if (datos.Lector.Read())
                {
                    return (int)datos.Lector["Stock"];
                }
                return 0;
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

        public int restarStock(int idArticulo, int cantidad)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("SP_RestarStock");
                datos.setearTipoComando(System.Data.CommandType.StoredProcedure);
                datos.setearParametro("@Id", idArticulo);
                datos.setearParametro("@Cantidad", cantidad);
                datos.ejecutarLectura();
                
                if (datos.Lector.Read())
                {
                    return (int)datos.Lector["Stock"];
                }
                return 0;
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

        public List<Articulo> obtenerArticulosBajoStock(int stockMinimo = 5)
        {
            List<Articulo> lista = new List<Articulo>();
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("SP_ArticulosBajoStock");
                datos.setearTipoComando(System.Data.CommandType.StoredProcedure);
                datos.setearParametro("@StockMinimo", stockMinimo);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Articulo aux = new Articulo();
                    aux.id = Convert.ToInt32(datos.Lector["Id"]);
                    aux.codigo = datos.Lector["Codigo"].ToString();
                    aux.nombre = datos.Lector["Nombre"].ToString();
                    aux.marca = new Marca();
                    aux.marca.descripcion = datos.Lector["Marca"].ToString();
                    aux.categoria = new Categoria();
                    aux.categoria.descripcion = datos.Lector["Categoria"].ToString();
                    aux.stock = Convert.ToInt32(datos.Lector["Stock"]);
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

        public List<Articulo> obtenerArticulosSinStock()
        {
            List<Articulo> lista = new List<Articulo>();
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("SP_ArticulosSinStock");
                datos.setearTipoComando(System.Data.CommandType.StoredProcedure);
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Articulo aux = new Articulo();
                    aux.id = Convert.ToInt32(datos.Lector["Id"]);
                    aux.codigo = datos.Lector["Codigo"].ToString();
                    aux.nombre = datos.Lector["Nombre"].ToString();
                    aux.marca = new Marca();
                    aux.marca.descripcion = datos.Lector["Marca"].ToString();
                    aux.categoria = new Categoria();
                    aux.categoria.descripcion = datos.Lector["Categoria"].ToString();
                    aux.stock = Convert.ToInt32(datos.Lector["Stock"]);
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
    }
}
