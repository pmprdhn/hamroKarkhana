package com.hamroKarkhana.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/dashboard")
public class DashboardController extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public DashboardController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int totalUsers = 0;
		int totalProductsInStock = 0;
		int totalOrders = 0;
		double totalRevenue = 0.0;

		String url = "jdbc:mysql://localhost:3306/hamro-karkhana";
		String username = "root";
		String password = "";

		List<Map<String, Object>> lowStockList = new ArrayList<>();

		try {
		    Class.forName("com.mysql.cj.jdbc.Driver");
		    Connection conn = DriverManager.getConnection(url, username, password);

		    // Total users
		    String userSql = "SELECT COUNT(*) FROM customerInfo";
		    try (PreparedStatement psUser = conn.prepareStatement(userSql);
		         ResultSet rsUser = psUser.executeQuery()) {
		        if (rsUser.next()) totalUsers = rsUser.getInt(1);
		    }

		    // Total products in stock
		    String productSql = "SELECT SUM(stock) FROM product";
		    try (PreparedStatement psProduct = conn.prepareStatement(productSql);
		         ResultSet rsProduct = psProduct.executeQuery()) {
		        if (rsProduct.next()) totalProductsInStock = rsProduct.getInt(1);
		    }

		    // Total orders placed
		    String orderSql = "SELECT COUNT(*) FROM orders";
		    try (PreparedStatement psOrder = conn.prepareStatement(orderSql);
		         ResultSet rsOrder = psOrder.executeQuery()) {
		        if (rsOrder.next()) totalOrders = rsOrder.getInt(1);
		    }

		    // ✅ Total revenue calculation using JOIN with product table
		    String revenueSql = "SELECT SUM(p.price) FROM orders o JOIN product p ON o.modelNo = p.modelNo";
		    try (PreparedStatement psRevenue = conn.prepareStatement(revenueSql);
		         ResultSet rsRevenue = psRevenue.executeQuery()) {
		        if (rsRevenue.next()) totalRevenue = rsRevenue.getDouble(1);
		    }

		    // Low stock products
		    String lowStockSql = "SELECT title, stock FROM product WHERE stock < ?";
		    try (PreparedStatement psLowStock = conn.prepareStatement(lowStockSql)) {
		        psLowStock.setInt(1, 5);
		        try (ResultSet rsLowStock = psLowStock.executeQuery()) {
		            while (rsLowStock.next()) {
		                Map<String, Object> product = new HashMap<>();
		                product.put("title", rsLowStock.getString("title"));
		                product.put("stock", rsLowStock.getInt("stock"));
		                lowStockList.add(product);
		            }
		        }
		    }

		    conn.close();
		} catch (Exception e) {
		    e.printStackTrace();
		}

		request.setAttribute("totalUsers", totalUsers);
		request.setAttribute("totalProducts", totalProductsInStock);
		request.setAttribute("totalOrders", totalOrders);
		request.setAttribute("totalRevenue", totalRevenue);
		request.setAttribute("lowStockList", lowStockList);

		request.getRequestDispatcher("/WEB-INF/pages/dashboard.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
