package team.j2e8.findcateserver.models;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "food")
public class Food {
    @Id//主键
    @Column(name = "food_id")
    @GeneratedValue//自增
    private Integer foodId;

    @Column
    private String foodName;
    @Column
    private Float foodPrice;
    @Column
    private String foodPhoto;



    @Column
    private Integer food_like;
    @Column
    private Integer food_dislike;

    @ManyToOne(targetEntity = Food.class,fetch = FetchType.LAZY,
            cascade = CascadeType.ALL)
    @JoinColumn(name = "food_type_id")
    private Type type;


    @ManyToOne(targetEntity = Shop.class,fetch = FetchType.LAZY,
            cascade = CascadeType.ALL)
    @JoinColumn(name = "food_shop_id")
    private Shop shop;

    public Integer getFoodId() {
        return foodId;
    }

    public void setFoodId(Integer foodId) {
        this.foodId = foodId;
    }

    public String getFoodName() {
        return foodName;
    }

    public void setFoodName(String foodName) {
        this.foodName = foodName;
    }

    public Float getFoodPrice() {
        return foodPrice;
    }

    public void setFoodPrice(Float foodPrice) {
        this.foodPrice = foodPrice;
    }

    public String getFoodPhoto() {
        return foodPhoto;
    }

    public void setFoodPhoto(String foodPhoto) {
        this.foodPhoto = foodPhoto;
    }

    public Integer getFood_like() {
        return food_like;
    }

    public void setFood_like(Integer food_like) {
        this.food_like = food_like;
    }

    public Integer getFood_dislike() {
        return food_dislike;
    }

    public void setFood_dislike(Integer food_dislike) {
        this.food_dislike = food_dislike;
    }

    public Type getType() {
        return type;
    }

    public void setType(Type type) {
        this.type = type;
    }

    public Shop getShop() {
        return shop;
    }

    public void setShop(Shop shop) {
        this.shop = shop;
    }
}
