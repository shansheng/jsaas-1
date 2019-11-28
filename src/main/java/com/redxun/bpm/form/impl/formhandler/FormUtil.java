package com.redxun.bpm.form.impl.formhandler;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.parser.Tag;
import org.jsoup.select.Elements;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.core.entity.BpmFormRight;
import com.redxun.bpm.core.entity.BpmInst;
import com.redxun.bpm.core.entity.BpmNodeJump;
import com.redxun.bpm.core.entity.BpmSolFv;
import com.redxun.bpm.core.entity.BpmSolution;
import com.redxun.bpm.core.entity.BpmTask;
import com.redxun.bpm.core.entity.IExecutionCmd;
import com.redxun.bpm.core.entity.config.ProcessConfig;
import com.redxun.bpm.core.manager.BoDataUtil;
import com.redxun.bpm.core.manager.BpmFormRightManager;
import com.redxun.bpm.core.manager.BpmInstDataManager;
import com.redxun.bpm.core.manager.BpmNodeJumpManager;
import com.redxun.bpm.core.manager.BpmSolFvManager;
import com.redxun.bpm.core.manager.IDataSettingHandler;
import com.redxun.bpm.core.manager.IFormDataHandler;
import com.redxun.bpm.form.api.IFormHandler;
import com.redxun.bpm.form.entity.BpmFormView;
import com.redxun.bpm.form.entity.FormModel;
import com.redxun.bpm.form.manager.BpmFormViewManager;
import com.redxun.bpm.view.consts.FormViewConsts;
import com.redxun.bpm.view.control.MiniControlParseConfig;
import com.redxun.bpm.view.control.MiniViewHanlder;
import com.redxun.bpm.view.util.FormViewUtil;
import com.redxun.core.context.HttpServletContext;
import com.redxun.core.engine.FreemakerUtil;
import com.redxun.core.engine.FreemarkEngine;
import com.redxun.core.entity.KeyValEnt;
import com.redxun.core.json.FastjsonUtil;
import com.redxun.core.script.GroovyEngine;
import com.redxun.core.util.AppBeanUtil;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.DateUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.org.api.context.ProfileUtil;
import com.redxun.org.api.model.IGroup;
import com.redxun.org.api.model.IUser;
import com.redxun.org.api.service.GroupService;
import com.redxun.org.api.service.UserService;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.sys.api.ContextHandlerFactory;
import com.redxun.sys.bo.entity.SysBoEnt;
import com.redxun.sys.bo.entity.SysBoRelation;
import com.redxun.sys.db.manager.SysSqlCustomQueryManager;

import freemarker.ext.beans.HashAdapter;
import freemarker.template.TemplateException;
import freemarker.template.TemplateHashModel;

public class FormUtil {
	static Pattern  regex = Pattern.compile("&lt;#if(.*?)&gt;", Pattern.CASE_INSENSITIVE | Pattern.UNICODE_CASE | Pattern.DOTALL);
	 
	/**
	 * 将BpmFormView 数据设置到FormModel
	 * @param model
	 * @param formView
	 */
	public static void setFormModelByFormView(FormModel model,BpmFormView formView,BpmInst bpmInst){
		model.setType(formView.getType());
		if(formView.getType().equals(BpmFormView.FORM_TYPE_ONLINE_DESIGN)){
			model.setType(BpmFormView.FORM_TYPE_ONLINE_DESIGN);
			model.setContent(formView.getTemplate());
		}else if(formView.getType().equals(BpmFormView.FORM_TYPE_SEL_DEV)){
			model.setType(BpmFormView.FORM_TYPE_SEL_DEV);
			HttpServletRequest request=HttpServletContext.getRequest();
			Map<String, Object> params = FormViewUtil.contructParams(request);
			if(BeanUtil.isNotEmpty(bpmInst)){
				params.put(IFormHandler.PK_VAR, bpmInst.getBusKey());
			}
			if(BeanUtil.isNotEmpty(model.getParams())){
				params.putAll(model.getParams());
			}
			String url=  formView.getRenderUrl();
			if(!url.startsWith("http")){
				url=params.get(FormViewConsts.PARAM_CTX_PATH)+ url;
			}
			
			try {
				url= StringUtil.replaceVariableMap(url, params);
			} catch (Exception e) {
				e.printStackTrace();
			}  
			model.setContent(url);
		}
	}
	
	/**
	 * 处理IFRAME。
	 * @param doc
	 * @param params
	 */
	private static void handIframe(Document doc,Map<String,Object> params){
		Elements iframes= doc.select(".mini-iframe");
		Iterator<Element> iframeIt=iframes.iterator();
		while(iframeIt.hasNext()){
			Element el=iframeIt.next();
			el.tagName("iframe");
			el.removeAttr("plugins");
			String src=el.attr("src");
			if(!src.startsWith("http")){
				src=(String)params.get(FormViewConsts.PARAM_CTX_PATH) + src;
				el.attr("src",src);
			}
		}
	}
	
	private static void handPermission(Document doc,JSONObject mainRightJson){
		Elements els=doc.select("[permission]");
		Iterator<Element> permissionIt=els.iterator();
		while(permissionIt.hasNext()){
			Element el=permissionIt.next();
			String key=el.attr("permission");
			JSONObject permission=mainRightJson.getJSONObject(key);
			if("none".equals(permission.getString("right"))){
				el.remove();
			}
		}
	}
	
