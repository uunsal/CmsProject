package com.ufuk.proje.Service;

import com.ufuk.proje.Model.Page;
import com.ufuk.proje.Model.Theme;
import com.ufuk.proje.Model.draftPage;
import com.ufuk.proje.Model.image;

import java.security.Principal;
import java.util.List;
import java.util.Optional;

public interface PageService {
    public String updatePage(Page page, String principal);
    public Page createPage(Page page,String principal);
    public Page findByTitle(String title);
    public Page findByUrl(String url);
    public List<Page> findAllPage(String contextPath);
    public List<Page> findAllPageIsNotDraft(String contextPath);
    public Optional<Page> findById(int ıd);
    public Theme getCurrentTheme(String contextPath);
    public void deletePage(Page page);
    public List<Page> findByPageType(String pageType);
    public void initalizeHomePage(Page page);
    public String updateDraftPage(Page page);
    public Page updatePageAdvanced(Page page);
    public List<Page> getNotDraftPage(String username);
    public void updateImage(image ımage);
    public List<image> findAllImage(String username);
    public void savePage(Page page);
    public Page findByPageTypeAndPrinciple(String pagetype,String username);
    public Page findByUrlAndPrinciples(String url,String principles);
    public void updateCv(Page page,String principal);
}
