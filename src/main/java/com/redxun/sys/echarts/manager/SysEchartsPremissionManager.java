package com.redxun.sys.echarts.manager;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.org.api.context.ProfileUtil;
import com.redxun.sys.echarts.dao.SysEchartsCustomDao;
import com.redxun.sys.echarts.dao.SysEchartsPremissionDao;
import com.redxun.sys.echarts.entity.SysEchartsCustom;
import com.redxun.sys.echarts.entity.SysEchartsPremission;

@Service
public class SysEchartsPremissionManager extends MybatisBaseManager<SysEchartsPremission> {
	
	@Resource
	private SysEchartsPremissionDao premissionDao;
	
	@Resource
	private SysEchartsCustomDao customDao;
	
	//TODO 权限管理部分 
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<String> hasAccessPremission() {
		Map<String,Set<String>> profiles = ProfileUtil.getCurrentProfile();
		Set<String> userIds = profiles.get("user");
		Set<String> groupIds = profiles.get("group");
		Set<String> subGroupIds = profiles.get("subGroup");
		List premTreeList = premissionDao.getUserTreeGrant(userIds, groupIds, subGroupIds);//当前登录用户所拥有的的树ID
		List<SysEchartsCustom> allCustomList = new ArrayList<SysEchartsCustom>();
		
		for(int i = 0; i < premTreeList.size(); i++) {
			Map<String, Object> map = (Map<String, Object>) premTreeList.get(i);
			List<SysEchartsCustom> customList = customDao.getByTreeId(map.get("TREE_ID_").toString(), null, null);
			allCustomList.addAll(customList);
		}
		
		List<String> urls = new ArrayList<String>();
		for(SysEchartsCustom custom : allCustomList) {
			urls.add("/sys/echarts/echartsCustom/preview/" + custom.getKey() + ".do");
			urls.add("/sys/echarts/echartsCustom/previewTableJson/" + custom.getKey() + ".do");
		}
		return urls;
	}
	
	
	public void delByTreeId(String treeId) {
		premissionDao.delByTreeId(treeId);
	}
	
	public List<SysEchartsPremission> getByTreeId(String treeId){
		return premissionDao.getByTreeId(treeId);
	}
	
	public List<SysEchartsPremission> getUserTreeGrant(Set<String> userIds, Set<String> groupIds, Set<String> subGroupIds){
		return premissionDao.getUserTreeGrant(userIds, groupIds, subGroupIds);
	}

	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return premissionDao;
	}

}
