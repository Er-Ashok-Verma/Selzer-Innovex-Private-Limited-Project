using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DownTime_Reason_Master : System.Web.UI.Page
{
    DbFunctions objfun = new DbFunctions();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            Response.Redirect("Login.aspx");
        }
        if (Session["ClientID"] == null)
        {
            Response.Redirect("Login.aspx");
        }
        if (Session["Name"] == null)
        {
            Response.Redirect("Login.aspx");
        }
        if (Session["RoleID"] == null)
        {
            Response.Redirect("Login.aspx");
        }
        if (Session["UserName"] == null)
        {
            Response.Redirect("Login.aspx");
        }

        if (!IsPostBack)
        {
            fillgrid();

        }
    }



    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (txtDownTimeReason.Text == "")
        {
            objfun.MsgBox("Please Enter DownTime Reason", this);
            txtDownTimeReason.Focus();
            return;
        }

        string DwonTime_Reason = objfun.Get_details("select DownTime_Reason from DownTime_Reason_Master where DownTime_Reason='" + txtDownTimeReason.Text + "'");

        int Dcount = Convert.ToInt32(objfun.Get_details("select count(*) from DownTime_Reason_Master where DownTime_Reason='" + txtDownTimeReason.Text + "'"));

        if (Dcount > 0)
        {
            fillgrid();
            objfun.MsgBox("This DownTime Reason alredy assign. ", this);
            txtDownTimeReason.Text = "";
            return;
        }

        if (btnSave.Text == "Save")
        {
            int insert = objfun.ExecuteDML("INSERT INTO DownTime_Reason_Master (DownTime_Reason, CreatedDate) " + "VALUES ('" + txtDownTimeReason.Text + "' , '" + DateTime.Now + "')");

            if (insert > 0)
            {
                objfun.MsgBox("DownTime Reason Submited Successfully...", this);
                fillgrid();
                Reset();
                return;
            }
        }

        else
        {
            if (btnSave.Text == "Update")
            {
                int Updatecount = objfun.ExecuteDML("UPDATE DownTime_Reason_Master SET DownTime_Reason = '" + txtDownTimeReason.Text + "',CreatedDate='" + DateTime.Now + "'  WHERE ID='" + hidden.Value + "'");
                if (Updatecount > 0)
                {
                    fillgrid();
                    objfun.MsgBox("DownTime Reason Update Successfully...", this);
                    Reset();
                    return;
                }
            }
        }
    }
    protected void btnReset_Click(object sender, EventArgs e)
    {
        Reset();
    }
    public void Reset()
    {
        txtDownTimeReason.Text = "";
        btnSave.Text = "Save";
    }

    public void fillgrid()
    {
        DataTable dt = new DataTable();
        dt = objfun.FillDataTable("Select * from DownTime_Reason_Master");
        if (dt.Rows.Count > 0)
        {
            if (dt.Rows.Count > 0)
            {
                gridview.DataSource = dt;
                gridview.DataBind();
            }
            else
            {
                gridview.DataSource = null;
                gridview.DataBind();
            }
        }

    }
    protected void lnkEdit_Click(object sender, EventArgs e)
    {

        LinkButton lnk = (LinkButton)sender;
        GridViewRow row = (GridViewRow)lnk.NamingContainer;

        string ID = gridview.DataKeys[row.RowIndex].Values[0].ToString();
        hidden.Value = ID;

        DataTable dtedit = new DataTable();

        dtedit = objfun.FillDataTable("Select * from DownTime_Reason_Master where ID='" + ID + "' ");
        if (dtedit.Rows.Count > 0)
        {
            txtDownTimeReason.Text = dtedit.Rows[0]["DownTime_Reason"].ToString();           
             btnSave.Text = "Update";
        }
    }
    protected void lnkbtndelete_Click(object sender, EventArgs e)
    { 
        LinkButton btn = (LinkButton)sender;
        GridViewRow row = (GridViewRow)btn.NamingContainer;
        string ID = gridview.DataKeys[row.RowIndex].Values[0].ToString();

        if (ID != "")
        {

            string DownTime = objfun.Get_details("SELECT DownTime_ReasonID FROM SFG_Production_Report  WHERE DownTime_ReasonID='" + ID + "'");

            int count = Convert.ToInt32(objfun.Get_details("SELECT COUNT(*) FROM SFG_Production_Report WHERE DownTime_ReasonID='" + DownTime + "'"));

            if (count > 0)
            {
                objfun.MsgBox("This DownTime Reason is used . Cannot Delete!", this);
                fillgrid();
                return;
            }
            else
            {
                int deletecount = objfun.ExecuteDML("DELETE FROM DownTime_Reason_Master WHERE ID='" + ID + "'");

                if (deletecount > 0)
                {
                    fillgrid();
                    objfun.MsgBox("Data Deleted Successfully...", this);
                    return;
                }
            }
         }
      }
   }