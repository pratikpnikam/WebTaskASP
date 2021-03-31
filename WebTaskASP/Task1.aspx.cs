using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

namespace WebTaskASP
{
    public partial class Task1 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=PRATIK\SQLEXPRESS;Initial Catalog=patientDB;Integrated Security=True");

        SqlCommand cmd;
        SqlDataAdapter da;
        DataSet ds;

        protected void Page_Load(object sender, EventArgs e)
        {
            bindGrid();
        }

        private void bindGrid()
        {
            con.Open();
            try
            {
                cmd = new SqlCommand("pr_query1", con);
                cmd.CommandType = CommandType.StoredProcedure;
                da = new SqlDataAdapter(cmd);
                ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables.Count > 0)
                {
                    GridView1.DataSource = ds.Tables[0];
                    GridView1.DataBind();
                }
            }catch(Exception ee)
            {
                throw ee;
            }
            finally
            {
                con.Close();
            }
        }

    }
}