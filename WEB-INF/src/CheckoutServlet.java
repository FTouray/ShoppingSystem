import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/CalculateTotalServlet")
public class CheckoutServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve parameters from the form submission
        String itemName = request.getParameter("itemName");
        double itemPrice = Double.parseDouble(request.getParameter("itemPrice"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        double vatRate = Double.parseDouble(request.getParameter("vatRate"));

        // Calculate total cost with VAT
        double totalCost = calculateTotalCost(itemPrice, quantity, vatRate);

        // Set attributes in the request to be used in checkout.jsp
        request.setAttribute("itemName", itemName);
        request.setAttribute("quantity", quantity);
        request.setAttribute("itemPrice", itemPrice);
        request.setAttribute("vatRate", vatRate);
        request.setAttribute("totalCost", totalCost);

        // Forward the request to checkout.jsp
        request.getRequestDispatcher("checkout.jsp").forward(request, response);
    }

    private double calculateTotalCost(double itemPrice, int quantity, double vatRate) {
        double totalCost = itemPrice * quantity * (1 + vatRate);
        return totalCost;
    }
}
