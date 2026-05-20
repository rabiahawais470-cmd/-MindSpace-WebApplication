using System;
using System.Data.SqlClient;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.SessionState;

namespace MindSpace.Handlers
{
    public class BookmarkHandler : IHttpHandler, IRequiresSessionState
    {
        public bool IsReusable { get { return false; } }

        public void ProcessRequest(HttpContext ctx)
        {
            ctx.Response.ContentType = "application/json";
            var ser = new JavaScriptSerializer();

            if (ctx.Session == null || ctx.Session["UserID"] == null)
            {
                ctx.Response.StatusCode = 401;
                ctx.Response.Write(ser.Serialize(new { ok = false, error = "not_authenticated" }));
                return;
            }

            int userID = Convert.ToInt32(ctx.Session["UserID"]);
            int courseID;
            if (!int.TryParse(ctx.Request["courseId"], out courseID) || courseID <= 0)
            {
                ctx.Response.StatusCode = 400;
                ctx.Response.Write(ser.Serialize(new { ok = false, error = "missing_courseId" }));
                return;
            }

            object courseRow = DatabaseHelper.ExecuteScalar(
                "SELECT CourseID FROM Courses WHERE CourseID=@cid AND IsActive=1",
                new[] { new SqlParameter("@cid", courseID) });
            if (courseRow == null || courseRow == DBNull.Value)
            {
                ctx.Response.StatusCode = 404;
                ctx.Response.Write(ser.Serialize(new { ok = false, error = "course_not_found" }));
                return;
            }

            object existing = DatabaseHelper.ExecuteScalar(
                "SELECT BookmarkID FROM Bookmarks WHERE UserID=@uid AND CourseID=@cid",
                new[] {
                    new SqlParameter("@uid", userID),
                    new SqlParameter("@cid", courseID)
                });

            bool nowBookmarked;
            if (existing != null && existing != DBNull.Value)
            {
                DatabaseHelper.ExecuteNonQuery(
                    "DELETE FROM Bookmarks WHERE UserID=@uid AND CourseID=@cid",
                    new[] {
                        new SqlParameter("@uid", userID),
                        new SqlParameter("@cid", courseID)
                    });
                nowBookmarked = false;
            }
            else
            {
                DatabaseHelper.ExecuteNonQuery(
                    "INSERT INTO Bookmarks (UserID, CourseID) VALUES (@uid, @cid)",
                    new[] {
                        new SqlParameter("@uid", userID),
                        new SqlParameter("@cid", courseID)
                    });
                nowBookmarked = true;
            }

            ctx.Response.Write(ser.Serialize(new { ok = true, bookmarked = nowBookmarked, courseId = courseID }));
        }
    }
}
