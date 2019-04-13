package com.ufuk.proje.Controller;

import com.ufuk.proje.Model.Page;
import com.ufuk.proje.Service.BlogService;
import com.ufuk.proje.Service.PageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@RestController
@RequestMapping("/admin")
public class AdminController {
    @Autowired
    private BlogService blogService;
    @Autowired
    private PageService pageService;


    @RequestMapping(value = {""})
    public ModelAndView admin_index(){
        ModelAndView mav = new ModelAndView();
        mav.setViewName("admin/index");
        return mav;
    }

    @RequestMapping(value = {"pages"})
    public ModelAndView admin_pages(){
        ModelAndView mav = new ModelAndView();
        mav.setViewName("admin/pages");
        return mav;
    }

    @RequestMapping(value = {"login"})
    public ModelAndView admin_login(){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        ModelAndView mav = new ModelAndView();
        if (!(auth instanceof AnonymousAuthenticationToken)) {// zaten kullanıcı girişi yapılmışla login sayfası gösterilmez..
            mav.setViewName("admin/index"); // zaten yetkilindirildiyse anasayfaya döndürür
            return mav;
        }

        mav.setViewName("admin/login");
        return mav;
    }
    @RequestMapping(value = {"blog"})
    public ModelAndView admin_blog(){
        List<Page> allPage= pageService.findAllPage();
        ModelAndView mav = new ModelAndView();
        Boolean blogType=false;
        for(Page p:allPage){
            if(p.getPageType().equals("blog")){
                blogType=true;
                break;
            }
        }
        System.out.println(blogType);
        mav.addObject("blogcontrol",blogType);//blog sayfası açılmamışsa kullanıcıya blog sayfası açması tavsiyesinde bulunur döndürür.
        mav.setViewName("admin/blog");
        return mav;
    }

}
