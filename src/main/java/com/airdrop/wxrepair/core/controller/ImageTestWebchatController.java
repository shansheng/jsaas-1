package com.airdrop.wxrepair.core.controller;

import com.airdrop.common.util.ResResult;
import com.airdrop.common.util.ResultMap;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.UUID;

@Controller
@RequestMapping("/wxrepair/core/image/")
public class ImageTestWebchatController {

    //小程序上传图片
    @RequestMapping("upload")
    @ResponseBody
    public ResResult imageUpload (HttpServletRequest request, HttpServletResponse response){
        ResResult result = new ResResult();
        ResultMap res = new ResultMap();
        MultipartHttpServletRequest req =(MultipartHttpServletRequest)request;
        MultipartFile multipartFile =  req.getFile("file");
        String uuid = UUID.randomUUID().toString();
        //Date current_time = new Date();
        //String realPath = "D:/image";
        String contexPath= request.getSession().getServletContext().getRealPath("/upload/images");
        String imageName = "patrol-"+uuid+".jpg";
        try {
            File dir = new File(contexPath);
            if (!dir.exists()) {
                dir.mkdir();
            }
            File file  =  new File(contexPath,imageName);
            multipartFile.transferTo(file);
            res.setResMsg("上传成功");
            res.setResCode(0);
            res.setData(imageName);
        } catch (IOException e) {
            e.printStackTrace();
            res.setResMsg("上传失败");
            res.setResCode(-1);
        } catch (IllegalStateException e) {
            e.printStackTrace();
            res.setResMsg("上传失败");
            res.setResCode(-2);
        }
        res.setResCode(0);
        res.setResMsg("请求成功");
        result.setResult(res);
        return result;
    }
}
