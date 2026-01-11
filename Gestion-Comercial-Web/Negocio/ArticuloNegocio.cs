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
                    aux.Id = (int)datos.Lector["Id"]; 
                    aux.Codigo = (string)datos.Lector["Codigo"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Descripcion = (string)datos.Lector["Descripcion"];
                    aux.Marca = new Marca();
                    aux.Marca.Id = (int)datos.Lector["IdMarca"];
                    aux.Marca.Descripcion = (string)datos.Lector["Marca"];
                    aux.Categoria = new Categoria();
                    aux.Categoria.Id = (int)datos.Lector["IdCategoria"];
                    aux.Categoria.Descripcion = (string)datos.Lector["Categoria"];
                    aux.UrlImagen = (string)datos.Lector["ImagenUrl"];
                    aux.Precio = (decimal)datos.Lector["Precio"];
                    aux.Stock = (int)datos.Lector["Stock"];
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
                    aux.Id = Convert.ToInt32(datos.Lector["Id"]);
                    aux.Codigo = datos.Lector["Codigo"].ToString();
                    aux.Nombre = datos.Lector["Nombre"].ToString();
                    aux.Descripcion = datos.Lector["Descripcion"].ToString();
                    aux.Marca = new Marca();
                    aux.Marca.Id = Convert.ToInt32(datos.Lector["IdMarca"]);
                    aux.Marca.Descripcion = datos.Lector["Marca"].ToString();
                    aux.Categoria = new Categoria();
                    aux.Categoria.Id = Convert.ToInt32(datos.Lector["IdCategoria"]);
                    aux.Categoria.Descripcion = datos.Lector["Categoria"].ToString();
                    aux.UrlImagen = datos.Lector["ImagenUrl"].ToString();
                    aux.Precio = Convert.ToDecimal(datos.Lector["Precio"]);
                    aux.Stock = Convert.ToInt32(datos.Lector["Stock"]);
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
                    aux.Id = Convert.ToInt32(datos.Lector["Id"]);
                    aux.Codigo = datos.Lector["Codigo"].ToString();
                    aux.Nombre = datos.Lector["Nombre"].ToString();
                    aux.Marca = new Marca();
                    aux.Marca.Descripcion = datos.Lector["Marca"].ToString();
                    aux.Categoria = new Categoria();
                    aux.Categoria.Descripcion = datos.Lector["Categoria"].ToString();
                    aux.Stock = Convert.ToInt32(datos.Lector["Stock"]);
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
                    aux.Id = Convert.ToInt32(datos.Lector["Id"]);
                    aux.Codigo = datos.Lector["Codigo"].ToString();
                    aux.Nombre = datos.Lector["Nombre"].ToString();
                    aux.Marca = new Marca();
                    aux.Marca.Descripcion = datos.Lector["Marca"].ToString();
                    aux.Categoria = new Categoria();
                    aux.Categoria.Descripcion = datos.Lector["Categoria"].ToString();
                    aux.Stock = Convert.ToInt32(datos.Lector["Stock"]);
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
