<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin Main Page</title>
    <link rel="stylesheet" href="css/adminMainStyle.css">
</head>
<body>
    <div class="header">
        <h1>Welcome to the Admin Main Page</h1>
        <form action="index.jsp" method="get">
            <input type="submit" value="Logout" class="logout-button">
        </form>
    </div>
    <p>Hi <%= session.getAttribute("loggedInUser") %>, you are currently logged in.</p>

    <div class="container">
    <img src="images/addItems.jpg" alt="Add Items Icon" width="50">
        <div class="buttons">
            <a href="addItemPage.jsp" class="button">
                 Add Items
            </a>
        </div>
        <img src="images/viewAllItems.png" alt="View All Items Icon" width="50"> 
        <div class="buttons">
            <a href="viewAllItems.jsp" class="button">
                View All Items
            </a>
        </div>
    </div>
</body>
</html>
