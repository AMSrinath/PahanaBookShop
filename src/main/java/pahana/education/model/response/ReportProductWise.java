package pahana.education.model.response;

public class ReportProductWise {
    private String itemName;
    private String itemImage;
    private String isbn_no;
    private String typeName;
    private String barcode;
    private String authorFName;
    private String authorLName;
    private double costPrice;
    private double sellPrice;
    private int qty;

    public ReportProductWise(String itemName, String itemImage, String isbn_no,
                             String typeName, String barcode, String authorFName, String authorLName,
                             double costPrice, double sellPrice, int qty) {
        this.itemName = itemName;
        this.itemImage = itemImage;
        this.isbn_no = isbn_no;
        this.typeName = typeName;
        this.barcode = barcode;
        this.authorFName = authorFName;
        this.authorLName = authorLName;
        this.costPrice = costPrice;
        this.sellPrice = sellPrice;
        this.qty = qty;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public String getItemImage() {
        return itemImage;
    }

    public void setItemImage(String itemImage) {
        this.itemImage = itemImage;
    }

    public String getIsbn_no() {
        return isbn_no;
    }

    public void setIsbn_no(String isbn_no) {
        this.isbn_no = isbn_no;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public String getBarcode() {
        return barcode;
    }

    public void setBarcode(String barcode) {
        this.barcode = barcode;
    }

    public String getAuthorFName() {
        return authorFName;
    }

    public void setAuthorFName(String authorFName) {
        this.authorFName = authorFName;
    }

    public String getAuthorLName() {
        return authorLName;
    }

    public void setAuthorLName(String authorLName) {
        this.authorLName = authorLName;
    }

    public double getCostPrice() {
        return costPrice;
    }

    public void setCostPrice(double costPrice) {
        this.costPrice = costPrice;
    }

    public double getSellPrice() {
        return sellPrice;
    }

    public void setSellPrice(double sellPrice) {
        this.sellPrice = sellPrice;
    }

    public int getQty() {
        return qty;
    }

    public void setQty(int qty) {
        this.qty = qty;
    }

    public String getAuthorFullName() {
        return authorFName + " " +authorLName;
    }
}