	/**
	 * 子表删除。
	 * 
	 * tbpermission="子表名称"
	 * @param doc
	 * @param subRightJson
	 */
	private static void handTablePermission(Document doc,JSONObject subRightJson){
		Elements els=doc.select("[tbpermission]");
		Iterator<Element> permissionIt=els.iterator();
		while(permissionIt.hasNext()){
			Element el=permissionIt.next();
			String key=el.attr("tbpermission");
			if(!subRightJson.containsKey(key)) {
                continue;
            }
			JSONObject permission=subRightJson.getJSONObject(key);
			JSONObject tbRight= permission.getJSONObject("tbright");
			if( tbRight.getBoolean("hidden")){
				el.remove();
			}
		}
	}
	
	
	public static void parseHtml(BpmFormView bpmFormView,Map<String,Object> params,JSONObject dataJson,
			JSONObject rightJson,boolean readOnly) throws IOException, TemplateException{
		FreemarkEngine freemarkEngine=AppBeanUtil.getBean(FreemarkEngine.class);
		
		String html=freemarkEngine.parseByStringTemplate(params,bpmFormView.getTemplate());
		
		//String html=bpmFormView.getTemplate();
		Document doc = Jsoup.parse(html);
		//处理IFRAME
		handIframe(doc,params);
		
		//主表权限
		JSONObject mainRightJson=rightJson.getJSONObject("main");
		JSONObject buttonRightJson=rightJson.getJSONObject("buttons");
		JSONObject opinionRightJson=rightJson.getJSONObject("opinions");
		JSONObject subTableRightJson=rightJson.getJSONObject("sub");
		//处理权限。
		handPermission(doc, mainRightJson);
		//子表权限。
		handTablePermission( doc, subTableRightJson);
		
		Elements forms=doc.select("[relationtype]");
		if(forms.size()>0){
			Iterator<Element> formIt=forms.iterator();
			while(formIt.hasNext()){
				Element form=formIt.next();
				handForm( form,dataJson, params, mainRightJson,
						 buttonRightJson, opinionRightJson, subTableRightJson,readOnly,false);
			}
			
			Elements grids=doc.select(":not([relationtype])>.rx-grid");
			Iterator<Element> gridIt=grids.iterator();
			
			while(gridIt.hasNext()){
				Element grid=gridIt.next();
				handForm( grid.parent(),dataJson, params, mainRightJson,
						 buttonRightJson, opinionRightJson, subTableRightJson,readOnly,false);
			}
		}
		else{
			handForm(doc.body(),dataJson, params, mainRightJson,
					 buttonRightJson, opinionRightJson, subTableRightJson,readOnly,true);
		}
		String template=doc.head().html() + doc.body().html();
		//head中会带有script及style的内容，需要返回给前台进行解析，Js可以有效获得变量的内容值
		bpmFormView.setTemplate(template );
	}
	
	
	/**
	 * 这个方法用在一对一的子表中。
	 * @param tableName
	 * @param dataJson
	 * @return
	 */
	private static JSONObject getSubJson(String tableName,JSONObject dataJson){
		JSONObject json=new JSONObject();
		JSONObject tmp=dataJson.getJSONObject("SUB_" + tableName);
		if(BeanUtil.isEmpty(tmp)) {
            return json;
        }
		for(String key:tmp.keySet()){
			json.put(key, tmp.get(key));
		}
		for(String key:dataJson.keySet()){
			if(!key.startsWith("SUB_") || key.equals("SUB_" + tableName)) {
                continue;
            }
			json.put(key, dataJson.get(key));
		}
		return json;
	}

	private static void handForm(Element form,JSONObject dataJson,Map<String,Object> params,JSONObject mainRightJson,
				JSONObject buttonRightJson,JSONObject opinionRightJson,JSONObject subTableRightJson,boolean readOnly,boolean isOld){
		MiniControlParseConfig miniControlParseConfig =AppBeanUtil.getBean(MiniControlParseConfig.class);
		//查找有该样式的控件
		Elements ctls=form.select(".rxc:not(.rx-grid .rxc),[plugins=\"mini-nodeopinion\"],[plugins=\"rx-grid\"]");
		
		JSONObject formJson=dataJson;
		
		JSONObject rightJson=null;
		if(isOld){
			rightJson=mainRightJson;
			if(formJson.containsKey(SysBoEnt.SQL_PK)){
				form.append("<input class='mini-hidden' name='"+SysBoEnt.SQL_PK+"' value='"+formJson.getString(SysBoEnt.SQL_PK)+"'>");
			}
		}
		else{
			String relationtype=form.attr("relationtype");
			if(StringUtil.isNotEmpty(relationtype)){
				if(SysBoRelation.RELATION_MAIN.equals(relationtype)){
					rightJson=mainRightJson;
					if(formJson.containsKey(SysBoEnt.SQL_PK)){
						form.append("<input class='mini-hidden' name='"+SysBoEnt.SQL_PK+"' value='"+formJson.getString(SysBoEnt.SQL_PK)+"'>");
					}
				}
				else{
					String tablename=form.attr("tablename");
					JSONObject subJson= subTableRightJson.getJSONObject(tablename);
					JSONObject tbRight= subJson.getJSONObject("tbright");
					if( tbRight.getBoolean("hidden")){
						form.remove();
						return;
					}
					if(SysBoRelation.RELATION_ONETOONE.equals(relationtype)){
						formJson=getSubJson(tablename, dataJson);
						if(formJson.containsKey(SysBoEnt.SQL_PK)){
							form.append("<input class='mini-hidden' name='"+SysBoEnt.SQL_PK+"' value='"+formJson.getString(SysBoEnt.SQL_PK)+"'>");
						}
					}
					rightJson= subJson.getJSONObject("fields");
				}
			}
			
		}
		 
		Iterator<Element> it=ctls.iterator();
		
		while(it.hasNext()){
			Element el=it.next();
			//取得控件的名字
			String name=el.attr("name");
			String plugins=el.attr("plugins");
			
			if(StringUtils.isEmpty(plugins)) {
                continue;
            }
			if(!"mini-contextonly".equals(plugins) && StringUtils.isEmpty(name)) {
                continue;
			}
			
			String right="";

			if("mini-nodeopinion".equals(plugins)){
				name=name.replace(IExecutionCmd.FORM_OPINION, "") ;
				if(opinionRightJson==null){
					el.remove();
					continue;
				}
				if(opinionRightJson.containsKey(name)){
					JSONObject json=opinionRightJson.getJSONObject(name);
					right=json.getString("right");
					if("none".equals(right)){
						el.remove();
						continue;
					}
				}
			}
			else if("mini-button".equals(plugins)){
				if(buttonRightJson!=null && buttonRightJson.containsKey(name)){
					JSONObject json=buttonRightJson.getJSONObject(name);
					if(!json.getBoolean("show")){
						el.remove();
						continue;
					}
				}
			}
			else if("rx-grid".equals(plugins)){
				if(subTableRightJson.containsKey(name)){
					JSONObject subJson= subTableRightJson.getJSONObject(name);
					JSONObject tbRight= subJson.getJSONObject("tbright");
					if(tbRight.getBoolean("hidden")){
						el.remove();
						continue;
					}
				}
			}
			else{
				//子表没有对应的权限则跳过。
				if(rightJson==null) {
                    continue;
                }
				
				JSONObject permission=rightJson.getJSONObject(name);
				
				 
				if(permission!=null){
					if("none".equals(permission.getString("right"))){
						el.remove();
						continue;
					}
					
					right=permission.getString("right");
					Boolean required=permission.getBoolean("require");
					if(required!=null && required){
						el.attr("required", "true");
					}
				}
			}
			
			if(readOnly && "w".equals(right)){
				right="r";
			}
			
			//通过视图来执行
			MiniViewHanlder handler=miniControlParseConfig.getElementViewHandler(plugins);
			params.put("right", right);
			handler.parse(el, params, formJson);
			//转为只读，有些是在服务端转，有些是需要在客户端转化
			if("r".equals(right)){
				el.attr(BpmFormRight. READONLY,"true");
				el.addClass("asLabel");
				
				handler.convertToReadOnly(el, params, formJson);
			}
			
		}
	}
	
