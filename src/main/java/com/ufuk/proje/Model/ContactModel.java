package com.ufuk.proje.Model;

public class ContactModel {
    private String ad;
    private String soyad;
    private String email;
    private String mesaj;
    private String mailgonderilecek;

    public String getMailgonderilecek() {
        return mailgonderilecek;
    }

    public void setMailgonderilecek(String mailgonderilecek) {
        this.mailgonderilecek = mailgonderilecek;
    }

    public String getAd() {
        return ad;
    }

    public void setAd(String ad) {
        this.ad = ad;
    }

    public String getSoyad() {
        return soyad;
    }

    public void setSoyad(String soyad) {
        this.soyad = soyad;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMesaj() {
        return mesaj;
    }

    public void setMesaj(String mesaj) {
        this.mesaj = mesaj;
    }
}
