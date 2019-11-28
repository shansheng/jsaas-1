package com.redxun.bpm.core.manager;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.core.dao.BpmAuthDefDao;
import com.redxun.bpm.core.dao.BpmAuthDefDao;
import com.redxun.bpm.core.dao.BpmAuthRightsDao;
import com.redxun.bpm.core.dao.BpmAuthSettingDao;
import com.redxun.bpm.core.dao.BpmSolutionDao;
import com.redxun.bpm.core.dao.BpmSolutionDao;
import com.redxun.bpm.core.entity.BpmAuthDef;
import com.redxun.bpm.core.entity.BpmAuthRights;
import com.redxun.bpm.core.entity.BpmAuthSetting;
import com.redxun.bpm.core.entity.BpmSolution;
import com.redxun.bpm.core.entity.IRightModel;
import com.redxun.core.dao.IDao;
import com.redxun.core.manager.BaseManager;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.org.api.context.ProfileUtil;
import com.redxun.saweb.util.IdUtil;
import com.redxun.saweb.util.WebAppUtil;
import com.redxun.sys.core.util.SysPropertiesUtil;
/**
 * <pre> 
 * 描述：BpmAuthSetting业务服务类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：广州红迅软件有限公司版权所有
 * </pre>
 */
@Service
public class BpmAuthSettingManager extends MybatisBaseManager<BpmAuthSetting>{
	@Resource
	private BpmAuthSettingDao bpmAuthSettingDao;
	@Resource
	private BpmAuthSettingManager bpmAuthSettingManager;
	@Resource
	private BpmAuthRightsDao  bpmAuthRightsDao;
	@Resource
	private BpmSolutionManager bpmSolutionManager;
	@Resource
	private BpmAuthDefDao bpmAuthDefDao;
	@Resource
	private BpmSolutionDao bpmSolutionDao;
	
	
	
	public static String getGrantType(){
		String type="";
		try {
			type = SysPropertiesUtil.getGlobalProperty("bpm.grantType");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return type;
	}
	
	
	
	/**
	 * 获取默认的权限。
	 * @return
	 */
	public static JSONObject getDefaultRightJson(){
		
		String json="{}";
		try {
			 json=SysPropertiesUtil.getGlobalProperty("bpm.permission");
		} catch (Exception e) {
			e.printStackTrace();
		}
		JSONObject rightJson  =JSONObject.parseObject(json);
		return rightJson;
	}
	
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmAuthSettingDao;
	}
	
	/**
	 * 保存授权。
	 * @param setting
	 * @param defs
	 * @param rights
	 */
	public void saveAuth(String setting,String defs,String rights){
		BpmAuthSetting bpmAuthSetting=JSONObject.parseObject(setting, BpmAuthSetting.class);
		
		
		List<BpmAuthDef> listDef=JSONArray.parseArray(defs, BpmAuthDef.class);
		JSONObject rightsJson=JSONObject.parseObject(rights);
		String settingId=bpmAuthSetting.getId();
		
		if(StringUtil.isNotEmpty(settingId)){
			bpmAuthDefDao.delBySettingId(settingId);
			bpmAuthRightsDao.delBySettingId(settingId);
			bpmAuthSetting.setType("BPM");
			bpmAuthSettingDao.update(bpmAuthSetting);
		}
		else{
			settingId=IdUtil.getId();
			bpmAuthSetting.setId(settingId);
			bpmAuthSetting.setType("BPM");
			bpmAuthSettingDao.create(bpmAuthSetting);
		}
		//添加权限
		addRights(rightsJson,settingId);
		
		//添加流程定义.
		for(BpmAuthDef def:listDef){
			def.setId(IdUtil.getId());
			def.setSettingId(settingId);
			bpmAuthDefDao.create(def);
		}
		
	}
	
	/**
	 * 添加权限。
	 * <pre>
	 * rightsJson:
	 * {
	 * 	def:[{type:"user",name:"",ids:"",names:""}],
	 * 	start:[{type:"user",name:"",ids:"",names:""}],
	 * 	inst:[{type:"user",name:"",ids:"",names:""}],
	 *  task:[{type:"user",name:"",ids:"",names:""}]
	 * };
	 * </pre>
	 * @param rightsJson
	 * @param settingId
	 */
	private void addRights(JSONObject rightsJson,String settingId){
		Set<String> keySet=rightsJson.keySet();
		for(Iterator<String> it=keySet.iterator();it.hasNext();){
			String rightType=it.next();
			
			JSONArray rightsAry=rightsJson.getJSONArray(rightType);
			
			for(Object obj:rightsAry){
				JSONObject rightItem=(JSONObject)obj;
				String type=rightItem.getString("type");
				if("everyone".equals(type)){
					BpmAuthRights authRights=new BpmAuthRights();
					authRights.setId(IdUtil.getId());
					authRights.setSettingId(settingId);
					authRights.setRightType(rightType);
					authRights.setType(type);
					bpmAuthRightsDao.create(authRights);
				}
				else{
					String ids=rightItem.getString("ids");
					String names=rightItem.getString("names");
					String[] aryId=ids.split(",");
					String[] aryName=names.split(",");
					for(int i=0;i<aryId.length;i++){
						String id=aryId[i];
						String name=aryName[i];
						BpmAuthRights authRights=new BpmAuthRights();
						authRights.setId(IdUtil.getId());
						authRights.setSettingId(settingId);
						authRights.setRightType(rightType);
						authRights.setType(type);
						authRights.setAuthId(id);
						authRights.setAuthName(name);
						
						bpmAuthRightsDao.create(authRights);
					}
				}
			}
			
		}
	}
	
