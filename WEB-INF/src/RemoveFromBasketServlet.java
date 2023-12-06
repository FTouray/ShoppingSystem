import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import itemclass.Items;


public class RemoveFromBasketServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve parameters from the request
        String itemName = request.getParameter("itemName");
        int removeQuantity = Integer.parseInt(request.getParameter("removeQuantity"));

        // Create or retrieve the shopping basket list from the session
        HttpSession session = request.getSession();
        ArrayList<Items> shoppingBasket = (ArrayList<Items>) session.getAttribute("basket");

        if (shoppingBasket != null && !shoppingBasket.isEmpty()) {
            // Find the item in the basket
            for (Items item : shoppingBasket) {
                if (item.getName().equals(itemName)) {
                    int currentQuantity = item.getQuantity();
                    if (removeQuantity < currentQuantity) {
                        // Update quantity, price, and total
                        item.setQuantity(currentQuantity - removeQuantity);
                        double itemPrice = item.getPrice();
                        double totalItemPrice = itemPrice * item.getQuantity();

                        // Update the shopping basket in the session
                        session.setAttribute("basket", shoppingBasket);

                        // Redirect back to the shopping basket page
                        response.sendRedirect("shoppingBasket.jsp");
                        return;
                    } else if (removeQuantity == currentQuantity) {
                        // Remove the item from the basket if the quantity is equal to the current quantity
                        shoppingBasket.remove(item);

                        // Update the shopping basket in the session
                        session.setAttribute("basket", shoppingBasket);

                        // Redirect back to the shopping basket page
                        response.sendRedirect("shoppingBasket.jsp");
                        return;
                    } else {
                        // Handle the case where removeQuantity is greater than the current quantity
                        // You can add appropriate error handling or redirect to an error page
                        response.sendRedirect("errorPage.jsp");
                        return;
                    }
                }
            }
        }

        // Redirect back to the shopping basket page if the item is not found
        response.sendRedirect("shoppingBasket.jsp");
    }
}
