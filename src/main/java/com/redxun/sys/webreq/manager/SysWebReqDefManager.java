
package com.redxun.sys.webreq.manager;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.core.dao.IDao;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.script.GroovyEngine;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.ExceptionUtil;
import com.redxun.core.util.HttpClientUtil;
import com.redxun.core.util.HttpClientUtil.HttpRtnModel;
import com.redxun.core.util.StringUtil;
import com.redxun.saweb.util.IdUtil;
import com.redxun.sys.api.ContextHandlerFactory;
import com.redxun.sys.webreq.dao.SysWebReqDefDao;
import com.redxun.sys.webreq.entity.SysWebReqDef;

/**
 * 
 * <pre>
 *  
 * 描述：流程数据绑定表 处理接口
 * 作者:mansan
 * 日期:2018-07-24 17:46:42
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class SysWebReqDefManager extends MybatisBaseManager<SysWebReqDef> {

	@Resource
	private SysWebReqDefDao sysWebReqDefDao;
	@Resource
	GroovyEngine groovyEngine;
	@Resource
	ContextHandlerFactory contextHandlerFactory;

	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return sysWebReqDefDao;
	}

	public SysWebReqDef getBpmDataBind(String uId) {
		SysWebReqDef bpmDataBind = get(uId);
		return bpmDataBind;
	}

	@Override
	public void create(SysWebReqDef entity) {
		entity.setId(IdUtil.getId());
		super.create(entity);

	}

	@Override
	public void update(SysWebReqDef entity) {
		super.update(entity);
	}

	public JSONArray getSelectData(String key) {
		if (StringUtil.isEmpty(key))
			return null;
		String json = "[]";
		if ("MODE".equalsIgnoreCase(key)) {
			json = SysWebReqDef.MODE_ARRAY;
		}
		if ("TYPE".equalsIgnoreCase(key)) {
			json = SysWebReqDef.TYPE_ARRAY;
		}
		if ("STATUS".equalsIgnoreCase(key)) {
			json = SysWebReqDef.STATUS_ARRAY;
		}
		return JSONArray.parseArray(json);
	}

	public SysWebReqDef getKey(String key) {
		return sysWebReqDefDao.getKey(key);
	}

	public boolean isExist(SysWebReqDef sysWebReqDef) {
		Integer rtn = sysWebReqDefDao.isExist(sysWebReqDef);
		return rtn > 0;
	}

	/**
	 * 
	 * @param key			web调用定义KEY
	 * @param paramsData	参数定义
	 * @param map			参数
	 * @return
	 */
	public JsonResult<String> executeStart(String key, String paramsData,Map map) {
		SysWebReqDef sysWebReqDef = getKey(key);
		if (BeanUtil.isEmpty(sysWebReqDef)) {
			return new JsonResult<String>(false, "未设置服务");
		}
		
		Map<String,String> paramsMap = new HashMap<String, String>();
		if(StringUtil.isNotEmpty(paramsData)) {
			JSONArray ary = JSONArray.parseArray(paramsData);
			Iterator<Object> it = ary.iterator();
			while (it.hasNext()) {
				JSONObject obj = (JSONObject) it.next();
				//获取配置结果
				Object value = getValue(map, obj);
				paramsMap.put(obj.getString("key"), (String)value);
			}
		}

		JsonResult<String> result = new JsonResult<String>();
		//请求URL
		String url = sysWebReqDef.getUrl();
		//请求头设置
		String header = sysWebReqDef.getParamsSet();
		//报文模板
		String template = sysWebReqDef.getTemp();
		//调用类型(soap,restful)
		String type = sysWebReqDef.getType();
		if ("SOAP".equals(sysWebReqDef.getMode())) {
			type="POST";
		}
		result = executeReq(url, type, parseParamsMap(header), paramsMap, template);
		
		return result;
	}
	
	/**
	 * [{key:"",value:""}]
	 * @param json
	 * @return
	 */
	public Map parseParamsMap(String json) {
		Map<String, String> map = new HashMap<String, String>();

		JSONArray ary = JSONArray.parseArray(json);
		for (int i = 0; i < ary.size(); i++) {
			JSONObject jsonObj = ary.getJSONObject(i);
			String key = jsonObj.getString("key");
			String value = jsonObj.getString("value");
			map.put(key, value);
		}
		return map;
	}

	/**
	 * 获取参数的值。
	 * 
	 * @param params
	 * @param valSource
	 * @param jsonObject
	 * @return
	 */
	private Object getValue(Map<String, Object> params, JSONObject jsonObject) {
		String valSource = (String) jsonObject.get("valueSource");
		String valueDef = (String) jsonObject.get("valueDef");
		Object val = null;
		//表单数据
		if ("formParam".equals(valSource) ) {
			Map<String, Object> map = (Map<String, Object>) params.get("formParam");
			if(BeanUtil.isNotEmpty(map)) {
				val = map.get(valueDef);
			}
		}
		//流程变量数据
		else if( "bpmParam".equals(valSource)){
			Map<String, Object> map = (Map<String, Object>) params.get("bpmParam");
			val = map.get(valueDef);
		}
		// 固定值
		else if ("fixedVar".equals(valSource)) { 
			val = valueDef;
		} 
		// 脚本
		else if ("script".equals(valSource)) { 
			val = (String) groovyEngine.executeScripts(valueDef, params);
		} 
		//常量
		else if ("constantVar".equals(valSource)) {
			val = contextHandlerFactory.getValByKey(valueDef, params);
		}
		//url参数
		else {
			val = jsonObject.get("value");
		}
		return val;
	}

	/**
	 * 执行http请求
	 * @param url			访问地址
	 * @param type			请求类型 POST,GET,DELETE
	 * @param headerMap		请求头
	 * @param params		请求参数定义
	 * @param template		报文模版
	 * @return
	 */
	public JsonResult<String> executeReq(String url, String type, Map headerMap, Map params, String template) {
		// 格式化URL
		url = StringUtil.format(url, params);
		// 格式化请求报文
		template = StringUtil.format(template, params);
		JsonResult<String> result = new JsonResult<String>();
		HttpRtnModel htm = new HttpClientUtil().new HttpRtnModel();
		try {
			switch (type.toUpperCase()) {
				case "GET":
					htm = HttpClientUtil.getFromUrlHreader(url, headerMap);
					result.setData(htm.getContent());
					break;
				case "POST":
					if(StringUtil.isEmpty(template)){
						htm = HttpClientUtil.postFromUrl(url, headerMap, params);
					}
					else{
						htm = HttpClientUtil.postFromUrl(url, headerMap, template);
					}
					result.setData(htm.getContent());
					break;
				case "DELETE":
					htm = HttpClientUtil.delFromUrl(url, headerMap);
					result.setData(htm.getContent());
					break;
				default:
					result = new JsonResult();
					break;
			}
			if (htm.getStatusCode() == 200) {
				result.setSuccess(true);
			}
			else{
				result.setMessage(htm.getStatusCode() +"");
				result.setData(htm.getContent());
			}
		} catch (Exception e) {
			result.setSuccess(false);
			result.setMessage("-1");
			result.setData(ExceptionUtil.getExceptionMessage(e));
		}
		return result;
	}

}
