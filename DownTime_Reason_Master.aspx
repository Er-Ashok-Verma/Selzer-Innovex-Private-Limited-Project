<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DownTime_Reason_Master.aspx.cs" Inherits="DownTime_Reason_Master" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>DwonTime Reason Master</title>
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

    <%--  DATATABLE CSS END--%>
    <style>
        /* ===============================
   GLOBAL
=================================*/
        body {
            background: #f1f4f9;
            font-family: 'Segoe UI', sans-serif;
            font-size: 14px;
            color: #2c3e50;
        }

        /* ===============================
   CARD CONTAINER
=================================*/
        .page-card {
            background: #ffffff;
            border-radius: 14px;
            padding: 30px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.08);
            border: 1px solid #e3e8f0;
            transition: 0.3s ease-in-out;
        }

            .page-card:hover {
                box-shadow: 0 12px 30px rgba(0,0,0,0.12);
            }

        /* ===============================
   HEADER
=================================*/
        .page-header-blue {
            background: linear-gradient(90deg, #1e3c72, #2a5298);
            color: #ffffff;
            padding: 16px 22px;
            font-size: 18px;
            font-weight: 600;
            border-radius: 14px 14px 0 0;
            display: flex;
            align-items: center;
            gap: 10px;
            margin: -30px -30px 30px -30px;
            letter-spacing: 0.5px;
        }

            /* Icon circle */
            .page-header-blue i {
                background: rgba(255,255,255,0.15);
                padding: 8px;
                border-radius: 50%;
            }

        /* ===============================
   LABELS
=================================*/
        .form-label {
            font-weight: 600;
            font-size: 13px;
            color: #34495e;
        }

        /* ===============================
   DROPDOWN / INPUT
=================================*/
        .form-select,
        .select2-container--default .select2-selection--single {
            height: 40px !important;
            border-radius: 8px !important;
            border: 1px solid #ced4da !important;
            transition: 0.2s;
        }

            .form-select:focus {
                border-color: #2a5298;
                box-shadow: 0 0 0 0.15rem rgba(42, 82, 152, 0.25);
            }

        /* ===============================
   BUTTONS
=================================*/
        .btn {
            border-radius: 8px;
            padding: 8px 18px;
            font-weight: 500;
            transition: 0.3s;
            min-width: 110px;
        }

        /* Save Button */
        .btn-theme-primary {
            background-color: #1e3c72;
            border-color: #1e3c72;
            color: #ffffff;
        }

            .btn-theme-primary:hover {
                background-color: #16325c;
                border-color: #16325c;
            }

        /* Reset Button */
        .btn-theme-danger {
            background-color: #c0392b;
            border-color: #c0392b;
            color: #ffffff;
        }

            .btn-theme-danger:hover {
                background-color: #992d22;
                border-color: #992d22;
            }

        /* ===============================
   GRID STYLE
=================================*/
        .pro-grid {
            margin-top: 40px;
        }

            .pro-grid table {
                border-radius: 12px !important;
                overflow: hidden;
                border: 1px solid #e3e8f0;
            }

            .pro-grid thead th {
                background: #1e3c72 !important;
                color: #ffffff !important;
                font-weight: 600 !important;
                text-align: center !important;
                font-size: 13px !important;
                padding: 12px 8px !important;
            }

            .pro-grid tbody td {
                padding: 10px !important;
                text-align: center !important;
                font-size: 13px !important;
                border-bottom: 1px solid #f0f2f5 !important;
            }

            .pro-grid tbody tr:hover {
                background: #f4f7fc !important;
                transition: 0.2s;
            }

        /* ===============================
   DATATABLE BUTTONS
=================================*/
        .dt-buttons .btn {
            border-radius: 6px !important;
            padding: 5px 12px !important;
        }

        /* ===============================
   PAGINATION
=================================*/
        .dataTables_paginate .paginate_button {
            border-radius: 6px !important;
            padding: 4px 10px !important;
        }

        /* ===============================
   LOADER
=================================*/
        .progress-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(255, 255, 255, 0.8);
            z-index: 99999;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .progress-box {
            text-align: center;
            background: #ffffff;
            padding: 30px 40px;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
            font-weight: 600;
            color: #2c3e50;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
     <asp:ScriptManager ID="ScriptManager1" runat="server" />

        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>

                <div class="container-fluid mt-4">
                    <div class="page-card">

                        <!-- TITLE -->
                        <div class="page-header-blue">
                            <i class="fas fa-layer-group me-2"></i>
                           DownTime Reason Master
                        </div>


                        <!-- FORM -->
                        <div class="row g-3">
                            <div class="col-md-4">
                                <asp:Label ID="Label1" runat="server" Text="DownTime Reason"></asp:Label>
                                <asp:TextBox ID="txtDownTimeReason" runat="server" CssClass="form-control" ></asp:TextBox>
                            </div>
                        </div>

                        <div class="text-center mt-4">
                            <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-theme-primary me-2" OnClick="btnSave_Click" />

                            <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn btn-theme-danger me-2" OnClick="btnReset_Click"/>
                        </div>

                        <!-- GRID -->
                        <div class="pro-grid mt-4">
                            <div class="table-responsive">
                                <asp:GridView ID="gridview" runat="server"
                                    CssClass="table table-bordered table-hover nowrap"
                                    Width="100%"
                                    AutoGenerateColumns="false"
                                    ClientIDMode="Static"
                                    GridLines="None"
                                    ShowHeaderWhenEmpty="true"
                                    DataKeyNames="ID">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Action">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkEdit" runat="server" ToolTip="Edit"
                                                    CommandName="EditRow"  Onclick="lnkEdit_Click"
                                                    CssClass="text-primary">
                                                <i class="fas fa-edit" ></i>
                                                </asp:LinkButton>

                                                 <asp:LinkButton ID="lnkbtndelete" runat="server" ForeColor="Red" CausesValidation="False" 
                                            CommandName="Delete" Style="margin-left: 12px;" OnClick="lnkbtndelete_Click" 
                                             Text='<i class="fas fa-trash-alt"></i>' ToolTip="Delete" 
                                            OnClientClick="return confirm('Are you sure delete this Data?');">
                                                     </asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Sr.No">
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex + 1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="DownTime_Reason" HeaderText="DownTime Reason" />
                                    </Columns>
                                </asp:GridView>
                                <asp:HiddenField ID="hidden" runat="server" />

                            </div>
                        </div>
                    </div>
            </ContentTemplate>
        </asp:UpdatePanel>
         <asp:UpdateProgress ID="UpdateProgress1" runat="server"
            AssociatedUpdatePanelID="UpdatePanel1"
            DisplayAfter="0">
            <ProgressTemplate>
                <div class="progress-overlay">
                    <div class="progress-box">
                        <img src="<%= ResolveUrl("~/Images/Loading.gif") %>" width="80" />
                        <br />
                        <span>Please wait...</span>
                    </div>
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>
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
                         title: 'DwonTime Reason Report'
                     },
                     {
                         extend: 'pdfHtml5',
                         text: '<i class="fa-solid fa-file-pdf" style="color:red"></i>',
                         className: 'btn btn-sm btn-danger',
                         titleAttr: 'Export to PDF',
                         title: 'DwonTime Reason Report',
                         orientation: 'landscape',
                         pageSize: 'A4'
                     },
                     {
                         extend: 'print',
                         text: '<i class="fa-solid fa-print" style="color:blue"></i>',
                         className: 'btn btn-sm btn-info',
                         titleAttr: 'Export to Print ',
                         title: 'DwonTime Reason Report'
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
