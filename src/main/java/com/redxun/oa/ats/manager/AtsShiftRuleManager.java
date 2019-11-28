
package com.redxun.oa.ats.manager;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.util.BeanUtil;
import com.redxun.oa.ats.dao.AtsShiftRuleDao;
import com.redxun.oa.ats.dao.AtsShiftRuleDetailDao;
import com.redxun.oa.ats.entity.AtsShiftInfo;
import com.redxun.oa.ats.entity.AtsShiftRule;
import com.redxun.oa.ats.entity.AtsShiftRuleDetail;
import com.redxun.saweb.util.IdUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * 
 * <pre> 
 * 描述：轮班规则 处理接口
 * 作者:mansan
 * 日期:2018-03-26 16:50:46
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class AtsShiftRuleManager extends MybatisBaseManager<AtsShiftRule>{
	@Resource
	private AtsShiftRuleDao atsShiftRuleDao;
	@Resource
	private AtsShiftRuleDetailDao atsShiftRuleDetailDao;
	@Resource
	private AtsShiftInfoManager atsShiftInfoManager;
	@Resource
	private AtsShiftTimeManager atsShiftTimeManager;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return atsShiftRuleDao;
	}
	

	
	public AtsShiftRule getAtsShiftRule(String uId){
		AtsShiftRule atsShiftRule = get(uId);
		if(atsShiftRule!=null) {
			List<AtsShiftRuleDetail> atsShiftRuleDetail= atsShiftRuleDetailDao.getAtsShiftRuleDetailList(uId);
			atsShiftRule.setAtsShiftRuleDetails(atsShiftRuleDetail);
		}
		return atsShiftRule;
	}

	public void save(AtsShiftRule atsShiftRule) {
		atsShiftRuleDao.create(atsShiftRule);
		String uId = atsShiftRule.getId();
		
		int sn = 1;
		List<AtsShiftRuleDetail> list = atsShiftRule.getAtsShiftRuleDetails();
		for (AtsShiftRuleDetail atsShiftRuleDetail : list) {
			atsShiftRuleDetail.setRuleId(uId);
			atsShiftRuleDetail.setId(IdUtil.getId());
			atsShiftRuleDetail.setSn(sn);
			sn = sn==7?1:sn+1;
			atsShiftRuleDetailDao.create(atsShiftRuleDetail);
		}
	}

	public void updateShiftRule(AtsShiftRule atsShiftRule) {
		atsShiftRuleDao.update(atsShiftRule);
		String uId = atsShiftRule.getId();
		atsShiftRuleDetailDao.delByMainId(uId);
		
		int sn = 1;
		List<AtsShiftRuleDetail> list = atsShiftRule.getAtsShiftRuleDetails();
		for (AtsShiftRuleDetail atsShiftRuleDetail : list) {
			atsShiftRuleDetail.setRuleId(uId);
			atsShiftRuleDetail.setId(IdUtil.getId());
			atsShiftRuleDetail.setSn(sn);
			sn = sn==7?1:sn+1;
			atsShiftRuleDetailDao.create(atsShiftRuleDetail);
		}
	}

	public String getDetailList(String id) {
		List<AtsShiftRuleDetail> list = atsShiftRuleDetailDao.getAtsShiftRuleDetailList(id);
		JSONArray jary = new JSONArray();
		for (AtsShiftRuleDetail srd : list) {
			JSONObject json = new JSONObject();
			String shiftId = srd.getShiftId();
			
			String shiftId1 = "";
			String shiftCode = "";
			String shiftName = "";
			String shiftTime = "";
			if(BeanUtil.isNotEmpty(shiftId)){
				AtsShiftInfo atsShiftInfo = atsShiftInfoManager.get(shiftId);
				shiftId1 = shiftId.toString();
				shiftTime = atsShiftTimeManager.getShiftTime(shiftId);
				shiftCode = atsShiftInfo.getCode();
				shiftName = atsShiftInfo.getName();
			}
			
			json.accumulate("sn", srd.getSn().toString());
			json.accumulate("dateType", srd.getDateType().toString());
			json.accumulate("shiftId",shiftId1);
			json.accumulate("shiftCode",shiftCode);
			json.accumulate("shiftName",shiftName);
		
			json.accumulate("shiftTime",shiftTime);
			jary.add(json);
		}
		return jary.toString();
	}
}
