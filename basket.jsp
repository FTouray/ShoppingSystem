<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <title>Basket</title>
</head>
<body>
  <h1>Your Basket</h1>
  
  <div id="items">
    <!-- Display items in the basket -->
    <ul id="basketList">
      <!-- Items will be added dynamically here -->
    </ul>
  </div>

  <div>
    <!-- Add item form -->
    <form id="addItemForm">
      <input type="text" id="nameOfItem" placeholder="Enter the name of the item">
      <button type="submit">Add Item</button>
    </form>
  </div>

  <!-- Include the JavaScript file -->
  <script src="basket.js"></script>
</body>
</html>
