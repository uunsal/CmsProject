package com.ufuk.proje.Controller;

import com.ufuk.proje.Model.*;
import com.ufuk.proje.Model.initalize.initalize_model;
import com.ufuk.proje.ProjeApplication;
import com.ufuk.proje.Repository.InıtalizeModelRepository;
import com.ufuk.proje.Service.BlogService;
import com.ufuk.proje.Service.MailService;
import com.ufuk.proje.Service.PageService;
import com.ufuk.proje.Service.UserService;
import com.ufuk.proje.Util.CvUtil;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

@Controller
@RequestMapping("/{contextPath}")
public class WebController {
    @Autowired
    private PageService pageService;
    @Autowired
    private InıtalizeModelRepository ınıtalizeModelRepository;
    @Autowired
    private BlogService blogService;
    @Autowired
    private UserService userService;
    @Autowired
    private MailService mailService;
    private String cvId;
    @PostMapping("/restart")
    public void restart() {
        ProjeApplication.restart();
    }
    @RequestMapping(value={""})
    public ModelAndView index(@PathVariable("contextPath") String contextPath){
        ModelAndView mav = new ModelAndView();
        if(contextPath.equals("login")){
            //Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            mav = new ModelAndView();
            //if (!(auth instanceof AnonymousAuthenticationToken)) {// zaten kullanıcı girişi yapılmışla login sayfası gösterilmez..
            //mav.setViewName("admin/index"); // zaten yetkilindirildiyse anasayfaya döndürür
            //return mav;
            //}
            mav.setViewName("admin/login");
            return mav;
        }
        if(userService.checkContext(contextPath)!=null) {
            Theme currentTheme = pageService.getCurrentTheme(contextPath);
            initalize_model itm = ınıtalizeModelRepository.findByUrl("/"+contextPath); // settings
            mav = new ModelAndView();
            mav.addObject("setting",itm); // custom css  gibi ayarları almak için kullanıldı
            mav.addObject("pages",pageService.findAllPageIsNotDraft(contextPath)); // tüm sayfaları menü için eklenir. // taslakların dışında
            mav.addObject("page",pageService.findByPageTypeAndPrinciple("home",itm.getUser().getUsername())); //findbypagetype a göre yapılabilir. ****!!!
            mav.setViewName("/themes/"+currentTheme.getUrl()+"/sample");
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            if (!(auth instanceof AnonymousAuthenticationToken)) {// zaten kullanıcı girişi yapılmışsa.
                mav.addObject("user",itm.getUser().getUsername());
                mav.addObject("auth",true);
            }
            else{mav.addObject("auth",false);}
            return mav;
        }
        mav.setViewName("/404.html");
        return mav;
    }

    @GetMapping("/pages/{page}")
    public ModelAndView pages(@PathVariable String page,@PathVariable("contextPath") String contextPath){
        ModelAndView mav = new ModelAndView();
        if(userService.checkContext(contextPath)!=null) {
            Theme currentTheme = pageService.getCurrentTheme(contextPath); // geçerli tema bilgisi
            initalize_model itm = ınıtalizeModelRepository.findByUrl("/"+contextPath); // settings
            List sayfalar = pageService.findAllPageIsNotDraft(contextPath);
            List<String> sayfa_isimleri = new ArrayList();
            for (Object p : sayfalar) {
                if (!((Page) p).getUrl().equals("/")) sayfa_isimleri.add(((Page) p).getUrl().split("/")[1]);
            }
            //System.out.println("sayfalar"+sayfalar);
            System.out.println(sayfa_isimleri);
            mav = new ModelAndView();
            System.out.println(sayfa_isimleri);
            if (sayfa_isimleri.contains(page) && page != "/") {
                System.out.println(page);
                mav.addObject("page", pageService.findByUrlAndPrinciples("/" + page,itm.getUser().getUsername()));
                mav.addObject("setting", itm); // custom css  gibi ayarları almak için kullanıldı
                List<Page> allPageIsNotDraft = pageService.findAllPageIsNotDraft(contextPath);
                mav.addObject("pages", allPageIsNotDraft); // tüm sayfaları menü için eklenir. //taslakların dışında
                Page currentPage = pageService.findByUrlAndPrinciples("/" + page,itm.getUser().getUsername());
                if (currentPage.getPageType().equals("blog")) {
                    int allblogSize = blogService.findAllSize();
                    int pageNumber = (allblogSize / itm.getBlogcount())-1;
                    //if(allblogSize%5!=0)pageNumber+=1;
                    List<Blog> blogs = blogService.findAll(new PageRequest(0,itm.getBlogcount()));
                    List<Blog> user_blogs = new ArrayList<>();
                    for (Blog b :blogs){
                        if(b.getUsername()==itm.getUser().getUsername()){
                            user_blogs.add(b);
                        }
                    }
                    mav.addObject("blogs", blogs);
                    mav.addObject("pagenumbers", pageNumber);
                    mav.setViewName("/themes/" + currentTheme.getUrl() + "/blog");
                }else if (currentPage.getPageType().equals("cv")){
                    Theme currentTheme1 = pageService.getCurrentTheme(contextPath);
                    mav.setViewName("/themes/"+currentTheme1.getUrl()+"/cv");
                }
                else if (currentPage.getPageType().equals("contact")){
                    mav.setViewName("/themes/"+currentTheme.getUrl()+"/contact");
                }
                else mav.setViewName("/themes/" + currentTheme.getUrl() + "/sample");
                System.out.println("/themes/" + currentTheme.getUrl() + "/sample");
                Authentication auth = SecurityContextHolder.getContext().getAuthentication();
                if (!(auth instanceof AnonymousAuthenticationToken)) {// zaten kullanıcı girişi yapılmışsa.
                    System.out.println(itm.getUser().getUsername());
                    mav.addObject("user",itm.getUser().getUsername());
                    mav.addObject("auth",true);
                }
                else{mav.addObject("auth",false);}
                return mav;
            }
            mav.setViewName("/404.html");
            return mav;
        }
        mav.setViewName("/404.html");
        return mav;
    }


