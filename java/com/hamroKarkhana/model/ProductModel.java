package com.hamroKarkhana.model;

public class ProductModel {
    private String image;
    private String modelNo; // Acts as the primary key
    private String brand;
    private String title;
    private String description;
    private int price; // Changed to int for Rs.
    private int stock;

    public ProductModel() {
    }

    public ProductModel(String image, String modelNo, String brand, String title, String description, int price, int stock) {
        this.image = image;
        this.modelNo = modelNo;
        this.brand = brand;
        this.title = title;
        this.description = description;
        this.price = price;
        this.stock = stock;
    }

    // Getters and setters
    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }

    public String getModelNo() { return modelNo; }
    public void setModelNo(String modelNo) { this.modelNo = modelNo; }

    public String getBrand() { return brand; }
    public void setBrand(String brand) { this.brand = brand; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public int getPrice() { return price; }
    public void setPrice(int price) { this.price = price; }

    public int getStock() { return stock; }
    public void setStock(int stock) { this.stock = stock; }
}