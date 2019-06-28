package com.ufuk.proje.Controller;

import com.ufuk.proje.Model.Page;
import com.ufuk.proje.Model.Theme;
import com.ufuk.proje.Model.User;
import com.ufuk.proje.Model.authorities;
import com.ufuk.proje.Model.initalize.initalize_model;
import com.ufuk.proje.Repository.AuthRepository;
import com.ufuk.proje.Repository.InıtalizeModelRepository;
import com.ufuk.proje.Repository.ThemeRepository;
import com.ufuk.proje.Repository.UserRepository;
import com.ufuk.proje.Service.BlogService;
import com.ufuk.proje.Service.PageService;
import com.ufuk.proje.Service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.security.Principal;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/admin")
public class AdminController {
    @Autowired
    private BlogService blogService;
    @Autowired
    private PageService pageService;
    @Autowired
    private AuthRepository authRepository;
    @Autowired
    private ThemeRepository themeRepository;
    @Autowired
    private InıtalizeModelRepository ınıtalizeModelRepository;
    @RequestMapping(value = {""})
    public ModelAndView admin_index(Principal principal, Authentication authentication){
        ModelAndView mav = new ModelAndView();
        for (GrantedAuthority ga:authentication.getAuthorities()){
            if(ga.getAuthority().equals("ROLE_SUPERADMIN")){
                mav.setViewName("admin/super");
                mav.addObject("user",principal.getName());
                return mav;
            }
        }
        initalize_model itm = ınıtalizeModelRepository.findByUserUsername(principal.getName());
        List<Page> allPage = pageService.findAllPageIsNotDraft(itm.getUrl().split("/")[1]);
        mav.setViewName("admin/index");
        mav.addObject("user",principal.getName());
        mav.addObject("pinfo",allPage.size());
        mav.addObject("tinfo",itm.getTheme().getName());
        return mav;
    }

    @RequestMapping(value = {"pages"})
    public ModelAndView admin_pages(Principal principal){
        ModelAndView mav = new ModelAndView();
        mav.setViewName("admin/pages");
        mav.addObject("user",principal.getName());
        return mav;
    }

    @RequestMapping(value = {"login"})
    public ModelAndView admin_login(){
        //Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        ModelAndView mav = new ModelAndView();
        //if (!(auth instanceof AnonymousAuthenticationToken)) {// zaten kullanıcı girişi yapılmışla login sayfası gösterilmez..
            //mav.setViewName("admin/index"); // zaten yetkilindirildiyse anasayfaya döndürür
            //return mav;
        //}
        List<authorities> allUser = authRepository.findByAuthority("ROLE_SUPERUSER");
        if(allUser.size()==0){
            mav.setViewName("admin/addSuper");
            return mav;
        }
        mav.setViewName("admin/login");
        return mav;
    }
    @RequestMapping(value = {"blog"})
    public ModelAndView admin_blog(Principal principal){
        initalize_model itm = ınıtalizeModelRepository.findByUserUsername(principal.getName());
        List<Page> allPage=  pageService.getNotDraftPage(principal.getName());
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
        mav.addObject("user",principal.getName());
        return mav;
    }

    @RequestMapping(value = {"design"})
    public ModelAndView admin_design(Principal principal){ // tasarım sayfası döndürülür
        ModelAndView mav = new ModelAndView();
        mav.setViewName("admin/design");
        mav.addObject("user",principal.getName());
        return mav;
    }

    @RequestMapping(value = {"images"})
    public ModelAndView admin_images(Principal principal){
        ModelAndView mav = new ModelAndView();
        mav.setViewName("admin/images");
        mav.addObject("user",principal.getName());
        return mav;
    }

    @RequestMapping(value = {"users"})
    public ModelAndView admin_users(Principal principal, Authentication authentication){
        ModelAndView mav = new ModelAndView();
        for (GrantedAuthority ga:authentication.getAuthorities()){
            if(ga.getAuthority().equals("ROLE_SUPERADMIN")){
                mav.setViewName("admin/users");
                mav.addObject("user",principal.getName());
                return mav;
            }
        }
        mav.setViewName("admin/index");
        return mav;
    }
    @RequestMapping(value = {"cv"})
    public ModelAndView admin_cv(Principal principal){
        ModelAndView mav = new ModelAndView();
        mav.setViewName("admin/cv");
        mav.addObject("user",principal.getName());
        return mav;
    }

    @RequestMapping(value = {"settings"})
    public ModelAndView admin_settings(Principal principal){
        ModelAndView mav = new ModelAndView();
        mav.setViewName("admin/settings");
        mav.addObject("user",principal.getName());
        return mav;
    }


}
