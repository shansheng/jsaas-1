package com.redxun.sys.echarts.controller;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.util.StringUtil;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.sys.echarts.entity.SysEchartsListPremission;
import com.redxun.sys.echarts.entity.SysEchartsPremission;
import com.redxun.sys.echarts.manager.SysEchartsListPremissionManager;
import com.redxun.sys.echarts.manager.SysEchartsPremissionManager;

@Controller
@RequestMapping("/sys/echarts/echartsPremission/")
public class SysEchartsPremissionController extends MybatisListController {
	
	@Resource
	private SysEchartsPremissionManager premissionManager;
	
	//@Resource
	//private SysEchartsListPremissionManager listPremissionManager;

	/** 授权处理 **************************************************************/
	
	@RequestMapping("grant")
	@ResponseBody
	public ModelAndView grant(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String treeId = RequestUtil.getString(req, "treeId");
		String singleId = RequestUtil.getString(req, "singleId");
		StringBuffer userName = new StringBuffer("");
		StringBuffer userId = new StringBuffer("");
		StringBuffer groupName = new StringBuffer("");
		StringBuffer groupId = new StringBuffer("");
		StringBuffer subGroupId = new StringBuffer("");
		StringBuffer subGroupName = new StringBuffer("");
		
		//if(StringUtil.isNotEmpty(treeId)) {
			List<SysEchartsPremission> premission = premissionManager.getByTreeId(treeId);
			if(premission.size() > 0) {
				for(SysEchartsPremission right : premission) {
					String type = right.getType();
					initTypeSetting(type, userName, userId, groupName, groupId, 
							subGroupName, subGroupId, right.getOwnerName(), right.getOwnerId());
				}
			}
		/*} else {
			List<SysEchartsListPremission> premission = listPremissionManager.getByPreId(singleId);
			if(premission.size() > 0) {
				for(SysEchartsListPremission right : premission) {
					String type = right.getType();
					initTypeSetting(type, userName, userId, groupName, groupId, 
							subGroupName, subGroupId, right.getOwnerName(), right.getOwnerId());
				}
			}
		}*/
		return this.getPathView(req).addObject("treeId", treeId).addObject("singleId", singleId)
				.addObject("groupName", slicingComma(groupName)).addObject("groupId", slicingComma(groupId))
				.addObject("userName", slicingComma(userName)).addObject("userId", slicingComma(userId))
				.addObject("subGroupName", slicingComma(subGroupName))
				.addObject("subGroupId", slicingComma(subGroupId));
	}
	
	private void initTypeSetting(String type, StringBuffer userName, StringBuffer userId, 
			StringBuffer groupName, StringBuffer groupId, StringBuffer subGroupName, StringBuffer subGroupId, 
			String ownerName, String ownerId) {
		if("group".equals(type)){
			groupName.append(ownerName).append(",");
			groupId.append(ownerId).append(",");
		}else if("user".equals(type)){
			userName.append(ownerName).append(",");
			userId.append(ownerId).append(",");
		} else {
			subGroupName.append(ownerName).append(",");
			subGroupId.append(ownerId).append(",");
		}
	}
	
	@RequestMapping("saveTreeGrantPremssion")
	@ResponseBody
	public JSONObject saveTreeGrantPremssion(HttpServletRequest request,HttpServletResponse response){
		String treeId = RequestUtil.getString(request, "treeId");
		String singleId = RequestUtil.getString(request, "singleId");
		String userId = RequestUtil.getString(request, "userId");
		String userName = RequestUtil.getString(request, "userName");
		String groupId = RequestUtil.getString(request, "groupId");
		String groupName = RequestUtil.getString(request, "groupName");
		String subGroupId = RequestUtil.getString(request, "subGroupId");
		String subGroupName = RequestUtil.getString(request, "subGroupName");
		
		//if(StringUtil.isNotEmpty(treeId)) {
			premissionManager.delByTreeId(treeId); //先删除后添加
			createAllRightArray("user", userId, userName, treeId, "TREE");
			createAllRightArray("group", groupId, groupName, treeId, "TREE");
			createAllRightArray("subGroup", subGroupId, subGroupName, treeId, "TREE");
		/*} else {
			listPremissionManager.delByPreId(singleId);
			createAllRightArray("user", userId, userName, singleId, null);
			createAllRightArray("group", groupId, groupName, singleId, null);
			createAllRightArray("subGroup", subGroupId, subGroupName, singleId, null);
		}*/
		
		return new JSONObject();
	}
	
	/**
	 * @param type "user/group/subGroup"
	 * @param idArrayString 以逗号分隔的id字符串
	 * @param nameArrayString 以逗号分隔的name字符串
	 */
	private void createAllRightArray(String type, String idArrayString, String nameArrayString, String id, String isTree) {
		String[] idArray = idArrayString.split(",");
		String[] nameArray = nameArrayString.split(",");
		for (int i = 0; i < idArray.length; i++) {
			if (StringUtils.isBlank(idArray[i])) {
				continue;
			}
			//if(StringUtil.isNotEmpty(isTree)) {
				SysEchartsPremission setting = new SysEchartsPremission();
				setting.setId(idGenerator.getSID());
				setting.setType(type);
				setting.setOwnerId(idArray[i]);
				setting.setOwnerName(nameArray[i]);
				setting.setTenantId(ContextUtil.getCurrentTenantId());
				setting.setCreateBy(ContextUtil.getCurrentUserId());
				setting.setCreateTime(new Date());
				setting.setTreeId(id);
				premissionManager.create(setting);
			/*} else {
				SysEchartsListPremission setting = new SysEchartsListPremission();
				setting.setId(idGenerator.getSID());
				setting.setType(type);
				setting.setOwnerId(idArray[i]);
				setting.setOwnerName(nameArray[i]);
				setting.setTenantId(ContextUtil.getCurrentTenantId());
				setting.setCreateBy(ContextUtil.getCurrentUserId());
				setting.setCreateTime(new Date());
				setting.setPreId(id);
				listPremissionManager.create(setting);
			}*/
		}
	}
	
	/**
	 * 切割末尾逗号返回string
	 * @param sb
	 * @return
	 */
	public String slicingComma(StringBuffer sb){
		if(sb.length()>=1){
			return  sb.substring(0, sb.length()-1);
		}else{
			return sb.toString();
		}
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return premissionManager;
	}
}