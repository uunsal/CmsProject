package com.ufuk.proje.Service;

import com.ufuk.proje.Model.Page;
import com.ufuk.proje.Model.Theme;
import com.ufuk.proje.Model.User;
import com.ufuk.proje.Model.authorities;
import com.ufuk.proje.Model.initalize.initalize_model;
import com.ufuk.proje.Repository.InıtalizeModelRepository;
import com.ufuk.proje.Repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public interface UserService {
    public void saveUser(User user);
    public void saveAuth(authorities authorities);
    public void saveUserSettings(initalize_model initalize_model);
    public void uploadTheme(Theme theme);
    public initalize_model getSettings();
    public initalize_model checkContext(String contextPath);
    public List<User> findAll();
    public User findUserByUsername(String username);
}
