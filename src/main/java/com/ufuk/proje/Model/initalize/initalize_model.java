package com.ufuk.proje.Model.initalize;

import com.ufuk.proje.Model.User;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name = "Settings")
public class initalize_model {
    @Id
    private String Id="set-01";
    private String url;
    private int isAdmin;
    private String theme = "Default";
    @OneToOne
    private User user;

    public String getId() {
        return Id;
    }

    public void setId(String id) {
        Id = id;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public int getIsAdmin() {
        return isAdmin;
    }

    public void setIsAdmin(int isAdmin) {
        this.isAdmin = isAdmin;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @Override
    public String toString() {
        return "initalize_model{" +
                "url='" + url + '\'' +
                ", isAdmin=" + isAdmin +
                ", user=" + user +
                '}';
    }
}
