using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ReportType_LevelMapping : System.Web.UI.Page
{
    DbFunctions objfun = new DbFunctions();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            objfun.FillDropdownlist(ddldbr, "DBReportType", "ID", "Select ID,DBReportType from DBReportTypeMaster", "--Select--");
            objfun.FillDropdownlist(ddll, "DB_Level", "ID", "Select ID,DB_Level from DB_Level_Master", "--Select--");

            FillGrid();         
            
        }
    }

    protected void btnsave_Click(object sender, EventArgs e)
    {


        if (ddldbr.SelectedItem.Text == "--Select--")
        {
            objfun.MsgBox("Please Select DB Report", this);
            ddldbr.Focus();
            return;
        }

        if (ddll.SelectedItem.Text == "--Select--")
        {
            objfun.MsgBox("Please Select Level", this);
            ddll.Focus();
            return;
        }

        int levelcount = Convert.ToInt32(objfun.Get_details("SELECT COUNT(*) FROM ReportTypeLevel_Mapping WHERE LevelID = '" + ddll.SelectedValue + "'"));

        if (levelcount > 0)
        {
            
            objfun.MsgBox("This Level is already assigned.", this);
            ddll.SelectedIndex = 0;
            return;
        }

        if (btnsave.Text == "Save")
        {

            int insert = objfun.ExecuteDML("Insert into ReportTypeLevel_Mapping(ReportTypeID,LevelID) values ('" + ddldbr.SelectedValue + "', '" + ddll.SelectedValue + "')");
            if (insert > 0)
            {
                objfun.MsgBox("Report Type Mapping Save Successfully...", this);
                FillGrid();
                Reset();
                return;
            }
        }
        else
        {
 
            int Updatecount = objfun.ExecuteDML("UPDATE ReportTypeLevel_Mapping SET ReportTypeID = '" + ddldbr.SelectedValue + "',LevelID = '" + ddll.SelectedValue + "'  WHERE ID='" + hdnID.Value + "'");
            if (Updatecount > 0)
                    {
                        FillGrid();
                        objfun.MsgBox("Report Type Mapping Update Successfully...", this);
                        Reset();
                        btnsave.Text = "Save";
                        return;
                    }
                   }
               }
           
    public void FillGrid()
    {
        DataTable dt = new DataTable();

        dt = objfun.FillDataTable("SELECT  DBReportTypeMaster.DBReportType, DB_Level_Master.DB_Level, ReportTypeLevel_Mapping.ID FROM ReportTypeLevel_Mapping INNER JOIN DBReportTypeMaster ON ReportTypeLevel_Mapping.ReportTypeID = DBReportTypeMaster.ID INNER JOIN DB_Level_Master ON ReportTypeLevel_Mapping.LevelID = DB_Level_Master.ID");
        if (dt.Rows.Count > 0)
        {
            gridview.DataSource = dt;
            gridview.DataBind();
            lblRowCount.Text = "<span style='color:darkgreen;'>Total " + gridview.Rows.Count.ToString() + " Report Type Mapping Created</span>";
        }
        else
        {
            gridview.DataSource = null;
            gridview.DataBind();
        }
    }
 

    protected void btndelete_Click(object sender, EventArgs e)
    {
        LinkButton btn = (LinkButton)sender;
        GridViewRow row = (GridViewRow)btn.NamingContainer;
        string ID = gridview.DataKeys[row.RowIndex].Values[0].ToString();
     

        if (ID != "")
        {
            int deletecount = objfun.ExecuteDML("DELETE FROM ReportTypeLevel_Mapping WHERE ID = ' " + ID + "'");
            if (deletecount > 0)
            {
                FillGrid();
                objfun.MsgBox("Report Type Mapping Deleted Successfully...", this);
                Reset();
                return;
            }
        }
    }
    protected void btnedit_Click(object sender, EventArgs e)
    {

        LinkButton lnk = (LinkButton)sender;
        GridViewRow row = (GridViewRow)lnk.NamingContainer;

        string ID = gridview.DataKeys[row.RowIndex].Values[0].ToString();
        hdnID.Value = ID;

        DataTable dtedit = new DataTable();

        dtedit = objfun.FillDataTable("Select * from ReportTypeLevel_Mapping where ID='" + ID + "' ");
        if (dtedit.Rows.Count > 0)
        {

            ddldbr.SelectedValue = dtedit.Rows[0]["ReportTypeID"].ToString();
            ddll.SelectedValue = dtedit.Rows[0]["LevelID"].ToString();
            ddldbr.Enabled = false;
            btnsave.Text = "Update";
           
        }
       
    }
      
    public void Reset()
    {
       
        ddldbr.SelectedValue = "0";
        ddll.SelectedValue = "0";
        ddldbr.Enabled = true;
        btnsave.Text = "Save";
    }

    protected void btnreset_Click(object sender, EventArgs e)
    {
        Reset();
    }
}

