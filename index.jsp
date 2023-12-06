<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Retail System</title>
    <link rel="stylesheet" href="css/homepageStyle.css">
</head>
<body>
    <header>
        <h1>Infinite Skin</h1>
        <nav>
            <a href="AdminLogin.html" class="component-link">Stock Control</a>
            <a href="shoppingBasket.jsp" class="component-link">Shopping Basket and Calculations</a>
            <a href="changeCalculator.jsp" class="component-link">Correct Change Calculator</a>
            <a href="itemPacking.jsp" class="component-link">Item Packing</a>
        </nav>
    </header>

    <a href="AdminLogin.html" class="icon-link">
        <img src="images/login.png" alt="Login Icon">
        <span class="icon-label">Admin Login</span>
    </a>

    <a href="shoppingBasket.jsp" class="basket-icon-link">
        <img src="images/shoppingBasket.png" alt="Shopping Basket">
        <span class="icon-label">Shopping Basket</span>
    </a>

    <h2 text align="center">Available Stock Items</h2>

    <!-- Dropdown menu for filtering -->
    <form action="" method="get">
        <label for="typeFilter">Filter by Type:</label>
        <select name="typeFilter" id="typeFilter">
            <option value="all">All</option>
            <option value="luxury">Luxury</option>
            <option value="essential">Essential</option>
            <option value="gift">Gift</option>
        </select>
        <button type="submit">Apply Filter</button>
    </form>

    <div class="stock-items-container">
        <% 
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/shoppingsystem?serverTimezone=UTC", "root", "root");
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }

        // Get the selected filter value
        String filterValue = request.getParameter("typeFilter");

        try {
            String sql = "SELECT name, price, type FROM items";
            
            // Modify the query based on the selected filter
            if (filterValue != null && !filterValue.equals("all")) {
                sql += " WHERE type = ?";
            }

            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                // Set the parameter if the filter is applied
                if (filterValue != null && !filterValue.equals("all")) {
                    preparedStatement.setString(1, filterValue);
                }

                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    while (resultSet.next()) {
                        String name = resultSet.getString("name");
                        double priceBeforeTax = resultSet.getDouble("price");
                        String type = resultSet.getString("type");

                        // Format price as Euro currency with the symbol before the number
                        Locale irelandLocale = new Locale("en", "IE");
                        NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance(irelandLocale);
                        String formattedPrice = currencyFormatter.format(priceBeforeTax);
        %>
                        <div class="stock-item">
                            <h3 style="color: white;"><%= name %></h3>
                            <p style="color: white;">Price before tax: <%= formattedPrice %></p>
                            <p style="color: white;">Type: <%= type %></p>
                             <!-- Form for adding to the basket -->
                <form action="addToBasket" method="post">
                    <input type="hidden" name="itemName" value="<%= name %>">
                    <input type="hidden" name="itemPrice" value="<%= priceBeforeTax %>">
                    <label for="quantity">Quantity:</label>
                    <input type="number" name="quantity" value="1" min="1">
                    
                    <button type="submit" class="add-to-basket-btn" onclick="showFloatingMessage('Item added successfully')">Add to Basket</button>
                </form>
                        </div>
        <%
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        %>

    </div>
    <script>
    function showFloatingMessage(message) {
    console.log('Function called with message:', message);
}

    </script>
</body>
</html>
