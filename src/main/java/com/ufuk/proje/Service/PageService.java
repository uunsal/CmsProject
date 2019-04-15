package com.ufuk.proje.Service;

import com.ufuk.proje.Model.Page;
import com.ufuk.proje.Model.Theme;
import com.ufuk.proje.Model.draftPage;
import com.ufuk.proje.Model.image;

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
    public List<Page> findByPageType(String pageType);
    public void initalizeHomePage(Page page);
    public String updateDraftPage(Page page);
    public Page updatePageAdvanced(Page page);
    public List<Page> getNotDraftPage();
    public void updateImage(image ımage);
    public List<image> findAllImage();
    public void savePage(Page page);
}
