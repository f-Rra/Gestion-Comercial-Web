using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Configuration;

namespace Negocio
{
    class AccesoDatos : IDisposable
    {
        private SqlConnection conexion;
        private SqlCommand comando;
        private SqlDataReader lector;
        private string ruta = ConfigurationManager.ConnectionStrings["GestionComercialDB"].ConnectionString;
        private SqlTransaction transaccion;

        public SqlDataReader Lector
        {
            get { return lector; }
        }

        public AccesoDatos()
        {
            conexion = new SqlConnection(ruta);
            comando = new SqlCommand();
        }

        public void abrirTransaccion()
        {
            if (conexion.State != System.Data.ConnectionState.Open)
                conexion.Open();
            transaccion = conexion.BeginTransaction();
            comando.Transaction = transaccion;
        }

        public void commitTransaccion()
        {
            if (transaccion != null)
                transaccion.Commit();
        }

        public void rollbackTransaccion()
        {
            if (transaccion != null)
                transaccion.Rollback();
        }

        public void setearConsulta(string consulta)
        {
            comando.CommandType = System.Data.CommandType.Text;
            comando.CommandText = consulta;
        }

        public void setearTipoComando(System.Data.CommandType tipo)
        {
            comando.CommandType = tipo;
        }

        public void ejecutarLectura()
        {
            comando.Connection = conexion;
            try
            {
                if (conexion.State != System.Data.ConnectionState.Open)
                    conexion.Open();
                lector = comando.ExecuteReader();
            }
            catch (Exception)
            {
                throw;
            }
        }

        public void ejecutarAccion()
        {
            comando.Connection = conexion;
            try
            {
                if (conexion.State != System.Data.ConnectionState.Open)
                    conexion.Open();
                comando.ExecuteNonQuery();
            }
            catch (Exception)
            {
                throw;
            }
            finally
            {
                if (transaccion == null)
                {
                    conexion.Close();
                }
                comando.Parameters.Clear();
            }
        }

        public void setearParametro(string nombre, object valor)
        {
            comando.Parameters.AddWithValue(nombre, valor ?? DBNull.Value);
        }

        public void limpiarParametros()
        {
            comando.Parameters.Clear();
        }

        public void cerrarConexion()
        {
            if (lector != null && !lector.IsClosed)
                lector.Close();

            if (conexion != null && conexion.State == System.Data.ConnectionState.Open && transaccion == null)
            {
                conexion.Close();
            }
        }

        public void Dispose()
        {
            cerrarConexion();
            if (comando != null)
                comando.Dispose();
            if (conexion != null)
                conexion.Dispose();
        }
    }
}

