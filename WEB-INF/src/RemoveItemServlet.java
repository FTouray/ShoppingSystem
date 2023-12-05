import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;




public class RemoveItemServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int itemId = Integer.parseInt(request.getParameter("itemId"));

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try (Connection connection = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/shoppingsystem?serverTimezone=UTC", "root", "root")) {

            String sql = "DELETE FROM items WHERE id = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                preparedStatement.setInt(1, itemId);
                int rowsAffected = preparedStatement.executeUpdate();

                
                if (rowsAffected > 0) {
                    out.println("<script>alert('Item Removed Successfully');</script>");
                    response.sendRedirect("viewExpiredItems.jsp");

                } else {
                    out.println("<script>alert('Item Removed Unsuccessfully');window.history.go(-1);</script>");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}