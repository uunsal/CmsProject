package com.ufuk.proje;

import com.ufuk.proje.Model.Page;
import com.ufuk.proje.Model.Theme;
import com.ufuk.proje.Model.User;
import com.ufuk.proje.Model.authorities;
import com.ufuk.proje.Model.initalize.initalize_model;
import com.ufuk.proje.Repository.InıtalizeModelRepository;
import com.ufuk.proje.Repository.ThemeRepository;
import com.ufuk.proje.Service.PageService;
import com.ufuk.proje.Service.ThemeService;
import com.ufuk.proje.Service.UserService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.List;


@RunWith(SpringRunner.class)
@SpringBootTest
public class ProjeApplicationTests {
    @Autowired
    private PageService pageService;
    @Autowired
    private InıtalizeModelRepository ınıtalizeModelRepository;
    @Autowired
    private UserService userService;
    @Autowired
    private ThemeRepository themeRepository;
    @Test
    public void contextLoads() {
        //List<Page> allpage = pageService.findAllPageIsNotDraft();
        int sayac=0;
//        for (Page p:allpage){
//            p.setSortNumber(sayac);
//            sayac++;
//            pageService.createPage(p);
//        }

    }

//    @Test
//    public void addInıtalizeModel (){
//        initalize_model itm = new initalize_model();
//        itm.setUrl("/ahmetcelik");
//        itm.setIsAdmin(1);
//        Theme t = new Theme();
//        t.setName("Ktün Klasik");
//        t.setUrl("Default");
//        Page p = new Page();
//        p.setPageType("home");
//        p.setUrl("/");
//        p.setContents("");
//        p.setTitle("ana sayfa");
//        p.setDraft(false);
//        User u = new User();
//        u.setUsername("acelik");
//        u.setEnabled(true);
//        itm.setUser(u);
//        p.setUser(u);
//        Theme te= themeRepository.findByUrl("Default");
//        itm.setTheme(te);
//        themeRepository.save(te);
//        ınıtalizeModelRepository.save(itm);
//
//
//    }
//
//    @Test
//    public void changeUSer(){
//        User u = new User();
//        authorities authorities = new authorities();
//        u.setUsername("acelik");
//        u.setEnabled(true);
//        u.setPassword("{bcrypt}"+new BCryptPasswordEncoder().encode("123"));
//        u.setUnvan("Prof.Dr.");
//        u.setEmail("acelik@hotmail.com");
//        u.setFirsNtame("Ahmet");
//        u.setLastName("Çelik");
//        authorities.setAuthority("ROLE_ADMIN");
//        authorities.setUsername(u.getUsername());
//        userService.saveUser(u);
//        userService.saveAuth(authorities);
//
//    }
//
//    @Test
//    public void addSuperUser(){
//        User u = new User();
//        authorities authorities = new authorities();
//        u.setUsername("uunsal");
//        u.setEnabled(true);
//        u.setPassword("{bcrypt}"+new BCryptPasswordEncoder().encode("123"));
//        authorities.setAuthority("ROLE_SUPERADMIN");
//        u.setUnvan("Ogrenci");
//        authorities.setUsername(u.getUsername());
//        userService.saveUser(u);
//        userService.saveAuth(authorities);
//    }
//
//    @Test
//    public void addPage (){
//        Page p = new Page();
//        p.setPageType("sample");
//        p.setUrl("/deneme");
//        p.setContents("");
//        p.setTitle("Deneme");
//        p.setDraft(false);
//        User u = new User();
//        u.setUsername("acelik");
//        p.setUser(u);
//        pageService.createPage(p,u.getUsername());
//
//
//    }
//    @Test
//    public void changeEmail(){
//        User user = userService.findUserByUsername("acelik");
//        user.setEmail("ufuk-selen@hotmail.com");
//        userService.saveUser(user);
//
//    }
//    @Test
//    public void changeAndAddTheme(){
//        Theme t = new Theme();
//        t.setName("Ktün Modern");
//        t.setDescription("Açık renkleri barındıran tema.");
//        t.setUrl("Theme1");
//        themeRepository.save(t);
//        //initalize_model itm = ınıtalizeModelRepository.findByUserUsername("acelik");
//        //itm.setTheme(t);
//        //ınıtalizeModelRepository.save(itm);
//    }
//    @Test
//    public  void changepass(){
//        User u = userService.findUserByUsername("mdemir606");
//        u.setPassword("{bcrypt}"+new BCryptPasswordEncoder().encode("123"));
//        userService.saveUser(u);
//    }
    @Test
    public void addTheme(){
        Theme t = new Theme();
        t.setName("Ktün-Selcuk Teması");
        t.setDescription("Selçuk üniversitesine benzeyen tema.");
        t.setUrl("ThemeSelcuk");
        themeRepository.save(t);
        //initalize_model itm = ınıtalizeModelRepository.findByUserUsername("acelik");
        //itm.setTheme(t);
        //ınıtalizeModelRepository.save(itm);
    }
}
