<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GamesPage.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" data-bs-theme="dark">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Game Manager</title>

    <!-- Bootstrap CSS (v5.3.6) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous" />
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" />
    <style>
        html, body {
            transition: background-color 0.075s ease-in-out, color 0.1s ease-out;
        }

        .table-responsive {
            min-width: 100%;
            overflow-x: visible !important;
        }

        .table {
            width: 100%;
        }

            .table th, .table td {
                white-space: nowrap;
            }
    </style>

</head>
<body>
    <div class="d-flex justify-content-end">
        <button id="themeToggle" class="btn btn-secondary">
            <i id="themeIcon" class="bi bi-sun"></i>
        </button>
    </div>


    <form id="GameForm" runat="server" class="container py-4 needs-validation" novalidate>

        <div class="row justify-content-center">
            <div class="col-lg-8">
                <!-- ====== Form Header ====== -->
                <div class="text-center mb-4">
                    <h1 class="h3">Game Manager 🎮</h1>
                    <p class="text-muted">Insert or update your games below</p>
                </div>

                <!-- ====== Insert Form ====== -->
                <div class="form-section mb-4 p-2 shadow-sm">
                    <div class="row g-3">
                        <!-- Game ID is hidden because assignment is handled by the DB -->
                        <asp:Panel ID="pnlIdForUpdate" runat="server" Visible="false">
                            <div class="col-md-4">
                                <label for="txtId" class="form-label">Game ID (for Update)</label>
                                <asp:TextBox ID="txtId" runat="server" CssClass="form-control" ReadOnly="true" />
                            </div>
                        </asp:Panel>

                        <!-- Name (required) -->
                        <div class="col-md-6">
                            <label for="txtName" class="form-label">Name</label>
                            <asp:TextBox
                                ID="txtName"
                                runat="server"
                                CssClass="form-control"
                                placeholder="eg. DOOM"
                                required="required" />
                            <div class="invalid-feedback">
                                Please enter a name of your game.
                            </div>

                        </div>


                        <!-- Genre -->
                        <div class="col-md-6">
                            <label for="txtGenre" class="form-label">Genre</label>
                            <asp:TextBox ID="txtGenre" runat="server" CssClass="form-control" placeholder=" eg. Action" />
                        </div>

                        <!-- Studio -->
                        <div class="col-md-6">
                            <label for="txtStudio" class="form-label">Studio</label>
                            <asp:TextBox ID="txtStudio" runat="server" CssClass="form-control" placeholder=" eg. id Software" />
                        </div>

                        <!-- Release Year -->
                        <div class="col-md-6">
                            <label for="txtReleaseYear" class="form-label">Release Year</label>
                            <asp:TextBox ID="txtReleaseYear" runat="server"
                                CssClass="form-control"
                                placeholder="eg. 1993" />
                        </div>

                        <!-- Buttons -->
                        <div class="col-md-12 d-flex justify-content-center">
                            <asp:Button ID="btnInsert" runat="server" Text="Save New Game"
                                OnClick="btnInsert_Click"
                                CssClass="btn btn-primary me-2"
                                ClientIDMode="Static" />

                        </div>

                    </div>
                </div>

                <!-- ====== GridView (Games List) ====== -->
                <div class="table-responsive">
                    <asp:GridView
                        ID="GridView"
                        runat="server"
                        AutoGenerateColumns="False"
                        CssClass="table table-striped table-bordered align-middle"
                        EmptyDataText="No games found."
                        DataKeyNames="Id"
                        OnRowEditing="GridView_RowEditing"
                        OnRowCancelingEdit="GridView_RowCancelingEdit"
                        OnRowUpdating="GridView_RowUpdating"
                        OnRowDeleting="GridView_RowDeleting">
                        <Columns>
                            <asp:BoundField
                                DataField="Id"
                                HeaderText="ID"
                                ReadOnly="True"
                                ItemStyle-Width="50px" />

                            <asp:BoundField
                                DataField="Name"
                                HeaderText="Name" />

                            <asp:BoundField
                                DataField="Genre"
                                HeaderText="Genre" />

                            <asp:BoundField
                                DataField="Studio"
                                HeaderText="Studio" />

                            <asp:BoundField
                                DataField="ReleaseYear"
                                HeaderText="Release Year" />

                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Button ID="btnEdit" runat="server" Text="Edit" CommandName="Edit" CssClass="btn btn-primary btn-sm" />
                                    <asp:Button ID="btnDelete" runat="server" Text="Delete" CommandName="Delete" CssClass="btn btn-danger btn-sm" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:Button ID="btnUpdate" runat="server" Text="Update" CommandName="Update" CssClass="btn btn-success btn-sm" />
                                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" CommandName="Cancel" CssClass="btn btn-secondary btn-sm" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                        </Columns>
                    </asp:GridView>

                </div>
            </div>
        </div>
    </form>


    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js" integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO" crossorigin="anonymous"></script>
</body>
<script>
    document.getElementById("themeToggle").addEventListener("click", function () {
        const htmlElement = document.documentElement;
        const themeIcon = document.getElementById("themeIcon");
        const currentTheme = htmlElement.getAttribute("data-bs-theme");

        if (currentTheme === "light") {
            htmlElement.setAttribute("data-bs-theme", "dark");
            themeIcon.className = "bi bi-sun";
        } else {
            htmlElement.setAttribute("data-bs-theme", "light");
            themeIcon.className = "bi bi-moon";
        }
    });
    
    // Bootstrap custom validation: Prevent form submission if Name is empty
    (function () {
        'use strict';
        var form = document.getElementById('GameForm');

        form.addEventListener('submit', function (event) {
            // event.submitter is the <button> or <input type="submit"> that triggered this submit event.
            // We only want to validate when the Save Game button (ID="btnInsert") was clicked.
            var btn = event.submitter;
            if (btn && btn.id === 'btnInsert') {
                // Only run validation for the Insert button
                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                form.classList.add('was-validated');
            } else {
                // If it wasn't the Save Game button (e.g. Edit/Update/Delete in GridView),
                // skip validation so inline edits/deletes work normally.
            }
        }, false);
    })();

</script>


</html>
