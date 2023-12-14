package itemclass;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

// Item.java
public class Items {
    private String name;
    private double price;
    private int quantity;
    private double vatRate;

    // Constructor
    public Items(String name, double price, int quantity) {
        this.name = name;
        this.price = price;
        this.quantity = quantity;
    }

    public double getDimensions() {
        double dimensions = 0.0;

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
            String sql = "SELECT dimensions FROM items WHERE name = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                preparedStatement.setString(1, this.name);
                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    if (resultSet.next()) {
                        dimensions = resultSet.getDouble("dimensions");
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Handle the exception appropriately
        }
        return dimensions;
    }

    public double getWeight() {
        double weight = 0.0;

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
            String sql = "SELECT weight FROM items WHERE name = ?";
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                preparedStatement.setString(1, this.name);
                try (ResultSet resultSet = preparedStatement.executeQuery()) {
                    if (resultSet.next()) {
                        weight = resultSet.getDouble("weight");
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Handle the exception appropriately
        }
        return weight;
    }

     public double getVatRate() {
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
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            // Perform database query to retrieve VAT rate
            // Replace the following with your actual database query
            // Example assumes you have a table named 'items' with a column 'vat_rate'
            String sql = "SELECT VAT FROM items WHERE name = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, this.name);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                this.vatRate = resultSet.getDouble("VAT");
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Handle the exception appropriately
        } 

        return vatRate;
    }

    // Getter methods
    public String getName() {
        return name;
    }

    public double getPrice() {
        return price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getTotalPrice() {
        return price * quantity;
    }

    public double getVat() {
        return vatRate;
    }

    public void setVat(double vatRate) {
        this.vatRate = vatRate;
    }


    
}