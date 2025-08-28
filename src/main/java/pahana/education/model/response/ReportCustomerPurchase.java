package pahana.education.model.response;

public class ReportCustomerPurchase {
    private String productImage;
    private String productName;
    private String productType;
    private int retailPrice;
    private int qty;
    private int total;
    private String invoice_no;

    public ReportCustomerPurchase(String productImage, String productName, String productType,
                                  int retailPrice, int qty, int total, String invoice_no) {
        this.productImage = productImage;
        this.productName = productName;
        this.productType = productType;
        this.retailPrice = retailPrice;
        this.qty = qty;
        this.total = total;
        this.invoice_no = invoice_no;
    }

    public String getProductImage() {
        return productImage;
    }

    public void setProductImage(String productImage) {
        this.productImage = productImage;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getProductType() {
        return productType;
    }

    public void setProductType(String productType) {
        this.productType = productType;
    }

    public int getRetailPrice() {
        return retailPrice;
    }

    public void setRetailPrice(int retailPrice) {
        this.retailPrice = retailPrice;
    }

    public int getQty() {
        return qty;
    }

    public void setQty(int qty) {
        this.qty = qty;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public String getInvoice_no() {
        return invoice_no;
    }

    public void setInvoice_no(String invoice_no) {
        this.invoice_no = invoice_no;
    }
}
