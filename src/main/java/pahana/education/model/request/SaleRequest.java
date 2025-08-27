package pahana.education.model.request;

import java.util.List;

public class SaleRequest {
    private int cashierId;
    private int customerId;
    private double cashReceived;
    private double totalGross;
    private double totalNet;
    private double taxAmount;
    private List<SaleItemRequest> saleItems;

    public int getCashierId() {
        return cashierId;
    }

    public void setCashierId(int cashierId) {
        this.cashierId = cashierId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public double getCashReceived() {
        return cashReceived;
    }

    public void setCashReceived(double cashReceived) {
        this.cashReceived = cashReceived;
    }

    public List<SaleItemRequest> getSaleItems() {
        return saleItems;
    }

    public void setSaleItems(List<SaleItemRequest> saleItems) {
        this.saleItems = saleItems;
    }

    public double getTotalGross() {
        return totalGross;
    }

    public void setTotalGross(double totalGross) {
        this.totalGross = totalGross;
    }

    public double getTotalNet() {
        return totalNet;
    }

    public void setTotalNet(double totalNet) {
        this.totalNet = totalNet;
    }

    public double getTaxAmount() {
        return taxAmount;
    }

    public void setTaxAmount(double taxAmount) {
        this.taxAmount = taxAmount;
    }
}
