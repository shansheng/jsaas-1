package com.airdrop.common.util;

import com.alibaba.fastjson.JSONObject;

public class WeChatUtil {
    /**
     * 登录凭证校验。通过 wx.login() 接口获得临时登录凭证 code 后传到开发者服务器调用此接口完成登录流程。
     *
     * @param appid  小程序 appId
     * @param secret 小程序 appSecret
     * @param jscode 登录时获取的 code
     * @return
     */
    public static JSONObject code2Session(String appid, String secret, String jscode) {
        String url = "https://api.weixin.qq.com/sns/jscode2session?appid=" + appid + "&secret=" + secret + "&js_code="
                + jscode + "&grant_type=authorization_code";
        String getResult = HttpRequest.sendGet(url);
        JSONObject result = JSONObject.parseObject(getResult);
        return result;
    }

    /**
     * 用户支付完成后，获取该用户的 UnionId，无需用户授权
     *
     * @param access_token   接口调用凭证
     * @param openid         支付用户唯一标识
     * @param transaction_id 微信支付订单号
     * @param mch_id         微信支付分配的商户号，和商户订单号配合使用
     * @param out_trade_no   微信支付商户订单号，和商户号配合使用
     * @return
     */
    public static JSONObject getPaidUnionId(String access_token, String openid, String transaction_id, String mch_id,
                                            String out_trade_no) {
        String url = "https://api.weixin.qq.com/wxa/getpaidunionid?access_token=" + access_token + "&openid=" + openid;
        if ( transaction_id != null && transaction_id.length() != 0 ) {
            url += "&transaction_id=" + transaction_id;
        }
        if ( mch_id != null && mch_id.length() != 0 ) {
            url += "&mch_id=" + mch_id;
        }
        if ( out_trade_no != null && out_trade_no.length() != 0 ) {
            url += "&out_trade_no=" + out_trade_no;
        }
        String getResult = HttpRequest.sendGet(url);
        JSONObject result = JSONObject.parseObject(getResult);
        return result;
    }

    /**
     * 获取小程序全局唯一后台接口调用凭据（access_token）
     *
     * @param appid  小程序唯一凭证，即 AppID
     * @param secret 小程序唯一凭证密钥，即 AppSecret
     * @return
     */
    public static JSONObject getAccessToken(String appid, String secret) {
        String url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=" + appid + "&secret="
                + secret;
        String getResult = HttpRequest.sendGet(url);
        JSONObject result = JSONObject.parseObject(getResult);
        return result;
    }

    /**
     * 获取用户访问小程序数据周趋势
     *
     * @param access_token 接口调用凭证
     * @param begin_date   开始日期，为周一日期。格式为 yyyymmdd
     * @param end_date     结束日期，为周日日期，限定查询一周数据。格式为 yyyymmdd
     * @return
     */
    public static JSONObject getWeeklyVisitTrend(String access_token, String begin_date, String end_date) {
        String url
                = "https://api.weixin.qq.com/datacube/getweanalysisappidweeklyvisittrend?access_token=" + access_token;
        String param = "begin_date=" + begin_date + "&end_date=" + end_date;
        String getResult = HttpRequest.sendPost(url, param);
        JSONObject result = JSONObject.parseObject(getResult);
        return result;
    }

    /**
     * 获取用户访问小程序数据日趋势
     *
     * @param access_token 接口调用凭证
     * @param begin_date   开始日期。格式为 yyyymmdd
     * @param end_date     结束日期，限定查询1天数据，允许设置的最大值为昨日。格式为 yyyymmdd
     * @return
     */
    public static JSONObject getDailyVisitTrend(String access_token, String begin_date, String end_date) {
        String url
                = "https://api.weixin.qq.com/datacube/getweanalysisappiddailyvisittrend?access_token=" + access_token;
        String param = "begin_date=" + begin_date + "&end_date=" + end_date;
        String getResult = HttpRequest.sendPost(url, param);
        JSONObject result = JSONObject.parseObject(getResult);
        return result;
    }

