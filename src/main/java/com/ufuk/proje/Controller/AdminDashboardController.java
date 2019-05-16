package com.ufuk.proje.Controller;

import com.ufuk.proje.Model.*;
import com.ufuk.proje.Model.initalize.initalize_model;
import com.ufuk.proje.Repository.InıtalizeModelRepository;
import com.ufuk.proje.Service.BlogService;
import com.ufuk.proje.Service.PageService;
import com.ufuk.proje.Service.ThemeService;
import com.ufuk.proje.Service.UserService;
import org.apache.catalina.core.ApplicationContext;
import org.apache.commons.io.FileUtils;
import org.apache.coyote.Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.text.Normalizer;
import java.util.*;

@RestController
@RequestMapping("admin/dashboard")
public class AdminDashboardController {
    @Autowired
    private PageService pageService;

    @Autowired
    private UserService userService;

    @Autowired
    private ThemeService themeService;

    @Autowired
    private BlogService blogService;

    @Autowired
    private InıtalizeModelRepository ınıtalizeModelRepository;

    @PostMapping("createPage")
    public ResponseEntity<Page> createPage(@RequestBody Page page,Principal principal){
        HashMap hsmp = new HashMap();
        hsmp.put("İ","I");hsmp.put("Ş","S");hsmp.put("Ğ","G");hsmp.put("Ç","C");hsmp.put("Ü","U");
        // Türkçe Karakterlere Dikkat edilmeli
        String pagetitle="";
        for(char s:page.getTitle().toCharArray()){
            if(s!=' '){
                String buyuk_h=String.valueOf(s).toUpperCase();
                if(hsmp.containsKey(buyuk_h.toUpperCase())) pagetitle+=String.valueOf(hsmp.get(buyuk_h.toUpperCase())).toLowerCase();
                else pagetitle+=String.valueOf(s).toLowerCase();
            }
        }
        if(page.getPageType()==null){
            page.setUrl("/"+pagetitle.toLowerCase());
        }
        else{
            String url=page.getUrl();
            page.setUrl("/"+url.toLowerCase());
        }
        page.setContents("");

        Page page_control = pageService.findByUrlAndPrinciples(page.getUrl(),principal.getName()); // sayfa yoksa sayfayı oluşturur.
        System.out.println(page_control);
        if(page.getPageType()==null) page.setPageType("sample"); // gelişmiş seçenekte sayfa türü belirtilmemişse sample dır
        if(!page.getPageType().equals("sample")){
            List<Page> page_type_control = pageService.findByPageType(page.getPageType());
            if(page_type_control.size()>0){ // var olan sayfa türlerinden zaten varsa kullanıcıya hata döndürmesi için yazıldı.
                return ResponseEntity.ok(null);
            }
        }
        if(page_control==null){
            return ResponseEntity.ok(pageService.createPage(page,principal.getName()));
        }
        return ResponseEntity.ok(null);
//        try {
//            File file = new File("src/main/webapp/WEB-INF/jsp/pages/index.jsp"); // temanın kopyalanan dosyası
//            File file_new = new File("src/main/webapp/WEB-INF/jsp/pages/"+page.getTitle().toLowerCase()+".jsp"); //kopyalanacak hedef dosya
//            FileUtils.touch(file_new);
//            FileUtils.copyFile(file,file_new);
//            pageService.createPage(page); // sayfayı veritabanına kaydeder
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        }

    }

    @PostMapping("updatePage")
    public ResponseEntity<String> updatePage(@RequestBody Page page,Principal principal){ // sayfaları güncelleyen fonksiyon
        return ResponseEntity.ok(pageService.updatePage(page,principal.getName()));
    }
    @PostMapping("deletePage")
    public void deletePage(@RequestBody Page page){
        pageService.deletePage(page);
    }
    @GetMapping("initPages")
    public ResponseEntity<List<Page>> initPages(Principal principal){

        //System.out.println(page.toString());
        System.out.println(principal.getName());
        return ResponseEntity.ok(pageService.findAllPage(principal.getName()));
    }

    @PostMapping("getPage")
    public  ResponseEntity<Page> getPage(@RequestBody Page page){ // sayfa bilgisini ıd ye göre getirir
        return ResponseEntity.ok(pageService.findById(page.getId()).get());
    }

    @PostMapping("getContextPath")
    public ResponseEntity<Context> getContextPath(HttpServletRequest request){ // context path url bilgisini döndürür
        Context context = new Context();
        context.setContextPath(request.getContextPath());
        return ResponseEntity.ok(context);
    }

    @PostMapping("uploadTheme")
    public ResponseEntity<String> uploadTheme(Theme theme){
        userService.uploadTheme(theme);
        return ResponseEntity.ok("Dosya Yüklendi");
    }

    @PostMapping("updateDraftPage")
    public ResponseEntity<String> updateDraftPage(@RequestBody Page page){// taslak sayfayı güncelleyen fonksiyon
        return ResponseEntity.ok(pageService.updateDraftPage(page));
    }

    @PostMapping("updatePageAdvanced")
    public ResponseEntity<Page> updatePageAdvanced(@RequestBody Page page){//sayfayı gelişmiş olarak güncelleyen fonksiyon
        return ResponseEntity.ok(pageService.updatePageAdvanced(page));
    }

    @GetMapping("allTheme")
    public ResponseEntity<List<Theme>> getAllTheme(){
        List<Theme> allTheme = themeService.findAllTheme();
        return ResponseEntity.ok(allTheme);
    }

    @GetMapping("getNotDraftPage")
    public ResponseEntity<List<Page>> getNotDraftPage(Principal principal){
        return ResponseEntity.ok(pageService.getNotDraftPage(principal.getName()));
    }

    @PostMapping("uploadPhoto")
    public void uploadPhoto(@RequestBody image ımage){
        Date date = new Date();
        ımage.setLoadDate(date.toString());
        pageService.updateImage(ımage);

    }

    @GetMapping("findAllImage")
    public ResponseEntity<List<image>> findAllImage(){
        return ResponseEntity.ok(pageService.findAllImage());
    }

    @PostMapping("changeTheme")
    public void changeTheme(@RequestBody Theme theme,Principal principal){
        System.out.println(theme.getId());
        themeService.changeTheme(theme,principal.getName());
    }

    @PostMapping("changeMenuSort")
    public void changeMenuSort(@RequestBody List<Page> pages,Principal principal){
        int sayac=0;
        for (Page p: pages){
            Optional<Page> page  = pageService.findById(p.getId());
            if(page.isPresent()){
                page.get().setSortNumber(sayac);
                System.out.println(page.get().getTitle()+" "+page.get().getSortNumber());
                pageService.savePage(page.get());
                sayac++;
            }
        }
    }

    @PostMapping("setCustomCss")
    public void updateCustomCss(@RequestBody String customCss){
        System.out.println("custo"+customCss);
        if(customCss.length()==0 | customCss.equals(null)){
            customCss = "";
        }
        themeService.addCustomCss(customCss);
    }

    @GetMapping("getCustomCss")
    public ResponseEntity<initalize_model> getCustomCss(){
        return ResponseEntity.ok(userService.getSettings());
    }

    @PostMapping("createBlog")
    public ResponseEntity<Boolean> createBlog(@RequestBody Blog blog){
        blogService.createBlog(blog);
        return ResponseEntity.ok(Boolean.TRUE);
    }

    @GetMapping("getAllUser")
    public ResponseEntity<List<User>> getAllUser(){
        return ResponseEntity.ok(userService.findAll());
    }

    @PostMapping("superCreate")
    public ResponseEntity<User> superCreate(@RequestBody initalize_model initalize_model){
        initalize_model itm = new initalize_model();
        if(initalize_model.getUrl().charAt(0)!='/') {
            String url = initalize_model.getUrl();
            initalize_model.setUrl("/"+url);
        }
        itm.setUrl(initalize_model.getUrl());
        itm.setIsAdmin(1);
        Theme t = themeService.getDefaultTheme("Default");
        Page p = new Page();
        p.setPageType("home");
        p.setUrl("/");
        p.setContents("");
        p.setTitle("ana sayfa");
        p.setDraft(false);
        itm.setTheme(t);
        User u = new User();
        String username = initalize_model.getUser().getFirstName()
                .toLowerCase().charAt(0)+initalize_model.getUser().getLastName().toLowerCase();
        u.setUsername(username);
        u.setEnabled(true);
        u.setUnvan(initalize_model.getUser().getUnvan());
        u.setFirsNtame(initalize_model.getUser().getFirstName());
        u.setLastName(initalize_model.getUser().getLastName());
        u.setEmail(initalize_model.getUser().getEmail());
        authorities authorities = new authorities();
        authorities.setUsername(u.getUsername());
        authorities.setAuthority("ROLE_ADMIN");
        String pass = "";
        Random r = new Random();
        for (int i=0;i<5;i++){
            pass+=r.nextInt(10);
        }
        u.setPassword("{bcrypt}"+new BCryptPasswordEncoder().encode(pass));
        itm.setUser(u);
        p.setUser(u);
        userService.saveUser(u);
        pageService.createPage(p,u.getUsername());
        ınıtalizeModelRepository.save(itm);
        userService.saveAuth(authorities);
        u.setPassword(pass);
        return ResponseEntity.ok(u);

    }

}
