using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Shift_Engineer_Master : System.Web.UI.Page
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
        if (txtName.Text == "")
        {
            objfun.MsgBox("Please Enter Name", this);
            txtName.Focus();
            return;
        }
        if (txtCode.Text == "")
        {
            objfun.MsgBox("Please Enter Code", this);
            txtCode.Focus();
            return;
        }


        if (btnSave.Text == "Save")
        {
            string DwonTime_Reason = objfun.Get_details("select Name from Shift_Engineer_Master where Code='" + txtCode.Text + "'");

            int Dcount = Convert.ToInt32(objfun.Get_details("select count(*) from Shift_Engineer_Master where Code='" + txtCode.Text + "'"));

            if (Dcount > 0)
            {
                fillgrid();
                objfun.MsgBox("This Code alredy assign. ", this);
                txtCode.Text = "";
                return;
            }

            int insert = objfun.ExecuteDML("INSERT INTO Shift_Engineer_Master (Name, Code, CreatedDate)  VALUES ('" + txtName.Text + "' , '" + txtCode.Text + "', '" + DateTime.Now.ToString("yyyy-MM-dd HH:MM") + "')");
             if (insert > 0)
            {
                objfun.MsgBox("Data Saved Successfully...", this);
                fillgrid();
                Reset();
                return;
            }
        }

        else
        {
            if (btnSave.Text == "Update")
            {
                int Updatecount = objfun.ExecuteDML("UPDATE Shift_Engineer_Master SET Name= '" + txtName.Text + "' , Code = '" + txtCode.Text + "',CreatedDate='" + DateTime.Now.ToString("yyyy-MM-dd HH:MM") + "'  WHERE ID='" + hidden.Value + "'");
                if (Updatecount > 0)
                {
                    fillgrid();
                    objfun.MsgBox("Data Updated Successfully...", this);
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
        txtName.Text = "";
        txtCode.Text = "";
        btnSave.Text = "Save";
        txtCode.Enabled = true;
    }

    public void fillgrid()
    {
        DataTable dt = new DataTable();
        dt = objfun.FillDataTable("Select * from Shift_Engineer_Master");
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
    
    protected void lnkbtndelete_Click(object sender, EventArgs e)
    {
        LinkButton btn = (LinkButton)sender;
        GridViewRow row = (GridViewRow)btn.NamingContainer;
        string ID = gridview.DataKeys[row.RowIndex].Values[0].ToString();

        if (ID != "")
        {

            string EngineerCode = objfun.Get_details("SELECT Shift_Engineer_Code FROM SFG_Production_Report  WHERE ID ='" + ID + "'");

            int Ecount = Convert.ToInt32(objfun.Get_details("SELECT COUNT(*) FROM SFG_Production_Report WHERE Shift_Engineer_Code ='" + EngineerCode + "'"));

            if (Ecount > 0)
            {
                objfun.MsgBox("This Engineer Code is used. Cannot Delete!", this);
                fillgrid();
                return;
            }


            else
            {
                int deletecount = objfun.ExecuteDML("DELETE FROM Shift_Engineer_Master WHERE ID='" + ID + "'");

                if (deletecount > 0)
                {
                    fillgrid();
                    objfun.MsgBox("Data Deleted Successfully...", this);
                    return;
                }
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

        dtedit = objfun.FillDataTable("Select * from Shift_Engineer_Master where ID='" + ID + "' ");
        if (dtedit.Rows.Count > 0)
        {
            txtName.Text = dtedit.Rows[0]["Name"].ToString();
            txtCode.Text = dtedit.Rows[0]["Code"].ToString();
            btnSave.Text = "Update";
            txtCode.Enabled =false;
        }
    }


}