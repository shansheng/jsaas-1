
package com.airdrop.wxrepair.core.manager;
import com.airdrop.wxrepair.core.dao.PatrolRecordImageDao;
import com.airdrop.wxrepair.core.entity.PatrolRecordImage;
import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.saweb.util.IdUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * 
 * <pre> 
 * 描述：巡检图片上传 处理接口
 * 作者:zpf
 * 日期:2019-10-24 14:54:56
 * 版权：麦希影业
 * </pre>
 */
@Service
public class PatrolRecordImageManager extends MybatisBaseManager<PatrolRecordImage>{
	
	@Resource
	private PatrolRecordImageDao patrolRecordImageDao;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return patrolRecordImageDao;
	}
	
	
	
	public PatrolRecordImage getPatrolRecordImage(String uId){
		PatrolRecordImage patrolRecordImage = get(uId);
		return patrolRecordImage;
	}
	

	
	
	@Override
	public void create(PatrolRecordImage entity) {
		entity.setId(IdUtil.getId());
		super.create(entity);
		
	}

	@Override
	public void update(PatrolRecordImage entity) {
		super.update(entity);
		
		
		
		
	}

	public void delByRefId(String rId){
		patrolRecordImageDao.delByRefId(rId);
	}

	public List<PatrolRecordImage> getImageByRefId(String rId){
		return patrolRecordImageDao.getImageByRefId(rId);
	}
}
