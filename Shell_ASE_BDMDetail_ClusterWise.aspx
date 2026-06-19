<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Shell_ASE_BDMDetail_ClusterWise.aspx.cs" Inherits="Shell_ASE_BDMDetail_ClusterWise" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <!-- Bootstrap -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <!-- Select2 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css" />
    <!-- DataTables -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css" />
    <link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.4.1/css/buttons.dataTables.min.css" />

    <%--  DATATABLE CSS START--%>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.7.0.js"></script>

    <!-- DataTables -->
    <script src="https://cdn.datatables.net/1.13.7/js/jquery.dataTables.min.js"></script>

    <!-- DataTables Buttons -->
    <script src="https://cdn.datatables.net/buttons/2.4.2/js/dataTables.buttons.min.js"></script>

    <!-- Excel Export -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.4.2/js/buttons.html5.min.js"></script>

    <!-- PDF Export -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>

    <!-- Print -->
    <script src="https://cdn.datatables.net/buttons/2.4.2/js/buttons.print.min.js"></script>

    <!-- Select2 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.full.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

     <script>
         function validnum() {
             var num = event.keyCode;
             if ((num >= 48 && num <= 57) || num == 46) {
                 return true;
             } else {
                 alert("Please Enter Only Number");
                 return false;
             }
         }
