package team.j2e8.findcateserver.models;

import com.fasterxml.jackson.annotation.JsonProperty;

import javax.persistence.*;

import java.util.HashSet;
import java.util.Set;


/**
 * @auther vinsonws
 * @date 2018/11/25 22:13
 */
@Entity
@Table(name = "user")
public class User {
    @Id//主键
    @Column(name = "user_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)//自增
    private Integer id;

    @Column
    private String userName;
    @Column
    private String userTelenumber;
    @Column
    private String userPhoto;
    @Column
    private String userEmail;
    @Column
    private String userPassword;
    @Column
    private String userSalt;

    @OneToMany(mappedBy = "user",targetEntity = Shop.class,fetch=FetchType.LAZY,
            cascade = CascadeType.ALL)
    private Set<Shop> shops = new HashSet<Shop>();

    @OneToMany(mappedBy = "user",targetEntity = Reply.class,fetch=FetchType.LAZY,
            cascade = CascadeType.ALL)
    private Set<Reply> replys = new HashSet<Reply>();

    @OneToMany(targetEntity = Commity.class, mappedBy = "user",fetch=FetchType.LAZY,
            cascade = CascadeType.ALL)
    private Set<Commity> commities = new HashSet<Commity>();


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserTelenumber() {
        return userTelenumber;
    }

    public void setUserTelenumber(String userTelenumber) {
        this.userTelenumber = userTelenumber;
    }

    public String getUserPhoto() {
        return userPhoto;
    }

    public void setUserPhoto(String userPhoto) {
        this.userPhoto = userPhoto;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public Set<Shop> getShops() {
        return shops;
    }

    public void setShops(Set<Shop> shops) {
        this.shops = shops;
    }

    public Set<Reply> getReplys() {
        return replys;
    }

    public void setReplys(Set<Reply> replys) {
        this.replys = replys;
    }

    public Set<Commity> getCommities() {
        return commities;
    }

    public void setCommities(Set<Commity> commities) {
        this.commities = commities;
    }

    public String getUserPassword() {
        return userPassword;
    }

    public void setUserPassword(String userPassword) {
        this.userPassword = userPassword;
    }

    public String getUserSalt() {
        return userSalt;
    }

    public void setUserSalt(String userSalt) {
        this.userSalt = userSalt;
    }
}
