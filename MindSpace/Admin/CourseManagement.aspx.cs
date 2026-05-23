using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MindSpace
{
    public partial class CourseManagement : Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            RequireAdmin();
            if (!IsPostBack)
                LoadCourses();
        }

        private void RequireAdmin()
        {
            if (Session["UserID"] == null || Session["Role"]?.ToString() != "admin")
                Response.Redirect("~/Login.aspx");
        }

        private void LoadCourses(string search = "", string category = "")
        {
            string sql = @"
            SELECT c.CourseID, c.Title, c.Description, c.Category, c.DifficultyLevel,
                   c.Duration, c.IsActive,
                   (SELECT COUNT(*) FROM Enrollments WHERE CourseID=c.CourseID) AS EnrollmentCount
            FROM Courses c
            WHERE (@search='' OR c.Title LIKE @searchLike OR c.Description LIKE @searchLike)
            AND (@cat='' OR c.Category=@cat)
            ORDER BY c.DateCreated DESC";

            SqlParameter[] prms = {
                new SqlParameter("@search", search),
                new SqlParameter("@searchLike", "%" + search + "%"),
                new SqlParameter("@cat", category)
            };

            DataTable dt = DatabaseHelper.ExecuteQuery(sql, prms);
            gvCourses.DataSource = dt;
            gvCourses.DataBind();
            litCount.Text = dt.Rows.Count.ToString();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string title = txtTitle.Text.Trim();
            string desc = txtDescription.Text.Trim();
            string category = ddlCategory.SelectedValue;
            string difficulty = ddlDifficulty.SelectedValue;
            string duration = txtDuration.Text.Trim();
            bool isActive = ddlStatus.SelectedValue == "1";
            int editID = Convert.ToInt32(hdnEditCourseID.Value);
            int adminID = Convert.ToInt32(Session["UserID"]);

            try
            {
                if (editID == 0)
                {
                    string sql = @"INSERT INTO Courses (Title,Description,Category,DifficultyLevel,Duration,IsActive,CreatedBy)
                                   VALUES (@title,@desc,@cat,@diff,@dur,@active,@admin)";
                    DatabaseHelper.ExecuteNonQuery(sql, new[] {
                        new SqlParameter("@title", title),
                        new SqlParameter("@desc", desc),
                        new SqlParameter("@cat", category),
                        new SqlParameter("@diff", difficulty),
                        new SqlParameter("@dur", duration),
                        new SqlParameter("@active", isActive),
                        new SqlParameter("@admin", adminID)
                    });
                    ShowMessage("Course added successfully.");
                }
                else
                {
                    string sql = @"UPDATE Courses SET Title=@title,Description=@desc,Category=@cat,
                                   DifficultyLevel=@diff,Duration=@dur,IsActive=@active WHERE CourseID=@id";
                    DatabaseHelper.ExecuteNonQuery(sql, new[] {
                        new SqlParameter("@title", title),
                        new SqlParameter("@desc", desc),
                        new SqlParameter("@cat", category),
                        new SqlParameter("@diff", difficulty),
                        new SqlParameter("@dur", duration),
                        new SqlParameter("@active", isActive),
                        new SqlParameter("@id", editID)
                    });
                    ShowMessage("Course updated successfully.");
                }

                ResetForm();
                LoadCourses();
            }
            catch (Exception ex)
            {
                ShowError("Error: " + ex.Message);
            }
        }

        protected void gvCourses_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int courseID = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "EditCourse")
            {
                string sql = "SELECT * FROM Courses WHERE CourseID=@id";
                DataTable dt = DatabaseHelper.ExecuteQuery(sql, new[] { new SqlParameter("@id", courseID) });

                if (dt.Rows.Count == 1)
                {
                    DataRow r = dt.Rows[0];
                    hdnEditCourseID.Value = courseID.ToString();
                    txtTitle.Text = r["Title"].ToString();
                    txtDescription.Text = r["Description"].ToString();
                    ddlCategory.SelectedValue = r["Category"].ToString();
                    ddlDifficulty.SelectedValue = r["DifficultyLevel"].ToString();
                    txtDuration.Text = r["Duration"].ToString();
                    ddlStatus.SelectedValue = Convert.ToBoolean(r["IsActive"]) ? "1" : "0";
                    litFormTitle.Text = "Edit Course";
                }
            }
            else if (e.CommandName == "DeleteCourse")
            {
                DeleteCourse(courseID);
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
            => LoadCourses(txtSearch.Text.Trim(), ddlCatFilter.SelectedValue);

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            ddlCatFilter.SelectedValue = "";
            LoadCourses();
        }

        protected void btnCancel_Click(object sender, EventArgs e)
            => ResetForm();

        private void ResetForm()
        {
            hdnEditCourseID.Value = "0";
            txtTitle.Text = "";
            txtDescription.Text = "";
            txtDuration.Text = "";
            ddlCategory.SelectedIndex = 0;
            ddlDifficulty.SelectedIndex = 0;
            ddlStatus.SelectedValue = "1";
            litFormTitle.Text = "Add New Course";
            pnlError.Visible = false;
        }

        private void ShowMessage(string msg) { pnlMsg.Visible = true; litMsg.Text = msg; pnlError.Visible = false; }
        private void ShowError(string msg)  { pnlError.Visible = true; litError.Text = msg; pnlMsg.Visible = false; }

        private void DeleteCourse(int courseID)
        {
            try
            {
                // Verify the course exists before attempting delete
                string checkSql = "SELECT COUNT(*) FROM Courses WHERE CourseID=@id";
                object exists = DatabaseHelper.ExecuteScalar(checkSql, new[] { new SqlParameter("@id", courseID) });
                if (exists == null || Convert.ToInt32(exists) == 0)
                {
                    ShowError("Course not found or already deleted.");
                    LoadCourses();
                    return;
                }

                int affected;

                using (SqlConnection conn = DatabaseHelper.GetConnection())
                {
                    conn.Open();
                    using (SqlTransaction tx = conn.BeginTransaction())
                    {
                        try
                        {
                            using (SqlCommand cmd = conn.CreateCommand())
                            {
                                cmd.Transaction = tx;
                                cmd.Parameters.Add(new SqlParameter("@id", courseID));

                                cmd.CommandText = @"DELETE FROM QuizResults WHERE QuizID IN (SELECT QuizID FROM Quizzes WHERE CourseID=@id)";
                                cmd.ExecuteNonQuery();

                                cmd.CommandText = @"DELETE FROM QuestionOptions WHERE QuestionID IN (SELECT QuestionID FROM Questions WHERE QuizID IN (SELECT QuizID FROM Quizzes WHERE CourseID=@id))";
                                cmd.ExecuteNonQuery();

                                cmd.CommandText = @"DELETE FROM Questions WHERE QuizID IN (SELECT QuizID FROM Quizzes WHERE CourseID=@id)";
                                cmd.ExecuteNonQuery();

                                cmd.CommandText = @"DELETE FROM Quizzes WHERE CourseID=@id";
                                cmd.ExecuteNonQuery();

                                cmd.CommandText = @"DELETE FROM Resources WHERE CourseID=@id";
                                cmd.ExecuteNonQuery();

                                cmd.CommandText = @"DELETE FROM SuccessStories WHERE CourseID=@id";
                                cmd.ExecuteNonQuery();

                                cmd.CommandText = @"DELETE FROM Enrollments WHERE CourseID=@id";
                                cmd.ExecuteNonQuery();

                                cmd.CommandText = @"DELETE FROM Bookmarks WHERE CourseID=@id";
                                cmd.ExecuteNonQuery();

                                cmd.CommandText = @"DELETE FROM Courses WHERE CourseID=@id";
                                affected = cmd.ExecuteNonQuery();
                            }

                            tx.Commit();
                        }
                        catch
                        {
                            try { tx.Rollback(); } catch { }
                            throw;
                        }
                    }
                }

                if (affected > 0) ShowMessage("Course permanently deleted.");
                else ShowError("Course not found or already deleted.");
            }
            catch (Exception ex)
            {
                ShowError("Error deleting course: " + ex.Message);
            }

            LoadCourses();
        }
    }
}
