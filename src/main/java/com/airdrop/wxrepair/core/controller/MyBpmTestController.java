package com.airdrop.wxrepair.core.controller;

import com.redxun.bpmclient.model.JsonResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping(value = "/wxrepair/core/bpmtest/")
public class MyBpmTestController {
    @RequestMapping(value = "demo")
    public JsonResult test() {
        JsonResult json = new JsonResult();
        json.setSuccess(true);
        json.setCode(0);
        json.setMsg("成功");
        Map map = new HashMap<String, String>();
        map.put("sex", "nan");
        map.put("age", "19");
        json.setData(map);
        return json;
    }

    @RequestMapping(value = "myTasks")
    public JsonResult myTasks() {
        JsonResult json = new JsonResult();
        json.setSuccess(true);
        json.setCode(0);
        json.setMsg("成功");
        Map map = new HashMap<String, String>();
        map.put("sex", "nan");
        map.put("age", "19");
        json.setData(map);
        return json;
    }
}
