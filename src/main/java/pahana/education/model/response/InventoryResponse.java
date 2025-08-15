package pahana.education.model.response;

public class InventoryResponse {
    private int id;
    private String barcode;
    private String name;
    private Boolean isActive;
    private String defaultImage;
    private int inventoryTypeId;
    private String inventoryType;
    private int authorId;
    private String author;
    private String isbnNo;
    private double retailPrice;
    private double costPrice;
    private Integer qtyHand;

    public InventoryResponse(int id, String barcode, String name, Boolean isActive, String defaultImage,
                             int inventoryTypeId, String inventoryType, int authorId, String author, String isbnNo,
                             double retailPrice, double costPrice, Integer qtyHand) {
        this.id = id;
        this.barcode = barcode;
        this.name = name;
        this.isActive = isActive;
        this.defaultImage = defaultImage;
        this.inventoryTypeId = inventoryTypeId;
        this.inventoryType = inventoryType;
        this.authorId = authorId;
        this.author = author;
        this.isbnNo = isbnNo;
        this.retailPrice = retailPrice;
        this.costPrice = costPrice;
        this.qtyHand = qtyHand;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getBarcode() {
        return barcode;
    }

    public void setBarcode(String barcode) {
        this.barcode = barcode;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Boolean getActive() {
        return isActive;
    }

    public void setActive(Boolean active) {
        isActive = active;
    }

    public String getDefaultImage() {
        return defaultImage;
    }

    public void setDefaultImage(String defaultImage) {
        this.defaultImage = defaultImage;
    }

    public int getInventoryTypeId() {
        return inventoryTypeId;
    }

    public void setInventoryTypeId(int inventoryTypeId) {
        this.inventoryTypeId = inventoryTypeId;
    }

    public String getInventoryType() {
        return inventoryType;
    }

    public void setInventoryType(String inventoryType) {
        this.inventoryType = inventoryType;
    }

    public int getAuthorId() {
        return authorId;
    }

    public void setAuthorId(int authorId) {
        this.authorId = authorId;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getIsbnNo() {
        return isbnNo;
    }

    public void setIsbnNo(String isbnNo) {
        this.isbnNo = isbnNo;
    }

    public double getRetailPrice() {
        return retailPrice;
    }

    public void setRetailPrice(double retailPrice) {
        this.retailPrice = retailPrice;
    }

    public double getCostPrice() {
        return costPrice;
    }

    public void setCostPrice(double costPrice) {
        this.costPrice = costPrice;
    }

    public Integer getQtyHand() {
        return qtyHand;
    }

    public void setQtyHand(Integer qtyHand) {
        this.qtyHand = qtyHand;
    }
}