	/**
	 * 设置必填。
	 * @param json
	 * @param require
	 * @return 
	 */
	public static String setRequired(Object tbRight,String json){
		HashAdapter right=(HashAdapter)tbRight;
		if(right==null) {
            return json;
        }
		JSONObject jsonObj= JSONObject.parseObject(json);
		jsonObj.put("delExist", right.get("delExist") );
		jsonObj.put("editExist",right.get("editExist") );
		boolean require=false;
		if( right.containsKey("require")){
			require=(Boolean) right.get("require");
		}
		if(require){
			jsonObj.put("required", true);
		}
		String str= jsonObj.toString();
		str=str.replace("\"","'");
		return str;
		
	}
	
	public static String setFieldRequired(String vtype,boolean require){
		if(!require){
            return vtype;
        }
		if(StringUtil.isEmpty(vtype)){
			return "required";
		}
		else {
			vtype=vtype.trim();
			if(vtype.indexOf("required")!=-1) {
                return vtype;
            }
			if(vtype.endsWith(";")){
				vtype+="required";
			}
			else{
				vtype+=";required";
			}
		}
		return vtype;
	}
	
	public static void handTab(BpmFormView bpmFormView,Map<String, Object> params,Map<String,Set<String>> profileMap,boolean isPrint) throws IOException, TemplateException{
		String templateHtml=bpmFormView.getTemplate();
		FreemarkEngine freemarkEngine=AppBeanUtil.getBean(FreemarkEngine.class);
		
		TemplateHashModel util=FreemakerUtil.getTemplateModel(FormUtil.class);
		params.put("util", util);

		
		templateHtml=freemarkEngine.parseByStringTemplate(params, templateHtml);
		bpmFormView.setTemplate(templateHtml);
		if(templateHtml.indexOf(BpmFormView. PAGE_TAG)==-1){
            return;
        }

	
		
		String html= getTabHtml(bpmFormView.getTitle(),bpmFormView.getTemplate(),isPrint,bpmFormView);
		
		bpmFormView.setTemplate(html);
	}
	
	
	/**
	 * {formView}和{bpmFormViewHtml,bpmFormViewTitle}两者需填一个,两者都填则取formView优先
	 * 生成tab
	 * exceptTab是排除哪个tab,传入tab的title,以,分隔,为null则不排除
	 * @param formView
	 * @param bpmFormViewHtml
	 * @param bpmFormViewTitle
	 * @param exceptTab
	 * @return
	 * @throws IOException
	 * @throws TemplateException
	 */
	private static String getTabHtml(String title,String html,boolean isPrint,BpmFormView bpmFormView) throws IOException, TemplateException{
		String[] templateAry=html.split(BpmFormView. PAGE_TAG);
		String[] tabsAry=title.split(BpmFormView. PAGE_TAG);
		String displayType=bpmFormView.getDisplayType();
		List<KeyValEnt> list=new ArrayList<KeyValEnt>();
		
		for (int i = 0; i < tabsAry.length; i++) {
			String tabTitle=tabsAry[i];
			if(i<templateAry.length){
				KeyValEnt obj=new KeyValEnt(tabTitle,templateAry[i]);
				list.add(obj);
			}
		}
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("list", list);
		model.put("displayType", displayType==null?"first":displayType);
		model.put("bpmFormView", bpmFormView);
		FreemarkEngine freemarkEngine=AppBeanUtil.getBean(FreemarkEngine.class);
		String template=isPrint?"form/render/formTabPrint.ftl":"form/render/formTabslet.ftl";
		String rtnHtml = freemarkEngine.mergeTemplateIntoString(template, model);
		return rtnHtml;
	}
	
	
	

	/**
	 * 获取起始节点的权限。
	 * @param formAlias
	 * @param actDefId
	 * @param solId
	 * @return
	 */
	public static JSONObject getByStart(String formAlias, String actDefId,String solId){
		BpmFormRightManager formRightManager=AppBeanUtil.getBean(BpmFormRightManager.class);
		
		String nodeId=BpmFormView.SCOPE_START;
		JSONObject json =  formRightManager.getBySolFormNode( solId, actDefId, nodeId, formAlias);
		if(BeanUtil.isEmpty(json)){
			json = formRightManager.getBySolFormNode(formAlias,BpmFormView.SCOPE_PROCESS,actDefId,solId);
		}
		if(BeanUtil.isEmpty(json)){
			json =formRightManager.getInitByAlias( formAlias);
		}
		return json;
	}
	
	public static JSONObject getByBoStart(String boDefId, String actDefId,String solId){
		BpmFormRightManager formRightManager=AppBeanUtil.getBean(BpmFormRightManager.class);
		
		String nodeId=BpmFormView.SCOPE_START;
		BpmFormRight bpmFormRight =  formRightManager.getBySolFormNodeBoDef( solId, actDefId, nodeId, boDefId);
		
		if(BeanUtil.isEmpty(bpmFormRight)){
			bpmFormRight = formRightManager.getBySolFormNodeBoDef( solId, actDefId, BpmFormView.SCOPE_PROCESS, boDefId);
		}
		JSONObject json=null;
		if(BeanUtil.isEmpty(bpmFormRight)){
			json =formRightManager.getInitByBoDefId( boDefId);
		}
		else{
			json=JSONObject.parseObject(bpmFormRight.getJson());
		}
		return json;
	}
	
	/**
	 * 根据明细获取表单权限。
	 * @param viewId
	 * @param actDefId
	 * @param solId
	 * @return
	 */
	public static JSONObject getByDetail(String formAlias, String actDefId,String solId){
		BpmFormRightManager bpmFormRightManager=AppBeanUtil.getBean(BpmFormRightManager.class);
		String nodeId=BpmFormView.SCOPE_DETAIL;
		JSONObject rights = bpmFormRightManager.getBySolFormNode(solId, actDefId, nodeId, formAlias) ;
		if(BeanUtil.isEmpty(rights)){
			rights = bpmFormRightManager.getBySolFormNode(solId, actDefId, BpmFormView.SCOPE_PROCESS, formAlias);
		}
		if(rights==null){
			rights =  bpmFormRightManager.getInitByAlias( formAlias);
		}
		return rights;
	}
	
	
	public static JSONObject getByBoDetail(String formKey, String actDefId,String solId ,String boDefId ){
		BpmFormRightManager bpmFormRightManager=AppBeanUtil.getBean(BpmFormRightManager.class);
		String nodeId=BpmFormView.SCOPE_DETAIL;
		BpmFormRight right = bpmFormRightManager.getBySolFormNodeBoDef(solId, actDefId, nodeId, formKey) ;
		JSONObject json=null;
		if(BeanUtil.isEmpty(right)){
			right = bpmFormRightManager.getBySolFormNodeBoDef(solId, actDefId, BpmFormView.SCOPE_PROCESS, formKey);
		}
		
		if(right==null){
			json =  bpmFormRightManager.getInitByBoDefId( boDefId);
		}
		else{
			json = JSONObject.parseObject(right.getJson()) ;
		}
		return json;
	}
	
