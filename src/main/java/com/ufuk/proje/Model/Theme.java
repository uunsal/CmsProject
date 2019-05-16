package com.ufuk.proje.Model;

import com.ufuk.proje.Model.initalize.initalize_model;

import javax.persistence.*;

@Entity
public class Theme {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int Id;
    private String name;
    private String url;
    @Column(name = "screenshouts", length = 1000000)
    private String ScreenShout;
    private String description;
    public int getId() {
        return Id;
    }
    @JoinColumn(name = "itm_id")
    @OneToOne
    private initalize_model initalizeModel;

    public initalize_model getInitalizeModel() {
        return initalizeModel;
    }

    public void setInitalizeModel(initalize_model initalizeModel) {
        this.initalizeModel = initalizeModel;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public void setId(int id) {
        Id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getScreenShout() {
        return ScreenShout;
    }

    public void setScreenShout(String screenShout) {
        ScreenShout = screenShout;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
