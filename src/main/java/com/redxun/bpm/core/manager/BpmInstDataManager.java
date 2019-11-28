
package com.redxun.bpm.core.manager;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.bpm.bm.manager.BpmFormInstManager;
import com.redxun.bpm.core.dao.BpmInstDataDao;
import com.redxun.bpm.core.entity.BpmInstData;
import com.redxun.core.dao.IDao;
import com.redxun.core.dao.mybatis.CommonDao;
import com.redxun.core.entity.SqlModel;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.saweb.util.IdUtil;
import com.redxun.sys.bo.entity.SysBoDef;
import com.redxun.sys.bo.entity.SysBoEnt;
import com.redxun.sys.bo.manager.SysBoEntManager;

/**
 * 
 * <pre> 
 * 描述：关联关系 处理接口
 * 作者:mansan
 * 日期:2017-06-29 09:59:32
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class BpmInstDataManager extends MybatisBaseManager<BpmInstData>{
	
	@Resource
	private BpmInstDataDao bpmInstDataDao;
	@Resource
	private SysBoEntManager sysBoEntManager;
	@Resource
	private BpmFormInstManager bpmFormInstManager;
	@Resource
	private CommonDao commonDao;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmInstDataDao;
	}
	
	
	/**
	 * 根据实例ID获取关联数据。
	 * @param instId
	 * @return
	 */
	public List<BpmInstData> getByInstId(String instId){
		return bpmInstDataDao.getByInstId(instId);
	}
	
	
	private Map<String,BpmInstData> getMapByInstId(String instId){
		List<BpmInstData> list= bpmInstDataDao.getByInstId(instId);
		Map<String,BpmInstData> map=new HashMap<String, BpmInstData>();
		for(BpmInstData data:list){
			map.put(data.getBoDefId(), data);
		}
		return map;
		
	}
	
	/**
	 * 添加关联数据。
	 * @param boDefId
	 * @param pk
	 * @param instId
	 */
	public void addBpmInstData(String boDefId,String pk,String instId){
		BpmInstData instData=new BpmInstData();
		instData.setId(IdUtil.getId());
		instData.setBoDefId(boDefId);
		instData.setInstId(instId);
		instData.setPk(pk);
		bpmInstDataDao.create(instData);
	}
	
	/**
	 * 获取主键。
	 * @param instId
	 * @param boDefId
	 * @return
	 */
	public String getPk(String instId,String boDefId){
		Map<String,BpmInstData> map= this.getMapByInstId(instId);
		if(map.containsKey(boDefId)){
			return map.get(boDefId).getPk();
		}
		return "";
	}
	
	/**
	 * 更新数据状态。
	 * @param instId	实例ID
	 * @param status	状态
	 */
	public void updFormDataStatus(String instId,String status){
		List<BpmInstData>  list=bpmInstDataDao.getByInstId(instId);
		if(BeanUtil.isEmpty(list)) return;
		for(BpmInstData instData:list){
			String pk=instData.getPk();
			String boDefId=instData.getBoDefId();
			SysBoEnt boEnt= sysBoEntManager.getByBoDefId(boDefId,false);
			//生成物理表了。
			String pkField=boEnt.getPkField();
			if(SysBoDef.BO_NO.equals(boEnt.getGenTable())) continue;
			if(StringUtil.isEmpty(boEnt.getTableName() )) continue;
			String sql="update " + boEnt.getTableName() +" set " +SysBoEnt.FIELD_INST_STATUS_
					+"='"+ status +"' where " + pkField +"=#{pk}";
			
			SqlModel sqlModel=new SqlModel(sql);
			sqlModel.addParam("pk", pk);
			commonDao.execute(sqlModel);
		}
	}
	
	/**
	 * 根据实例删除业务表数据。
	 * @param instId
	 */
	public void removeByInstId(String instId){
		List<BpmInstData>  list=bpmInstDataDao.getByInstId(instId);
		if(BeanUtil.isEmpty(list)) return;
		
		for(BpmInstData instData:list){
			String pk=instData.getPk();
			bpmFormInstManager.delete(pk);
			List<SysBoEnt> boEnts= sysBoEntManager.getListByBoDefId(instData.getBoDefId(),false);
			for(SysBoEnt boEnt:boEnts){
				String sql="";
				if("main".equals(boEnt.getRelationType())){
					sql="delete from " + boEnt.getTableName() + " where ID_=#{PK}" ;
				}
				else{
					sql="delete from " + boEnt.getTableName() + " where REF_ID_=#{PK}" ;
				}
				SqlModel sqlModel=new SqlModel(sql);
				sqlModel.addParam("PK", pk);
				commonDao.execute(sqlModel);
			}
		}
		
		//删除关联表数据。
		bpmInstDataDao.removeByInstId(instId);
	}
}
