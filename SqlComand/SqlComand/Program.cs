using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SqlComand
{
    class Program
    {
        static void Main(string[] args)
        {


            //data source=(LocalDb)\MSSQLLocalDB;
            //initial catalog=CodeFirst.Model;
            //integrated security=True;
            //MultipleActiveResultSets =True;

            SqlConnectionStringBuilder SCSB = new SqlConnectionStringBuilder();
            SCSB.DataSource = @"(LocalDb)\MSSQLLocalDB";
            SCSB.InitialCatalog = "AdventureworksDW2016CTP3";
            SCSB.IntegratedSecurity = false;
            SCSB.Pooling = true;
            //SCSB.UserID = "";
            //SCSB.Password = "";


            using (SqlConnection conection = new SqlConnection(SCSB.ConnectionString))
            {
                conection.Open();

                string comand = @"SELECT * from dbo.FactFinance";

                SqlCommand SQLcomand = new SqlCommand(comand, conection);

                using (SqlDataReader DR = SQLcomand.ExecuteReader())
                {

                    while (DR.Read())
                    {
                        for (int i = 0; i < DR.FieldCount; i++)
                        {
                            Console.Write($"{DR.GetName(i)} ");
                            Console.WriteLine($"'{DR[i]}' ");
                        }
                        Console.WriteLine();
                    }
                }
            }
        }
    }
}