	/**
	 * 获取审批节点的权限。
	 * @param viewId
	 * @param nodeId
	 * @param actDefId
	 * @param solId
	 * @return
	 */
	public static JSONObject getByNodeId(String formAlias,String nodeId, String actDefId,String solId){
		BpmFormRightManager bpmFormRightManager=AppBeanUtil.getBean(BpmFormRightManager.class);
		JSONObject rights = bpmFormRightManager.getBySolFormNode(solId, actDefId, nodeId, formAlias) ;
		
		if(BeanUtil.isEmpty(rights)){
			rights = bpmFormRightManager.getBySolFormNode(solId, actDefId, BpmFormView.SCOPE_PROCESS, formAlias) ;
		}
		if(rights==null){
			rights =  bpmFormRightManager.getInitByAlias( formAlias);
		}
		return rights;
	}
	
	public static JSONObject getByBoNodeId(String boDefId,String nodeId, String actDefId,String solId){
		BpmFormRightManager bpmFormRightManager=AppBeanUtil.getBean(BpmFormRightManager.class);
		BpmFormRight bpmFormRight = bpmFormRightManager.getBySolFormNodeBoDef(solId, actDefId, nodeId, boDefId) ;
		JSONObject json=null;
		if(BeanUtil.isEmpty(bpmFormRight)){
			bpmFormRight = bpmFormRightManager.getBySolFormNodeBoDef(solId, actDefId, BpmFormView.SCOPE_PROCESS, boDefId) ;
		}
		if(bpmFormRight==null){
			json =  bpmFormRightManager.getInitByBoDefId( boDefId);
		}
		else{
			json=JSONObject.parseObject(bpmFormRight.getJson());
		}
		return json;
	}
	
	/**
	 * 根据表单获取权限。
	 * @param viewId
	 * @return
	 */
	public static JSONObject getRightByForm(String formKey){
		BpmFormRightManager bpmFormRightManager=AppBeanUtil.getBean(BpmFormRightManager.class);
		String nodeId=BpmFormRight.NODE_FORM;
		JSONObject rights =  bpmFormRightManager.getBySolFormNode("", "", nodeId, formKey);
		if(rights==null){
			rights =  bpmFormRightManager.getInitByAlias( formKey);
		}
		return rights;
	}
	
	/**
	 * 根据表单方案获取权限。
	 * @param solId
	 * @param formKey
	 * @return
	 */
	public static JSONObject getRightByForm(String solId, String formKey){
		BpmFormRightManager bpmFormRightManager=AppBeanUtil.getBean(BpmFormRightManager.class);
		String nodeId=BpmFormRight.NODE_FORM_SOL;
		JSONObject rights =  bpmFormRightManager.getBySolFormNode(solId, "", nodeId, formKey);
		if(rights==null){
			rights =  bpmFormRightManager.getInitByAlias( formKey);
		}
		return rights;
	}
	
	/**
	 * 构建上下文参数。
	 * 
	 * @param solId
	 * @param actDefId
	 * @param jsonData
	 * @return
	 */
	public static Map<String, Object> getParams(BpmInst bpmInst,JSONObject jsonData){
		HttpServletRequest request=HttpServletContext.getRequest();
		Map<String, Object> params = FormViewUtil.contructParams(request);
		
		String solId=bpmInst.getSolId();
		String actInstId=bpmInst.getActInstId();
		

		params.put(FormViewConsts.PARAM_SOL_ID, solId);
		params.put(FormViewConsts.PARAM_BILLNO, bpmInst.getBillNo());
		params.put(FormViewConsts.PARAM_START_USER_ID, bpmInst.getCreateBy());
		if(StringUtil.isNotEmpty(bpmInst.getActInstId())){
			params.put(FormViewConsts.PARAM_ACT_INST_ID, actInstId);
		}
		if(StringUtil.isNotEmpty(bpmInst.getInstId())){
			params.put(FormViewConsts.PARAM_INST_ID, bpmInst.getInstId());
		}
		
		params.put("json", jsonData);
		
		
		return params;
	}
	
	
	
	/**
	 * 发起时获取表单数据。
	 * @param solution
	 * @param formView
	 * @return
	 */
	public static JSONObject getData( BpmSolution solution,BpmFormView formView){
		Map<String,Object> vars=new HashMap<String, Object>();
		String boDefId=formView.getBoDefId();
		IFormDataHandler handler=BoDataUtil.getDataHandler(solution.getDataSaveMode());
		//获得初始化数据
		JSONObject jsonObj= handler.getInitData(boDefId);
		
		String dataConfs=formView.getBpmSolFv().getDataConfs();
		
		if(StringUtils.isEmpty(dataConfs)){
			return jsonObj;
		}
		
		IDataSettingHandler settingHanler=AppBeanUtil.getBean(IDataSettingHandler.class);
		if(settingHanler!=null){
			if(StringUtil.isNotEmpty(dataConfs)){
				JSONObject settingJson=JSONObject.parseObject(dataConfs);
				settingHanler.handSetting(jsonObj, boDefId, settingJson, false,vars);
			}
		}
		return jsonObj;
	}
	
	/**
	 * 在审批过程中获取表单数据。
	 * <pre>
	 * 	1.获取数据。
	 *  2.根据设定对数据进行修改。
	 * </pre>
	 * @param bpmInst
	 * @param bpmFormView
	 * @return
	 */
	public static JSONObject getData(BpmInst bpmInst,BpmFormView bpmFormView,Map<String,Object> vars){
		JSONObject jsonObj=getData(bpmInst,bpmFormView.getBoDefId());
		
		//初始化表单。
		IDataSettingHandler settingHanler=AppBeanUtil.getBean(IDataSettingHandler.class);
		if(settingHanler==null || BeanUtil.isEmpty(bpmFormView.getBpmSolFv())) {
            return jsonObj;
        }

		BpmSolFv bpmSolFv=bpmFormView.getBpmSolFv();
		String initSetting=bpmSolFv.getDataConfs();
		if(StringUtil.isEmpty(initSetting)) {
			BpmSolFvManager bpmSolFvManager=AppBeanUtil.getBean(BpmSolFvManager.class);
			bpmSolFv=bpmSolFvManager.getBySolIdActDefIdNodeId(bpmSolFv.getSolId(), bpmSolFv.getActDefId(), ProcessConfig.PROCESS_NODE_ID);//查找全局
			initSetting=bpmSolFv.getDataConfs();
			if(StringUtil.isEmpty(initSetting)){
				return jsonObj;
			}
		}
		//处理数据
		JSONObject settingJson=JSONObject.parseObject(initSetting);
		settingHanler.handSetting(jsonObj, bpmFormView.getBoDefId(), settingJson, false,vars);
		
		return jsonObj;
	}
	
	
	
