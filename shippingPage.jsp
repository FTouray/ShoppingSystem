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
                Connection connection = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/shoppingsystem?serverTimezone=UTC", "root", "root");
                } catch (SQLException | ClassNotFoundException e) {
                    e.printStackTrace();
                }
                
                try {
                    int i = 0;
                    for (Items item : basket) {
                        String itemName = item.getName();
                        // Retrieve item details from the database
                        String sql = "SELECT * FROM items WHERE name = ?";
                        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                            preparedStatement.setString(1, itemName);
                            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                                if (resultSet.next()) {
            %>
                                    <tr>
                                        <td><%= itemName %></td>
                                        <td><%= resultSet.getDouble("dimension") %></td>
                                        <td><%= resultSet.getDouble("weight") %></td>
                                        <td>
                                            <input onclick="updateNumberOfItems()" type="checkbox" name="selectedItems" value="<%= i %>">
                                        </td>
                                    </tr>
                                    <input type="hidden" id="item_<%= i %>" value='{"name": "<%= itemName %>", "dimension": <%= resultSet.getDouble("dimension") %>, "weight": <%= resultSet.getDouble("weight") %> }'>
            <%
                                    i++;
                                }
                            }
                        }
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            %>
        </table>

         

        <button onclick="calculatePacking()">Calculate Packing</button>
<br>
<br>
        <div id="numberOfBoxesDisplay">Number of Boxes Needed: <span id="numberOfBoxes"></span></div>
<br>
<a href="index.jsp">Back to Homepage</a>

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

           function calculatePacking() {
    var checkboxes = document.getElementsByName("selectedItems");
    var selectedItems = [];
    var totalDimensions = 0.0;
    var totalWeight = 0.0;

    for (var i = 0; i < checkboxes.length; i++) {
        if (checkboxes[i].checked) {
            var itemDetails = JSON.parse(document.getElementById("item_" + checkboxes[i].value).value);
            selectedItems.push(itemDetails);

           
            totalDimensions += itemDetails.dimension;
            totalWeight += itemDetails.weight;
        }
    }

  
    console.log(selectedItems);

    
    console.log("Total Dimensions: " + totalDimensions);
    console.log("Total Weight: " + totalWeight);

    
    var maxBoxDimensions = parseFloat(document.getElementById("boxDimensions").value);
    var maxBoxWeight = parseFloat(document.getElementById("boxWeight").value);

    var numberOfBoxes = 1;

    if (totalDimensions > maxBoxDimensions || totalWeight > maxBoxWeight) {
        
        numberOfBoxes = Math.ceil(Math.max(totalDimensions / maxBoxDimensions, totalWeight / maxBoxWeight));
    }

    document.getElementById("numberOfBoxes").textContent = numberOfBoxes;
     var encodedSelectedItems = encodeURIComponent(JSON.stringify(selectedItems));

    // Redirect to the confirmation page with relevant data
    window.location.href = "confirmationPage.jsp?totalDimensions=" + totalDimensions +
                           "&totalWeight=" + totalWeight +
                           "&numberOfBoxes=" + numberOfBoxes +
                           "&selectedItems=" + encodedSelectedItems;
}
        </script>

    </div>
</body>
</html>