	public JSONObject getById(String settingId){
		BpmAuthSetting  bpmAuthSetting=bpmAuthSettingManager.get(settingId);
		String bpmGrantType=BpmAuthSettingManager.getGrantType();
		JSONObject jsonOut=new JSONObject();
        
        JSONObject jsonObj=new JSONObject();
        jsonObj.put("id", settingId);
        jsonObj.put("name", bpmAuthSetting.getName());
        jsonObj.put("enable", bpmAuthSetting.getEnable());
        
        jsonOut.put("authSetting", jsonObj);
        
        //获取流程定义
        List<BpmAuthDef> listDef=new ArrayList<BpmAuthDef>();
        if("actDefinition".equals(bpmGrantType)){
        	listDef=bpmAuthDefDao.getBySettingId(settingId);
        }else{
        	listDef=bpmAuthDefDao.defTreeGetBySettingId(settingId);
        }
        
        JSONArray defJsonAry=new JSONArray();
        defJsonAry.addAll(listDef);
        jsonOut.put("defs", defJsonAry);
        
        //获取流程权限
        List<BpmAuthRights> rights= bpmAuthRightsDao.getBySettingId(settingId);
        Map<String,List<BpmAuthRights>> rightMap=new HashMap<String, List<BpmAuthRights>>();
        for(BpmAuthRights right:rights){
        	if(rightMap.containsKey(right.getRightType())){
        		List<BpmAuthRights> list=rightMap.get(right.getRightType());
        		list.add(right);
        	}
        	else{
        		List<BpmAuthRights> list=new ArrayList<BpmAuthRights>();
        		list.add(right);
        		rightMap.put(right.getRightType(), list);
        	}
        }
       
       JSONObject jsonRight=new JSONObject();
       
       Map<String,String> profileMap=ProfileUtil. getProileTypes();
        
       for (Map.Entry<String, List<BpmAuthRights>> ent : rightMap.entrySet()){
    	   List<BpmAuthRights> bpmAuthRights= ent.getValue();
    	   List<JSONObject>  jsonObjects= getRights(profileMap,bpmAuthRights);
    	   jsonRight.put(ent.getKey(), jsonObjects);
       }
       
       jsonOut.put("rights" , jsonRight);
        
        
        return jsonOut;
	}
	
	private List<JSONObject> getRights(Map<String,String> profileMap,List<BpmAuthRights> list){
		Map<String,List<BpmAuthRights>> rightMap=new HashMap<String, List<BpmAuthRights>>();
		for(BpmAuthRights rights:list){
			String type=rights.getType();
			if(rightMap.containsKey(type)){
				List<BpmAuthRights> authRights=rightMap.get(type);
				authRights.add(rights);
			}
			else{
				List<BpmAuthRights> authRights=new ArrayList<BpmAuthRights>();
				authRights.add(rights);
				rightMap.put(type, authRights);
			}
		}
		
		List<JSONObject> jsonList=new ArrayList<JSONObject>();
		for (Map.Entry<String, List<BpmAuthRights>> ent : rightMap.entrySet()) { 
			String type=ent.getKey();
			
			String name="everyone".equals(type)?"所有人":profileMap.get(type);
			JSONObject json=new JSONObject();
			json.put("type", type);
			json.put("name", name);
			if(!"everyone".equals(type)){
				List<BpmAuthRights> authRights=ent.getValue();
				String ids="";
				String names="";
				for(int i=0;i<authRights.size();i++){
					BpmAuthRights obj=authRights.get(i);
					if(i==0){
						ids+=obj.getAuthId();
						names+=obj.getAuthName();
					}
					else{
						ids+= "," +obj.getAuthId();
						names+="," + obj.getAuthName();
					}
				}
				json.put("ids", ids);
				json.put("names", names);
			}
			jsonList.add(json);
		}
		
		return jsonList;
	}
	
	
	
	@Override
	public void delete(String id) {
		bpmAuthSettingDao.delete(id);
		//删除def
		bpmAuthDefDao.delBySettingId(id);
		//delBySettingId
		bpmAuthRightsDao.delBySettingId(id);
	}

