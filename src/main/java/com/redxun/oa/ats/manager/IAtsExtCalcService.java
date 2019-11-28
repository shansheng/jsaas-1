package com.redxun.oa.ats.manager;

import java.util.List;
import java.util.Map;

import com.redxun.oa.ats.entity.AtsAttenceCalculate;

/**
 * 计算接口
 * @author Administrator
 *
 */
public interface IAtsExtCalcService {
	/**
	 * 
	 * 返回请假/加班/出差 是否成功
	 * 
	 * @param atsModel
	 		中的 useId和开始、结束时间必填
	 * @throws Exception
	 */
	List<AtsAttenceCalculate> calculate(CalcModel atsModel) throws Exception;
	
	List<Map<String,Object>> getCalTime(CalcModel atsModel);

}