    @GetMapping("pages/{page}/{pageno}")
    public ModelAndView blogPages(@PathVariable String page,@PathVariable int pageno,@PathVariable("contextPath") String contextPath){  // sayfalandırılmış bloglar için kullanıldı
        Page currentPage = pageService.findByUrl("/"+page);
        initalize_model itm = ınıtalizeModelRepository.findByUrl("/"+contextPath); // settings
        Theme currentTheme = pageService.getCurrentTheme(contextPath); // geçerli tema bilgisi
        ModelAndView mav = new ModelAndView();
        if(currentPage.getPageType().equals("blog")){
            int allblogSize = blogService.findAllSize();
            //if(allblogSize%5!=0)pageNumber+=1;
            mav.addObject("pagenumbers",(allblogSize/itm.getBlogcount())-1);
            System.out.println(pageno);

            List<Blog> blogs = blogService.findAll(new PageRequest(pageno,itm.getBlogcount()));
            System.out.println(blogs);
            List<Blog> user_blogs = new ArrayList<>();
            for (Blog b :blogs){
                System.out.println(b.getUsername() + " " + itm.getUser().getUsername());
                if(b.getUsername().equals(itm.getUser().getUsername())){
                    user_blogs.add(b);
                }
            }
            System.out.println(user_blogs);
            mav.addObject("page",pageService.findByUrl("/"+page));
            mav.addObject("setting",itm); // custom css  gibi ayarları almak için kullanıldı
            mav.addObject("blogs",user_blogs);
            List<Page> allPageIsNotDraft = pageService.findAllPageIsNotDraft(contextPath);
            mav.addObject("pages",allPageIsNotDraft); // tüm sayfaları menü için eklenir. //taslakların dışında
            mav.setViewName("/themes/"+currentTheme.getUrl()+"/blog");
        }
        return mav;
    }

    @GetMapping("/admin/**")
    public ModelAndView adminPath(){
        System.out.println("admineatıldı");
        return null;
    }
    @GetMapping("pages/cvId")
    public ResponseEntity<CvModel> getCvId(@PathVariable("contextPath") String contextPath){
        initalize_model itm = ınıtalizeModelRepository.findByUrl("/"+contextPath);
        CvModel cvModel = new CvModel();
        cvModel.setId(itm.getCvId());
        return ResponseEntity.ok(cvModel);
    }
    @GetMapping("pages/emailinfo")
    public ResponseEntity<ContactModel> sendMail(@PathVariable("contextPath") String contextPath){
        ContactModel contactModel = new ContactModel();
        //System.out.println("emailinfo");
        initalize_model itm = ınıtalizeModelRepository.findByUrl("/"+contextPath);
        contactModel.setMailgonderilecek(itm.getUser().getEmail());
        System.out.println(itm.getUser().getEmail());
        return ResponseEntity.ok(contactModel);
    }


    }
