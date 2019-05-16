package com.ufuk.proje.Service;

import com.ufuk.proje.Model.Theme;
import com.ufuk.proje.Model.User;
import com.ufuk.proje.Model.authorities;
import com.ufuk.proje.Model.initalize.initalize_model;
import com.ufuk.proje.Repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.*;
import java.util.List;

@Service
public class UserServiceImpl implements UserService {
    private UserRepository userRepository;
    private AuthRepository authRepository;
    private InıtalizeModelRepository ınıtalizeModelRepository;
    private ThemeRepository themeRepository;
    @Autowired
    public UserServiceImpl(UserRepository userRepository, AuthRepository authRepository, InıtalizeModelRepository ınıtalizeModelRepository, ThemeRepository themeRepository) {
        this.userRepository = userRepository;
        this.authRepository = authRepository;
        this.ınıtalizeModelRepository = ınıtalizeModelRepository;
        this.themeRepository = themeRepository;
    }

    @Override
    public void saveUser(User user) { // kullanıcıyı veritabanına ekler
        userRepository.save(user);

    }

    @Override
    public void saveAuth(authorities authorities) { //kullanıcı yetkisini veitabanına ekler
        authRepository.save(authorities);
    }
    @Override
    public void saveUserSettings(initalize_model initalize_model){
        FileReader fileReader = null;
        File file =new File("src/main/resources/public/config.txt");
        try {
            fileReader = new FileReader("src/main/resources/public/config.txt");
            BufferedReader br = new BufferedReader(fileReader);
            String line="";
            String yazılacak="";
            while ((line = br.readLine()) != null) {
                System.out.println(line);
                String paramater[] = line.split("=");
                if(paramater[0]=="url"){
                    line = paramater[0]+"="+initalize_model.getUrl();
                }
                if(paramater[0].equals("initalize")){
                    if(paramater[1].equals("0")){
                        line=paramater[0]+"=1";
                        String write="url="+initalize_model.getUrl();
                        yazılacak+=write+"\n";
                    }

                }
                yazılacak+=line+"\n";

            }
            br.close();
            FileWriter fw = new FileWriter(file);
            BufferedWriter bw = new BufferedWriter(fw);
            bw.write(yazılacak);
            bw.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        ınıtalizeModelRepository.save(initalize_model);
    }

    @Override
    public void uploadTheme(Theme theme) {
        themeRepository.save(theme);
    }

    @Override
    public initalize_model getSettings() {
        List<initalize_model> settings  = ınıtalizeModelRepository.findAll();
        return settings.get(0);
    }

    @Override
    public initalize_model checkContext(String contextPath) {
        return ınıtalizeModelRepository.findByUrl("/"+contextPath);
    }

    @Override
    public List<User> findAll() {
        return userRepository.findAll();
    }


}
