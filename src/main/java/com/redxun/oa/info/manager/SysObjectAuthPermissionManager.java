package com.redxun.oa.info.manager;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.core.dao.IDao;
import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.ExtBaseManager;
import com.redxun.oa.info.dao.SysObjectAuthPermissionDao;
import com.redxun.oa.info.dao.SysObjectAuthPermissionQueryDao;
import com.redxun.oa.info.entity.SysObjectAuthPermission;
import com.redxun.saweb.util.IdUtil;
import com.redxun.sys.org.manager.OsGroupManager;
import com.redxun.sys.org.manager.OsUserManager;


/**
 * 
 * <pre>
 * 描述：系统对象授权表 处理接口
 * 作者:mansan
 * 日期:2018-05-02 09:55:15
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class SysObjectAuthPermissionManager extends
		ExtBaseManager<SysObjectAuthPermission> {
	@Resource
	private SysObjectAuthPermissionDao sysObjectAuthPermissionDao;
	@Resource
	private SysObjectAuthPermissionQueryDao sysObjectAuthPermissionQueryDao;
	
	@Resource
	public OsUserManager osUserManager;
	
	@Resource
	public OsGroupManager osGroupManager;
	

	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return sysObjectAuthPermissionDao;
	}

	@Override
	public BaseMybatisDao getMyBatisDao() {
		return sysObjectAuthPermissionQueryDao;
	}

	public SysObjectAuthPermission getSysObjectAuthPermission(String uId) {
		SysObjectAuthPermission sysObjectAuthPermission = get(uId);
		return sysObjectAuthPermission;
	}

	@Override
	public void create(SysObjectAuthPermission entity) {
		entity.setId(IdUtil.getId());
		super.create(entity);

	}

	@Override
	public void update(SysObjectAuthPermission entity) {
		super.update(entity);

	}

	/** 删除权限 */
	public void delbyObjectId(String objectId) {
		sysObjectAuthPermissionQueryDao.delbyObjectId(objectId,"remind");
	}
	
	/**
	 *  获取当前消息的权限
	 * @param objectId
	 * @return
	 */
	public List<JSONObject> getAuthPermission(String objectId,String authtype ){
		List<SysObjectAuthPermission> lists = sysObjectAuthPermissionQueryDao.getAllByObjectIdAndAuthType(objectId, authtype);
		Map<String,List<SysObjectAuthPermission>> map=new HashMap<String,List<SysObjectAuthPermission>>();
		for(SysObjectAuthPermission permission:lists){
			String type=permission.getType();
			List<SysObjectAuthPermission>  permissions=map.get(type);
			if(permissions==null){
				permissions=new ArrayList<>();
				map.put(type, permissions);
			}
			permissions.add(permission);
		}
		List<JSONObject> jsonObjects=new ArrayList<>();
		for (String key : map.keySet()) {  
			List<SysObjectAuthPermission> list=map.get(key);
			String ids="";
			String names="";
			for(int i=0;i<list.size();i++){
				SysObjectAuthPermission permission=list.get(i);
				ids+=(i==0?"":",")+  permission.getAuthId();
				names+=(i==0?"":",")+ permission.getAuthName();
			}
			JSONObject obj=new JSONObject();
			obj.put("type", key);
			obj.put("ids", ids);
			obj.put("names", names);
			jsonObjects.add(obj);
		}  
		
		return jsonObjects;
	}

	
	public JsonResult saveRight(JSONObject remindJson) {
		String jsonString = remindJson.getString("data");
		String remindType = remindJson.getString("type");
		String objectId = remindJson.getString("objectId");
		JSONArray jsonarray = JSONArray.parseArray(jsonString);
		
		delbyObjectId(objectId);
		for (Object obj : jsonarray) {
			JSONObject remindItem = (JSONObject) obj;
			String type = remindItem.getString("type");
			if ("everyone".equals(type)) {
				SysObjectAuthPermission sysObjectAuthPermission = new SysObjectAuthPermission();
				sysObjectAuthPermission.setId(IdUtil.getId());
				sysObjectAuthPermission.setObjectId(objectId);
				sysObjectAuthPermission.setAuthType(remindType);
				sysObjectAuthPermission.setType(type);
				create(sysObjectAuthPermission);
			} else {
				String ids = remindItem.getString("ids");
				String names = remindItem.getString("names");
				type = remindItem.getString("type");
				String[] aryId = ids.split(",");
				String[] aryName = names.split(",");
				for (int i = 0; i < aryId.length; i++) {
					String id = aryId[i];
					String name = aryName[i];
					SysObjectAuthPermission sysObjectAuthPermission = new SysObjectAuthPermission();
					sysObjectAuthPermission.setId(IdUtil.getId());
					sysObjectAuthPermission.setObjectId(objectId);
					sysObjectAuthPermission.setAuthType(remindType);
					sysObjectAuthPermission.setType(type);
					sysObjectAuthPermission.setAuthId(id);
					sysObjectAuthPermission.setAuthName(name);
					create(sysObjectAuthPermission);
				}
			}
		}

		return new JsonResult(true, "保存权限成功!");

	}


}
