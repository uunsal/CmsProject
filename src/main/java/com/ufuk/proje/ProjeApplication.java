package com.ufuk.proje;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ConfigurableApplicationContext;

import java.io.*;
import java.util.HashMap;

@SpringBootApplication
public class ProjeApplication {
    private static HashMap hsmp = new HashMap();
    private static ConfigurableApplicationContext context;
    public static void main(String[] args) {
        if(readInıtalize()){
            String url=String.valueOf(hsmp.get("url"));
            if(url.charAt(0)!='/') url="/"+url;
            System.setProperty("server.servlet.context-path", url);
        }
        else{
            System.setProperty("server.servlet.context-path", "/setup");
        }
        context = SpringApplication.run(ProjeApplication.class, args);
        System.out.println("Ana uygulama deploy oldu");


    }
    public static void restart() {
        ApplicationArguments args = context.getBean(ApplicationArguments.class);

        Thread thread = new Thread(() -> {
            context.close();
            main(new String[0]);
        });

        thread.setDaemon(false);
        thread.start();
    }
    public static Boolean readInıtalize(){
        FileReader fileReader = null;
        String line;
        try {
            fileReader = new FileReader("src/main/resources/public/config.txt");
            BufferedReader br = new BufferedReader(fileReader);
            while ((line = br.readLine()) != null) {
                String paramater[] = line.split("=");
                hsmp.put(paramater[0],paramater[1]);

            }
            if (hsmp.get("initalize").equals("0")) return false;
            br.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return true;
    }

}
