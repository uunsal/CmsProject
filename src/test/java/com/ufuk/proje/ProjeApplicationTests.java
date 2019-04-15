package com.ufuk.proje;

import com.ufuk.proje.Model.Page;
import com.ufuk.proje.Repository.ThemeRepository;
import com.ufuk.proje.Service.PageService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.List;


@RunWith(SpringRunner.class)
@SpringBootTest
public class ProjeApplicationTests {
    @Autowired
    private PageService pageService;
    @Test
    public void contextLoads() {
        List<Page> allpage = pageService.findAllPageIsNotDraft();
        int sayac=0;
        for (Page p:allpage){
            p.setSortNumber(sayac);
            sayac++;
            pageService.createPage(p);
        }

    }

}
