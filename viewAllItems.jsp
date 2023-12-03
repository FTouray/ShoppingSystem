<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<html>
<head>
    <title>Display Items</title>
    <link rel="stylesheet" type="text/css" href="css/viewItemsStyle.css">
</head>


<body>
    <h2>Items List</h2>
    <table border="1">
        <tr>
            <th>Name</th>
            <th>Type</th>
            <th>Expiration Date</th>
            <th>VAT</th>
            <th>Price</th>
            <th>Weight</th>
            <th>Dimension</th>
        </tr>

        <%
            try {
                Connection connection = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/shoppingsystem?serverTimezone=UTC", "root", "root");

                String sql = "SELECT * FROM items";
                try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                    try (ResultSet resultSet = preparedStatement.executeQuery()) {
                        while (resultSet.next()) {
        %>
                            <tr>
                                <td><%= resultSet.getString("name") %></td>
                                <td><%= resultSet.getString("type") %></td>
                                <td><%= resultSet.getString("expirationDate") %></td>
                                <td><%= resultSet.getDouble("VAT") %></td>
                                <td><%= resultSet.getDouble("price") %></td>
                                <td><%= resultSet.getDouble("weight") %></td>
                                <td><%= resultSet.getDouble("dimension") %></td>
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
</body>
</html>








