package com.ufuk.proje.Service;

import com.ufuk.proje.Model.Page;
import com.ufuk.proje.Model.Theme;
import com.ufuk.proje.Model.image;
import com.ufuk.proje.Repository.PageRepository;
import com.ufuk.proje.Repository.ThemeRepository;
import com.ufuk.proje.Repository.imageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

@Service
public class PageServiceImpl implements PageService {
    private PageRepository pageRepository;
    private ThemeRepository themeRepository;
    private imageRepository ımageRepository;
    @Autowired
    public PageServiceImpl(PageRepository pageRepository, ThemeRepository themeRepository, imageRepository ımageRepository) {
        this.pageRepository = pageRepository;
        this.themeRepository = themeRepository;
        this.ımageRepository = ımageRepository;
    }

    @Override
    public String updatePage(Page page) {
        Optional<Page> temp_page = pageRepository.findById(page.getId());
        if(temp_page.isPresent()){
            if(temp_page.get().getDraft()){//sayfa taslak sayfa ise taslak olmayan canlı sayfaya dönüştürülür
                temp_page.get().setDraft(false);
            }
            //System.out.println("gelen_page"+page.toString());
            temp_page.get().setContents(page.getContents());
            //System.out.println("yazilan_page"+temp_page.toString());
            pageRepository.save(temp_page.get());
            return "true";
        }
        return "false";
    }

    @Override
    public Page createPage(Page page) {
        List<Page> allPage=pageRepository.findByIsDraft(Boolean.FALSE);
        List sortNumber = new ArrayList();
        for (Page p :allPage){
            sortNumber.add(p.getSortNumber());
        }
        if(allPage.size()==0){
            page.setSortNumber(0);
        }else {
            int numbers= (int) Collections.max(sortNumber);
            page.setSortNumber(numbers+1);
        }
        page.setContents("");
        pageRepository.save(page);
        return page;
    }
    @Override
    public void deletePage(Page page){
        Optional<Page> deleted_page = pageRepository.findById(page.getId());
        if(deleted_page.isPresent()){
            pageRepository.delete(deleted_page.get());
        }
    }

    @Override
    public List<Page> findByPageType(String pageType) {
        return pageRepository.findByPageType(pageType);
    }

    @Override
    public void initalizeHomePage(Page page) { //initalize işleminde anasayfayı kaydeder.
        page.setSortNumber(0);
        pageRepository.save(page);
    }

    @Override
    public String updateDraftPage(Page page) {
        Optional<Page> temp_page = pageRepository.findById(page.getId());
        if(temp_page.isPresent() && temp_page.get().getDraft()==true){
            temp_page.get().setContents(page.getContents());
            pageRepository.save(temp_page.get());
            return "true";
        }
        return "false";
    }

    @Override
    public Page updatePageAdvanced(Page page) {
        Optional<Page> temp_page = pageRepository.findById(page.getId());
        if(temp_page.isPresent()){
            if(page.getTitle()!=null){
                temp_page.get().setTitle(page.getTitle());
            }
            if(page.getUrl()!=null){
                String url ="";
                if(page.getUrl().charAt(0)!='/'){
                    url = "/"+page.getUrl();
                }
                temp_page.get().setUrl(url);
            }
            if(page.getDraft()!=null){
                temp_page.get().setDraft(page.getDraft());
            }
            if(page.getPageType()!=null){
                temp_page.get().setPageType(page.getPageType());
            }
            pageRepository.save(temp_page.get());
            return temp_page.get();
        }
        return null;
    }

    @Override
    public List<Page> getNotDraftPage() {
        return pageRepository.findByIsDraft(false);
    }

    @Override
    public void updateImage(image ımage) {
        ımageRepository.save(ımage);
    }

    @Override
    public List<image> findAllImage() {
        return ımageRepository.findAll();
    }

    @Override
    public void savePage(Page page) {
        pageRepository.save(page);
    }


    @Override
    public Page findByTitle(String title) {
        return pageRepository.findByTitle(title);
    }
    @Override
    public Page findByUrl(String url) {return pageRepository.findByUrl(url);}
    @Override
    public List<Page> findAllPage() {
        return pageRepository.findAll();
    }

    @Override
    public List<Page> findAllPageIsNotDraft() { // taslak olmayan sayfaları döndürür.
        List<Page> pages= pageRepository.findByIsDraft(Boolean.FALSE);
        return pages;
    }

    @Override
    public Optional<Page> findById(int ıd) {
        return pageRepository.findById(ıd);
    }

    @Override
    public Theme getCurrentTheme() { // geçerli tema bilgisini döndürür
        return themeRepository.findByIsActive(true);
    }

}
