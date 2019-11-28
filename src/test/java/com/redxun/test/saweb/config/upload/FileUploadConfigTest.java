/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.redxun.test.saweb.config.upload;

import java.io.IOException;
import java.io.InputStream;

import org.dom4j.Document;
import org.junit.Assert;
import org.junit.Test;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;

import com.redxun.core.util.Dom4jUtil;
import com.redxun.test.BaseTestCase;

/**
 *
 * @author X230
 */
public class FileUploadConfigTest extends BaseTestCase{
    
    @Test
    public void loadXml() throws IOException{
        Resource resource = new ClassPathResource("config/fileTypeConfig.xml");
        
        InputStream is=resource.getInputStream();
        
        Document doc=Dom4jUtil.load(is);
        
        Assert.assertNotNull(doc);
    }
}
