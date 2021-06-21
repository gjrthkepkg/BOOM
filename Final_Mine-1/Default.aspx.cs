using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

public partial class mine_Default : System.Web.UI.Page
{
    int x = 16;
    int y = 16;
    int m = 40;
    public void get_x()
    {
        Response.Write(x.ToString());
    }
    public void get_y()
    {
        Response.Write(y.ToString());
    }
    public void get_m()
    {
        Response.Write(m.ToString());
    }
    public void draw_tb()
    {
        int i, j;
        for (i = 0; i < x; i++)
        {
            //Response.Write("<tr>\n");
            for (j = 0; j < y; j++)
            {
                //Response.Write("<td><input type=\"button\" value=\" \"></td>");
                //Response.Write("<td><img src=\"img/box.png\" Width=\"20\" Height=\"20\" ></td>");
                Response.Write("<img src=\"img/box.png\" Width=\"20\" Height=\"20\" id=\"box_" + i.ToString() + "_" + j.ToString() + "\" onclick=\"javascript:box_click(" + i.ToString() + "," + j.ToString() + ",0);\" oncontextmenu=\"javascript:box_r_click(" + i.ToString() + "," + j.ToString() + ");return false;\">");
            }
            Response.Write("<br>");
            //Response.Write("<tr>");
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }
}
