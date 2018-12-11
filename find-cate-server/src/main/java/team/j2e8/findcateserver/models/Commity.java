package team.j2e8.findcateserver.models;

import javax.persistence.*;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "commity")
public class Commity {
    @Id//主键
    @Column(name = "commity_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)//自增
    private Integer commityId;

    @Column
    private String commityContent;
    @Column
    private Date commityTime;


    @Column
    private Integer commityLike;
    @Column
    private Integer commityDislike;

    @ManyToOne(targetEntity = User.class,fetch = FetchType.LAZY)
    @JoinColumn(name = "commity_user_id")
    private User user;

    @ManyToOne(targetEntity = Shop.class,fetch = FetchType.LAZY)
    @JoinColumn(name = "commity_shop_id")
    private Shop shop;

    @OneToMany(targetEntity = Reply.class,fetch = FetchType.LAZY,mappedBy = "commity",cascade = CascadeType.REMOVE)
    private List<Reply> replyList = new ArrayList<>();
    public Integer getCommityId() {
        return commityId;
    }

    public List<Reply> getReplyList() {
        return replyList;
    }

    public void setReplyList(List<Reply> replyList) {
        this.replyList = replyList;
    }

    public void setCommityId(Integer commityId) {
        this.commityId = commityId;
    }

    public String getCommityContent() {
        return commityContent;
    }

    public void setCommityContent(String commityContent) {
        this.commityContent = commityContent;
    }

    public Date getCommityTime() {
        return commityTime;
    }

    public void setCommityTime(Date commityTime) {
        this.commityTime = commityTime;
    }

    public Integer getCommityLike() {
        return commityLike;
    }

    public void setCommityLike(Integer commityLike) {
        this.commityLike = commityLike;
    }

    public Integer getCommityDislike() {
        return commityDislike;
    }

    public void setCommityDislike(Integer commityDislike) {
        this.commityDislike = commityDislike;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Shop getShop() {
        return shop;
    }

    public void setShop(Shop shop) {
        this.shop = shop;
    }
}
