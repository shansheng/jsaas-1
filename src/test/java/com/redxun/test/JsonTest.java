package com.redxun.test;

import java.util.Arrays;
import java.util.Map;
import java.util.function.Consumer;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.core.json.JSONUtil;
import com.redxun.core.script.GroovyEngine;
import com.redxun.core.util.AppBeanUtil;

public class JsonTest {
	public static void main(String[] args) {
		JSONArray array = new JSONArray();
		for (int i = 0; i < 5; i++) {
			JSONObject obj = new JSONObject();
			obj.put("aaa", i);
			obj.put("bbb", i);
			obj.put("ccc", i+1);
			array.add(obj);
		}
		
		String filter = "{aaa} == 1 OR {bbb}==2 OR ({aaa}==0 AND {ccc}==1)";
		
		//使用filter过滤条件，来实现集合的过滤
		System.out.println(array);
	}
}
