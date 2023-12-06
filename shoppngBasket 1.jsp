<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="itemclass.Items" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Basket</title>
    <link rel="stylesheet" href="css/basketStyle.css"> 
</head>
<body>

    <header>
        <h1>Shopping Basket</h1>
        <p>Proceed to Checkout to See Prices After VAT</p>
    </header>

    <div class="basket-container">
        <table>
            <tr>
                <th>Item</th>
                <th>Quantity</th>
                <th>Price</th>
                <th>Total</th>
                <th>Action</th>
            </tr>
            <% 
                ArrayList<Items> basket = (ArrayList<Items>) session.getAttribute("basket");

                if (basket != null && !basket.isEmpty()) {
                    double totalPrice = 0.0;

                    for (Items item : basket) {
                        String itemName = item.getName();
                        int quantity = item.getQuantity();
                        double itemPrice = item.getPrice();
                        double totalItemPrice = itemPrice * quantity;

                        totalPrice += totalItemPrice;
            %>
                        <tr>
                            <td><%= itemName %></td>
                            <td><%= quantity %></td>
                            <td>€<%= String.format("%.2f", itemPrice) %></td>
                            <td>€<%= String.format("%.2f", totalItemPrice) %></td>
                            <td>
                                <form action="RemoveFromBasket" method="post">
                                    <input type="hidden" name="itemName" value="<%= itemName %>">
                                    <label for="removeQuantity">Remove:</label>
                                    <input type="number" name="removeQuantity" value="1" min="1" max="<%= quantity %>">
                                    <button type="submit">Remove</button>
                                </form>
                            </td>
                        </tr>
            <%
                    }

            %>
                    <tr>
                        <td colspan="3"></td>
                        <td>Total: €<%= String.format("%.2f", totalPrice) %></td>
                        <td></td>
                    </tr>
            <%
                } else {
            %>
                   <tr>
                        <td colspan="5" class="empty-basket-message">
                            Your basket is empty.
                        </td>
                    </tr>
            <%
                }
            %>
        </table>
        
        <div class="checkout-button">
            <a href="checkoutPage.jsp">Proceed to Checkout</a>
        </div>
        
        <!-- Continue Shopping button linking back to the index page -->
        <div class="continue-shopping-button">
            <a href="index.jsp">Continue Shopping</a>
        </div>
    </div>
</body>
</html>
