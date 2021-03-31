using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebTaskASP
{
    public partial class index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnTask1_Click(object sender, EventArgs e)
        {
            Response.Redirect("Task1.aspx");
        }

        protected void btnTask2_Click(object sender, EventArgs e)
        {
            Response.Redirect("Task2.aspx");
        }

        protected void btnTask3_Click(object sender, EventArgs e)
        {
            Response.Redirect("task3.aspx");
        }

        protected void btnTask4_Click(object sender, EventArgs e)
        {
            Response.Redirect("task4.aspx");
        }

        protected void btntask5_Click(object sender, EventArgs e)
        {
            Response.Redirect("task5.aspx");
        }
    }
}