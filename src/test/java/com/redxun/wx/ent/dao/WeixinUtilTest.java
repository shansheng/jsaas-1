package com.redxun.wx.ent.dao;

import java.util.Calendar;
import java.util.Date;

import org.junit.Test;

import com.redxun.core.util.DateUtil;
import com.redxun.test.BaseTestCase;
import com.redxun.wx.ent.util.OrgUtil;
import com.redxun.wx.ent.util.WeixinUtil;
import com.redxun.wx.ent.util.model.SignParamModel;
import com.redxun.wx.util.TokenModel;
import com.redxun.wx.util.TokenUtil;

public class WeixinUtilTest extends BaseTestCase{
	
//	@Test
	public void getSignData() throws Exception{
		String corpId="wwef2127890086b34d";
		String secret="8H-5BndC1RewmeM7hV-tO2xYlKz4pQekPco_9NXam8w";
		SignParamModel model=new SignParamModel();
		model.setStartDate(DateUtil.add(new Date(), Calendar.DATE, -1));
		model.setEndDate(DateUtil.add(new Date(), Calendar.DATE, 1));
		model.addUser("zyg");
		String str= WeixinUtil.getSignData(corpId, secret, model);
		System.out.println(str);
	}
	
//	@Test
	public void getToken() throws Exception{
		TokenModel tokenModel= TokenUtil.getEntToken("wld3c3bd6812", "XaazHPWH50g-CrZqNTHw2l3Z20r6dtjPNn_4lHxy_0k");
		System.out.println(tokenModel.getToken());
	}

	
	@Test
	public void getOrgList() throws Exception{
		TokenModel tokenModel= TokenUtil.getEntToken("wld3c3bd6812", "XaazHPWH50g-CrZqNTHw2l3Z20r6dtjPNn_4lHxy_0k");
		String str=OrgUtil.getOrgList(tokenModel.getToken(), "1");
		System.out.println(str);
	}
}
