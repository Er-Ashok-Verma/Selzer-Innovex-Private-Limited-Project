using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Shell_DB_Report_TypeMaster : System.Web.UI.Page
{
    DbFunctions objfun = new DbFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            FillGrid();

        }
    }

    protected void btninsert_Click(object sender, EventArgs e)
    {
        if (txtedbr.Text == "")
        {
            objfun.MsgBox("Please Enter DB Report", this);
            txtedbr.Focus();
            return;
        }
        if (btninsert.Text == "Insert")
        {
            int insert = objfun.ExecuteDML("Insert into DBReportTypeMaster(DBReportType) values ('" + txtedbr.Text + "')");
            if (insert > 0)
            {
                objfun.MsgBox("DB Report Insert Successfully...", this);
                FillGrid();
                Reset();
                return;
            }
        }

        else
        {
            int Updatecount = objfun.ExecuteDML("UPDATE DBReportTypeMaster SET DBReportType = '" + txtedbr.Text + "'  WHERE ID='" + hdnID.Value + "'");
            if (Updatecount > 0)
            {
                FillGrid();
                objfun.MsgBox("DB Report Update Successfully...", this);
                Reset();
                return;
            }
        }
        }
    
    public void FillGrid()
    {
        DataTable dt = new DataTable();
        dt = objfun.FillDataTable("Select * from DBReportTypeMaster");
        if (dt.Rows.Count > 0)
        {
            if (dt.Rows.Count > 0)
            {
                gridview.DataSource = dt;
                gridview.DataBind();
                lblRowCount.Text = "<span style='color:darkgreen;'>Total " + gridview.Rows.Count.ToString() + " BD Report Created</span>";

            }
            else
            {
                gridview.DataSource = null;
                gridview.DataBind();
            }
        }

    }
    protected void lnkbtnedit_Click(object sender, EventArgs e)
    {
        LinkButton lnk = (LinkButton)sender;
        GridViewRow row = (GridViewRow)lnk.NamingContainer;

        string ID = gridview.DataKeys[row.RowIndex].Values[0].ToString();
        hdnID.Value = ID;

        DataTable dtedit = new DataTable();

        dtedit = objfun.FillDataTable("Select * from DBReportTypeMaster where ID='" + ID + "' ");
        if (dtedit.Rows.Count > 0)
        {

            txtedbr.Text = dtedit.Rows[0]["DBReportType"].ToString();
            btninsert.Text = "Update";
        }
    }

   
    
    public void Reset()
    {
        txtedbr.Text = "";
        btninsert.Text = "Insert";
    }
    protected void btnReset_Click(object sender, EventArgs e)
    {
        Reset();
    }


    protected void lnkbtndelete_Click(object sender, EventArgs e)
    {


        LinkButton btn = (LinkButton)sender;
        GridViewRow row = (GridViewRow)btn.NamingContainer;
        string ID = gridview.DataKeys[row.RowIndex].Values[0].ToString();
        string Cluster = gridview.DataKeys[row.RowIndex].Values[1].ToString();

        if (ID != "")
        {
            int deletecount = objfun.ExecuteDML("DELETE FROM DBReportTypeMaster WHERE ID = ' " + ID + "'");
            if (deletecount > 0)
            {
                FillGrid();
                objfun.MsgBox("DB Report Deleted Successfully...", this);
            }

        }
    }
    
}