	/**
	 * 根据流程实例获取流程数据。
	 * @param bpmInst
	 * @return
	 */
	public static JSONObject getData(BpmInst bpmInst,String boDefId){
		return getData(bpmInst.getDataSaveMode(), boDefId, bpmInst.getInstId());
	}
	
	/**
	 * 根据数据保存模式，BO定义ID,流程实例ID。
	 * @param saveMode
	 * @param boDefId
	 * @param instId
	 * @return
	 */
	public static JSONObject getData(String saveMode, String boDefId,String instId){
		String pk="";
		IFormDataHandler handler=BoDataUtil.getDataHandler(saveMode);
		
		if(StringUtil.isNotEmpty(instId)){
			BpmInstDataManager bpmInstDataManager=AppBeanUtil.getBean(BpmInstDataManager.class);
			pk=bpmInstDataManager.getPk(instId, boDefId);
			if(StringUtil.isEmpty(pk)) {
				JSONObject jsonData= handler.getInitData(boDefId);
				return jsonData;
			};
		}
		
		JSONObject jsonObj= handler.getData(boDefId, pk);
		return jsonObj;
	}
	
	/**
	 * 获取表单数据。
	 * @param bodefId
	 * @param id
	 * @return
	 */
	public static JSONObject getData(String bodefId,String id){
		IFormDataHandler handler=BoDataUtil.getDataHandler(ProcessConfig.DATA_SAVE_MODE_DB);
		JSONObject jsonObj=null;
		if(StringUtil.isNotEmpty(id)){
			jsonObj= handler.getData(bodefId,id);
		}
		else{
			jsonObj= handler.getInitData(bodefId);
		}
		return jsonObj;
		
	}
	
	private static Object getValue(HttpServletRequest req,JSONObject jsonObject){
		GroovyEngine groovyEngine=AppBeanUtil.getBean(GroovyEngine.class);
		ContextHandlerFactory contextHandlerFactory=AppBeanUtil.getBean(ContextHandlerFactory.class);
		String fieldName=(String)jsonObject.get("name");
		String valSource=(String)jsonObject.get("valueSource");
		String valueDef=(String)jsonObject.get("valueDef");
		String dateType=(String)jsonObject.get("dateType");
		Map<String,Object> vars=new HashMap<String, Object>();
		Object val=null;
		if("param".equals(valSource)){      //传入参数
			val=req.getParameter(fieldName);
		}else if("fixedVar".equals(valSource)){   //固定值
			val=valueDef;
		}else if("script".equals(valSource)){    //脚本
			val=(String)groovyEngine.executeScripts(valueDef,vars);
		}else if("constantVar".equals(valSource)){
			val=contextHandlerFactory.getValByKey(valueDef,vars);
		}
		if(val==null) {
            return null;
        }
		if("number".equals(dateType)){
			val=Long.parseLong(val.toString());
		}
		
		return val;
	}
	
	public static JSONObject getDataByParam(String bodefId,String paramDef){
		IFormDataHandler handler=BoDataUtil.getDataHandler(ProcessConfig.DATA_SAVE_MODE_DB);
		JSONArray ary=JSONArray.parseArray(paramDef);
		Map<String,Object> params=new HashMap<>();
		for(int i=0;i<ary.size();i++){
			JSONObject json=ary.getJSONObject(i);
			HttpServletRequest req=HttpServletContext.getRequest();
			Object val= getValue( req, json);
			if(val==null) {
                continue;
            }
			params.put(json.getString("name"), val);
		}
		JSONObject rtn= handler.getData(bodefId, params);
		if(BeanUtil.isEmpty(rtn)){
			rtn=handler.getInitData(bodefId);
		}
		return rtn;
	}
	
	/**
	 * 获取发起表单的html。
	 * @param bpmSolution
	 * @param bpmFormView
	 * @param jsonData
	 * @return
	 * @throws Exception
	 */
	public static FormModel getByStart(BpmSolution bpmSolution,BpmFormView bpmFormView, JSONObject jsonData,boolean readOnly,boolean isPrint) throws Exception {
		String solId=bpmSolution.getSolId();
		String actDefId=bpmSolution.getActDefId();
		FormModel model=new FormModel();
		model.setType(BpmFormView.FORM_TYPE_ONLINE_DESIGN);
		//1. 取得当前人的身份信息。
		Map<String, Set<String>> profileMap=ProfileUtil.getCurrentProfile();
		//TODO
		BpmInst bpmInst=new BpmInst();
		bpmInst.setActDefId(actDefId);
		bpmInst.setSolId(solId);
		//3.获取上下文参数
		Map<String, Object> params =FormUtil.getParams(bpmInst,jsonData);
		//4.获取表单的权限。
		JSONObject rightSetting=FormUtil.getByStart(bpmFormView.getKey(), actDefId, solId);
		
		BpmFormRightManager bpmFormRightManager =AppBeanUtil.getBean(BpmFormRightManager.class); 
		
		JSONObject rightsJson= bpmFormRightManager.calcRights(rightSetting, profileMap, readOnly,params);
		
		params.put(BpmFormRight.PERMISSION, rightsJson);
		
		setParams(jsonData,params);
		//处理tab权限。
		FormUtil.handTab(bpmFormView, params,profileMap,isPrint);
		//5.解析html。
		FormUtil.parseHtml(bpmFormView, params, jsonData, rightsJson, readOnly);
		
		model.setContent(bpmFormView.getTemplate());
		
		model.setDescription(bpmFormView.getDescp());
		
		model.setViewId(bpmFormView.getViewId());
		
		model.setJsonData(jsonData);
		
		return model;
	}


