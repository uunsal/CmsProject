package com.ufuk.proje.Controller;

import com.ufuk.proje.Model.*;
import com.ufuk.proje.Model.initalize.initalize_model;
import com.ufuk.proje.Repository.InıtalizeModelRepository;
import com.ufuk.proje.Service.BlogService;
import com.ufuk.proje.Service.PageService;
import com.ufuk.proje.Service.ThemeService;
import com.ufuk.proje.Service.UserService;
import com.ufuk.proje.Util.CvUtil;
import org.apache.catalina.core.ApplicationContext;
import org.apache.commons.io.FileUtils;
import org.apache.coyote.Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

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
        System.out.println(page_control+ " "+principal.getName());

            if (page.getPageType() == null)
                page.setPageType("sample");// gelişmiş seçenekte sayfa türü belirtilmemişse sample dır

            if (!page.getPageType().equals("sample")) {
                Page page_type_control = pageService.findByPageTypeAndPrinciple(page.getPageType(),principal.getName());
                if (page_type_control!= null) { // var olan sayfa türlerinden zaten varsa kullanıcıya hata döndürmesi için yazıldı.
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
    public ResponseEntity<Context> getContextPath(HttpServletRequest request,Principal principal){ // context path url bilgisini döndürür
        Context context = new Context();
//        context.setContextPath(request.getContextPath());
        initalize_model itm = ınıtalizeModelRepository.findByUserUsername(principal.getName());
        String url="";
        for (char s: itm.getUrl().toCharArray()){
            if(s!='/') url+=s;
        }
        context.setContextPath(url);
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
    public void uploadPhoto(@RequestBody image ımage,Principal principal){
        Date date = new Date();
        ımage.setLoadDate(date.toString());
        ımage.setUsername(principal.getName());
        pageService.updateImage(ımage);
    }

    @GetMapping("findAllImage")
    public ResponseEntity<List<image>> findAllImage(Principal principal){
        return ResponseEntity.ok(pageService.findAllImage(principal.getName()));
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
    public ResponseEntity<Boolean> createBlog(@RequestBody Blog blog,Principal principal){
        blog.setUsername(principal.getName());
        blogService.createBlog(blog);
        return ResponseEntity.ok(Boolean.TRUE);
    }

    @GetMapping("getAllUser")
    public ResponseEntity<List<User>> getAllUser(){
        return ResponseEntity.ok(userService.findAll());
    }

    @PostMapping("superCreate")
    public ResponseEntity<User> superCreate(@RequestBody initalize_model initalize_model){
        List<Theme> themecheck= themeService.findAllTheme();
        initalize_model itmcheck = ınıtalizeModelRepository.findByUrl("/"+initalize_model.getUrl());
        if(itmcheck!=null){// url kontrolü yapıldı
            User user = new User();
            user.setUsername("null");
            return ResponseEntity.ok(user);
        }
        if(themecheck.size()==0){ // database de tema yoksa temaları oluşturur
            Theme t1 = new Theme();
            t1.setName("Ktün Kırmızı");
            t1.setDescription("Konya Teknik Üniversitesine Benzeyen Kırmızı Ağırlıkta Tema");
            t1.setUrl("Ktun");
            Theme t2 =  new Theme();
            t2.setName("Ktün Klasik");
            t2.setUrl("Default");
            t2.setDescription("Web sayfanızı ilk oluşturduğunuzha hazır olarak gelen koyu ağırlıkta tema");
            Theme t3 = new Theme();
            t3.setName("Ktün Modern");
            t3.setUrl("Theme1");
            t3.setDescription("Açık renkleri barındıran web tasarımı.");
            themeService.save(t1);
            themeService.save(t2);
            themeService.save(t3);
        }
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
        Random random = new Random();
        for (int i=0;i<3;i++){
            username = username+random.nextInt(10);
        }
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

    @PostMapping("updateCv")
    public ResponseEntity<String> updateCv(@RequestBody initalize_model initalize_model,Principal principal){
        initalize_model itm = ınıtalizeModelRepository.findByUserUsername(principal.getName());
        itm.setCvId(initalize_model.getCvId());
        ınıtalizeModelRepository.save(itm);
        Page p = new Page();
        p.setContents("");
        p.setDraft(false);
        p.setTitle("cv");
        p.setUrl("/cv");
        p.setPageType("cv");
        pageService.updateCv(p,principal.getName());
        System.out.println(String.valueOf(itm.getProfilePhoto()).equals(null));
        if(itm.getProfilePhoto()==""||itm.getProfilePhoto()==null){
            CvUtil cv = new CvUtil();
            HashMap hashMap = cv.getOtherInfo(itm.getCvId(),"http://ktun.edu.tr/PersonelBilgi/Index/"+itm.getCvId());
            itm.setProfilePhoto(hashMap.get("img")+itm.getCvId());
            ınıtalizeModelRepository.save(itm);
        }
        else{
            CvUtil cv = new CvUtil();
            HashMap hashMap = cv.getOtherInfo(itm.getCvId(),"http://ktun.edu.tr/PersonelBilgi/Index/"+itm.getCvId());
            itm.setProfilePhoto(hashMap.get("img")+itm.getCvId());
            ınıtalizeModelRepository.save(itm);
        }
        return ResponseEntity.ok("");
    }
    @GetMapping("settingsinit")
    public ResponseEntity<initalize_model> userInfoSettings(Principal principal){
        return ResponseEntity.ok(ınıtalizeModelRepository.findByUserUsername(principal.getName()));
    }
    @PostMapping("updatepass")
    public void changePassword(@RequestBody User user,Principal principal){
        User userDb = userService.findUserByUsername(principal.getName());
        userDb.setPassword("{bcrypt}"+new BCryptPasswordEncoder().encode(user.getPassword()));
        userService.saveUser(userDb);
    }
    @PostMapping("updatenamelast")
    public void changeName(@RequestBody User user,Principal principal){
        User userDb = userService.findUserByUsername(principal.getName());
        userDb.setFirsNtame(user.getFirstName());
        userDb.setLastName(user.getLastName());
        userService.saveUser(userDb);
    }
    @PostMapping("updateemail")
    public void changeEmail(@RequestBody User user,Principal principal){
        User userDb = userService.findUserByUsername(principal.getName());
        userDb.setEmail(user.getEmail());
        userService.saveUser(userDb);
    }
    @PostMapping("updateProfilePhoto")
    public void updateProfilePhotos(@RequestBody initalize_model initalize_model,Principal principal){
        initalize_model itm = ınıtalizeModelRepository.findByUserUsername(principal.getName());
        itm.setProfilePhoto(initalize_model.getProfilePhoto());
        ınıtalizeModelRepository.save(itm);
    }

    @PostMapping("previewTheme")
    public ResponseEntity<Theme> previewTheme(@RequestBody Theme theme){
        Optional <Theme> t = themeService.findById(theme.getId());
        if(t.isPresent()){
            System.out.println(t.get().getUrl());
            return ResponseEntity.ok(t.get()) ;
        }
        return null;
    }

    @PostMapping("updateBlogCount")
    public void updateBlogCount(@RequestBody initalize_model itm1,Principal principal){
        System.out.println("geldi"+itm1.getBlogcount());
       initalize_model itm = ınıtalizeModelRepository.findByUserUsername(principal.getName());
       itm.setBlogcount(itm1.getBlogcount());
       ınıtalizeModelRepository.save(itm);

    }

}
