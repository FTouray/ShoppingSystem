<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="itemclass.Items" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/shippingPage.css">
    <title>Transaction Confirmation</title>
</head>
<body>
    <header>
        <h1>Transaction Confirmation</h1>
    </header>

    <div class="confirmation-container">
        <h2>Confirmation Details</h2>

        <% 
            
            int numberOfBoxes = Integer.parseInt(request.getParameter("numberOfBoxes"));

            // Retrieve the basket items from the session
            ArrayList<Items> selectedItems = (ArrayList<Items>) session.getAttribute("basket");
        %>

       
        <p><strong>Number of Boxes Needed:</strong> <%= numberOfBoxes %></p>

        <h2>Selected Items</h2>

        <table>
    <tr>
        <th>Item Name</th>
        <th>Quantity</th>
        <th>Total Cost (After Tax)</th>
    </tr>
    <% 
        double overallTotalCost = 0.0; // Initialize overall total cost

        for (Items item : selectedItems) {
    %>
            <tr>
                <td><%= item.getName() %></td>
                <td><%= item.getQuantity() %></td>
                <td>€<%= String.format("%.2f", item.getTotalCostAfterTax()) %></td>
            </tr>
            <% 
                // Add the item's total cost to the overall total cost
                overallTotalCost += item.getTotalCostAfterTax();
            %>
    <%
        }
    %>
    <!-- Display overall total cost after the loop -->
    <tr>
        <td colspan="2"><strong>Overall Total Cost:</strong></td>
        <td><strong>€<%= String.format("%.2f", overallTotalCost) %></strong></td>
    </tr>
</table>

        

        <p>Thank you for your purchase!</p>
    </div>
    <a href="index.jsp">Back to Homepage</a>

    <%
    // Clear the basket in the session
    session.removeAttribute("basket");
%>
</body>
</html>
