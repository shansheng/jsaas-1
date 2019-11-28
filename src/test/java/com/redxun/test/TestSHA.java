package com.redxun.test;

import java.io.FileInputStream;
import java.io.IOException;

import org.apache.commons.codec.DecoderException;
import org.apache.commons.codec.digest.DigestUtils;

public class TestSHA {
	
	public static void main(String[] args) throws DecoderException, IOException {
//		String str= EncryptUtil.encryptMd5("aa");
//		System.out.println(str);
		FileInputStream stream=new FileInputStream("E:\\work\\redxun\\jsaas\\metadata\\build-dev\\JSaas开发框架环境安装.doc");
		String str= DigestUtils.md2Hex(stream);
		System.out.println(str);
	}
	
	

}
