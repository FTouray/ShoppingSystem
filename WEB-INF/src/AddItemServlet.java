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

public class AddItemServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		Connection connection = null;
				try {
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			connection = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/shoppingsystem?serverTimezone=UTC", "root", "root");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		 String itemName = request.getParameter("itemName");
        String itemType = request.getParameter("itemType").toLowerCase();
        String expirationDate = request.getParameter("expirationDate");
        double price = Double.parseDouble(request.getParameter("price"));
        double weight = Double.parseDouble(request.getParameter("weight"));
        double dimension = Double.parseDouble(request.getParameter("dimension"));

// Print out responses in the web browser
response.setContentType("text/html");
PrintWriter out = response.getWriter();


double vatRate; //Vat Rates
        switch (itemType.toLowerCase()) {
            case "luxury":
                vatRate = 0.20; // 20%
                break;
            case "essential":
                vatRate = 0.10; // 10%
                break;
            case "gift":
                vatRate = 0.05; // 5%
                break;
            default:
                vatRate = 0.0; // default value
                break;
        }

        try  {
            String sql = "INSERT INTO items (name, type, expirationDate, VAT, price, weight, dimension) VALUES (?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                preparedStatement.setString(1, itemName);
                preparedStatement.setString(2, itemType);
                preparedStatement.setString(3, expirationDate);
                preparedStatement.setDouble(4, vatRate);
                preparedStatement.setDouble(5, price);
                preparedStatement.setDouble(6, weight);
                preparedStatement.setDouble(7, dimension);

                int rowsAffected = preparedStatement.executeUpdate();

                if (rowsAffected > 0) {
                    out.println("<script>alert('Item Added Successfully');</script>");
                    response.sendRedirect("addItemPage.jsp");
                } else {
                    out.println("<script>alert('Failed to add item');window.history.go(-1);</script>");
                    
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

	}

}


