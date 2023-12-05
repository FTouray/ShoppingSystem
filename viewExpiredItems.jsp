<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<html>
<head>
    <title>Expired Stock</title>
    <link rel="stylesheet" type="text/css" href="css/viewItemsStyle.css">
</head>

<body>
    <h2>Expired Stock List</h2>
    <table border="1">
        <tr>
            <th>Name</th>
            <th>Type</th>
            <th>Expiration Date</th>
            <th>VAT</th>
            <th>Price</th>
            <th>Weight</th>
            <th>Dimension</th>
            <th>Remove</th>
        </tr>

        <%
            try {
                Connection connection = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/shoppingsystem?serverTimezone=UTC", "root", "root");

                String sql = "SELECT * FROM items WHERE expirationDate < ?";
                try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                    preparedStatement.setDate(1, new java.sql.Date(System.currentTimeMillis()));
                    try (ResultSet resultSet = preparedStatement.executeQuery()) {
                        while (resultSet.next()) {
                            int itemId = resultSet.getInt("id");
        %>
        <tr id="<%= itemId %>">
            <td><%= resultSet.getString("name") %></td>
            <td><%= resultSet.getString("type") %></td>
            <td><%= resultSet.getString("expirationDate") %></td>
            <td><%= resultSet.getDouble("VAT") %></td>
            <td><%= resultSet.getDouble("price") %></td>
            <td><%= resultSet.getDouble("weight") %></td>
            <td><%= resultSet.getDouble("dimension") %></td>
            <td>
                 <form action="removeItem" method="GET">
              <input type="hidden" value="<%= itemId %>" name="itemId">
                <input type="submit" value="Remove">
        </form>
            </td>
        </tr>
        <%
                        }
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        %>
    </table>
    <form action="viewAllItems.jsp">
        <input type="submit" value="Back to View All Items">
    </form>
</body>
</html>