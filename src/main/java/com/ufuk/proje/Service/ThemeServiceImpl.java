package com.ufuk.proje.Service;

import com.ufuk.proje.Model.Theme;
import com.ufuk.proje.Model.initalize.initalize_model;
import com.ufuk.proje.Repository.InıtalizeModelRepository;
import com.ufuk.proje.Repository.ThemeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ThemeServiceImpl implements ThemeService {
    private ThemeRepository themeRepository;
    private InıtalizeModelRepository ınıtalizeModelRepository;
    @Autowired
    public ThemeServiceImpl(ThemeRepository themeRepository,InıtalizeModelRepository ınıtalizeModelRepository) {
        this.themeRepository = themeRepository;
        this.ınıtalizeModelRepository = ınıtalizeModelRepository;
    }

    @Override
    public List<Theme> findAllTheme() {
        return themeRepository.findAll();
    }

    @Override
    public void changeTheme(Theme theme,String username) { //tema değiştirme işlemini yapar.
//        List<Theme> allTheme = themeRepository.findAll();
//        for(Theme t: allTheme){
//            t.setActive(false);
//            themeRepository.save(t);
//        }
//        Optional<Theme> enableTheme = themeRepository.findById(theme.getId());
//        if(enableTheme.isPresent()){
//            enableTheme.get().setActive(true);
//            themeRepository.save(enableTheme.get());
//        }
        initalize_model itm = ınıtalizeModelRepository.findByUserUsername(username);
        Optional<Theme> t = themeRepository.findById(theme.getId());
        if(t.isPresent()){
            itm.setTheme(t.get());
            ınıtalizeModelRepository.save(itm);
        }
    }

    @Override
    public void addCustomCss(String customCss) {
        List<initalize_model> settings = ınıtalizeModelRepository.findAll();
        initalize_model setting = settings.get(0);
        setting.setCustomCss(customCss);
        ınıtalizeModelRepository.save(setting);
    }

    @Override
    public Theme getDefaultTheme(String url) {
        return themeRepository.findByUrl(url);
    }

    @Override
    public void save(Theme theme) {
        themeRepository.save(theme);
    }

    @Override
    public Optional<Theme> findById(int id) {
        return themeRepository.findById(id);
    }
}