    /**
     * 获取用户访问小程序数据月趋势
     *
     * @param access_token 接口调用凭证
     * @param begin_date   开始日期，为自然月第一天。格式为 yyyymmdd
     * @param end_date     结束日期，为自然月最后一天，限定查询一个月的数据。格式为 yyyymmdd
     * @return
     */
    public static JSONObject getMonthlyVisitTrend(String access_token, String begin_date, String end_date) {
        String url
                = "https://api.weixin.qq.com/datacube/getweanalysisappidmonthlyvisittrend?access_token=" + access_token;
        String param = "begin_date=" + begin_date + "&end_date=" + end_date;
        String getResult = HttpRequest.sendPost(url, param);
        JSONObject result = JSONObject.parseObject(getResult);
        return result;
    }

    /**
     * 获取用户访问小程序日留存
     *
     * @param access_token 接口调用凭证
     * @param begin_date   开始日期。格式为 yyyymmdd
     * @param end_date     结束日期，限定查询1天数据，允许设置的最大值为昨日。格式为 yyyymmdd
     * @return
     */
    public static JSONObject getDailyRetain(String access_token, String begin_date, String end_date) {
        String url
                = "https://api.weixin.qq.com/datacube/getweanalysisappiddailyretaininfo?access_token=" + access_token;
        String param = "begin_date=" + begin_date + "&end_date=" + end_date;
        String getResult = HttpRequest.sendPost(url, param);
        JSONObject result = JSONObject.parseObject(getResult);
        return result;
    }

    /**
     * 获取用户访问小程序月留存
     *
     * @param access_token 接口调用凭证
     * @param begin_date   开始日期，为自然月第一天。格式为 yyyymmdd
     * @param end_date     结束日期，为自然月最后一天，限定查询一个月数据。格式为 yyyymmdd
     * @return
     */
    public static JSONObject getMonthlyRetain(String access_token, String begin_date, String end_date) {
        String url
                = "https://api.weixin.qq.com/datacube/getweanalysisappidmonthlyretaininfo?access_token=" + access_token;
        String param = "begin_date=" + begin_date + "&end_date=" + end_date;
        String getResult = HttpRequest.sendPost(url, param);
        JSONObject result = JSONObject.parseObject(getResult);
        return result;
    }

    /**
     * 获取用户访问小程序周留存
     *
     * @param access_token 接口调用凭证
     * @param begin_date   开始日期，为周一日期。格式为 yyyymmdd
     * @param end_date     结束日期，为周日日期，限定查询一周数据。格式为 yyyymmdd
     * @return
     */
    public static JSONObject getWeeklyRetain(String access_token, String begin_date, String end_date) {
        String url
                = "https://api.weixin.qq.com/datacube/getweanalysisappidweeklyretaininfo?access_token=" + access_token;
        String param = "begin_date=" + begin_date + "&end_date=" + end_date;
        String getResult = HttpRequest.sendPost(url, param);
        JSONObject result = JSONObject.parseObject(getResult);
        return result;
    }

    /**
     * 获取小程序新增或活跃用户的画像分布数据。时间范围支持昨天、最近7天、最近30天。其中，新增用户数为时间范围内首次访问小程序的去重用户数，活跃用户数为时间范围内访问过小程序的去重用户数。
     *
     * @param access_token 接口调用凭证
     * @param begin_date   开始日期。格式为 yyyymmdd
     * @param end_date     结束日期，开始日期与结束日期相差的天数限定为0/6/29，分别表示查询最近1/7/30天数据，允许设置的最大值为昨日。格式为 yyyymmdd
     * @return
     */
    public static JSONObject getUserPortrait(String access_token, String begin_date, String end_date) {
        String url
                = "https://api.weixin.qq.com/datacube/getweanalysisappiduserportrait?access_token=" + access_token;
        String param = "begin_date=" + begin_date + "&end_date=" + end_date;
        String getResult = HttpRequest.sendPost(url, param);
        JSONObject result = JSONObject.parseObject(getResult);
        return result;
    }

