using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Machine_Master : System.Web.UI.Page
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
        if (txtMachineCode.Text == "")
        {
            objfun.MsgBox("Please Enter Machine Code", this);
            txtMachineCode.Focus();
            return;
        }
        if (txtMachineName.Text == "")
        {
            objfun.MsgBox("Please Enter Machine Name", this);
            txtMachineName.Focus();
            return;
        }
        if (txtType.Text == "")
        {
            objfun.MsgBox("Please Enter Type", this);
            txtType.Focus();
            return;
        }

       

        if (btnSave.Text == "Save")
        {
            string machinecode = objfun.Get_details("select Machine_Code from Machine_Master where Machine_Code='" + txtMachineCode.Text + "'");

            int mcount = Convert.ToInt32(objfun.Get_details("select count(*) from Machine_Master where Machine_Code='" + txtMachineCode.Text + "'"));

            if (mcount > 0)
            {
                fillgrid();
                objfun.MsgBox("This Machine Code alredy assign. ", this);
                 txtMachineCode.Text = "";
                return;
            }

            string machinename = objfun.Get_details("select Machine_Code from Machine_Master where Machine_Name='" + txtMachineName.Text + "'");

            int ncount = Convert.ToInt32(objfun.Get_details("select count(*) from Machine_Master where Machine_Name='" + txtMachineName.Text + "'"));

            if (ncount > 0)
            {
                fillgrid();
                objfun.MsgBox("This Machine Name alredy assign. ", this);
                 txtMachineName.Text = "";
                return;
            }
            int insert = objfun.ExecuteDML("INSERT INTO Machine_Master " + "(Machine_Code, Machine_Name,Type, CreatedDate) " + "VALUES ('" + txtMachineCode.Text + "','" + txtMachineName.Text + "', '" + txtType.Text + "', '" + DateTime.Now + "')");

            if (insert > 0)
            {
                objfun.MsgBox("Machine Master Submited Successfully...", this);
                fillgrid();
                Reset();
                return;
            }
        }

        else
        {
            if (btnSave.Text == "Update")
            {
                int Updatecount = objfun.ExecuteDML("UPDATE Machine_Master SET Machine_Code = '" + txtMachineCode.Text + "', Machine_Name ='" + txtMachineName.Text + "',  Type ='" + txtType.Text + "',CreatedDate='" + DateTime.Now + "'  WHERE ID='" + hidden.Value + "'");
                if (Updatecount > 0)
                {
                    fillgrid();
                    objfun.MsgBox("Leave Reason Update Successfully...", this);
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
        txtMachineCode.Text = "";
        txtMachineName.Text = "";
        txtType.Text = "";
        txtMachineCode.Enabled = true;
        txtMachineName.Enabled = true;
        btnSave.Text = "Save";
    }

    public void fillgrid()
    {
        DataTable dt = new DataTable();
        dt = objfun.FillDataTable("Select * from Machine_Master");
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

            string machineNo = objfun.Get_details("SELECT Machine_No FROM SFG_Production_Report  WHERE ID='" + ID + "'");

            int count = Convert.ToInt32(objfun.Get_details("SELECT COUNT(*) FROM SFG_Production_Report WHERE Machine_No='" + machineNo + "'"));

            if (count > 0)
            {
                objfun.MsgBox("This Machine is used in Production Report. Cannot Delete!", this);
                fillgrid();
                return;
            }


            else
            {
                int deletecount = objfun.ExecuteDML("DELETE FROM Machine_Master WHERE ID='" + ID + "'");

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

        dtedit = objfun.FillDataTable("Select * from Machine_Master where ID='" + ID + "' ");
        if (dtedit.Rows.Count > 0)
        {
            txtMachineCode.Text = dtedit.Rows[0]["Machine_Code"].ToString();
            txtMachineName.Text = dtedit.Rows[0]["Machine_Name"].ToString();
             txtType.Text = dtedit.Rows[0]["Type"].ToString();
             txtMachineCode.Enabled = false;
             txtMachineName.Enabled = false;
            btnSave.Text = "Update";
        }
    }
}
