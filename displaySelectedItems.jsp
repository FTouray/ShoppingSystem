<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>

<!DOCTYPE html>
<html>
<head>
  <title>Selected Items</title>
  <style>
    /* Styling for basket and items */
    #basket {
      border: 1px solid #ccc;
      padding: 10px;
      margin-bottom: 20px;
    }
  </style>
</head>
<body>
  <h1>Your Selected Items</h1>
  
  <div id="basket">
    <h2>Shopping Basket</h2>
    <ul id="shoppingBasket">
      <!-- JSP logic for selected items -->
      <% 
      
        String[] selectedItems = {"Selected Item 1", "Selected Item 2", "Selected Item 3"};
        for (String item : selectedItems) { 
      %>
      <li><%= item %></li>
      <% } %>
    </ul>
  </div>

  <div id="items">
    <h2>All Items</h2>
    <!-- selected items displayed in basket -->
    <ul id="selectedItemsList">
      <!-- JSP logic for all items -->
      <%
        // Getting items from a database
        try {
          // Establish a connection to the database (replace with your database details)
          Context initContext = new InitialContext();
          Context envContext = (Context) initContext.lookup("java:/comp/env");
          DataSource dataSource = (DataSource) envContext.lookup("jdbc/mydb");
          Connection connection = dataSource.getConnection();

          // Prepare and execute SQL query to fetch all available items
          PreparedStatement statement = connection.prepareStatement("SELECT item_name FROM all_items"); // all_items is the table name, using it as placeholder
          ResultSet resultSet = statement.executeQuery();

          // Display all available items
          while (resultSet.next()) {
            String nameOfItem = resultSet.getString("item_name");
      %>
      <li><%= itemName %></li>
      <% 
          }
          // Close resources
          resultSet.close();
          statement.close();
          connection.close();
        } catch (Exception e) {
          e.printStackTrace();
        }
      %>
    </ul>
  </div>
</body>
</html>