    /**
     * 获取用户小程序访问分布数据
     *
     * @param access_token 接口调用凭证
     * @param begin_date   开始日期。格式为 yyyymmdd
     * @param end_date     结束日期，限定查询 1 天数据，允许设置的最大值为昨日。格式为 yyyymmdd
     * @return
     */
    public static JSONObject getVisitDistribution(String access_token, String begin_date, String end_date) {
        String url
                = "https://api.weixin.qq.com/datacube/getweanalysisappidvisitdistribution?access_token=" + access_token;
        String param = "begin_date=" + begin_date + "&end_date=" + end_date;
        String getResult = HttpRequest.sendPost(url, param);
        JSONObject result = JSONObject.parseObject(getResult);
        return result;
    }

    /**
     * 访问页面。目前只提供按 page_visit_pv 排序的 top200。
     *
     * @param access_token 接口调用凭证
     * @param begin_date   开始日期。格式为 yyyymmdd
     * @param end_date     结束日期，限定查询1天数据，允许设置的最大值为昨日。格式为 yyyymmdd
     * @return
     */
    public static JSONObject getVisitPage(String access_token, String begin_date, String end_date) {
        String url
                = "https://api.weixin.qq.com/datacube/getweanalysisappidvisitpage?access_token=" + access_token;
        String param = "begin_date=" + begin_date + "&end_date=" + end_date;
        String getResult = HttpRequest.sendPost(url, param);
        JSONObject result = JSONObject.parseObject(getResult);
        return result;
    }

    /**
     * 获取用户访问小程序数据概况
     *
     * @param access_token 接口调用凭证
     * @param begin_date   开始日期。格式为 yyyymmdd
     * @param end_date     结束日期，限定查询1天数据，允许设置的最大值为昨日。格式为 yyyymmdd
     * @return
     */
    public static JSONObject getDailySummary(String access_token, String begin_date, String end_date) {
        String url
                = "https://api.weixin.qq.com/datacube/getweanalysisappiddailysummarytrend?access_token=" + access_token;
        String param = "begin_date=" + begin_date + "&end_date=" + end_date;
        String getResult = HttpRequest.sendPost(url, param);
        JSONObject result = JSONObject.parseObject(getResult);
        return result;
    }

    /**
     * 获取客服消息内的临时素材。即下载临时的多媒体文件。目前小程序仅支持下载图片文件。
     *
     * @param access_token 接口调用凭证
     * @param media_id     媒体文件 ID
     * @return
     */
    public static JSONObject getTempMedia(String access_token, String media_id) {
        String url
                = "https://api.weixin.qq.com/cgi-bin/media/get?access_token=" + access_token + "&media_id=" + media_id;
        String getResult = HttpRequest.sendGet(url);
        JSONObject result = JSONObject.parseObject(getResult);
        return result;
    }

    /**
     * 下发客服当前输入状态给用户。
     *
     * @param access_token 接口调用凭证
     * @param touser       用户的 OpenID
     * @param command      命令
     * @return
     */
    public static JSONObject setTyping(String access_token, String touser, String command) {
        String url
                = "https://api.weixin.qq.com/cgi-bin/message/custom/typing?access_token=" + access_token;
        String param = "touser=" + touser + "&command=" + command;
        String getResult = HttpRequest.sendPost(url, param);
        JSONObject result = JSONObject.parseObject(getResult);
        return result;
    }

    /**
     * 把媒体文件上传到微信服务器。目前仅支持图片。用于发送客服消息或被动回复用户消息。
     *
     * @param access_token 接口调用凭证
     * @param type         文件类型
     * @param media        form-data 中媒体文件标识，有filename、filelength、content-type等信息
     * @return
     */
    public static JSONObject uploadTempMedia(String access_token, String type, JSONObject media) {
        String url
                = "https://api.weixin.qq.com/cgi-bin/media/upload?access_token=" + access_token + "&type=" + type;
        String getResult = HttpRequest.HttpPost(media, url);
        JSONObject result = JSONObject.parseObject(getResult);
        return result;
    }

    /**
     * 发送客服消息给用户
     *
     * @param access_token 接口调用凭证
     * @param params
     * @return
     */
    public static JSONObject customerMessageSend(String access_token, JSONObject params) {
        String url
                = "https://api.weixin.qq.com/cgi-bin/message/custom/send?access_token=" + access_token;
        String getResult = HttpRequest.HttpPost(params, url);
        JSONObject result = JSONObject.parseObject(getResult);
        return result;
    }

