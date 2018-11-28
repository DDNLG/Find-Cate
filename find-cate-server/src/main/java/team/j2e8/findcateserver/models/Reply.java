package team.j2e8.findcateserver.models;

import javax.persistence.*;
import java.sql.Date;

@Entity
@Table(name = "reply")
public class Reply {
    @Id//主键
    @Column(name = "reply_id")
    @GeneratedValue//自增
    private Integer replyId;

    @Column
    private String replyContent;
    @Column
    private Date replyTime;

    @ManyToOne(targetEntity = User.class,fetch = FetchType.LAZY,cascade = CascadeType.ALL)
    @JoinColumn(name = "reply_user_id")
    private User user;

    @ManyToOne(targetEntity = Commity.class,fetch = FetchType.LAZY,cascade = CascadeType.ALL)
    @JoinColumn(name = "reply_commity_id")
    private Commity commity;

    public Integer getReplyId() {
        return replyId;
    }

    public void setReplyId(Integer replyId) {
        this.replyId = replyId;
    }

    public String getReplyContent() {
        return replyContent;
    }

    public void setReplyContent(String replyContent) {
        this.replyContent = replyContent;
    }

    public Date getReplyTime() {
        return replyTime;
    }

    public void setReplyTime(Date replyTime) {
        this.replyTime = replyTime;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Commity getCommity() {
        return commity;
    }

    public void setCommity(Commity commity) {
        this.commity = commity;
    }
}
