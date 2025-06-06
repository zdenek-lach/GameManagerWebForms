using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : Page
{
    // This name must match the <add name="MyDb" ...> in web.config
    private string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MyDb"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadGames();
        }
    }

    // 1) RowEditing: put the row in "edit mode"
    protected void GridView_RowEditing(object sender, GridViewEditEventArgs e)
    {
        // Set the GridView’s EditIndex to the row being edited
        GridView.EditIndex = e.NewEditIndex;
        LoadGames(); // Rebind data so the row appears with textboxes instead of labels
    }

    // 2) RowCancelingEdit: exit edit mode without saving
    protected void GridView_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GridView.EditIndex = -1; // "-1" means no row is being edited
        //LoadGames(); // PRG pattern
        Response.Redirect(Request.RawUrl);
    }

    // 3) RowUpdating: save the changes back to the DB
    protected void GridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        // 3a) Grab the Id of the row being updated
        int id = Convert.ToInt32(GridView.DataKeys[e.RowIndex].Value);

        // 3b) Find the new values from the row’s controls
        GridViewRow row = GridView.Rows[e.RowIndex];
        string newName = ((TextBox)row.Cells[1].Controls[0]).Text.Trim();
        string newGenre = ((TextBox)row.Cells[2].Controls[0]).Text.Trim();
        string newStudio = ((TextBox)row.Cells[3].Controls[0]).Text.Trim();

        // For ReleaseYear, the BoundField is converted to a TextBox in edit mode, same pattern:
        int newReleaseYear = 0;
        int.TryParse(((TextBox)row.Cells[4].Controls[0]).Text.Trim(), out newReleaseYear);

        // 3c) Update the record in the database
        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            string query = @"
                UPDATE Games
                SET Name = @Name,
                    Genre = @Genre,
                    Studio = @Studio,
                    ReleaseYear = @ReleaseYear
                WHERE Id = @Id";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@Name", newName);
            cmd.Parameters.AddWithValue("@Genre", newGenre);
            cmd.Parameters.AddWithValue("@Studio", newStudio);
            cmd.Parameters.AddWithValue("@ReleaseYear", newReleaseYear);
            cmd.Parameters.AddWithValue("@Id", id);

            conn.Open();
            cmd.ExecuteNonQuery();
        }

        // 3d) Exit edit mode and rebind
        GridView.EditIndex = -1;
        LoadGames();
    }

    // 4) RowDeleting: remove the row from the DB
    protected void GridView_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int id = (int)GridView.DataKeys[e.RowIndex].Value;

        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            string query = "DELETE FROM Games WHERE Id = @Id";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@Id", id);

            conn.Open();
            cmd.ExecuteNonQuery();
        }

        // After deleting, rebind so the row disappears
        // PRG pattern
        //LoadGames();
        Response.Redirect(Request.RawUrl);
    }
    protected void btnInsert_Click(object sender, EventArgs e)
    {
        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            // Append SELECT SCOPE_IDENTITY() to get the new Id back
            string query = @"
            INSERT INTO Games (Name, Genre, Studio, ReleaseYear)
            VALUES (@Name, @Genre, @Studio, @ReleaseYear);
            SELECT SCOPE_IDENTITY();";

            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@Name", txtName.Text);
            cmd.Parameters.AddWithValue("@Genre", txtGenre.Text);
            cmd.Parameters.AddWithValue("@Studio", txtStudio.Text);

            int year = 0;
            Int32.TryParse(txtReleaseYear.Text, out year);
            cmd.Parameters.AddWithValue("@ReleaseYear", year);

            conn.Open();
            // ExecuteScalar() will return the value of SCOPE_IDENTITY()
            object result = cmd.ExecuteScalar();

            // result is a decimal (SQL numeric), so convert to int
            int newId = Convert.ToInt32(result);

            // Refresh the grid, clear form, ..
            Response.Redirect(Request.RawUrl);
        }

        ClearForm();
        LoadGames();
    }


    //protected void btnUpdate_Click(object sender, EventArgs e)
    //{
    //    // Update an existing game by Id
    //    using (SqlConnection conn = new SqlConnection(connectionString))
    //    {
    //        string query = @"
    //            UPDATE Games
    //            SET Name=@Name, Genre=@Genre, Studio=@Studio, ReleaseYear=@ReleaseYear
    //            WHERE Id=@Id";
    //        SqlCommand cmd = new SqlCommand(query, conn);

    //        // Parse Id to int (if empty or invalid, Id=0; no row will match)
    //        int id = 0;
    //        Int32.TryParse(txtId.Text, out id);
    //        cmd.Parameters.AddWithValue("@Id", id);

    //        cmd.Parameters.AddWithValue("@Name", txtName.Text);
    //        cmd.Parameters.AddWithValue("@Genre", txtGenre.Text);
    //        cmd.Parameters.AddWithValue("@Studio", txtStudio.Text);

    //        int year = 0;
    //        Int32.TryParse(txtReleaseYear.Text, out year);
    //        cmd.Parameters.AddWithValue("@ReleaseYear", year);

    //        conn.Open();
    //        cmd.ExecuteNonQuery();
    //        Response.Redirect(Request.RawUrl);
    //    }

    //    ClearForm();
    //    LoadGames();
    //}

    private void LoadGames()
    {
        // Show all games in the GridView
        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT * FROM Games", conn);
            DataTable dt = new DataTable();
            adapter.Fill(dt);
            GridView.DataSource = dt;
            GridView.DataBind();
        }
    }

    private void ClearForm()
    {
        txtId.Text = "";
        txtName.Text = "";
        txtGenre.Text = "";
        txtStudio.Text = "";
        txtReleaseYear.Text = "";
    }
}