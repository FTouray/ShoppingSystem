import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import itemclass.Items;


public class AddToBasketServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve parameters from the request
        String itemName = request.getParameter("itemName");
        double itemPrice = Double.parseDouble(request.getParameter("itemPrice"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        // Create or retrieve the shopping basket list from the session
        HttpSession session = request.getSession();
        ArrayList<Items> shoppingBasket = (ArrayList<Items>) session.getAttribute("basket");

        if (shoppingBasket == null) {
            shoppingBasket = new ArrayList<>();
        }

        // Check if the item is already in the basket
        for (Items item : shoppingBasket) {
            if (item.getName().equals(itemName)) {
                // Update the quantity and price if the item exists
                int newQuantity = item.getQuantity() + quantity;
                item.setQuantity(newQuantity);
                   session.setAttribute("basket", shoppingBasket);

                // Redirect back to the index page
                response.sendRedirect("index.jsp");
                return;
            }
        }

        // If the item is not in the basket, add it
        Items newItem = new Items(itemName, itemPrice, quantity);
        shoppingBasket.add(newItem);

        // Update the shopping basket in the session
        session.setAttribute("basket", shoppingBasket);

        // Redirect back to the index page
        response.sendRedirect("index.jsp");
    }
}
