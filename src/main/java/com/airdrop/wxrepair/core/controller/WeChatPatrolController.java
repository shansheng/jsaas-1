package com.airdrop.wxrepair.core.controller;

import com.airdrop.common.constant.AppConstant;
import com.airdrop.common.util.ResResult;
import com.airdrop.common.util.ResultMap;
import com.airdrop.wxrepair.core.entity.PatrolFullbillRecord;
import com.airdrop.wxrepair.core.entity.PatrolFullbillRecordDetail;
import com.airdrop.wxrepair.core.entity.PatrolRecordImage;
import com.airdrop.wxrepair.core.entity.PatrolWechatAccesstoken;
import com.airdrop.wxrepair.core.manager.*;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Date;

@Controller
@RequestMapping("/wxrepair/core/patrol/")
public class WeChatPatrolController {
    @Resource
    PatrolFullbillRecordManager patrolFullbillRecordManager;

    @Resource
    PatrolFullbillRecordDetailManager patrolFullbillRecordDetailManager;

    @Resource
    PatrolWechatUserinfoManager patrolWechatUserinfoManager;

    @Resource
    PatrolWechatAccesstokenManager patrolWechatAccesstokenManager;

    @Resource
    PatrolRecordImageManager patrolRecordImageManager;

    /**
     * 保存填单信息
     *
     * @param params
     * @return
     */
    @RequestMapping("saveRecord")
    @ResponseBody
    public ResResult saveRecord(@RequestBody JSONObject params) {
        ResResult result = new ResResult();
        String staffId = params.getString("staffId");
        String staffName = params.getString("staffName");
        String questionNaireId = params.getString("questionNaireId");
        String questionNaireName = params.getString("questionNaireName");
        String statusId = params.getString("statusId");
        String statusName = params.getString("statusName");
        String shopId = params.getString("shopId");
        String shopName = params.getString("shopName");
        PatrolFullbillRecord record = new PatrolFullbillRecord();
        record.setStaff(staffId);
        record.setStaffName(staffName);
        record.setQuestionnaire(questionNaireId);
        record.setQuestionnaireName(questionNaireName);
        record.setStatus(statusId);
        record.setStatusName(statusName);
        record.setShop(shopId);
        record.setShopName(shopName);
        record.setFulldate(new Date());
        patrolFullbillRecordManager.create(record);
        //detail
        JSONArray arr = params.getJSONArray("answerInfo");
        String recordId = record.getId();
        for (int i = 0; i < arr.size(); i++) {
            JSONObject obj = arr.getJSONObject(i);
            saveRecordDetail(obj, recordId);
        }
        result.setResCode(0);
        result.setResMsg("请求成功");
        return result;
    }

    public void saveRecordDetail(JSONObject params, String recordId) {
        String questionId = params.getString("questionId");
        String questionName = params.getString("questionName");
        String questionType = params.getString("questionType");
        String typeName = params.getString("typeName");
        String answer = params.getString("answer");
        PatrolFullbillRecordDetail recordDetail = new PatrolFullbillRecordDetail();
        recordDetail.setQuestion(questionId);
        recordDetail.setQuestionName(questionName);
        recordDetail.setQuestionType(questionType);
        recordDetail.setQuestionTypeName(typeName);
        recordDetail.setAnswer(answer);
        recordDetail.setRefId(recordId);
        patrolFullbillRecordDetailManager.create(recordDetail);
        if(questionType.equals("004") && StringUtils.isNotEmpty(answer)){
            String[] arr = answer.split("&");
            for (int i = 0; i < arr.length; i++) {
                String path = AppConstant.WX_BASE_IMAGEPATH+arr[i];
                String imgtype = "url";
                JSONObject imgInfo = new JSONObject();
                imgInfo.put("imgtype",imgtype);
                imgInfo.put("val",path);
                PatrolRecordImage image = new PatrolRecordImage();
                image.setImage(imgInfo.toString());
                image.setRefId(recordDetail.getId());
                patrolRecordImageManager.create(image);
            }
        }

    }

