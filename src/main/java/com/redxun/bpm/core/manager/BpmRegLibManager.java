
package com.redxun.bpm.core.manager;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.bpm.core.dao.BpmRegLibDao;
import com.redxun.bpm.core.entity.BpmRegLib;
import com.redxun.core.cache.CacheUtil;
import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.util.BeanUtil;
import com.redxun.saweb.util.IdUtil;

/**
 * 
 * <pre> 
 * 描述：BPM_REG_LIB 处理接口
 * 作者:ray
 * 日期:2018-12-25 15:49:05
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class BpmRegLibManager extends MybatisBaseManager<BpmRegLib>{
	
	@Resource
	private BpmRegLibDao bpmRegLibDao;
	
	//校验正则
	private static String REGS0="regs0_";
	//脱敏正则
	private static String REGS1="regs1_";
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmRegLibDao;
	}
	
	
	
	public BpmRegLib getBpmRegLib(String uId){
		BpmRegLib bpmRegLib = get(uId);
		return bpmRegLib;
	}
	

	@Override
	public void delete(String id) {
		super.delete(id);
	}
	
	@Override
	public void create(BpmRegLib entity) {
		entity.setRegId(IdUtil.getId());
		super.create(entity);
	}

	@Override
	public void update(BpmRegLib entity) {
		super.update(entity);
	}



	public List<BpmRegLib> getRegByType(String type) {
		return bpmRegLibDao.getRegByType(type);
	}
	
	public BpmRegLib getRegByKey(String key,String cacheName) {
		Map<String,BpmRegLib> map= (Map<String,BpmRegLib>) CacheUtil.getCache(cacheName);
		BpmRegLib bpmRegLib;
		if(BeanUtil.isEmpty(map)){
			bpmRegLib = bpmRegLibDao.getRegByKey(key);
		}else {
			bpmRegLib = map.get(key);
		}
		return bpmRegLib;
	}
	
	public BpmRegLib getRegByKeyCheck(String key) {
		return getRegByKey(key, REGS0);
	}
	
	public BpmRegLib getRegByKeyReplace(String key) {
		return getRegByKey(key, REGS1);
	}
	
	public boolean isExistKey(BpmRegLib bpmRegLib){
		 Integer rtn= bpmRegLibDao.getCountByKey(bpmRegLib.getRegId(),bpmRegLib.getKey());
		 return rtn>0;
	}



	public void initReg() {
		List<BpmRegLib> list0= getRegByType("0");
		Map<String,BpmRegLib> map0 = new HashMap<String,BpmRegLib>();
		for (BpmRegLib bpmRegLib : list0) {
			map0.put(bpmRegLib.getKey(), bpmRegLib);
		}
		List<BpmRegLib> list1= getRegByType("1");
		Map<String,BpmRegLib> map1 = new HashMap<String,BpmRegLib>();
		for (BpmRegLib bpmRegLib : list1) {
			map1.put(bpmRegLib.getKey(), bpmRegLib);
		}
		CacheUtil.addCache(REGS0, map0);
		CacheUtil.addCache(REGS1, map1);
	}
	
}
