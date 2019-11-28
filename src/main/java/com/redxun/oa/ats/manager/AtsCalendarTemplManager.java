
package com.redxun.oa.ats.manager;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.util.BeanUtil;
import com.redxun.oa.ats.dao.AtsCalendarTemplDao;
import com.redxun.oa.ats.dao.AtsCalendarTemplDetailDao;
import com.redxun.oa.ats.entity.AtsCalendarTempl;
import com.redxun.oa.ats.entity.AtsCalendarTemplDetail;
import com.redxun.saweb.util.IdUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * 
 * <pre> 
 * 描述：日历模版 处理接口
 * 作者:mansan
 * 日期:2018-03-22 09:49:46
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class AtsCalendarTemplManager extends MybatisBaseManager<AtsCalendarTempl>{
	@Resource
	private AtsCalendarTemplDao atsCalendarTemplDao;
	
	@Resource
	private AtsCalendarTemplDetailDao atsCalendarTemplDetailDao;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return atsCalendarTemplDao;
	}
	
	
	
	public AtsCalendarTempl getAtsCalendarTempl(String uId){
		AtsCalendarTempl atsCalendarTempl = get(uId);
		if(BeanUtil.isNotEmpty(atsCalendarTempl)) {
			List<AtsCalendarTemplDetail> details= atsCalendarTemplDetailDao.getByCalId(uId);
			atsCalendarTempl.setAtsCalendarTemplDetails(details);
		}
		return atsCalendarTempl;
	}
	
	/**
	 * 保存 日历模版 信息
	 * 
	 * @param atsCalendarTempl
	 */
	public void save(AtsCalendarTempl atsCalendarTempl) {
		this.create(atsCalendarTempl);
		String uId = atsCalendarTempl.getId();
		JSONArray jary = JSONArray.fromObject(atsCalendarTempl.getAtsCalendarTemplDetails());
		for (Object obj : jary) {
			JSONObject json = (JSONObject) obj;
			String week = String.valueOf(json.get("week"));
			String dayType = String.valueOf(json.get("dayType"));
			AtsCalendarTemplDetail ctd = new AtsCalendarTemplDetail();
			ctd.setWeek(Short.parseShort(week));
			ctd.setDayType(Short.parseShort(dayType));
			ctd.setCalendarId(uId);
			ctd.setId(IdUtil.getId());
			atsCalendarTemplDetailDao.create(ctd);
		}

	}

	public void updateCalendar(AtsCalendarTempl atsCalendarTempl) {
		this.update(atsCalendarTempl);
		atsCalendarTemplDetailDao.delByMainId(atsCalendarTempl.getId());
		for(AtsCalendarTemplDetail detail : atsCalendarTempl.getAtsCalendarTemplDetails()){
			detail.setId(IdUtil.getId());
			detail.setCalendarId(atsCalendarTempl.getId());
			atsCalendarTemplDetailDao.create(detail);
		}
		
	}

	public List<?> getDetail(QueryFilter queryFilter) {
		return atsCalendarTemplDetailDao.getAll(queryFilter);
	}

}
