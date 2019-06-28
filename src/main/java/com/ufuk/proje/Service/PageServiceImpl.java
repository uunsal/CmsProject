package com.ufuk.proje.Service;

import com.ufuk.proje.Model.Page;
import com.ufuk.proje.Model.Theme;
import com.ufuk.proje.Model.User;
import com.ufuk.proje.Model.image;
import com.ufuk.proje.Model.initalize.initalize_model;
import com.ufuk.proje.Repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.security.Principal;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

@Service
public class PageServiceImpl implements PageService {
    private final PageRepository pageRepository;
    private final ThemeRepository themeRepository;
    private final imageRepository ımageRepository;
    private final InıtalizeModelRepository ınıtalizeModelRepository;
    private final UserRepository userRepository;
    @Autowired
    public PageServiceImpl(PageRepository pageRepository, ThemeRepository themeRepository, imageRepository ımageRepository, InıtalizeModelRepository ınıtalizeModelRepository, UserRepository userRepository) {
        this.pageRepository = pageRepository;
        this.themeRepository = themeRepository;
        this.ımageRepository = ımageRepository;
        this.ınıtalizeModelRepository = ınıtalizeModelRepository;
        this.userRepository = userRepository;
    }

    @Override
    public String updatePage(Page page, String username) {
        Optional<Page> temp_page = pageRepository.findById(page.getId());
        if(temp_page.isPresent()){
            if(temp_page.get().getDraft()){//sayfa taslak sayfa ise taslak olmayan canlı sayfaya dönüştürülür
                temp_page.get().setDraft(false);
            }
            //System.out.println("gelen_page"+page.toString());
            temp_page.get().setContents(page.getContents());
            //System.out.println("yazilan_page"+temp_page.toString());
            temp_page.get().setUser(userRepository.findById(username).get());
            pageRepository.save(temp_page.get());
            return "true";
        }
        return "false";
    }

    @Override
    public Page createPage(Page page,String username) {
        List<Page> allPage=pageRepository.findByIsDraftAndUserUsernameOrderBySortNumber(Boolean.FALSE,username);
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
        page.setUser(userRepository.findById(username).get());
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
    public List<Page> getNotDraftPage(String username) {
        return pageRepository.findByIsDraftAndUserUsernameOrderBySortNumber(false,username);
    }

    @Override
    public void updateImage(image ımage) {
        ımageRepository.save(ımage);
    }

    @Override
    public List<image> findAllImage(String username) {
        return ımageRepository.findByUsername(username);
    }

    @Override
    public void savePage(Page page) {
        pageRepository.save(page);
    }

    @Override
    public Page findByPageTypeAndPrinciple(String pagetype, String username) {
        return pageRepository.findByPageTypeAndUserUsername(pagetype,username);
    }

    @Override
    public Page findByUrlAndPrinciples(String url,String username) {
        return pageRepository.findByUrlAndUserUsername(url,username);
    }


    @Override
    public Page findByTitle(String title) {
        return pageRepository.findByTitle(title);
    }
    @Override
    public Page findByUrl(String url) {return pageRepository.findByUrl(url);}
    @Override
    public List<Page> findAllPage(String username) {
        List<Page> pages = pageRepository.findAllByUserUsername(username);
        return pages;
    }

    @Override
    public List<Page> findAllPageIsNotDraft(String contextPath) { // taslak olmayan sayfaları döndürür.
        initalize_model itm = ınıtalizeModelRepository.findByUrl("/"+contextPath);
        List<Page> pages= pageRepository.findByIsDraftAndUserUsernameOrderBySortNumber(Boolean.FALSE,itm.getUser().getUsername());
        return pages;
    }

    @Override
    public Optional<Page> findById(int ıd) {
        return pageRepository.findById(ıd);
    }

    @Override
    public Theme getCurrentTheme(String contextPath) { // geçerli tema bilgisini döndürür
        initalize_model itm = ınıtalizeModelRepository.findByUrl("/"+contextPath);
        System.out.println(itm.getTheme());
        return itm.getTheme();
    }
    @Override
    public void updateCv(Page page,String principal){
        Optional<Page> p = pageRepository.getByUrlAndUserUsername("/cv",principal);
        if(!p.isPresent()){
            User user = userRepository.findByUsername(principal);
            page.setUser(user);
            pageRepository.save(page);
        }


    }




}
