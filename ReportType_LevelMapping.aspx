<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReportType_LevelMapping.aspx.cs" Inherits="ReportType_LevelMapping" %>

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

   

     <style>
       
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f9;
            padding: 20px;
        }

        .container {
            max-width: 900px;
            background: #fff;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 0 12px rgba(0,0,0,0.1);
        }

        /* ===== HEADING ===== */
        .page-title {
            font-size: 20px;
            font-weight: 600;
            color: #003366;
            flex-align: center;
        }

        .heading-line {
            height: 3px;
            width: 100%;
            background-color: #003366;
            margin: 8px 0 25px 0;
            border-radius: 2px;
        }

        /* ===== INPUT ===== */
        .input-box {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 15px;
        }

        .asp-btn {
            padding: 10px 25px;
            border-radius: 5px;
            font-size: 15px;
            border: none;
        }

        .save-btn {
            background-color: #28a745;
            color: #fff;
        }

        .reset-btn {
            background-color: #dc3545;
            color: #fff;
        }

        /* Row spacing */
        .row.g-4 > [class^="col-"] {
            margin-bottom: 12px;
        }

        /* Professional Grid */
        .pro-grid {
            margin-top: 35px;
            margin-bottom: 10px;
            width: 100%;
            overflow-x: auto;
        }

            .pro-grid table {
                border: 1px solid #dee2e6;
                border-radius: 8px !important;
                overflow: hidden;
                width: 100% !important;
            }

            /* Fix header styling - REMOVE DUPLICATE COLOR */
            .pro-grid thead th {
                background: #004b8d !important;
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

            /* Hover effect */
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
        <script type="text/javascript">
            function applySelect2() {
                // List all your dropdown IDs in an array
                var ddlIds = [
                  '<%=ddldbr.ClientID%>',
        '<%=ddll.ClientID%>',
        ]; 
                ddlIds.forEach(function (id) {
                    var $ddl = $('#' + id);
                    // If it's already been Select2’d, destroy to avoid dupes
                    if ($ddl.hasClass('select2-hidden-accessible')) {
                        $ddl.select2('destroy');
                    }
                    // Re-initialize
                    $ddl.select2({ width: 'resolve' });
                });
            }

            // first init on full page load
            $(document).ready(function () {
                applySelect2();

                // then hook into every partial postback
                if (typeof (Sys) !== 'undefined' && Sys.WebForms && Sys.WebForms.PageRequestManager) {
                    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(applySelect2);
                }
            });
        </script>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div class="container">

                    <div class="d-flex align-items-center">
                        <i class="fas fa-layer-group me-2"></i>
                        <span class="page-title">Report Type Mapping</span>
                    </div>
                    <div class="heading-line"></div>
                    <div class="row g-2">

                        <div class="col-md-6">
                            <label class="form-label fw-semibold">DB Report</label>
                            <asp:DropDownList ID="ddldbr" runat="server" CssClass="form-select"></asp:DropDownList>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Level</label>
                            <asp:DropDownList ID="ddll" runat="server" CssClass="form-select" ></asp:DropDownList>
                        </div>

                        <div class="mt-4 d-flex gap-3 justify-content-center">
                            <asp:Button ID="btnsave" runat="server" CssClass="btn btn-success" Text="Save" OnClick="btnsave_Click"/>
                            <asp:Button ID="btnreset" runat="server" CssClass="btn btn-danger" Text="Reset" OnClick="btnreset_Click" />
                        </div>
                    </div>

                          <%--  GridView--%>
                            <div class="pro-grid mt-2">
                                 <asp:Label ID="lblRowCount" runat="server" Font-Bold="true" Font-Size="Small" CssClass="mb-2 d-block"></asp:Label>
                                <asp:GridView ID="gridview" runat="server"
                                    CssClass="table table-bordered table-hover"
                                    AutoGenerateColumns="false"
                                    ClientIDMode="Static"
                                    GridLines="None"
                                    ShowHeaderWhenEmpty="true"
                                    HeaderStyle-CssClass="grid-header"
                                    RowStyle-CssClass="grid-row"
                                    AlternatingRowStyle-CssClass="grid-alt-row" 
                                    DataKeyNames="ID">
                                    <Columns>

                                        <asp:TemplateField HeaderText="Sr.No">
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex + 1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:BoundField HeaderText="DB Report Type" DataField="DBReportType" />
                                        <asp:BoundField HeaderText="Level Type " DataField="DB_Level" />
                                        

                                        <asp:TemplateField HeaderText="Action">
                                            <ItemTemplate>
                                                <div class="action-icons">
                                                    <asp:LinkButton ID="btnedit" runat="server" ForeColor="Green" OnClick="btnedit_Click" CausesValidation="False"
                                                        CommandName="Select" Text='<i class="fas fa-edit fa-1x"></i>' ToolTip="Edit"></asp:LinkButton>

                                                    <asp:LinkButton ID="btndelete" runat="server" ForeColor="Red" CausesValidation="False" CommandName="Delete" Text='<i class="fas fa-trash-alt"></i>'
                                                        ToolTip="Delete" OnClick="btndelete_Click" OnClientClick="return confirm('Are you sure to delete this Report Type Mapping?');"> </asp:LinkButton>
                                                </div>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                    </Columns>
                                </asp:GridView>
                                <asp:HiddenField ID="hdnID" runat="server" />
            </ContentTemplate>
            <Triggers>
                <asp:PostBackTrigger ControlID="btnsave" />
                <asp:PostBackTrigger ControlID="btnreset" />
            </Triggers>
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
                     title: 'Report Type Mapping Details'
                 },
                 {
                     extend: 'pdfHtml5',
                     text: '<i class="fa-solid fa-file-pdf" style="color:red"></i>',
                     className: 'btn btn-sm btn-danger',
                     titleAttr: 'Export to PDF',
                     title: 'Report Type Mapping Details',
                     orientation: 'landscape',
                     pageSize: 'A4'
                 },
                 {
                     extend: 'print',
                     text: '<i class="fa-solid fa-print" style="color:blue"></i>',
                     className: 'btn btn-sm btn-info',
                     titleAttr: 'Print Report',
                     title: 'Report Type Mapping Details'
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
