package model;

public class Product {
    private int productId;
    private int categoryId;
    private String productName;
    private double price;
    private String unit; 
    private int stockQuantity;
    private String imageUrl;
    private String description;

    public Product() {
    }

    public Product(int productId, int categoryId, String productName, double price, String unit, int stockQuantity, String imageUrl, String description) {
        this.productId = productId;
        this.categoryId = categoryId;
        this.productName = productName;
        this.price = price;
        this.unit = unit;
        this.stockQuantity = stockQuantity;
        this.imageUrl = imageUrl;
        this.description = description;
    }

    // Nhấn Alt + Insert để tạo Getter và Setter tại đây

    public int getProductId() {
        return productId;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public String getProductName() {
        return productName;
    }

    public double getPrice() {
        return price;
    }

    public String getUnit() {
        return unit;
    }

    public int getStockQuantity() {
        return stockQuantity;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public String getDescription() {
        return description;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    
}