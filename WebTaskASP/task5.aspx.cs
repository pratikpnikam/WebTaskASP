using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace WebTaskASP
{
    public partial class task5 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=PRATIK\SQLEXPRESS;Initial Catalog=patientDB;Integrated Security=True");
        SqlCommand cmd;
        SqlDataAdapter da;
        DataSet ds;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnView_Click(object sender, EventArgs e)
        {
            bindGridview();
        }

        private void bindGridview()
        {
            con.Open();
            try
            {
                cmd = new SqlCommand("pr_query5_part1", con);
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

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            deleteRecord();
        }

        private void deleteRecord()
        {
            con.Open();
            try
            {
                cmd = new SqlCommand("pr_query5_part2", con);
                cmd.CommandType = CommandType.StoredProcedure;
                int n=cmd.ExecuteNonQuery();
                if (n > 0)
                {
                    lblMessage.Text = "Records Deleted Successfully!!";
                }
                else
                {
                    lblMessage.Text = "Cant Delete The Records";
                }
            }
            catch (Exception ee)
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