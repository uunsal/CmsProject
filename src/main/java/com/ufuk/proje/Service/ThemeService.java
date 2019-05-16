package com.ufuk.proje.Service;

import com.ufuk.proje.Model.Theme;

import java.util.List;

public interface ThemeService {
    List<Theme> findAllTheme();

    void changeTheme(Theme theme,String principal);

    void addCustomCss(String customCss);

    Theme getDefaultTheme(String url);
}
