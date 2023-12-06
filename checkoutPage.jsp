<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="itemclass.Items" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout</title>
    <link rel="stylesheet" href="css/checkoutStyle.css"> <!-- Link to your CSS file for styling -->
</head>
<body>

    <header>
        <h1>Checkout</h1>
    </header>

    <div class="checkout-container">
        <%
            ArrayList<Items> basket = (ArrayList<Items>)session.getAttribute("basket");

            if (basket != null && !basket.isEmpty()) {
                for (Items item : basket) {
                    double vatRate = item.getVatRate();
                    double priceAfterTax = item.getPrice() + (item.getPrice() * vatRate);
                    double amount = priceAfterTax * item.getQuantity();
        %>
                    <form action="calculateTotal" method="post">
                        <input type="hidden" name="itemName" value="<%= item.getName() %>">
                        <input type="hidden" name="itemPrice" value="<%= item.getPrice() %>">
                        <input type="hidden" name="quantity" value="<%= item.getQuantity() %>">
                        <input type="hidden" name="vatRate" value="<%= item.getVatRate() %>">

                        <h2><%= item.getName() %></h2>
                        <p>Quantity: <%= item.getQuantity() %></p>
                        <p>Price per unit: €<%= String.format("%.2f", item.getPrice()) %></p>
                        <p>VAT Rate: <%= String.format("%.2f", item.getVatRate() * 100) %>%</p>
                         <p>Price after tax: €<%= String.format("%.2f", priceAfterTax) %></p>
                          <p>Amount: €<%= String.format("%.2f", amount) %></p>

                    </form>
        <%
                }
        %>
                <!-- Displayed only once for the overall basket -->
                <form action="calculateTotal" method="post">
                    <label for="totalValue">Total Value of Shopping Basket: €</label>
                    <input type="text" id="totalValue" name="totalValue" required>

                    <label for="paymentAmount">Amount to Pay: €</label>
                    <input type="text" id="paymentAmount" name="paymentAmount" required>

                    <button type="submit">Calculate Total</button>
                </form>
                <a href="shoppingBasket.jsp">Back to Basket</a>
        <%
            } else {
        %>
                <p>Your basket is empty.</p>
        <%
            }
        %>
    </div>

</body>
</html>
