using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

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

    protected void btnInsert_Click(object sender, EventArgs e)
    {
        // Insert a new game using all four fields
        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            string query = @"
                INSERT INTO Games (Name, Genre, Studio, ReleaseYear)
                VALUES (@Name, @Genre, @Studio, @ReleaseYear)";
            SqlCommand cmd = new SqlCommand(query, conn);

            cmd.Parameters.AddWithValue("@Name", txtName.Text);
            cmd.Parameters.AddWithValue("@Genre", txtGenre.Text);
            cmd.Parameters.AddWithValue("@Studio", txtStudio.Text);
            // Parse ReleaseYear to int; default to 0 if parse fails
            int year = 0;
            Int32.TryParse(txtReleaseYear.Text, out year);
            cmd.Parameters.AddWithValue("@ReleaseYear", year);

            conn.Open();
            cmd.ExecuteNonQuery();
        }

        ClearForm();
        LoadGames();
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        // Update an existing game by Id
        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            string query = @"
                UPDATE Games
                SET Name=@Name, Genre=@Genre, Studio=@Studio, ReleaseYear=@ReleaseYear
                WHERE Id=@Id";
            SqlCommand cmd = new SqlCommand(query, conn);

            // Parse Id to int (if empty or invalid, Id=0; no row will match)
            int id = 0;
            Int32.TryParse(txtId.Text, out id);
            cmd.Parameters.AddWithValue("@Id", id);

            cmd.Parameters.AddWithValue("@Name", txtName.Text);
            cmd.Parameters.AddWithValue("@Genre", txtGenre.Text);
            cmd.Parameters.AddWithValue("@Studio", txtStudio.Text);

            int year = 0;
            Int32.TryParse(txtReleaseYear.Text, out year);
            cmd.Parameters.AddWithValue("@ReleaseYear", year);

            conn.Open();
            cmd.ExecuteNonQuery();
        }

        ClearForm();
        LoadGames();
    }

    private void LoadGames()
    {
        // Show all games in the GridView
        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT * FROM Games", conn);
            DataTable dt = new DataTable();
            adapter.Fill(dt);
            GridView1.DataSource = dt;
            GridView1.DataBind();
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
