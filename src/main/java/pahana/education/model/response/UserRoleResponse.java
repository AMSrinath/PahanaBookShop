package pahana.education.model.response;

public class UserRoleResponse {
    private int id;
private String name;
private String title;


public UserRoleResponse(int roleId, String name, String title) {
    this.id = roleId;
    this.name = name;
    this.title = title;
}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
}
