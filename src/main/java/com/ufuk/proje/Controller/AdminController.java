package com.ufuk.proje.Controller;

import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
@RequestMapping("/admin")
public class AdminController {
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

}