    /*public static void main(String[] args) {
        JSONObject params = new JSONObject();
        params.put("code", 0);
        params.put("type", "图片");
        JSONObject content = new JSONObject();
        content.put("name", "dog");
        content.put("age", 3);
        params.put("content", content);
        String string = HttpRequest.HttpPost(params, "https://www.baidu.com");
    }*/

    /**
     * 组合模板并添加至帐号下的个人模板库
     *
     * @param access_token 接口调用凭证
     * @param params
     * @return
     */
    public static JSONObject addTemplate(String access_token, JSONObject params) {
        String url
                = "https://api.weixin.qq.com/cgi-bin/wxopen/template/add?access_token=" + access_token;
        String getResult = HttpRequest.HttpPost(params, url);
        JSONObject result = JSONObject.parseObject(getResult);
        return result;
    }

    /**
     * 删除帐号下的某个模板
     *
     * @param access_token 接口调用凭证
     * @param template_id  要删除的模板id
     * @return
     */
    public static JSONObject deleteTemplate(String access_token, String template_id) {
        String url
                = "https://api.weixin.qq.com/cgi-bin/wxopen/template/del?access_token=" + access_token;
        String getResult = HttpRequest.sendPost(url, template_id);
        JSONObject result = JSONObject.parseObject(getResult);
        return result;
    }

    /**
     * 获取模板库某个模板标题下关键词库
     *
     * @param access_token 接口调用凭证
     * @param id           模板标题id，可通过接口获取，也可登录小程序后台查看获取
     * @return
     */
    public static JSONObject getTemplateLibraryById(String access_token, String id) {
        String url
                = "https://api.weixin.qq.com/cgi-bin/wxopen/template/library/get?access_token=" + access_token;
        String getResult = HttpRequest.sendPost(url, id);
        JSONObject result = JSONObject.parseObject(getResult);
        return result;
    }

    /**
     * 获取小程序模板库标题列表
     *
     * @param access_token 接口调用凭证
     * @param params
     * @return
     */
    public static JSONObject getTemplateLibraryList(String access_token, JSONObject params) {
        String url
                = "https://api.weixin.qq.com/cgi-bin/wxopen/template/library/list?access_token=" + access_token;
        String getResult = HttpRequest.HttpPost(params, url);
        JSONObject result = JSONObject.parseObject(getResult);
        return result;
    }

    /**
     * 获取帐号下已存在的模板列表
     *
     * @param access_token 接口调用凭证
     * @param params
     * @return
     */
    public static JSONObject getTemplateList(String access_token, JSONObject params) {
        String url
                = "https://api.weixin.qq.com/cgi-bin/wxopen/template/list?access_token=" + access_token;
        String getResult = HttpRequest.HttpPost(params, url);
        JSONObject result = JSONObject.parseObject(getResult);
        return result;
    }

    /**
     * 发送模板消息
     *
     * @param access_token 接口调用凭证
     * @param params
     * @return
     */
    public static JSONObject templateMessageSend(String access_token, JSONObject params) {
        String url
                = "https://api.weixin.qq.com/cgi-bin/message/wxopen/template/send?access_token=" + access_token;
        String getResult = HttpRequest.HttpPost(params, url);
        JSONObject result = JSONObject.parseObject(getResult);
        return result;
    }

    /**
     * 下发小程序和公众号统一的服务消息
     *
     * @param access_token 接口调用凭证
     * @param params
     * @return
     */
    public static JSONObject uniformMessageSend(String access_token, JSONObject params) {
        String url
                = "https://api.weixin.qq.com/cgi-bin/message/wxopen/template/uniform_send?access_token=" + access_token;
        String getResult = HttpRequest.HttpPost(params, url);
        JSONObject result = JSONObject.parseObject(getResult);
        return result;
    }

