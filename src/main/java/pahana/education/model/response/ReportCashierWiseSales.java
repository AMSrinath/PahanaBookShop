package pahana.education.model.response;

public class ReportCashierWiseSales {
    private String userImage;
    private String firstName;
    private String lastName;
    private String email;
    private String phoneNo;
    private int retailPrice;
    private int qty;
    private int total;

    public ReportCashierWiseSales(String userImage, String firstName, String lastName, String email, String phoneNo,
                                  int retailPrice, int qty, int total) {
        this.userImage = userImage;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.phoneNo = phoneNo;
        this.retailPrice = retailPrice;
        this.qty = qty;
        this.total = total;
    }

    public String getUserImage() {
        return userImage;
    }

    public void setUserImage(String userImage) {
        this.userImage = userImage;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhoneNo() {
        return phoneNo;
    }

    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
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

    public String getFullName() {
        return firstName + " " + lastName;
    }
}