</script>
     
    
    <style>
        body {
            background: #eef2f7;
            font-family: 'Segoe UI', sans-serif;
            font-size: 14px;
        }

        /* PAGE LEVEL MARGIN (IMPORTANT) */
        .page-wrapper {
            margin: 10px 10px 10px 10px; /* top right bottom left */
        }

        /* Main Card */
        .main-card {
            border: none;
            border-radius: 10px;
            background: #ffffff;
            box-shadow: 0px 3px 12px rgba(0,0,0,0.08);
            margin-bottom: 40px; /* space below card */
        }

        .card-header-custom {
            background: linear-gradient(90deg, #0f766e, #14b8a6);
            color: white;
            padding: 14px 22px;
            border-radius: 10px 10px 0 0;
            font-size: 16px;
            font-weight: 600;
        }

        .card-body {
            padding: 30px; /* increased padding */
        }

        /* FORM */
        .form-label {
            font-weight: 600;
            font-size: 14px;
            margin-bottom: 6px;
        }

        .form-select {
            min-height: 42px;
            padding: 8px 12px;
        }

        /* Buttons */
        .btn {
            font-weight: 600;
            padding: 9px 26px;
            border-radius: 6px;
        }

        /* Row spacing */
        .row.g-4 > [class^="col-"] {
            margin-bottom: 12px;
        }

        /* Professional Grid */
        .pro-grid {
            margin-top: 0px;
            margin-bottom: 10px;
            width: 100%;
        }

            .pro-grid table {
                border: 1px solid #dee2e6;
                border-radius: 8px !important;
                overflow: hidden;
                width: 100% !important;
            }

            /* Fix header styling - REMOVE DUPLICATE COLOR */
            .pro-grid thead th {
                background: #26837c !important;
                color: white !important;
                font-weight: 600 !important;
                text-align: center !important;
                vertical-align: middle !important;
                border: none !important;
                font-size: 13px !important;
            }

            /* Fix cell styling */
            .pro-grid tbody td {
                padding: 10px 8px !important;
                font-size: 13px !important;
                text-align: center !important;
                vertical-align: middle !important;
                border-bottom: 1px solid #eaeaea !important;
            }

            /*Hover effect*/
            .pro-grid tbody tr:hover {
                background: #f8f9fa !important;
                transition: 0.2s;
            }

        /* DataTables specific overrides */
        .dataTables_wrapper {
            margin-top: 20px;
        }

            .dataTables_wrapper .dt-buttons {
                margin-bottom: 10px;
            }

        /* Remove duplicate header from fixedHeader plugin */
        .fixedHeader-floating {
            display: none !important;
        }

        .dataTables_scrollHead {
            border: none !important;
        }

        .dataTables_scrollHeadInner {
            width: 100% !important;
        }

            .dataTables_scrollHeadInner table {
                width: 100% !important;
                margin-bottom: 0 !important;
            }

        /* Ensure proper alignment in Export buttons */
        .dt-buttons .btn {
            margin-right: 5px;
        }

        /* Fix for DataTables pagination */
        .dataTables_paginate .paginate_button {
            padding: 6px 12px !important;
            margin: 0 2px !important;
        }
        /* Full screen overlay */
        .progress-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(255, 255, 255, 0.7);
            z-index: 99999;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        /* Loader box */
        .progress-box {
            text-align: center;
            background: #ffffff;
            padding: 25px 35px;
            border-radius: 10px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.15);
            font-weight: 600;
            color: #333;
        }

        .action-icons a,
        .action-icons .aspNetDisabled {
            display: inline-block;
            margin: 0 10px;
            font-size: 13px;
            text-decoration: none;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" />

        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div class="page-wrapper">
                    <div class="main-card">

                        <div class="card-header-custom">
                            <i class="fa-solid fa-receipt"></i>
                            ASE BDM Detail
                        </div>
                        <div class="card-body">
                            <div class="row g-3">

                                <div class="col-md-4">
                                    <asp:Label ID="Label1" runat="server" Text="Cluster:"></asp:Label>
                                    <asp:TextBox ID="txtcluster" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>

                                <div class="col-md-4">
                                    <asp:Label ID="Label2" runat="server" Text="BDM:"></asp:Label>
                                    <asp:TextBox ID="txtbdm" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>

                                <div class="col-md-4">
                                    <asp:Label ID="Label3" runat="server" Text="ASE:"></asp:Label>
                                    <asp:TextBox ID="txtase" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>

                                <div class="col-md-4">
                                    <asp:Label ID="Label4" runat="server" Text="Credit:"></asp:Label>
                                    <asp:TextBox ID="txtcredit" runat="server" CssClass="form-control" onkeypress="return validnum()" ></asp:TextBox>
                                </div>


                                <div class="mt-4 d-flex gap-3 justify-content-center">
                                    <asp:Button ID="btnupdate" runat="server" CssClass="btn btn-success" Text="Update" OnClick="btnupdate_Click" />
                                    <asp:Button ID="btnreset" runat="server" CssClass="btn btn-danger" Text="Reset" OnClick="btnreset_Click" />
                                </div>
                            </div>

                            <%--  GridView--%>
                            <div class="pro-grid mt-4">
                                <asp:GridView ID="gridview" runat="server"
                                    CssClass="table table-bordered table-hover"
                                    AutoGenerateColumns="False"
                                    ClientIDMode="Static"
                                    GridLines="None"
                                    ShowHeaderWhenEmpty="true"
                                    HeaderStyle-CssClass="grid-header"
                                    RowStyle-CssClass="grid-row"
                                    AlternatingRowStyle-CssClass="grid-alt-row"
                                    DataKeyNames="ID,Cluster">
                                    <Columns>

                                        <asp:TemplateField HeaderText="Sr.No">
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex + 1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:BoundField HeaderText="Cluster" DataField="Cluster" />
                                        <asp:BoundField HeaderText="BDM " DataField="BDM" />
                                        <asp:BoundField HeaderText="ASE" DataField="ASE" />
                                        <asp:BoundField HeaderText="Credit" DataField="Credit" />

                                        <asp:TemplateField HeaderText="Action">
                                            <ItemTemplate>
                                                <div class="action-icons">
                                                    <asp:LinkButton ID="btnedit" runat="server" ForeColor="Green" OnClick="btnedit_Click" CausesValidation="False"
                                                        CommandName="Select" Text='<i class="fas fa-edit fa-1x"></i>' ToolTip="Edit"></asp:LinkButton>

                                                    <asp:LinkButton ID="btndelete" runat="server" ForeColor="Red" CausesValidation="False" CommandName="Delete" Text='<i class="fas fa-trash-alt"></i>'
                                                        ToolTip="Delete" OnClick="btndelete_Click" OnClientClick="return confirm('Are you sure to delete this Product?');"> </asp:LinkButton>
                                                </div>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                    </Columns>
                                </asp:GridView>
                                <asp:HiddenField ID="hdnid" runat="server" />
                            </div>

                        </div>
                    </div>
                </div>


            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
    <script type="text/javascript">
        function pageLoad(sender, args) {
            // Destroy old datatable on postback
            if ($.fn.DataTable.isDataTable('#gridview')) {
                $('#gridview').DataTable().destroy();
                $('#gridview').css('width', '100%');
            }

            // Convert GridView header into THEAD
            $("#gridview").prepend(
                $("<thead></thead>").append($("#gridview").find("tr:first"))
            );

            // Initialize DataTable WITHOUT fixedHeader plugin
            $('#gridview').DataTable({
                fixedHeader: false, // DISABLE fixed header to avoid duplicate
                bFilter: true,
                bSort: true,
                bPaginate: true,

                scrollCollapse: true,
                dom: '<"top"Bf>rt<"bottom"ip><"clear">',
                lengthMenu: [
                    [10, 25, 50, -1],
                    ['10 rows', '25 rows', '50 rows', 'Show all']
                ],
                buttons: [
                    {
                        extend: 'pageLength',
                        className: 'btn btn-sm btn-outline-secondary'
                    },
                    {
                        extend: 'excelHtml5',
                        text: '<i class="fa-solid fa-file-excel" style="color:green"></i>',
                        className: 'btn btn-sm btn-success',
                        titleAttr: 'Export to Excel',
                        title: 'ASE BDM Details'
                    },
                    {
                        extend: 'pdfHtml5',
                        text: '<i class="fa-solid fa-file-pdf" style="color:red"></i>',
                        className: 'btn btn-sm btn-danger',
                        titleAttr: 'Export to PDF',
                        title: 'ASE BDM Details',
                        orientation: 'landscape',
                        pageSize: 'A4'
                    },
                    {
                        extend: 'print',
                        text: '<i class="fa-solid fa-print" style="color:blue"></i>',
                        className: 'btn btn-sm btn-info',
                        titleAttr: 'Print Report',
                        title: 'ASE BDM Details'
                    }
                ],
                initComplete: function () {
                    // Ensure proper width after initialization
                    this.api().columns.adjust();

                    // Remove any duplicate headers created by DataTables
                    $('.fixedHeader-floating').remove();
                    $('.dataTables_scrollHead').css('border', 'none');
                },
                columnDefs: [
                    { targets: '_all', className: 'dt-center' }
                ],
                language: {
                    paginate: {
                        previous: '<i class="fas fa-chevron-left"></i>',
                        next: '<i class="fas fa-chevron-right"></i>'
                    }
                }
            });
        }
    </script>
</body>
</html>



