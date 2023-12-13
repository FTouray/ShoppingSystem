<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="itemclass.Items" %>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet" href="css/shippingPage.css">

    <link rel="stylesheet" href="css/checkoutStyle.css">

    <title>Item Packing</title>

</head>

<body>

 

    <header>

        <h1>Item Packing</h1>

    </header>

 

    <div class="packing-container">

        <% 

            ArrayList<Items> basket = (ArrayList<Items>)session.getAttribute("basket");

        %>

 

            <label for="boxDimensions">Box Dimensions (Width x Height x Depth):</label>

            <input type="text" id="boxDimensions" name="boxDimensions" required>

 

            <label for="boxWeight">Box Maximum Weight:</label>

            <input type="text" id="boxWeight" name="boxWeight" required>

 

            <label id="numberOfItems">Number of Items: 0</label>

 

            <hr>

 

            <table>

                <tr>

                    <th>Item Name</th>

                    <th>Dimensions (Width x Height x Depth)</th>

                    <th>Weight</th>

                    <th>Select</th>

                </tr>

 

                <%

                   

 

                    try {

                        Connection connection = DriverManager.getConnection(

                                "jdbc:mysql://localhost:3306/shoppingsystem?serverTimezone=UTC", "root", "root");

 

                        String sql = "SELECT * FROM items";

                        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

                            try (ResultSet resultSet = preparedStatement.executeQuery()) {

                                int i = 0;

                                while (resultSet.next()) {

                                    for (Items item : basket) {

                                        if (resultSet.getString("name").equals(item.getName())) {

                                            i++;

                %>

                <tr>

                    <td><%= resultSet.getString("name") %></td>

                    <td><%= resultSet.getDouble("dimension") %></td>

                    <td>

                        <%= resultSet.getDouble("weight") %>

                    </td>

                    <td>

        <input onclick="updateNumberOfItems()" type="checkbox" name="selectedItems" value="<%= i %>">

                    </td>

                </tr>

                <%

 

                                           

                                        }

                                    }

                                }

                            

                            }

                        }

                    }

                   

                    catch (SQLException e) {

                        e.printStackTrace();

                    }

                %>

            </table>

 

         <button onclick="calculatePacking()">Calculate Packing</button>

<div id="numberOfBoxesDisplay">Number of Boxes Needed: <span id="numberOfBoxes"></span></div>

<script>

   function updateNumberOfItems() {

    var checkboxes = document.getElementsByName("selectedItems");

    var numberOfItemsLabel = document.getElementById("numberOfItems");

 

    var selectedItems = 0;

    for (var i = 0; i < checkboxes.length; i++) {

        if (checkboxes[i].checked) {

            selectedItems++;

        }

    }

 

    numberOfItemsLabel.textContent = "Number of Items: " + selectedItems;

}

 

</script>

 

    </div>

   

</body>

</html>