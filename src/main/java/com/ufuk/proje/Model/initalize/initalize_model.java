package com.ufuk.proje.Model.initalize;

import com.ufuk.proje.Model.Theme;
import com.ufuk.proje.Model.User;

import javax.persistence.*;

@Entity
@Table(name = "Settings")
public class initalize_model {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String url;
    private int isAdmin;
    @OneToOne
    private User user;
    @Column(length = 1000000)
    private String profilePhoto;
    @Column(length = 1000000)
    private String customCss;
    @OneToOne
    private Theme theme;

    public String getProfilePhoto() {
        return profilePhoto;
    }

    public void setProfilePhoto(String profilePhoto) {
        this.profilePhoto = profilePhoto;
    }

    public String getCustomCss() {
        return customCss;
    }

    public void setCustomCss(String customCss) {
        this.customCss = customCss;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public Theme getTheme() {
        return theme;
    }

    public void setTheme(Theme theme) {
        this.theme = theme;
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
