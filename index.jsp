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
        <h1>Welcome </h1>

       
        <nav>
            <a href="AdminLogin.html" class="component-link">Stock Control</a>
            <a href="basket.jsp" class="component-link">Shopping Basket and Calculations</a>
            <a href="changeCalculator.jsp" class="component-link">Correct Change Calculator</a>
            <a href="itemPacking.jsp" class="component-link">Item Packing</a>
        </nav>
       
    </header>

    <a href="AdminLogin.html" class="icon-link">
      <img src="images/login.png" alt="Login Icon">
      <span class="icon-label">Admin Login</span>
    </a>

    
    <a href="basket.jsp" class="basket-icon-link">
      <img src="images/shoppingBasket.png" alt="Shopping Basket">
      <span class="icon-label">Shopping Basket</span>
    </a>

    <div class="stock-items-container">
      <h2>Available Stock Items</h2>
      <ul>
          <% 
          Connection connection = null;
				try {
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			connection = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/shoppingsystem?serverTimezone=UTC", "root", "root");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
              try {
                 
                  String sql = "SELECT name FROM items";
                  try (PreparedStatement preparedStatement = connection.prepareStatement(sql);
                      ResultSet resultSet = preparedStatement.executeQuery()) {

                      while (resultSet.next()) {
                          String name = resultSet.getString("name");
          %>
                          <li><%= name %> </li>
          <%
                      }
                  }
              } catch (SQLException e) {
                  e.printStackTrace();
              }
          %>
      </ul>
  </div>

</body>
</html>

