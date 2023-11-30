<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add Items</title>
    <link rel="stylesheet" href="css/addItemStyle.css">
</head>
<body>
    <h1>Add Items</h1>

    <form action="addItems" method="post" onsubmit="return validateForm()">
        <label for="itemName">Item Name:</label>
        <input type="text" id="itemName" name="itemName" required><br>

        <label for="itemType">Item Type:</label>
        <select id="itemType" name="itemType" required>
            <option value="luxury">Luxury</option>
            <option value="essential">Essential</option>
            <option value="gift">Gift</option>
        </select><br>

        <label for="price">Price (€):</label>
        <input type="number" id="price" name="price" min="0" step="any" required><br>

        <label for="expirationDate">Expiration Date:</label>
        <input type="date" id="expirationDate" name="expirationDate" required><br>

        <label for="weight">Weight (kg):</label>
        <input type="number" id="weight" name="weight" min="0" step="any" required><br>

        <label for="dimension">Dimension:</label>
        <input type="number" id="dimension" name="dimension" min="0" required><br>

        <input type="submit" value="Add Item">
    </form>

   
   <button id="backButton" onclick="goBack()" class="backButton">Back</button>


    <script>
        function validateForm() {
            var expirationDateInput = document.getElementById("expirationDate");
            var today = new Date();
            var selectedDate = new Date(expirationDateInput.value);

            if (selectedDate < today) {
                alert("Expiration date cannot be before today's date.");
                expirationDateInput.value = ""; // Clear the input
                return false;
            }

            return true;
        }

     function goBack() {
            window.location.href = 'adminMainPage.jsp';
        }

    </script>
</body>
</html>
