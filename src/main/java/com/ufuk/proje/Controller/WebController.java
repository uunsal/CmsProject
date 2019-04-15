package com.ufuk.proje.Controller;

import com.ufuk.proje.Model.Page;
import com.ufuk.proje.Model.Theme;
import com.ufuk.proje.Model.initalize.initalize_model;
import com.ufuk.proje.ProjeApplication;
import com.ufuk.proje.Repository.InıtalizeModelRepository;
import com.ufuk.proje.Service.PageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Controller
public class WebController {
    @Autowired
    private PageService pageService;
    @Autowired
    private InıtalizeModelRepository ınıtalizeModelRepository;
    @PostMapping("/restart")
    public void restart() {
        ProjeApplication.restart();
    }
    @RequestMapping(value={"/"})
    public ModelAndView index(){
        Theme currentTheme = pageService.getCurrentTheme();
        initalize_model itm = ınıtalizeModelRepository.findAll().get(0); // settings
        ModelAndView mav = new ModelAndView();
        if(ProjeApplication.readInıtalize()){
            mav.addObject("setting",itm); // custom css  gibi ayarları almak için kullanıldı
            mav.addObject("pages",pageService.findAllPageIsNotDraft()); // tüm sayfaları menü için eklenir. // taslakların dışında
            mav.addObject("page",pageService.findByTitle("ana sayfa")); //findbypagetype a göre yapılabilir. ****!!!
            mav.setViewName("/themes/"+currentTheme.getName()+"/sample");
        }else {
            mav.setViewName("setup");
        }
        return mav;
    }

    @GetMapping("pages/{page}")
    public ModelAndView pages(@PathVariable String page){
        Theme currentTheme = pageService.getCurrentTheme(); // geçerli tema bilgisi
        initalize_model itm = ınıtalizeModelRepository.findAll().get(0); // settings
        List sayfalar = pageService.findAllPage();
        List<String> sayfa_isimleri = new ArrayList();
        for(Object p: sayfalar){
            if(!((Page) p).getUrl().equals("/")) sayfa_isimleri.add(((Page) p).getUrl().split("/")[1]);
        }
        System.out.println(sayfa_isimleri);
        ModelAndView mav =  new ModelAndView();
        System.out.println(sayfa_isimleri);
        if(sayfa_isimleri.contains(page) && page!="/"){
            mav.addObject("page",pageService.findByUrl("/"+page));
            mav.addObject("setting",itm); // custom css  gibi ayarları almak için kullanıldı
            List<Page> allPageIsNotDraft = pageService.findAllPageIsNotDraft();
            mav.addObject("pages",allPageIsNotDraft); // tüm sayfaları menü için eklenir. //taslakların dışında
            mav.setViewName("/themes/"+currentTheme.getName()+"/sample");
            System.out.println("/themes/"+currentTheme.getName()+"/sample");
            return mav;
        }
        mav.setViewName("/404.html");
        return mav;
    }




}
