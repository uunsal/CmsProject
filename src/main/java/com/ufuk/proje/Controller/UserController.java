package com.ufuk.proje.Controller;

import com.ufuk.proje.Model.Page;
import com.ufuk.proje.Model.Theme;
import com.ufuk.proje.Model.authorities;
import com.ufuk.proje.Model.initalize.initalize_model;
import com.ufuk.proje.ProjeApplication;
import com.ufuk.proje.Service.PageService;
import com.ufuk.proje.Service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.*;

@RestController
@RequestMapping("/user")
public class UserController {
    @Autowired
    private PageService pageService;
    @Autowired
    private UserService userService;
    @PostMapping("initalize")
    public void initalize_server(@RequestBody initalize_model initalize_model){
        //System.out.println(initalize_model.toString());
        authorities authorities = new authorities();
        authorities.setUsername(initalize_model.getUser().getUsername());
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        String temp_pass=initalize_model.getUser().getPassword();
        initalize_model.getUser().setPassword("{bcrypt}"+passwordEncoder.encode(temp_pass));
        initalize_model.getUser().setEnabled(true);
        if(initalize_model.getUrl().charAt(0)!='/') {
            String temp_url=initalize_model.getUrl();
            initalize_model.setUrl("/"+temp_url);
        }
        if(initalize_model.getIsAdmin()==1){
            authorities.setAuthority("ROLE_ADMIN");
        }else{
            authorities.setAuthority("ROLE_EDITOR");
        }
        Page page = new Page();
        page.setContents("<p>Web sayfanız hazırlandı!</p>");
        page.setUrl("/");
        page.setDraft(false);
        page.setPageType("home");
        page.setTitle("ana sayfa");
        Theme theme = new Theme();
        theme.setActive(true);
        theme.setName("Default");
        theme.setScreenShout("");
        userService.uploadTheme(theme);
        pageService.initalizeHomePage(page);
        System.out.println(initalize_model.toString());
        System.out.println(initalize_model.getUser().getPassword());
        userService.saveUser(initalize_model.getUser());
        userService.saveAuth(authorities);
        userService.saveUserSettings(initalize_model);
        ProjeApplication.restart();

    }
}