	/**
	 * 获取用户权的流程定义数据。
	 * @param userId
	 * @param isCreate
	 * @return
	 */
	public Map<String,JSONObject> getRights(String rightType){
		
		Map<String,Set<String>> profileMap=ProfileUtil.getCurrentProfile();
		List defList=bpmAuthSettingDao.getRights(rightType,profileMap);
		Map<String,JSONObject> map=merageRights(defList);
		return map;
	}
	
	/**
	 * 根据解决方案ID获取权限。
	 * @param solIds
	 * @return
	 */
	public Map<String,JSONObject> getRightsBySolId(List<String> solIds){
		List defList=bpmAuthSettingDao.getRightsBySolId(solIds);
		Map<String,JSONObject> map=merageRights(defList);
		return map;
	}
	
	
	
	private Map<String,JSONObject> merageRights(List defList){
		Map<String,JSONObject> rtnMap=new HashMap<String, JSONObject>();
		for(Object obj:defList){
			Map map=(Map)obj;
			String solId=(String) map.get("SOL_ID_");
			String json=(String) map.get("RIGHT_JSON_");
			JSONObject curJson=JSONObject.parseObject(json);
			if(rtnMap.containsKey(solId)){
				JSONObject oldJson=rtnMap.get(solId);
				merageJson(oldJson, curJson);
			}
			rtnMap.put(solId, curJson);
		}
		return rtnMap;
	}
	
	/**
	 *  权限合并。
	 * {"def":[{"val":true,"name":"设计","key":"design"},{"val":false,"name":"编辑","key":"edit"},
	 * {"val":true,"name":"删除","key":"del"}],"inst":[{"val":false,"name":"删除","key":"del"}]}
	 * @param oldJson
	 * @param curJson
	 * @return
	 */
	private void merageJson(JSONObject oldJson,JSONObject curJson){
		Set<String> set= curJson.keySet();
		for(Iterator<String> it=set.iterator();it.hasNext();){
			String key=it.next();
			JSONArray jsonAry=curJson.getJSONArray(key);
			JSONArray oldJsonAry=oldJson.getJSONArray(key);
			merageJsonAry(oldJsonAry,jsonAry);
		}
	}
	
	/**
	 * 合并json数据。
	 * @param oldJsonAry
	 * @param jsonAry
	 */
	private void merageJsonAry(JSONArray oldJsonAry,JSONArray jsonAry){
		Map<String,JSONObject> oldMap=convertMap(oldJsonAry);
		Map<String,JSONObject> map=convertMap(jsonAry);
		
		for(Map.Entry<String, JSONObject> ent:map.entrySet()){    
			String key=ent.getKey();
			JSONObject curObj=map.get(key);
			JSONObject oldObj=oldMap.get(key);
			Boolean oldVal=oldObj.getBoolean("val");
			if(oldVal){
				curObj.put("val", true);
			}
		}   
	}
	
	private Map<String,JSONObject> convertMap(JSONArray aryJson){
		Map<String,JSONObject> map=new HashMap<String, JSONObject>();
		for(Object obj:aryJson){
			JSONObject jObj=(JSONObject)obj;
			map.put(jObj.getString("key"), jObj);
		}
		return map;
	}
	
	/**
	 * 设置权限。
	 * @param list
	 */
	public void setRight(List<? extends IRightModel> list){
		if(BeanUtil.isEmpty(list)) return;
		List<String> solIds=new ArrayList<String>();
		for(IRightModel model:list){
				model.setRightJson(BpmAuthSettingManager.getDefaultRightJson());
		}
		String grantType=BpmAuthSettingManager.getGrantType();
		if("bpmAssortment".equals(grantType)){
			List<BpmAuthDef> bpmAuthDefs=bpmAuthDefDao.getAllNotEmptyTreeId();
			for (BpmAuthDef bpmAuthDef : bpmAuthDefs) {
				List<BpmSolution> bpmSolutions=bpmSolutionDao.getByTreeId(bpmAuthDef.getTreeId());
				for(IRightModel model:list){
					JSONObject jsonObject=JSONObject.parseObject(bpmAuthDef.getRightJson());
					if(bpmSolutions.contains(bpmSolutionDao.get(model.getSolId()))){
						model.setRightJson(jsonObject);
					}
				}
			}
		}else{
			for(IRightModel model:list){
				solIds.add(model.getSolId());
			}
			Map<String,JSONObject> mapRights= bpmAuthSettingManager.getRightsBySolId(solIds);
			for(IRightModel model:list){
				JSONObject jsonObj=mapRights.get(model.getSolId());
				if(jsonObj!=null){
					model.setRightJson(jsonObj);
				}
			}
		}
		
		
	}

	public BpmAuthSetting getSettingByDefTreeId(String treeId){
		return bpmAuthSettingDao.getSettingByDefTreeId(treeId);
	}
	
}