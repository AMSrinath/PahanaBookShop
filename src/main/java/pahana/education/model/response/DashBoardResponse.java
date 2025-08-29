package pahana.education.model.response;

public class DashBoardResponse {
    private int saleCount = 0;
    private int inventoryCount = 0;
    private int userCount =0;
    private int customerCount =0;
    private int stockCount =0;
    private double saleTotal = 0.00;
    private double dailySales =0.00;
    private double stockValue =0.00;
    private double currentMonth =0.00;
    private double lastMonth =0.00;


    public int getSaleCount() {
        return saleCount;
    }

    public void setSaleCount(int saleCount) {
        this.saleCount = saleCount;
    }

    public int getInventoryCount() {
        return inventoryCount;
    }

    public void setInventoryCount(int inventoryCount) {
        this.inventoryCount = inventoryCount;
    }

    public int getUserCount() {
        return userCount;
    }

    public void setUserCount(int userCount) {
        this.userCount = userCount;
    }

    public int getCustomerCount() {
        return customerCount;
    }

    public void setCustomerCount(int customerCount) {
        this.customerCount = customerCount;
    }

    public int getStockCount() {
        return stockCount;
    }

    public void setStockCount(int stockCount) {
        this.stockCount = stockCount;
    }

    public double getSaleTotal() {
        return saleTotal;
    }

    public void setSaleTotal(double saleTotal) {
        this.saleTotal = saleTotal;
    }

    public double getDailySales() {
        return dailySales;
    }

    public void setDailySales(double dailySales) {
        this.dailySales = dailySales;
    }

    public double getStockValue() {
        return stockValue;
    }

    public void setStockValue(double stockValue) {
        this.stockValue = stockValue;
    }

    public double getCurrentMonth() {
        return currentMonth;
    }

    public void setCurrentMonth(double currentMonth) {
        this.currentMonth = currentMonth;
    }

    public double getLastMonth() {
        return lastMonth;
    }

    public void setLastMonth(double lastMonth) {
        this.lastMonth = lastMonth;
    }
}


