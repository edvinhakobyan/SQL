using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;


namespace OpenAsinq
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            //timer1.Interval = 1;
            progressBar1.Step = 1;
            progressBar1.Maximum = 100;

        }


        async private void button1_Click(object sender, EventArgs e)
        {
            timer1.Start();

            SqlConnectionStringBuilder SCSB = new SqlConnectionStringBuilder();

            SCSB.DataSource = @"(localdb)\MSSQLLocalDB";
            SCSB.InitialCatalog = "AdventureworksDW2016CTP3";

            /*Data Source=(localdb)\MSSQLLocalDB;
              Initial Catalog=AdventureworksDW2016CTP3;
              Integrated Security=True;
              Connect Timeout=30;
              Encrypt =False;
              TrustServerCertificate =False;
              ApplicationIntent =ReadWrite;
              MultiSubnetFailover =False*/

            using (SqlConnection SC = new SqlConnection(SCSB.ConnectionString))
            {
                try
                {
                   await SC.OpenAsync();
                }
                catch(Exception ex)
                {
                    Console.WriteLine(ex.Message);
                }
                string comand = "select * from [FactFinance]";

                SqlCommand SCom = new SqlCommand(comand, SC);

                SqlDataReader reader = await SCom.ExecuteReaderAsync();

                while(await reader.ReadAsync())
                {
                    for (int i = 0; i < reader.FieldCount; i++)
                    {
                        Console.WriteLine("{0} --> {1}",reader.GetName(i),reader[i]);
                    }
                    Console.WriteLine(new string('-',50));
                }
            }

        }

        private void timer1_Tick_1(object sender, EventArgs e)
        {
            richTextBox1.Text += ++progressBar1.Value + " ";
            if (progressBar1.Value == progressBar1.Maximum)
            {
                progressBar1.Refresh();
                Thread.Sleep(10000);
            }
        }
    }
}