	public static FormModel getByTask(BpmInst bpmInst,BpmTask bpmTask, BpmFormView bpmFormView,JSONObject jsonData,boolean readOnly,boolean isPrint) throws Exception{
		String solId=bpmInst.getSolId();
		String actDefId=bpmInst.getActDefId();
		FormModel model=new FormModel();
		model.setType(BpmFormView.FORM_TYPE_ONLINE_DESIGN);
		
		BpmFormRightManager bpmFormRightManager=AppBeanUtil.getBean(BpmFormRightManager.class); 
		
		//1. 取得当前人的身份信息。
		Map<String, Set<String>> profileMap=ProfileUtil.getCurrentProfile();
		
		//3.获取上下文参数
		Map<String, Object> params =FormUtil.getParams(bpmInst,jsonData);
		params.put("taskId",bpmTask.getId());
		params.put("nodeId",bpmTask.getTaskDefKey());
		//4.获取表单的权限。
		JSONObject rightSetting=FormUtil.getByNodeId(bpmFormView.getKey(),
				bpmTask.getTaskDefKey(), actDefId, solId);
		
		JSONObject rightJson=bpmFormRightManager.calcRights(rightSetting, profileMap, readOnly,params);
		
		params.put(BpmFormRight.PERMISSION, rightJson);
		
		setParams(jsonData,params);
		
		FormUtil.handTab( bpmFormView, params,profileMap,isPrint);
		//5.解析html。
		FormUtil.parseHtml(bpmFormView, params, jsonData, rightJson,readOnly);
		
		model.setContent(bpmFormView.getTemplate());
		
		model.setDescription(bpmFormView.getName());
		
		model.setViewId(bpmFormView.getViewId());
		
		model.setJsonData(jsonData);
		
		return model;
	}
	
	/**
	 * 往参数中加常量。
	 * @param jsonData
	 * @param params
	 */
	private static void setParams(JSONObject jsonData,Map<String, Object> params ){
		UserService userService=AppBeanUtil.getBean(UserService.class);
		GroupService groupService=AppBeanUtil.getBean(GroupService.class);
		
		Date date=jsonData.getDate(SysBoEnt.FIELD_CREATE_TIME);
		Date updDate=jsonData.getDate(SysBoEnt.FIELD_UPDATE_TIME);
		if(date!=null){
			params.put(SysBoEnt.FIELD_CREATE_TIME, DateUtil.formatDate(date) );
			params.put(SysBoEnt.FIELD_CREATE_DATE, DateUtil.formatDate(date, "yyyy-MM-dd"));
		}
		
		if(updDate!=null){
			params.put(SysBoEnt.FIELD_UPDATE_TIME, DateUtil.formatDate(updDate) );
			params.put(SysBoEnt.FIELD_UPDATE_DATE, DateUtil.formatDate(updDate, "yyyy-MM-dd"));
		}
		String userId=jsonData.getString(SysBoEnt.FIELD_CREATE_BY);
		if(StringUtil.isNotEmpty(userId)){
			IUser user=userService.getByUserId(userId);
			params.put(SysBoEnt.FIELD_CREATE_BY, userId);
			params.put(SysBoEnt.FIELD_CREATE_USER, user.getFullname());
		}
		
		String groupId=jsonData.getString(SysBoEnt.SQL_PK);
		if(StringUtil.isNotEmpty(groupId)){
			IGroup group=groupService.getById(groupId);
			if(group!=null){
				params.put(SysBoEnt.FIELD_GROUP, groupId);
				params.put(SysBoEnt.FIELD_GROUP_NAME, group.getIdentityName());
			}
			
		}
		
		params.put(SysBoEnt.FIELD_INST_STATUS_, jsonData.getString(SysBoEnt.FIELD_INST_STATUS_));
		
		params.put(SysBoEnt.FIELD_GROUP, jsonData.getString(SysBoEnt.FIELD_GROUP));
		params.put(SysBoEnt.SQL_FK, jsonData.getString(SysBoEnt.SQL_FK));
		params.put(SysBoEnt.SQL_PK, jsonData.getString(SysBoEnt.SQL_PK));
	}
	
	public static FormModel getByFormView( BpmFormView bpmFormView,JSONObject jsonData,boolean readOnly,boolean isPrint) throws Exception{
		HttpServletRequest request=HttpServletContext.getRequest();
		Map<String, Object> params = FormViewUtil.contructParams(request);
		
		params.put(FormViewConsts.PARAM_CTX_PATH,request.getContextPath() );
		params.put("json", jsonData);
		
		//1. 取得当前人的身份信息。
		Map<String, Set<String>> profileMap=ProfileUtil.getCurrentProfile();
		
		//4.获取表单的权限。
		JSONObject rightSetting =FormUtil.getRightByForm(bpmFormView.getKey());
		
		BpmFormRightManager bpmFormRightManager =AppBeanUtil.getBean(BpmFormRightManager.class); 
		
		JSONObject rightsJson= bpmFormRightManager.calcRights(rightSetting, profileMap, readOnly,params);
		
		params.put(BpmFormRight.PERMISSION, rightsJson);
	
		params.put(BpmFormRight.READONLY, readOnly);
		
		setParams(jsonData,params);
		
		FormUtil.handTab( bpmFormView, params,profileMap,isPrint);
		
		//5.解析html。
		FormUtil.parseHtml(bpmFormView, params, jsonData, rightsJson,  readOnly);
		
		FormModel model=new FormModel();
		model.setContent(bpmFormView.getTemplate());
		model.setViewId(bpmFormView.getViewId());
		model.setJsonData(jsonData);
		return model;
	}
	
	/**
	 * 根据表单方案获取表单。
	 * @param formSolId
	 * @param bpmFormView
	 * @param jsonData
	 * @param readOnly
	 * @param isPrint
	 * @return
	 * @throws Exception
	 */
	public static FormModel getByFormView(String formSolId, BpmFormView bpmFormView,JSONObject jsonData,boolean readOnly,boolean isPrint) throws Exception{
		HttpServletRequest request=HttpServletContext.getRequest();
		Map<String, Object> params = FormViewUtil.contructParams(request);
		
		params.put(FormViewConsts.PARAM_CTX_PATH,request.getContextPath() );
		params.put("json",jsonData );
		
		//1. 取得当前人的身份信息。
		Map<String, Set<String>> profileMap=ProfileUtil.getCurrentProfile();
		
		//4.获取表单的权限。
		JSONObject rightSetting =FormUtil.getRightByForm(formSolId,bpmFormView.getKey());
		
		BpmFormRightManager bpmFormRightManager =AppBeanUtil.getBean(BpmFormRightManager.class); 
		
		JSONObject rightsJson= bpmFormRightManager.calcRights(rightSetting, profileMap, readOnly,params);
		
		params.put(BpmFormRight.PERMISSION, rightsJson);
	
		params.put(BpmFormRight.READONLY, readOnly);
		
		setParams(jsonData,params);
		
		FormUtil.handTab( bpmFormView, params,profileMap,isPrint);
		
		//5.解析html。
		FormUtil.parseHtml(bpmFormView, params, jsonData, rightsJson,  readOnly);
		
		FormModel model=new FormModel();
		model.setContent(bpmFormView.getTemplate());
		model.setViewId(bpmFormView.getViewId());
		model.setBoDefId(bpmFormView.getBoDefId());
		model.setJsonData(jsonData);
		return model;
	}
	
	
	
