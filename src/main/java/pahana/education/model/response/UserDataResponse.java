package pahana.education.model.response;
import pahana.education.model.request.UserRequest;
import java.time.LocalDate;

public class UserDataResponse {
    private String firstName;
    private String lastName;
    private LocalDate dateOfBirth;
    private String phoneNo;
    private UserRequest.Gender gender;
    private String address;
    private String userImagePath;
    private String accountNo;
    private String email;
    private String userName;
    private String title;
    private UserRoleResponse userRole;

    public UserDataResponse(String firstName, String lastName, LocalDate dateOfBirth,
                            String phoneNo, UserRequest.Gender gender, String address,
                            String userImagePath, String accountNo, String email,
                            String userName, String title, UserRoleResponse userRole) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.dateOfBirth = dateOfBirth;
        this.phoneNo = phoneNo;
        this.gender = gender;
        this.address = address;
        this.userImagePath = userImagePath;
        this.accountNo = accountNo;
        this.email = email;
        this.userName = userName;
        this.title = title;
        this.userRole = userRole;
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

    public LocalDate getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(LocalDate dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public String getPhoneNo() {
        return phoneNo;
    }

    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
    }

    public UserRequest.Gender getGender() {
        return gender;
    }

    public void setGender(UserRequest.Gender gender) {
        this.gender = gender;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getUserImagePath() {
        return userImagePath;
    }

    public void setUserImagePath(String userImagePath) {
        this.userImagePath = userImagePath;
    }

    public String getAccountNo() {
        return accountNo;
    }

    public void setAccountNo(String accountNo) {
        this.accountNo = accountNo;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public UserRoleResponse getUserRole() {
        return userRole;
    }

    public void setUserRole(UserRoleResponse userRole) {
        this.userRole = userRole;
    }
}
