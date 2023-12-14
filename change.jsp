<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="itemclass.Items" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout</title>
    <link rel="stylesheet" href="css/checkoutStyle.css"> 
</head>
<body>
    <header>
        <h1>Checkout</h1>
    </header>

    <div class="checkout-container">
        <% 
            ArrayList<Items> basket = (ArrayList<Items>) session.getAttribute("basket");
            double totalValue = 0;

            if (basket != null && !basket.isEmpty()) {
                for (Items item : basket) {
                    double vatRate = item.getVatRate();
                    double priceAfterTax = item.getPrice() + (item.getPrice() * vatRate);
                    double amount = priceAfterTax * item.getQuantity();
                    totalValue += amount;
                    // Display item details as needed
                }
        %>          
                <!-- Display total value -->
                <label for="total">Total: €<%= String.format("%.2f", totalValue) %> </label>
                
                <!-- Form for payment and change calculation -->
                <form onsubmit="calculateChange(); return false;">
                    <label for="totalValue">Total Value of Shopping Basket: €</label>
                    <input type="number" id="totalValue" min="0" step="0.01" required><br>

                    <label for="paymentAmount">Amount to Pay: €</label>
                    <input type="number" id="paymentAmount" min="0" step="0.01" required><br>
                  <br>
                    <button type="submit">Calculate Total</button>
                </form>

                <!-- Display change and notes/coins -->
                <p id="changeMessage"></p>
                <p id="notesCoins"></p>

                <a href="shippingPage.jsp">Shipping details</a>
                <!-- Back to Basket link -->
                <br>
                <br>
                <a href="shoppingBasket.jsp">Back to Basket</a>

        <% } else { %>
            <p>Your basket is empty.</p>
        <% } %>
    </div>

    <script>
        function calculateChange() {
            var totalValue = parseFloat(document.getElementById('totalValue').value);
            var paymentAmount = parseFloat(document.getElementById('paymentAmount').value);
            var change = paymentAmount - totalValue;
    
            if (change >= 0) {
                document.getElementById('changeMessage').innerHTML = 'Change: €' + change.toFixed(2);
    
                // Calculate notes and coins
                var denominations = [500, 200, 100, 50, 20, 10, 5, 2, 1, 0.5, 0.2, 0.1, 0.05, 0.02, 0.01];
                var notesCoinsNames = ['€500', '€200', '€100', '€50', '€20', '€10', '€5', '€2', '€1', '50c', '20c', '10c', '5c', '2c', '1c'];
                var notesCoinsCount = {};
    
                for (var i = 0; i < denominations.length; i++) {
                    var count = Math.floor(change / denominations[i]);
                    if (count > 0) {
                        notesCoinsCount[notesCoinsNames[i]] = count;
                        change -= count * denominations[i];
                        change = parseFloat(change.toFixed(2));
                    }
                }
    
                // Display notes and coins
                var notesCoinsOutput = 'Notes and Coins: <br>';
                for (var key in notesCoinsCount) {
                    if (notesCoinsCount.hasOwnProperty(key)) {
                        notesCoinsOutput += key + ': ' + notesCoinsCount[key] + '<br>';
                    }
                }
                document.getElementById('notesCoins').innerHTML = notesCoinsOutput;
            } else {
                document.getElementById('changeMessage').innerHTML = 'Insufficient payment amount.';
                document.getElementById('notesCoins').innerHTML = '';
            }
        }
    </script>
    
</body>
</html>