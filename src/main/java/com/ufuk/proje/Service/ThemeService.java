package com.ufuk.proje.Service;

import com.ufuk.proje.Model.Theme;

import java.util.List;
import java.util.Optional;

public interface ThemeService {
    List<Theme> findAllTheme();

    void changeTheme(Theme theme,String principal);

    void addCustomCss(String customCss);

    Theme getDefaultTheme(String url);

    void save(Theme theme);

    Optional<Theme> findById(int id);
}
