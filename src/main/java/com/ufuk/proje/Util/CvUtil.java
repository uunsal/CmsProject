package com.ufuk.proje.Util;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.web.servlet.ModelAndView;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

public class CvUtil {
    public String getCvInfo(String url,String id){
        Element element = null;
        try {
            Document doc = Jsoup.connect("http://ktun.edu.tr/PersonelBilgi/KisiselBilgiler/").data("id",id).post();
            element = doc.body();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return element.html();
    }
    public String getCvInfoComplex(String baseUrl,String url , String id){
        Element element = null;
        try {
            System.out.println(id);
            Document doc = Jsoup.connect(url).data("id",id).post();
            element = doc.body();
        } catch (IOException e) {
            e.printStackTrace();
        }
        String donus = element.html();
        return donus;
    }
    public HashMap getOtherInfo(String id,String url){
        HashMap hsmp = new HashMap();
        try {
            Document doc = Jsoup.connect(url).get();
            String img_url = doc.select("img[class=img-thumbnail image-text]").first().attr("src");
            Elements e = doc.getElementsByClass("col-sm-5 col-md-5 col-xs-12");
            hsmp.put("name",e.select("h4").text());
            hsmp.put("img",img_url);
            hsmp.put("unvan",e.select("h6").text());
            hsmp.put("email",e.select("img").attr("src"));
        } catch (IOException e) {
            e.printStackTrace();
        }
        return hsmp;
    }
}
