
/**
 * 
 * <pre> 
 * 描述：巡检图片上传 DAO接口
 * 作者:zpf
 * 日期:2019-10-24 14:54:56
 * 版权：麦希影业
 * </pre>
 */
package com.airdrop.wxrepair.core.dao;

import com.airdrop.wxrepair.core.entity.PatrolRecordImage;
import com.redxun.core.dao.mybatis.BaseMybatisDao;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class PatrolRecordImageDao extends BaseMybatisDao<PatrolRecordImage> {

	@Override
	public String getNamespace() {
		return PatrolRecordImage.class.getName();
	}
	
	public void delByRefId(String rId){
		this.deleteBySqlKey("delByRefId",rId);
	}

	public List<PatrolRecordImage> getImageByRefId(String rId){
		return this.getBySqlKey("getByRefId",rId);
	}
}

