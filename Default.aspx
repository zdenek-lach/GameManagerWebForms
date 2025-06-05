<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Game Manager</title>

    <!-- Bootstrap CSS (v5.3) -->
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">

    <style>
      /* Optional: add a subtle background color */
      body {
        background-color: #f8f9fa;
      }
      .form-section {
        background: #ffffff;
        border-radius: 0.5rem;
        box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
        padding: 2rem;
        margin-bottom: 2rem;
      }
    </style>
</head>
<body>
    <form id="form1" runat="server" class="container py-4">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <!-- ====== Form Header ====== -->
                <div class="text-center mb-4">
                    <h1 class="h3">🎮 Game Manager</h1>
                    <p class="text-muted">Insert or update your games below</p>
                </div>

                <!-- ====== Insert/Update Form ====== -->
                <div class="form-section">
                    <div class="row g-3">
                        <!-- Game ID (for update) -->
                        <div class="col-md-4">
                            <label for="txtId" class="form-label">Game ID (for Update)</label>
                            <asp:TextBox ID="txtId" runat="server" CssClass="form-control" />
                        </div>

                        <!-- Name -->
                        <div class="col-md-8">
                            <label for="txtName" class="form-label">Name</label>
                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control" />
                        </div>

                        <!-- Genre -->
                        <div class="col-md-6">
                            <label for="txtGenre" class="form-label">Genre</label>
                            <asp:TextBox ID="txtGenre" runat="server" CssClass="form-control" />
                        </div>

                        <!-- Studio -->
                        <div class="col-md-6">
                            <label for="txtStudio" class="form-label">Studio</label>
                            <asp:TextBox ID="txtStudio" runat="server" CssClass="form-control" />
                        </div>

                        <!-- Release Year -->
                        <div class="col-md-6">
                            <label for="txtReleaseYear" class="form-label">Release Year</label>
                            <asp:TextBox ID="txtReleaseYear" runat="server"
                                CssClass="form-control"
                                placeholder="e.g., 2022" />
                        </div>

                        <!-- Buttons -->
                        <div class="col-md-6 d-flex align-items-end justify-content-md-end">
                            <asp:Button ID="btnInsert" runat="server" Text="Insert"
                                OnClick="btnInsert_Click"
                                CssClass="btn btn-primary me-2" />
                            <asp:Button ID="btnUpdate" runat="server" Text="Update"
                                OnClick="btnUpdate_Click"
                                CssClass="btn btn-success" />
                        </div>
                    </div>
                </div>

                <!-- ====== GridView (Games List) ====== -->
                <div class="table-responsive">
                    <asp:GridView ID="GridView1" runat="server"
                        AutoGenerateColumns="True"
                        CssClass="table table-striped table-bordered align-middle"
                        HeaderStyle-CssClass="table-light"
                        EmptyDataText="No games found.">
                    </asp:GridView>
                </div>
            </div>
        </div>
    </form>

    <!-- Bootstrap JS (v5.3) and dependencies -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js" integrity="sha384-j1CDi7MgGQ12Z7Qab0qlWQ/Qqz24Gc6BM0thvEMVjHnfYGF0rmFCozFSxQBxwHKO" crossorigin="anonymous"></script>
</body>
</html>
