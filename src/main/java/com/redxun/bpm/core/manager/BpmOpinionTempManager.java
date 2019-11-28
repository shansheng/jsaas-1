
package com.redxun.bpm.core.manager;
import javax.annotation.Resource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.bpm.core.dao.BpmOpinionTempDao;
import com.redxun.bpm.core.dao.BpmOpinionTempDao;
import com.redxun.bpm.core.entity.BpmOpinionTemp;
import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.core.manager.ExtBaseManager;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.saweb.util.IdUtil;
import com.sun.mail.imap.protocol.UID;

/**
 * 
 * <pre> 
 * 描述：BPM_OPINION_TEMP 处理接口
 * 作者:mansan
 * 日期:2017-09-26 18:02:24
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class BpmOpinionTempManager extends MybatisBaseManager<BpmOpinionTemp>{
	@Resource
	private BpmOpinionTempDao bpmOpinionTempDao;
	
	@Resource
	JdbcTemplate jdbcTemplate;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return bpmOpinionTempDao;
	}
	
 
	
	public BpmOpinionTemp getBpmOpinionTemp(String uId){
		BpmOpinionTemp bpmOpinionTemp = get(uId);
		return bpmOpinionTemp;
	}
	
	public void createTemp(String type,String typeId,String opinion,String attachment){
		bpmOpinionTempDao.delTemp(type, typeId);
		BpmOpinionTemp temp = new BpmOpinionTemp();
		temp.setId(IdUtil.getId());
		temp.setType(type);
		temp.setInstId(typeId);
		temp.setOpinion(opinion);
		temp.setAttachment(attachment);
		create(temp);
	}
	
	public BpmOpinionTemp getByType(String type,String typeId){
		BpmOpinionTemp opinionTemp= bpmOpinionTempDao.getByType(type, typeId);
		if(opinionTemp==null){
			opinionTemp=new BpmOpinionTemp();
		}
		return opinionTemp;
	}

	public int deleteByInst(String instId) {
		String sql = "DELETE FROM bpm_opinion_temp WHERE INST_ID_=?";
		int result = jdbcTemplate.update(sql, instId);
		return result;
	}
}