    /**
     * 创建被分享动态消息的 activity_id
     *
     * @param access_token 接口调用凭证
     * @return
     */
    public static JSONObject createActivityId(String access_token) {
        String url
                = "https://api.weixin.qq.com/cgi-bin/message/wxopen/activityid/create?access_token=" + access_token;
        String getResult = HttpRequest.sendGet(url);
        JSONObject result = JSONObject.parseObject(getResult);
        return result;
    }

    /**
     * 修改被分享的动态消息
     *
     * @param access_token 接口调用凭证
     * @param params
     * @return
     */
    public static JSONObject setUpdatableMsg(String access_token, JSONObject params) {
        String url
                = "https://api.weixin.qq.com/cgi-bin/message/wxopen/updatablemsg/send?access_token=" + access_token;
        String getResult = HttpRequest.HttpPost(params, url);
        JSONObject result = JSONObject.parseObject(getResult);
        return result;
    }

    /**
     * 向插件开发者发起使用插件的申请
     *
     * @param access_token 接口调用凭证
     * @param params
     * @return
     */
    public static JSONObject applyPlugin(String access_token, JSONObject params) {
        String url
                = "https://api.weixin.qq.com/wxa/plugin?access_token=" + access_token;
        String getResult = HttpRequest.HttpPost(params, url);
        JSONObject result = JSONObject.parseObject(getResult);
        return result;
    }

    /**
     * 获取当前所有插件使用方（供插件开发者调用）
     *
     * @param access_token 接口调用凭证
     * @param params
     * @return
     */
    public static JSONObject getPluginDevApplyList(String access_token, JSONObject params) {
        String url
                = "https://api.weixin.qq.com/wxa/devplugin?access_token=" + access_token;
        String getResult = HttpRequest.HttpPost(params, url);
        JSONObject result = JSONObject.parseObject(getResult);
        return result;
    }

    /**
     * 查询已添加的插件
     *
     * @param access_token 接口调用凭证
     * @param params
     * @return
     */
    public static JSONObject getPluginList(String access_token, JSONObject params) {
        String url
                = "https://api.weixin.qq.com/wxa/plugin?access_token=" + access_token;
        String getResult = HttpRequest.HttpPost(params, url);
        JSONObject result = JSONObject.parseObject(getResult);
        return result;
    }

    /**
     * 修改插件使用申请的状态（供插件开发者调用）
     *
     * @param access_token 接口调用凭证
     * @param params
     * @return
     */
    public static JSONObject setDevPluginApplyStatus(String access_token, JSONObject params) {
        String url
                = "https://api.weixin.qq.com/wxa/devplugin?access_token=" + access_token;
        String getResult = HttpRequest.HttpPost(params, url);
        JSONObject result = JSONObject.parseObject(getResult);
        return result;
    }

    /**
     * 删除已添加的插件
     *
     * @param access_token 接口调用凭证
     * @param params
     * @return
     */
    public static JSONObject unbindPlugin(String access_token, JSONObject params) {
        String url
                = "https://api.weixin.qq.com/wxa/plugin?access_token=" + access_token;
        String getResult = HttpRequest.HttpPost(params, url);
        JSONObject result = JSONObject.parseObject(getResult);
        return result;
    }

    /**
     * 添加地点
     *
     * @param access_token 接口调用凭证
     * @param params
     * @return
     */
    public static JSONObject nearbyPoiAdd(String access_token, JSONObject params) {
        String url
                = "https://api.weixin.qq.com/wxa/addnearbypoi?access_token=" + access_token;
        String getResult = HttpRequest.HttpPost(params, url);
        JSONObject result = JSONObject.parseObject(getResult);
        return result;
    }

    /**
     * 删除地点
     *
     * @param access_token 接口调用凭证
     * @param params
     * @return
     */
    public static JSONObject nearbyPoiDelete(String access_token, JSONObject params) {
        String url
                = "https://api.weixin.qq.com/wxa/delnearbypoi?access_token=" + access_token;
        String getResult = HttpRequest.HttpPost(params, url);
        JSONObject result = JSONObject.parseObject(getResult);
        return result;
    }

