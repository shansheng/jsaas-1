package com.redxun.oa.ats.manager;

import java.util.HashSet;
import java.util.Set;

import org.apache.commons.lang.StringUtils;

import com.redxun.oa.ats.entity.AtsAttenceCalculate;
import com.redxun.oa.ats.entity.AtsConstant;

public class AtsUtils {

	public static String getAttenceType(AtsAttenceCalculate calculate, String separator, boolean isShort) {
		if (StringUtils.isEmpty(calculate.getAttenceType()))
			return "";

		Set<String> set = new HashSet<String>();
		if (isShort) {
			getShortAttenceType(calculate, set);
		} else {
			getLongAttenceType(calculate, set);
		}

		return StringUtils.join(set, separator);
	}

	private static void getLongAttenceType(AtsAttenceCalculate calculate, Set<String> set) {
		String attenceType = calculate.getAttenceType();
		if (attenceType.contains(String.valueOf(AtsConstant.ATTENDANCE_TYPE_1_NORMAL)))
			set.add("第一段缺卡");
		if (attenceType.contains(String.valueOf(AtsConstant.ATTENDANCE_TYPE_1_NORMAL)))
			set.add("第一段正常");
		if (attenceType.contains(String.valueOf(AtsConstant.ATTENDANCE_TYPE_1_ABSENT)))
			set.add("第一段旷工");
		if (attenceType.contains(String.valueOf(AtsConstant.ATTENDANCE_TYPE_1_LATE)))
			set.add("第一段迟到");
		if (attenceType.contains(String.valueOf(AtsConstant.ATTENDANCE_TYPE_1_LEAVE)))
			set.add("第一段早退");

		if (attenceType.contains(String.valueOf(AtsConstant.ATTENDANCE_TYPE_2_ABSENT_CARD)))
			set.add("第二段缺卡");
		if (attenceType.contains(String.valueOf(AtsConstant.ATTENDANCE_TYPE_2_NORMAL)))
			set.add("第二段正常");
		if (attenceType.contains(String.valueOf(AtsConstant.ATTENDANCE_TYPE_2_ABSENT)))
			set.add("第二段旷工");
		if (attenceType.contains(String.valueOf(AtsConstant.ATTENDANCE_TYPE_2_LATE)))
			set.add("第二段迟到");
		if (attenceType.contains(String.valueOf(AtsConstant.ATTENDANCE_TYPE_2_LEAVE)))
			set.add("第二段早退");
		if (attenceType.contains(String.valueOf(AtsConstant.ATTENDANCE_TYPE_3_ABSENT_CARD)))
			set.add("第三段缺卡");
		if (attenceType.contains(String.valueOf(AtsConstant.ATTENDANCE_TYPE_3_NORMAL)))
			set.add("第三段正常");

		if (attenceType.contains(String.valueOf(AtsConstant.ATTENDANCE_TYPE_3_ABSENT)))
			set.add("第三段旷工");
		if (attenceType.contains(String.valueOf(AtsConstant.ATTENDANCE_TYPE_3_LATE)))
			set.add("第三段迟到");
		if (attenceType.contains(String.valueOf(AtsConstant.ATTENDANCE_TYPE_3_LEAVE)))
			set.add("第三段早退");
		if (attenceType.contains(String.valueOf(AtsConstant.ATTENDANCE_TYPE_HOLIDAY)))
			set.add("请假");
		if (attenceType.contains(String.valueOf(AtsConstant.ATTENDANCE_TYPE_TRIP)))
			set.add("出差");
		if (attenceType.contains(String.valueOf(AtsConstant.ATTENDANCE_TYPE_8_NORMAL)))
			set.add("休息日正常");
		if (attenceType.contains(String.valueOf(AtsConstant.ATTENDANCE_TYPE_9_NORMAL)))
			set.add("节假日正常");
	}

	private static void getShortAttenceType(AtsAttenceCalculate calculate, Set<String> set) {
		String attenceType = calculate.getAttenceType();
		if (attenceType.contains("000"))
			set.add("缺卡");
		if (attenceType.contains("001"))
			set.add("正常");
		if (attenceType.contains("002"))
			set.add("迟到");
		if (attenceType.contains("003"))
			set.add("早退");
		if (attenceType.contains("004"))
			set.add("旷工");
		if (attenceType.contains("005")){
			set.add("加班");
			//set.add(calculate.getOtRecord());
		}
		if (attenceType.contains("006")){
			set.add("请假");
			//set.add(calculate.getHolidayRecord());
		}
			
		if (attenceType.contains("007"))
			set.add("出差");
	}

}
