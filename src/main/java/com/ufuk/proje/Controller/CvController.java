package com.ufuk.proje.Controller;

import com.ufuk.proje.Model.CvModel;
import com.ufuk.proje.Util.CvUtil;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;

@RestController
@RequestMapping("/cv")
public class CvController {
    private CvModel temp=null;
    public void setCvController(CvModel temp) {
        this.temp = temp;
    }
    @PostMapping("post")
    public ResponseEntity<CvModel> getCvInfo(@RequestBody CvModel cvModel){
        CvUtil cv = new CvUtil();
        cvModel.setContent(cv.getCvInfoComplex(cvModel.getUrl(),"http://ktun.edu.tr/PersonelBilgi/"+cvModel.getUrl(),cvModel.getId()));
        HashMap hashMap = cv.getOtherInfo(cvModel.getId(),"http://ktun.edu.tr/PersonelBilgi/Index/"+cvModel.getId());
        cvModel.setImage(String.valueOf(hashMap.get("img")));
        cvModel.setName(String.valueOf(hashMap.get("name")));
        cvModel.setUnvan(String.valueOf(hashMap.get("unvan")));
        cvModel.setEmail(String.valueOf(hashMap.get("email")));
        return ResponseEntity.ok(cvModel);
    }

}
