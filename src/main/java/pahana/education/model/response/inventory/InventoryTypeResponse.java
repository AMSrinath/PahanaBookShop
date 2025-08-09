package pahana.education.model.response.inventory;

public class InventoryTypeResponse {
    private int id;
    private String name;
    private Boolean isActive;


    public InventoryTypeResponse(int id,String name, Boolean isActive) {
        this.id = id;
        this.name = name;
        this.isActive = isActive;
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

    public Boolean getActive() {
        return isActive;
    }

    public void setActive(Boolean active) {
        isActive = active;
    }
}
