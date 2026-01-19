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
            aux.Id = lector["Id"] != DBNull.Value ? Convert.ToInt32(lector["Id"]) : 0;
            aux.Codigo = lector["Codigo"] != DBNull.Value ? Convert.ToString(lector["Codigo"]) : "";
            aux.Nombre = lector["Nombre"] != DBNull.Value ? Convert.ToString(lector["Nombre"]) : "";
            aux.Descripcion = lector["Descripcion"] != DBNull.Value ? Convert.ToString(lector["Descripcion"]) : "";
            
            aux.Marca = new Marca();
            aux.Marca.Id = lector["IdMarca"] != DBNull.Value ? Convert.ToInt32(lector["IdMarca"]) : 0;
            aux.Marca.Descripcion = lector["Marca"] != DBNull.Value ? Convert.ToString(lector["Marca"]) : "";
            
            aux.Categoria = new Categoria();
            aux.Categoria.Id = lector["IdCategoria"] != DBNull.Value ? Convert.ToInt32(lector["IdCategoria"]) : 0;
            aux.Categoria.Descripcion = lector["Categoria"] != DBNull.Value ? Convert.ToString(lector["Categoria"]) : "";
            
            aux.UrlImagen = lector["ImagenUrl"] != DBNull.Value ? Convert.ToString(lector["ImagenUrl"]) : "";
            aux.Precio = lector["Precio"] != DBNull.Value ? Convert.ToDecimal(lector["Precio"]) : 0;
            aux.Stock = lector["Stock"] != DBNull.Value ? Convert.ToInt32(lector["Stock"]) : 0;
            
            return aux;
        }

        public static Categoria MapCategoria(SqlDataReader lector)
        {
            Categoria aux = new Categoria();
            aux.Id = lector["Id"] != DBNull.Value ? Convert.ToInt32(lector["Id"]) : 0;
            aux.Descripcion = lector["Descripcion"] != DBNull.Value ? Convert.ToString(lector["Descripcion"]) : "";
            return aux;
        }

        public static Marca MapMarca(SqlDataReader lector)
        {
            Marca aux = new Marca();
            aux.Id = lector["Id"] != DBNull.Value ? Convert.ToInt32(lector["Id"]) : 0;
            aux.Descripcion = lector["Descripcion"] != DBNull.Value ? Convert.ToString(lector["Descripcion"]) : "";
            return aux;
        }

        public static Usuario MapUsuario(SqlDataReader lector)
        {
            Usuario aux = new Usuario();
            aux.IdUsuario = lector["IdUsuario"] != DBNull.Value ? Convert.ToInt32(lector["IdUsuario"]) : 0;
            aux.NombreUsuario = lector["NombreUsuario"] != DBNull.Value ? Convert.ToString(lector["NombreUsuario"]) : "";
            aux.EsAdministrador = lector["EsAdministrador"] != DBNull.Value ? Convert.ToBoolean(lector["EsAdministrador"]) : false;

            // Manejar Estado opcionalmente si existe en el lector
            try {
                if (ColumnExists(lector, "Estado"))
                    aux.Estado = lector["Estado"] != DBNull.Value ? Convert.ToBoolean(lector["Estado"]) : false;
            } catch { } 
            
            return aux;
        }

        private static bool ColumnExists(SqlDataReader reader, string columnName)
        {
            for (int i = 0; i < reader.FieldCount; i++)
            {
                if (reader.GetName(i).Equals(columnName, StringComparison.InvariantCultureIgnoreCase))
                    return true;
            }
            return false;
        }
    }
}