	public static FormModel getByInst(BpmFormView bpmFormView,BpmInst bpmInst, JSONObject jsonData,boolean readOnly,boolean isPrint) throws Exception{
		
		FormModel model=new FormModel();
		model.setType(BpmFormView.FORM_TYPE_ONLINE_DESIGN);
		//1. 取得当前人的身份信息。
		Map<String, Set<String>> profileMap=ProfileUtil.getCurrentProfile();
		
		Map<String, Object> params =FormUtil.getParams(bpmInst,jsonData);
		
		JSONObject rightSetting=FormUtil.getByDetail(bpmFormView.getKey(), bpmInst.getActDefId(), bpmInst.getSolId());
		
		BpmFormRightManager bpmFormRightManager =AppBeanUtil.getBean(BpmFormRightManager.class); 
		
		JSONObject rightsJson= bpmFormRightManager.calcRights(rightSetting, profileMap, readOnly,params);
		
		params.put(BpmFormRight.PERMISSION, rightsJson);
		
		params.put(BpmFormRight.READONLY, readOnly);
		
		setParams(jsonData,params);
		
		FormUtil.handTab( bpmFormView, params,profileMap,isPrint);
		
		//5.解析html。
		FormUtil.parseHtml(bpmFormView, params, jsonData, rightsJson,  readOnly);
		
		
		
		model.setContent(bpmFormView.getTemplate());
		
		model.setDescription(bpmFormView.getName());
		
		model.setViewId(bpmFormView.getViewId());
		
		model.setJsonData(jsonData);
		
		return model;
	}
	
	/**
	 * 获取表单意见。
	 * {
	 * 	意见1:[{
	 * 		userId:"",
	 * 		userName:"",
	 * 		opinion:"",
	 * 		type:"",
	 * 		createTime:""
	 * 	}]
	 * }
	 * @param bpmInst
	 * @return
	 * @throws Exception
	 */
	public static JSONObject getOpinionByInst(BpmInst bpmInst) {
		BpmNodeJumpManager jumpManager=AppBeanUtil.getBean(BpmNodeJumpManager.class);
		UserService userService=AppBeanUtil.getBean(UserService.class);
		List<BpmNodeJump> jumps= jumpManager.getFormOpinionByActInstId(bpmInst.getActInstId());
		if(BeanUtil.isEmpty(jumps)){
            return null;
        }
		JSONObject jsonObj=new JSONObject();
		for(BpmNodeJump jump:jumps){
			String opinionName=jump.getOpinionName();
			if(StringUtil.isEmpty(opinionName)) {
                continue;
            }
			JSONObject obj=new JSONObject();
			obj.put("userId", jump.getHandlerId());
			IUser user=userService.getByUserId(jump.getHandlerId());
			obj.put("userName", user.getFullname());
			obj.put("opinion", jump.getRemark());
			obj.put("type", jump.getJumpType());
			obj.put("createTime", DateUtil.formatDate(jump.getCreateTime()));
			
			if(jsonObj.containsKey(jump.getOpinionName())){
				JSONArray ary=jsonObj.getJSONArray(opinionName);
				ary.add(obj);
			}
			else{
				JSONArray ary=new JSONArray();
				ary.add(obj);
				jsonObj.put(opinionName, ary);
			}
		}
		return jsonObj;
	}
	
	/**
	 * 设置意见表单数据。
	 * @param bpmInst
	 * @param jsonObject
	 */
	public static void setOpinionData(BpmInst bpmInst ,JSONObject jsonObject){
		JSONObject jsonObj=getOpinionByInst(  bpmInst);
		if(BeanUtil.isEmpty(jsonObj)){
            return ;
        }
		
		jsonObject.put("form_opinion_", jsonObj);
		
	}
	

	
	/**
	 * 根据设定别名获取表单。
	 * @param alias		别名
	 * @param pk		主键
	 * @param readOnly	只读
	 * @param isPrint	是否打印
	 * @return
	 * @throws Exception
	 */
	public static FormModel getFormByFormAlias(String alias, String pk,boolean readOnly,boolean isPrint,Map<String,Object> params) throws Exception {
		BpmFormViewManager bpmFormViewManager=AppBeanUtil.getBean(BpmFormViewManager.class);
		String tenantId=ContextUtil.getCurrentTenantId();
		BpmFormView bpmFormView = bpmFormViewManager.getLatestByKey(alias,tenantId);
		JSONObject jsonData= FormUtil.getData(bpmFormView.getBoDefId(),pk);
		
		//将外部数据放到表单中。
		setContextData(jsonData,params);
		
		
		FormModel model=FormUtil.getByFormView(bpmFormView, jsonData, readOnly, isPrint);
		model.setJsonData(jsonData);
		return model;
	}
	
	public static FormModel getFormByFormAlias(String formSolId,String alias, String pk,boolean readOnly,boolean isPrint,Map<String,Object> params) throws Exception {
		BpmFormViewManager bpmFormViewManager=AppBeanUtil.getBean(BpmFormViewManager.class);
		String tenantId=ContextUtil.getCurrentTenantId();
		BpmFormView bpmFormView = bpmFormViewManager.getLatestByKey(alias,tenantId);
		JSONObject jsonData= FormUtil.getData(bpmFormView.getBoDefId(),pk);
		
		//将外部数据放到表单中。
		setContextData(jsonData,params);
		
		
		FormModel model=FormUtil.getByFormView(formSolId,bpmFormView, jsonData, readOnly, isPrint);
		model.setJsonData(jsonData);
		return model;
	}
	
