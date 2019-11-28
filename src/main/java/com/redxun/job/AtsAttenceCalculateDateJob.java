package com.redxun.job;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.quartz.JobExecutionContext;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.core.scheduler.BaseJob;
import com.redxun.core.util.AppBeanUtil;
import com.redxun.core.util.DateUtil;
import com.redxun.oa.ats.manager.AtsAttenceCalculateManager;
import com.redxun.oa.ats.manager.AtsAttendanceFileManager;
import com.redxun.oa.ats.manager.AtsCardRecordManager;
import com.redxun.saweb.util.WebAppUtil;
import com.redxun.wx.ent.entity.WxEntAgent;
import com.redxun.wx.ent.manager.WxEntAgentManager;
import com.redxun.wx.ent.util.WeixinUtil;
import com.redxun.wx.ent.util.model.SignParamModel;

public class AtsAttenceCalculateDateJob extends BaseJob {
	//考勤档案业务层
		private AtsAttendanceFileManager atsAttendanceFileManager = WebAppUtil.getBean(AtsAttendanceFileManager.class);
		private AtsCardRecordManager atsCardRecordManager = WebAppUtil.getBean(AtsCardRecordManager.class);
		private AtsAttenceCalculateManager atsAttenceCalculateManager = WebAppUtil.getBean(AtsAttenceCalculateManager.class);
		
		@Override
		public void executeJob(JobExecutionContext context) {
			try {
				Map paramsMap=context.getJobDetail().getJobDataMap();
				String agentId=(String) paramsMap.get("agentId");
				Integer year = Integer.parseInt(paramsMap.get("year").toString());
				Integer month = Integer.parseInt(paramsMap.get("month").toString());
				WxEntAgentManager wxEntAgentManager =AppBeanUtil.getBean(WxEntAgentManager.class);
				WxEntAgent agent=wxEntAgentManager.get(agentId);
				
				String tenantId = (String) paramsMap.get("tenantId");
				String corpId=agent.getCorpId();
				String secret=agent.getSecret();
				
				SignParamModel model=new SignParamModel();
				
				 //获取当前月第一天：
		        Calendar c = Calendar.getInstance();
		        c.set(year, month-1, 1);
		        //获取当前月最后一天
		        Calendar ca = Calendar.getInstance();
		        ca.set(year, month-1, 1);
		        ca.set(Calendar.DAY_OF_MONTH, ca.getActualMaximum(Calendar.DAY_OF_MONTH));  

		        //录入这个月的考勤
				model.setStartDate(c.getTime());
				model.setEndDate(ca.getTime());
				
				//获取参与考勤的人员
				List<String> users = atsAttendanceFileManager.getAttendance();
				int size = 100;
				for(int j =0; j<=users.size()/size;j++) {
					List<String> temp = new ArrayList<String>();
					for (int i = j*size; i < (j+1)*size; i++) {
						if(i==users.size()) {
							break;
						}
						temp.add(users.get(i));
					}
					model.setUserIds(temp);
					
					String str= WeixinUtil.getSignData(corpId, secret, model);
					JSONObject json = JSON.parseObject(str);
					JSONArray array = json.getJSONArray("checkindata");
					
					for (Object object : array) {
						JSONObject obj = (JSONObject) object;
						atsCardRecordManager.save(obj);
					}
				}
				atsAttenceCalculateManager.allCalculate(model.getStartDate(), model.getEndDate(),tenantId);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		private Date getWeekDay(int day){
			Calendar cal = Calendar.getInstance(Locale.CHINA);
			cal.setFirstDayOfWeek(Calendar.MONDAY);
			cal.set(Calendar.DAY_OF_WEEK, day);
			return cal.getTime();
		}

}
