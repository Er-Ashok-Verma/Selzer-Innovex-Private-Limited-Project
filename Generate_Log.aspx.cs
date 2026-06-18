using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;

public partial class Generate_Log : System.Web.UI.Page
{
    DbFunctions objfun = new DbFunctions();

    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!IsPostBack)
        {

            FillGrid();
        }
    }


    private string condition()
    {
        string where = "";

        string[] formats = {"ddMMyyyy","dd-MM-yyyy","dd/MM/yyyy"};

        DateTime activityDate;

        if (!string.IsNullOrWhiteSpace(txtad.Text) && DateTime.TryParseExact(txtad.Text,formats, System.Globalization.CultureInfo.InvariantCulture,
            System.Globalization.DateTimeStyles.None,out activityDate))
        {
            where = "CONVERT(date, ActivityDate) = '" + activityDate.ToString("yyyy-MM-dd") + "'";
        }
        else
        {
            where = "CONVERT(date, ActivityDate) = '" + DateTime.Now.ToString("yyyy-MM-dd") + "'";
        }

        return where;
    }


    public void FillGrid()
    {
        DataTable dt = new DataTable();
        dt = objfun.FillDataTable("SELECT Activity_Log.ID, Activity_Log.ActivityDate, Activity_Log.ActivityTime, Activity_Log.FormName, Activity_Log.Action, User_Master.Name, Activity_Log.UserID FROM Activity_Log INNER JOIN User_Master ON Activity_Log.UserID = User_Master.UserID where " + condition() + "");
        if (dt.Rows.Count > 0)
        {
            gridview.DataSource = dt;
            gridview.DataBind();
            lblRowCount.Text = "<span style='color:darkgreen;'>Total " + gridview.Rows.Count.ToString() + " Generate Log Created</span>";

        }
        else
        {
            gridview.DataSource = null;
            gridview.DataBind();
            objfun.MsgBox("Record not found!", this);
            return;
        }

    }

    protected void btnReset_Click(object sender, EventArgs e)
    {
        txtad.Text = "";
    }
    protected void btnView_Click(object sender, EventArgs e)
    {
        if (txtad.Text == "")
        {
            objfun.MsgBox("Please Enter Activity Date!", this);
            return;
        }

        if (!Regex.IsMatch(txtad.Text, @"^(0[1-9]|[12][0-9]|3[01])([\/-]?)(0[1-9]|1[0-2])\2\d{4}$"))
        {   

            objfun.MsgBox("Please Enter Valid Activity Date", this);
            txtad.Focus();
            return;

        }
        FillGrid();
    }
}