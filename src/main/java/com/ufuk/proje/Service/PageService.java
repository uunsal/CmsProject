package com.ufuk.proje.Service;

import com.ufuk.proje.Model.Page;
import com.ufuk.proje.Model.Theme;
import com.ufuk.proje.Model.draftPage;

import java.util.List;
import java.util.Optional;

public interface PageService {
    public String updatePage(Page page);
    public Page createPage(Page page);
    public Page findByTitle(String title);
    public Page findByUrl(String url);
    public List<Page> findAllPage();
    public List<Page> findAllPageIsNotDraft();
    public Optional<Page> findById(int ıd);
    public Theme getCurrentTheme();
    public void deletePage(Page page);
    List<Page> findByPageType(String pageType);
    public void initalizeHomePage(Page page);
    public String updateDraftPage(Page page);
    public Page updatePageAdvanced(Page page);

}
