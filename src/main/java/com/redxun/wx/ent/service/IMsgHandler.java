package com.redxun.wx.ent.service;

import java.util.Map;

import com.redxun.wx.ent.util.model.BaseRtnMsg;

public interface IMsgHandler {
	
	BaseRtnMsg handMessage(Map<String,String> msgMap);

}
