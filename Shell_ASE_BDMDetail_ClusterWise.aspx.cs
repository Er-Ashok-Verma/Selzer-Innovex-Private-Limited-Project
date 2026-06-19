using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Shell_ASE_BDMDetail_ClusterWise : System.Web.UI.Page
{
    DbFunctions objfun = new DbFunctions();
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            fillgrid();
            btnupdate.Enabled = false;
        }
    }

    public void fillgrid()
    {
        DataTable dt = new DataTable();

        dt = objfun.FillDataTable("select * from Shell_ASE_BDMDetail_ClusterWise");
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



    protected void btndelete_Click(object sender, EventArgs e)
    {
        LinkButton btn = (LinkButton)sender;
        GridViewRow row = (GridViewRow)btn.NamingContainer;
        string ID = gridview.DataKeys[row.RowIndex].Values[0].ToString();
        string Cluster = gridview.DataKeys[row.RowIndex].Values[1].ToString();

        if (ID != "")
        {
            int deletecount = objfun.ExecuteDML("DELETE FROM Shell_ASE_BDMDetail_ClusterWise WHERE ID = ' " + ID + "'");
            if (deletecount > 0)
            {
                fillgrid();
                objfun.MsgBox("Data Deleted Successfully...", this);
            }

        }
   
    }

    protected void btnupdate_Click(object sender, EventArgs e)

    {
        if (txtcluster.Text == "")
        {
            objfun.MsgBox("Please Enter Cluster", this);
            txtcluster.Focus();
            return;
        }


        if (txtbdm.Text == "")
        {
            objfun.MsgBox("Please Enter BDM", this);
            txtbdm.Focus();
            return;
        }


        if (txtase.Text == "")
        {
            objfun.MsgBox("Please Enter ASE", this);
            txtase.Focus();
            return;
        }

        if (txtcredit.Text == "")
        {
            objfun.MsgBox("Please Enter Credit", this);
            txtcredit.Focus();
            return;
        }


        int Updatecount = objfun.ExecuteDML("UPDATE Shell_ASE_BDMDetail_ClusterWise SET Cluster = '" + txtcluster.Text + "', BDM = '" + txtbdm.Text + "',  ASE = '" + txtase.Text + "', Credit= '" + txtcredit.Text + "' WHERE ID='" + hdnid.Value + "'");
        if (Updatecount > 0)
        {
            fillgrid();
            objfun.MsgBox("Data Update Successfully...", this);

        }
        Reset();
    }



    protected void btnedit_Click(object sender, EventArgs e)
    {
        btnupdate.Enabled = true;
        LinkButton btn = (LinkButton)sender;
        GridViewRow row = (GridViewRow)btn.NamingContainer;

        string ID = gridview.DataKeys[row.RowIndex].Values[0].ToString();
        hdnid.Value = ID;

        DataTable dtedit = new DataTable();

        dtedit = objfun.FillDataTable("Select * from Shell_ASE_BDMDetail_ClusterWise where ID='" + ID + "' ");
        if (dtedit.Rows.Count > 0)
        {

            txtcluster.Text = dtedit.Rows[0]["Cluster"].ToString();

            txtbdm.Text = dtedit.Rows[0]["BDM"].ToString();

            txtase.Text = dtedit.Rows[0]["ASE"].ToString();

            txtcredit.Text = dtedit.Rows[0]["Credit"].ToString();

            btnupdate.Text = "Update";

           
        }
        
    }
   
    public void Reset()
    {
        btnupdate.Enabled = false;
        txtcluster.Text = "";
        txtbdm.Text = "";
        txtase.Text = "";
        txtcredit.Text = "";
    }
    protected void btnreset_Click(object sender, EventArgs e)
    {
        Reset();
    }
}