    /**
     * 修改填单信息
     */
    @RequestMapping("editRecord")
    @ResponseBody
    public ResResult editRecord(@RequestBody JSONObject params) {
        ResResult result = new ResResult();
        String recordId = params.getString("recordId");
        String statusId = params.getString("statusId");
        String statusName = params.getString("statusName");
        String shopId = params.getString("shopId");
        String shopName = params.getString("shopName");
        PatrolFullbillRecord record = new PatrolFullbillRecord();
        record.setId(recordId);
        record.setStatus(statusId);
        record.setStatusName(statusName);
        record.setShop(shopId);
        record.setShopName(shopName);
        record.setFulldate(new Date());
        patrolFullbillRecordManager.update(record);
        JSONArray arr = params.getJSONArray("answerInfo");
        for (int i = 0; i < arr.size(); i++) {
            JSONObject obj = arr.getJSONObject(i);
            String rdId = obj.getString("rdId");
            String answer = obj.getString("answer");
            patrolFullbillRecordDetailManager.updateRecordDetail(rdId, answer);
            String questionType = obj.getString("questionType");
            if(questionType.equals("004")){
                patrolRecordImageManager.delByRefId(rdId);
                if(StringUtils.isNotEmpty(answer)){
                    String[] strArr = answer.split("&");
                    for (int j = 0; j < strArr.length; j++) {
                        String path = AppConstant.WX_BASE_IMAGEPATH+strArr[j];
                        String imgtype = "url";
                        JSONObject imgInfo = new JSONObject();
                        imgInfo.put("imgtype",imgtype);
                        imgInfo.put("val",path);
                        PatrolRecordImage image = new PatrolRecordImage();
                        image.setImage(imgInfo.toString());
                        image.setRefId(rdId);
                        patrolRecordImageManager.create(image);
                    }
                }
            }
        }
        result.setResCode(0);
        result.setResMsg("请求成功");
        return result;
    }

    /**
     * 获取账户角色(门店)
     *
     * @param params
     * @return
     */
    @RequestMapping("getAccountRole")
    @ResponseBody
    public ResResult getAccountRole(@RequestBody JSONObject params) {
        ResResult result = new ResResult();
        ResultMap res = new ResultMap();
        String account = params.getString("account");
        if ( StringUtils.isEmpty(account) ) {
            result.setResCode(-1);
            result.setResMsg("数据有误,请检查请求参数");
            result.setResult(null);
        } else {
            JSONObject jsonObject = patrolWechatUserinfoManager.getUserRoleInfo(account);
            int code = jsonObject.getIntValue("code");
            if ( code == 1 ) {
                res.setResMsg("门店人员登录");
                res.setResCode(1);
                res.setData(jsonObject.get("data"));
            } else if ( code == 2 ) {
                res.setResMsg("督导登录");
                res.setResCode(2);
                res.setData(patrolWechatUserinfoManager.getAllShop());
            } else if ( code == 3 ) {
                res.setResMsg("其它人员登录");
                res.setResCode(3);
                res.setData(patrolWechatUserinfoManager.getAllShop());
            }
            result.setResCode(0);
            result.setResMsg("获取用户角色");
            result.setResult(res);
        }
        return result;
    }

    /**
     * 获取巡检单二维码
     *
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping("getPicture")
    @ResponseBody
    public void getPicture(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //问卷id
        String naireId = request.getParameter("nId");
        String type = request.getParameter("type");
        String appId = AppConstant.WX_APPID;
        String appSecret = AppConstant.WX_APPSECRET;
        PatrolWechatAccesstoken wxtoken = patrolWechatAccesstokenManager.getAccessToken(appId, appSecret);
        String token = wxtoken.getToken();
        JSONObject params = new JSONObject();
        params.put("scene", "naireId=" + naireId + "&type="+type);
        //String res = WeChatUtil.getUnlimited(token, params);
        params.put("page","pages/xunjian/index");
        String action
                = "https://api.weixin.qq.com/wxa/getwxacodeunlimit?access_token=" + token;
        String jsonStr = params.toString();
        URL url = new URL(action);
        HttpURLConnection http = (HttpURLConnection) url.openConnection();
        http.setRequestMethod("POST");
        http.setRequestProperty("Content-Type",
                "application/json;charset=UTF-8");
        http.setDoOutput(true);
        http.setDoInput(true);
        System.setProperty("sun.net.client.defaultConnectTimeout", "30000");// 连接超时30秒
        System.setProperty("sun.net.client.defaultReadTimeout", "30000"); // 读取超时30秒
        http.connect();
        OutputStream os = http.getOutputStream();
        os.write(jsonStr.getBytes("UTF-8"));// 传入参数
        os.flush();
        os.close();
        InputStream is = http.getInputStream();
        int size = is.available();
        byte[] jsonBytes = new byte[size];
        response.setContentType("image/png");
        ServletOutputStream sos = response.getOutputStream();
        int len;
        while ((len = is.read(jsonBytes)) != -1) {
            sos.write(jsonBytes, 0, len);
            sos.flush();
        }
        sos.close();
    }
}
