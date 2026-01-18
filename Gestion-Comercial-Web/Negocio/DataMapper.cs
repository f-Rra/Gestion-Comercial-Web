using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using Dominio;

namespace Negocio
{
    public static class DataMapper
    {
        public static Articulo MapArticulo(SqlDataReader lector)
        {
            Articulo aux = new Articulo();
            aux.Id = Convert.ToInt32(lector["Id"]);
            aux.Codigo = lector["Codigo"] != DBNull.Value ? (string)lector["Codigo"] : "";
            aux.Nombre = lector["Nombre"] != DBNull.Value ? (string)lector["Nombre"] : "";
            aux.Descripcion = lector["Descripcion"] != DBNull.Value ? (string)lector["Descripcion"] : "";
            
            aux.Marca = new Marca();
            aux.Marca.Id = Convert.ToInt32(lector["IdMarca"]);
            aux.Marca.Descripcion = lector["Marca"] != DBNull.Value ? (string)lector["Marca"] : "";
            
            aux.Categoria = new Categoria();
            aux.Categoria.Id = Convert.ToInt32(lector["IdCategoria"]);
            aux.Categoria.Descripcion = lector["Categoria"] != DBNull.Value ? (string)lector["Categoria"] : "";
            
            aux.UrlImagen = lector["ImagenUrl"] != DBNull.Value ? (string)lector["ImagenUrl"] : "";
            aux.Precio = Convert.ToDecimal(lector["Precio"]);
            aux.Stock = Convert.ToInt32(lector["Stock"]);
            
            return aux;
        }

        public static Categoria MapCategoria(SqlDataReader lector)
        {
            Categoria aux = new Categoria();
            aux.Id = Convert.ToInt32(lector["Id"]);
            aux.Descripcion = (string)lector["Descripcion"];
            return aux;
        }

        public static Marca MapMarca(SqlDataReader lector)
        {
            Marca aux = new Marca();
            aux.Id = Convert.ToInt32(lector["Id"]);
            aux.Descripcion = (string)lector["Descripcion"];
            return aux;
        }

        public static Usuario MapUsuario(SqlDataReader lector)
        {
            Usuario aux = new Usuario();
            aux.IdUsuario = Convert.ToInt32(lector["IdUsuario"]);
            aux.NombreUsuario = (string)lector["NombreUsuario"];
            aux.EsAdministrador = Convert.ToBoolean(lector["EsAdministrador"]);
            // Manejar Estado opcionalmente si existe en el lector
            try {
                if (lector["Estado"] != DBNull.Value)
                    aux.Estado = Convert.ToBoolean(lector["Estado"]);
            } catch { } 
            
            return aux;
        }
    }
}
