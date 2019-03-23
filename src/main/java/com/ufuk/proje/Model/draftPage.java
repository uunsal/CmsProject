package com.ufuk.proje.Model;

import javax.persistence.*;

@Entity
public class draftPage {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int ıd;
    private String title;
    private String url;
    @Column(length = 1000000)
    private String contents;
    private String pageType; // home|blog|sample types

    public int getId() {
        return ıd;
    }

    public void setId(int ıd) {
        this.ıd = ıd;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getContents() {
        return contents;
    }

    public void setContents(String contents) {
        this.contents = contents;
    }

    public String getPageType() {
        return pageType;
    }

    public void setPageType(String pageType) {
        this.pageType = pageType;
    }
}