	public static FormModel getFormByFormAliasParam(String formSolId,String alias, String paramDef,boolean readOnly,boolean isPrint,Map<String,Object> params) throws Exception {
		BpmFormViewManager bpmFormViewManager=AppBeanUtil.getBean(BpmFormViewManager.class);
		String tenantId=ContextUtil.getCurrentTenantId();
		BpmFormView bpmFormView = bpmFormViewManager.getLatestByKey(alias,tenantId);
		JSONObject jsonData= FormUtil.getDataByParam(bpmFormView.getBoDefId(), paramDef);
		
		//将外部数据放到表单中。
		setContextData(jsonData,params);
		
		
		FormModel model=FormUtil.getByFormView(formSolId,bpmFormView, jsonData, readOnly, isPrint);
		model.setJsonData(jsonData);
		return model;
	}
	
	
	/**
	 * 设置上下文数据。
	 * @param jsonData
	 * @param params
	 */
	public static void setContextData(JSONObject jsonData,Map<String,Object> params){
		if(BeanUtil.isEmpty(params)){
            return;
        }
		for (Map.Entry<String,Object> ent : params.entrySet()) {
			jsonData.put(ent.getKey(), ent.getValue());
		}
	}
	
	
	/**
	 * 转化为关联的Field并只读
	 * @param el
	 * @param params
	 * @param jsonObj
	 */
	public static void convertFieldToReadOnly(Element el, Map<String, Object> params,JSONObject jsonObj,String htmlText){
		
		String dataOptions=el.attr("data-options");
		
		if(StringUtils.isEmpty(dataOptions)){
			el.replaceWith(new Element(Tag.valueOf("span"), "").html(htmlText));
			return;
		}
		JSONObject dataOpJSON=JSONObject.parseObject(dataOptions);
		JSONObject linkFieldConfig=dataOpJSON.getJSONObject("linkFieldConfig");
		/**
		 * linkFieldConfig的格式如下：
		 * {
				"cur_label": "勘察单单号",
				"cur_control": "surveyFormId",
				"paramFields": "",
				"linkType": "newWindow",
				"iconCls": " icon-book-18",
				"cusQuery": "surveyOrderQuery",
				"pagesize": 10,
				"replaceRule": "{F_FILETITLE} ",
				"returnFields": "F_FILETITLE",
				"cusInputData": "[{fieldName:'parentId]',mode:'mapping',bindVal:''}]",
				"url": "{ctxPath}/sys/customform/sysCustomFormSetting/form/accOpenSol/{surveyFormId}.do",
				"cusQueryName": "勘察单查询"
			}
		 */
		if(linkFieldConfig==null){
			el.replaceWith(new Element(Tag.valueOf("span"), "").html(htmlText));
			return;
		}

		String url=linkFieldConfig.getString("url");
		String linkType=linkFieldConfig.getString("linkType");
		if(StringUtils.isEmpty(url)){
			el.replaceWith(new Element(Tag.valueOf("span"), "").html(htmlText));
			return;
		}

		//通过自定义关联查询显示关联的标题
		String cusQuery=linkFieldConfig.getString("cusQuery");
		String replaceRule=linkFieldConfig.getString("replaceRule");
		Map<String,Object> dataMap=FastjsonUtil.json2Map(jsonObj);
		
		//需要从自定义查询中取
		if(StringUtils.isNotEmpty(cusQuery) && StringUtils.isNotEmpty(replaceRule)){
			replaceRule=replaceRule.trim();
			Map<String,Object> inputParams=new HashMap<String,Object>();
			JSONArray paramArr=linkFieldConfig.getJSONArray("cusInputData");
			GroovyEngine groovyEngine=(GroovyEngine)AppBeanUtil.getBean(GroovyEngine.class);
			for(int i=0;i<paramArr.size();i++){
				JSONObject param=paramArr.getJSONObject(i);
				String mode=param.getString("mode");
				String fieldName=param.getString("fieldName");
				String bindVal=param.getString("bindVal");
				//通过脚本计算输入值
				if("script".equals(mode)){
					Object val=groovyEngine.executeScripts(bindVal, params);
					inputParams.put(fieldName, val);
				}else{//通过输入参数计算输入值
					Object val=dataMap.get(bindVal);
					inputParams.put(fieldName, val);
				}
			}
			SysSqlCustomQueryManager queryManager=(SysSqlCustomQueryManager)AppBeanUtil.getBean(SysSqlCustomQueryManager.class);
			try{
				Element ul=new Element(Tag.valueOf("ul"),"");
				ul.addClass("link-field-ul");
				//检查输入的参数，若存在值，并且不空，则进行查询，否则返回空
				boolean isInputData=true;
				Iterator<String> keyIt=inputParams.keySet().iterator();
				while(keyIt.hasNext()){
					Object val=inputParams.get(keyIt.next());
					if(val==null){
						isInputData=false;
						break;
					}
				}
				List results=null;
				//输入参数若存在空，则不进行数据库的数据查询
				if(isInputData==false){
					results=new ArrayList();
				}else{
					results=queryManager.getQueryData(cusQuery, inputParams);
				}
				dataMap=mapAddKeyPrefix("self.", dataMap);
				for(int i=0;i<results.size();i++){
					String newUrl=url;
					Map<String,Object> rows=(Map<String,Object>)results.get(i);
					rows=mapAddKeyPrefix("ref.", rows);

					String rule=StringUtil.replaceVariableMap(replaceRule, rows);
					
					//加上解析的参数
					rows.putAll(params);
					//根据记录来生成多个关联的超连接
					Element li=new Element(Tag.valueOf("li"),"");
					Element link=new Element(Tag.valueOf("a"),"");
					try{
						//url=freemarkEngine.parseByStringTemplate(rows, url);
						
						dataMap.putAll(rows);
						dataMap.putAll(params);
						url=StringUtil.replaceVariableMap(url, dataMap);
						link.attr("href","javascript:void(0);");
						link.attr("onclick","_ShowLinkFieldInfo('"+newUrl.trim()+"','"+linkType+"')");
						//设置超连接的文本
						link.text(rule);
						li.appendChild(link);
						ul.appendChild(li);
						
					}catch(Exception e){
						e.printStackTrace();
					}
				}
				el.replaceWith(ul);
			}catch(Exception e){
				e.printStackTrace();
			}
		}else{//
			Element link=new Element(Tag.valueOf("a"),"");
			try{
				dataMap.putAll(params);
				url=StringUtil.replaceVariableMap(url, dataMap);
				link.attr("href","javascript:void(0);");
				link.attr("onclick","_ShowLinkFieldInfo('"+url+"','"+linkType+"')");
				String curControl=linkFieldConfig.getString("cur_control");
				String labelText=jsonObj.getString(curControl);
				//设置超连接的文本
				link.text(labelText);
				el.replaceWith(link);
			}catch(Exception e){
				e.printStackTrace();
			}
		}
	}
	
	/**
	 * 将json 转成boDefid,表单数据。
	 * @param jsonData
	 * @return
	 */
	public static Map<String,JSONObject> convertJsonToMap(JSONObject jsonData){
		Map<String,JSONObject> map=new HashMap<String,JSONObject>();
		JSONArray jsonAry=jsonData.getJSONArray("bos");
		if(jsonAry==null) {
            return map;
        }
		for(int i=0;i<jsonAry.size();i++){
			JSONObject formJson=jsonAry.getJSONObject(i);
			String boDefId=formJson.getString("boDefId");
			JSONObject data=formJson.getJSONObject("data");
			map.put(boDefId, data);
		}
		return map;
	}
	
	/**
	 * 将map的key加上前缀
	 * @param keyPrefix 例如{a=2},当keyPrefix="self." 变成{self.a=2}
	 * @param map
	 * @return
	 */
	public static Map<String, Object> mapAddKeyPrefix(String keyPrefix,Map<String,Object> map){
		Map<String,Object> rtnMap=new HashMap<String, Object>();
		for(Entry<String, Object> entry:map.entrySet()){
			rtnMap.put(keyPrefix+entry.getKey(), entry.getValue());
		}
		return rtnMap;
	}
	
}
