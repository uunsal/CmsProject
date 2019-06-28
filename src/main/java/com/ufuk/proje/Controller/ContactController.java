package com.ufuk.proje.Controller;

import com.ufuk.proje.Model.ContactModel;
import com.ufuk.proje.Service.MailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/contact")
public class ContactController {
    @Autowired
    private MailService mailService;
    @PostMapping("sendMail")
    public void sendMail(@RequestBody ContactModel contactModel){
        mailService.sendEmail(contactModel.getMailgonderilecek(),contactModel);
        System.out.println("yolladı");
    }
}
