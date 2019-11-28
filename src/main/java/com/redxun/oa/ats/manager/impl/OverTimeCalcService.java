package com.redxun.oa.ats.manager.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.jdbc.core.JdbcTemplate;

import com.redxun.oa.ats.entity.AtsAttenceCalculate;
import com.redxun.oa.ats.manager.CalcModel;
import com.redxun.oa.ats.manager.IAtsExtCalcService;

public class OverTimeCalcService implements IAtsExtCalcService{
	@Resource
	JdbcTemplate jdbcTemplate;
	

	@Override
	public List<AtsAttenceCalculate> calculate(CalcModel atsModel) throws Exception {
		return null;
	}


	@Override
	public List<Map<String, Object>> getCalTime(CalcModel atsModel) {
		return null;
	}

}
