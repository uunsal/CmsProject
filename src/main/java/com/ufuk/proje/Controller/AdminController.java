package com.ufuk.proje.Controller;

import com.ufuk.proje.Model.Page;
import com.ufuk.proje.Service.BlogService;
import com.ufuk.proje.Service.PageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import java.security.Principal;
import java.util.List;

@RestController
@RequestMapping("/admin")
public class AdminController {
    @Autowired
    private BlogService blogService;
    @Autowired
    private PageService pageService;


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
        mav.setViewName("admin/index");
        mav.addObject("user",principal.getName());
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

        mav.setViewName("admin/login");
        return mav;
    }
    @RequestMapping(value = {"blog"})
    public ModelAndView admin_blog(Principal principal){
//        List<Page> allPage= pageService.findAllPage();
//        ModelAndView mav = new ModelAndView();
//        Boolean blogType=false;
//        for(Page p:allPage){
//            if(p.getPageType().equals("blog")){
//                blogType=true;
//                break;
//            }
//        }
//        System.out.println(blogType);
//        mav.addObject("blogcontrol",blogType);//blog sayfası açılmamışsa kullanıcıya blog sayfası açması tavsiyesinde bulunur döndürür.
//        mav.setViewName("admin/blog");
//        mav.addObject("user",principal.getName());
//        return mav;
        return null;
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

}
