package com.redxun.oa.ats.manager.impl;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.DateUtil;
import com.redxun.oa.ats.dao.AtsAttenceCalculateDao;
import com.redxun.oa.ats.entity.AtsAttenceCalculate;
import com.redxun.oa.ats.entity.AtsConstant;
import com.redxun.oa.ats.entity.AtsHolidayType;
import com.redxun.oa.ats.manager.AtsHolidayTypeManager;
import com.redxun.oa.ats.manager.CalcModel;
import com.redxun.oa.ats.manager.IAtsExtCalcService;

/**
 * 考勤请假计算
 * @author Administrator
 *
 */
public class LeaveCalcService implements IAtsExtCalcService {
	
	/**
	 * 表名
	 */
	String tableName;
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public String getTableName() {
		return tableName;
	}
	/**
	 * 条件字段
	 */
	Map<String,String> fileds;
	public void setFileds(Map<String,String> fileds) {
		this.fileds = fileds;
	}
	public Map<String,String> getFileds() {
		return fileds;
	}
	
	
	@Resource
	JdbcTemplate jdbcTemplate;
	@Resource
	private AtsAttenceCalculateDao atsAttenceCalculateDao;
	@Resource
	private AtsHolidayTypeManager atsHolidayTypeManager;
	
	@Override
	public List<AtsAttenceCalculate> calculate(CalcModel atsModel)
			throws Exception {
		String fileId = atsModel.getFileId();
		//开始时间
		Date startTime = atsModel.getStartTime();
		List<Map<String, Object>> maps = getDate(atsModel,startTime);
		List<AtsAttenceCalculate> list = new ArrayList<AtsAttenceCalculate>();
		
		for (Map<String, Object> map : maps) { 
			//获取今天存在的计算，要修改它
			AtsAttenceCalculate calculate = atsAttenceCalculateDao.getByFileIdAttenceTime(fileId, startTime);
			if (BeanUtil.isEmpty(calculate)) {
				continue;
			}
			//String type = (String) map.get("F_QJYY");//假期类型
			Date start = (Date) map.get(fileds.get("startTime"));
			Date end = (Date) map.get(fileds.get("endTime"));
			//获取假期
			String typeName = (String) map.get(fileds.get("title"));
			
			JSONArray array = JSONArray.parseArray(calculate.getShiftTime());
			JSONObject obj = (JSONObject) array.get(0);
			DateFormat df = new SimpleDateFormat(DateUtil.DATE_FORMAT_FULL);
			Date onTime = df.parse(obj.get("onTime").toString());
			Date offTime = df.parse(obj.get("offTime").toString());
			
			double hour =  DateUtil.betweenHour(start, end);
			if(DateUtil.daysBetween(startTime, start)==0) {
				offTime = DateUtil.addDay(offTime, DateUtil.daysBetween(offTime, start)+1);
				if(end.after(offTime)) {
					hour = DateUtil.betweenHour(start, offTime);
				}
			}else if(DateUtil.isBetween(start, end, startTime)) {
				hour = calculate.getShouldAttenceHours();
			}else if(DateUtil.daysBetween(startTime, end)==0) {
				if(DateUtil.daysBetween(start, end)!=0) {
					onTime = DateUtil.addDay(onTime, DateUtil.daysBetween(onTime, startTime)+1);
					hour = DateUtil.betweenHour(onTime, end);
				}
			}else {
				if(DateUtil.daysBetween(offTime, end)!=0) {
					continue;
				}
			}
			
			calculate.setAbsentNumber((double)0);
			calculate.setLateNumber((double)0);
			calculate.setLeaveNumber((double)0);
			calculate.setHolidayName(typeName);
			calculate.setHolidayRecord("" + typeName + " " + hour + "(小时)");
			calculate.setHolidayTime((double) hour * 60);
			calculate.setHolidayNumber((double) 1);
			String attenceType = AtsConstant.ATTENDANCE_TYPE_HOLIDAY + "";
			calculate.setAttenceType(attenceType);
			
			AtsHolidayType atsHolidayType = atsHolidayTypeManager.getByName(typeName);
			Integer abnormity = null;
			if(atsHolidayType!=null) {
				abnormity = atsHolidayType.getAbnormity();
			}
			if(abnormity==null || abnormity==-1){//假期是异常
				calculate.setAbnormity(AtsAttenceCalculate.AbnormityType.abnormity);
			}else if(abnormity==0 && hour >= calculate.getShouldAttenceHours()){
				calculate.setAbnormity(AtsAttenceCalculate.AbnormityType.normal);
			}
			
			list.add(calculate);
		}
		
		atsModel.setMapList(maps);//其他属性,供外部调用
		
		return list;
	}
	
	private List<Map<String, Object>> getDate(CalcModel atsModel, Date endTime){
		//用户ID
		String userId = atsModel.getUserId();
		
		String filed = fileds.get("userId")+ "," +
					   fileds.get("startTime")+ "," +
					   fileds.get("endTime")+ "," +
					   fileds.get("title");
		String sql = "select "+ filed +" from "+ tableName +" where DATE_ADD(?,INTERVAL -1 DAY) < DATE_FORMAT("+fileds.get("startTime")+",'%Y-%m-%d') and DATE_ADD(?,INTERVAL 1 DAY) >= DATE_FORMAT("+fileds.get("endTime")+",'%Y-%m-%d')  and "+fileds.get("userId") +" = ?"
				+ " order by F_KSSJ desc";
	
		String end = new SimpleDateFormat("YYYY-MM-dd").format(endTime);
		Object[] args = new Object[]{end,end, userId};
		//调用方法获得记录数
		List<Map<String, Object>> count;
		try {
			count = jdbcTemplate.queryForList(sql, args);
		} catch (DataAccessException e) {
			return new ArrayList<Map<String, Object>>();
		}
		if(BeanUtil.isNotEmpty(count)){
			atsModel.setIsSuccess(true);
		}
		
		return count;
	}
	@Override
	public List<Map<String,Object>> getCalTime(CalcModel atsModel) {
		//开始时间
		Date start = atsModel.getStartTime();
		List<Map<String,Object>> list = getDate(atsModel, start);
		
		List<Map<String,Object>> list1 = new ArrayList<Map<String,Object>>();
		for (Map<String, Object> map : list) {
			Map<String, Object> map1 = new HashMap<String,Object>();
			map1.put("startTime", map.get(fileds.get("startTime")));
			map1.put("endTime", map.get(fileds.get("endTime")));
			list1.add(map1);
		}
		
		return list1;
	}
	
}