    /**
     * 查看地点列表
     *
     * @param access_token 接口调用凭证
     * @param page         起始页id（从1开始计数）
     * @param page_rows    每页展示个数（最多1000个）
     * @return
     */
    public static JSONObject nearbyPoigetList(String access_token, String page, String page_rows) {
        String url
                = "https://api.weixin.qq.com/wxa/getnearbypoilist?page=" + page + "&page_rows=" + page_rows
                + "&access_token=" + access_token;
        String getResult = HttpRequest.sendGet(url);
        JSONObject result = JSONObject.parseObject(getResult);
        return result;
    }

    /**
     * 展示/取消展示附近小程序
     *
     * @param access_token 接口调用凭证
     * @param params
     * @return
     */
    public static JSONObject nearbyPoisetShowStatus(String access_token, JSONObject params) {
        String url
                = "https://api.weixin.qq.com/wxa/setnearbypoishowstatus?access_token=" + access_token;
        String getResult = HttpRequest.HttpPost(params, url);
        JSONObject result = JSONObject.parseObject(getResult);
        return result;
    }

    /**
     * 获取小程序二维码，适用于需要的码数量较少的业务场景。通过该接口生成的小程序码，永久有效，有数量限制
     *
     * @param access_token 接口调用凭证
     * @param params
     * @return
     */
    public static JSONObject createQRCode(String access_token, JSONObject params) {
        String url
                = "https://api.weixin.qq.com/cgi-bin/wxaapp/createwxaqrcode?access_token=" + access_token;
        String getResult = HttpRequest.HttpPost(params, url);
        JSONObject result = JSONObject.parseObject(getResult);
        return result;
    }

    /**
     * 获取小程序码，适用于需要的码数量较少的业务场景。通过该接口生成的小程序码，永久有效，有数量限制
     *
     * @param access_token 接口调用凭证
     * @param params
     * @return
     */
    public static JSONObject wxacodeGet(String access_token, JSONObject params) {
        String url
                = "https://api.weixin.qq.com/wxa/getwxacode?access_token=" + access_token;
        String getResult = HttpRequest.HttpPost(params, url);
        JSONObject result = JSONObject.parseObject(getResult);
        return result;
    }

    /**
     * 获取小程序码，适用于需要的码数量极多的业务场景。通过该接口生成的小程序码，永久有效，数量暂无限制
     *
     * @param access_token 接口调用凭证
     * @param params
     * @return
     */
    public static JSONObject getUnlimited(String access_token, JSONObject params) {
        String url
                = "https://api.weixin.qq.com/wxa/getwxacodeunlimit?access_token=" + access_token;
        String getResult = HttpRequest.HttpPost(params, url);
        JSONObject result = JSONObject.parseObject(getResult);
        return result;
    }

    /**
     * 校验一张图片是否含有违法违规内容
     *
     * @param access_token 接口调用凭证
     * @param params
     * @return
     */
    public static JSONObject imgSecCheck(String access_token, JSONObject params) {
        String url
                = "https://api.weixin.qq.com/wxa/img_sec_check?access_token=" + access_token;
        String getResult = HttpRequest.HttpPost(params, url);
        JSONObject result = JSONObject.parseObject(getResult);
        return result;
    }

    /**
     * 检查一段文本是否含有违法违规内容
     *
     * @param access_token 接口调用凭证
     * @param params
     * @return
     */
    public static JSONObject msgSecCheck(String access_token, JSONObject params) {
        String url
                = "https://api.weixin.qq.com/wxa/msg_sec_check?access_token=" + access_token;
        String getResult = HttpRequest.HttpPost(params, url);
        JSONObject result = JSONObject.parseObject(getResult);
        return result;
    }

    /**
     * SOTER 生物认证秘钥签名验证
     *
     * @param access_token 接口调用凭证
     * @param params
     * @return
     */
    public static JSONObject verifySignature(String access_token, JSONObject params) {
        String url
                = "https://api.weixin.qq.com/cgi-bin/soter/verify_signature?access_token=" + access_token;
        String getResult = HttpRequest.HttpPost(params, url);
        JSONObject result = JSONObject.parseObject(getResult);
        return result;
    }
}
