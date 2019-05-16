package com.ufuk.proje.Model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;

import javax.persistence.*;

@Entity
public class Page {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int ıd;
    private String title;
    private String url;
    @Column(length = 10000000)
    private String contents;
    private String pageType; // home|blog|sample types
    @JsonProperty("draft")
    private Boolean isDraft; // taslak sayfa kontrolü için kullanıldı
    @Column(name = "sort_numbers")
    private int sortNumber; // sayfanın sıra numarası

    @JoinColumn(name = "user_id")
    @ManyToOne(optional = true, fetch = FetchType.LAZY)
    @JsonIgnore
    private User user;
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

    public Boolean getDraft() {
        return isDraft;
    }

    public void setDraft(Boolean draft) {
        isDraft = draft;
    }

    public int getSortNumber() {
        return sortNumber;
    }

    public void setSortNumber(int sortNumber) {
        this.sortNumber = sortNumber;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @Override
    public String toString() {
        return "Page{" +
                "ıd=" + ıd +
                ", title='" + title + '\'' +
                ", url='" + url + '\'' +
                ", contents='" + contents + '\'' +
                ", pageType='" + pageType + '\'' +
                ", isDraft=" + isDraft +
                '}';
    }
}
