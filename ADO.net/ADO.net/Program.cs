using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ADO.net
{
    class Program
    {
        static void connection_StateChange(object sender, System.Data.StateChangeEventArgs e)
        {
            SqlConnection connection = sender as SqlConnection;

            Console.WriteLine();

            Console.WriteLine
                (
                "Connection to" + Environment.NewLine +
                "Data Source: " + connection.DataSource + Environment.NewLine +
                "Database: " + connection.Database + Environment.NewLine +
                "State: " + connection.State
                );
        }


        static void Main(string[] args)
        {
            SqlConnectionStringBuilder ConnectionString = new SqlConnectionStringBuilder();

            ConnectionString.DataSource = @"(LocalDb)\MSSQLLocalDB";
            ConnectionString.InitialCatalog = "AdventureworksDW2016CTP3";
            ConnectionString.IntegratedSecurity = true;
            ConnectionString.MultipleActiveResultSets = true;
            ConnectionString.Pooling = true;
            Console.Write("Login: ");
            ConnectionString.UserID = Console.ReadLine();
            Console.Write("Password: ");
            string password = "";


            while(true)
            {
                char key = Console.ReadKey().KeyChar;
                password += key;
                if (key == '\r')
                    break;
                Console.CursorLeft--;
                Console.Write('*');
            }

            ConnectionString.Password = password;

            using (SqlConnection connection = new SqlConnection(ConnectionString.ConnectionString))
            {
                connection.StateChange += connection_StateChange;
                try { connection.Open(); }
                catch { }
                
            }
        }
    }
}
