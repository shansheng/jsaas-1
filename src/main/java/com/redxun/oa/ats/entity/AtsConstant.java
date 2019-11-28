package com.redxun.oa.ats.entity;

/**
 * 考勤管理常量
 * @author zxh
 *
 */
public interface AtsConstant {

	/** 是*/
	short YES = 1;
	
	/** 否*/
	short NO = 0;
	
	/**日期类型-工作日 */
	short DATE_TYPE_WORKDAY =1;
	/**日期类型-休息日*/
	short DATE_TYPE_DAYOFF =2;
	/**日期类型-法定假日*/
	short DATE_TYPE_HOLIDAY =3;
	
	/**日期类型-工作日 */
	String DATE_TYPE_WORKDAY_STRING ="工作日";
	/**日期类型-休息日*/
	String DATE_TYPE_DAYOFF_STRING  ="休息日";
	/**日期类型-法定假日*/
	String DATE_TYPE_HOLIDAY_STRING  ="法定假日";
	
	String NO_SHIFT = "未排班";
	
	//背景颜色
	String BACKGROUND_COLOR_WORKDAY = "#337ab7";
	String BACKGROUND_COLOR_DAYOFF = "#000000";
	String BACKGROUND_COLOR_HOLIDAY = "#257e4a";
	
	/**节假日处理方式-替换*/
	short HOLIDAY_HANDLE_REPLACE = 1;
	/**节假日处理方式-不替换*/
	short HOLIDAY_HANDLE_NOREPLACE = 2;
	/**节假日处理方式-顺延*/
	short HOLIDAY_HANDLE_POSTPONE =3;
	
	/**段次1*/
	short SEGMENT_1 = 1;
	/**段次2*/
	short SEGMENT_2 = 2;
	/**段次3*/
	short SEGMENT_3 = 3;
	
	//该段最早卡
	short CARD_FIRST = 1;
	//该段最晚卡
	short CARD_LATEST = 2;
	
	/**上班*/
	short ATTENCE_TYPE_ON =1;
	/**下班*/
	short ATTENCE_TYPE_OFF =2;
	
	/**
	 * 手工分配
	 */
	short ASSIGN_TYPE_HAND =1;
	/**
	 * 最近打卡点
	 */
	short ASSIGN_TYPE_NEAR = 2;
	
	/**
	 * 分配段次-上一段
	 */
	short ASSIGN_SEGMENT_PRE= 1;
	/**
	 * 分配段次-下一段
	 */
	short ASSIGN_SEGMENT_NEXT= 2;

	/**
	 * 缺卡
	 */
	short TIME_TYPE_ABSENT_CARD = 0;
	/**正常打卡*/
	short TIME_TYPE_NORMAL = 1;
	/**迟到 */
	short TIME_TYPE_LATE = 2;
	/** 早退 */
	short TIME_TYPE_LEAVE = 3;
	/**旷工 */
	short TIME_TYPE_ABSENT = 4;
	/**加班 */
	short TIME_TYPE_OT = 5;
	/** 请假 */
	short TIME_TYPE_HOLIDAY = 6;
	/** 出差*/
	short TIME_TYPE_TRIP = 7;

	
	
	
	/**打卡类型-- 异常打卡不计异常*/
	short  CARD_NORMAL_ABNORMA= 2;	
	
	
	
	/**
	 * 考勤类型-正常出勤
	 */
	short ATTENDANCE_TYPE_NORMAL = 0;

	/**
	 * 考勤类型-固定加班
	 */
	short ATTENDANCE_TYPE_REGULAR_OT =1;
	/**
	 * 考勤类型-正常出勤不计异常
	 */
	short ATTENDANCE_TYPE_NORMAL_ABNORMAL =2;
	/**
	 * 考勤类型-固定加班不计异常
	 */
	short ATTENDANCE_TYPE_REGULAR_OT_ABNORMAL =3;
	
	//昨天
	short  TIME_YESTERDAY = 1;
	//今天
	short  TIME_TODAY = 2;
	//明天
	short  TIME_TOMORROW =3;
	
	///===========================
	
	/**
	 * 第一段  缺卡
	 */
	int ATTENDANCE_TYPE_1_ABSENT_CARD = 1000;
	/**
	 * 第一段 正常考勤
	 */
	int ATTENDANCE_TYPE_1_NORMAL = 1001;
	/**
	 * 第一段 迟到
	 */
	int ATTENDANCE_TYPE_1_LATE = 1002;
	/**
	 * 第一段  早退
	 */
	int ATTENDANCE_TYPE_1_LEAVE = 1003;
	
	/**
	 * 第一段  旷工
	 */
	int ATTENDANCE_TYPE_1_ABSENT = 1004;

	
	/**
	 * 第二段 正常考勤
	 */
	int ATTENDANCE_TYPE_2_NORMAL = 2001;
	/**
	 * 第二段 迟到
	 */
	int ATTENDANCE_TYPE_2_LATE = 2002;
	/**
	 * 第二段  早退
	 */
	int ATTENDANCE_TYPE_2_LEAVE = 2003;
	
	/**
	 * 第二段  旷工
	 */
	int ATTENDANCE_TYPE_2_ABSENT = 2004;
	/**
	 * 第二段  缺卡
	 */
	int ATTENDANCE_TYPE_2_ABSENT_CARD = 2000;
	/**
	 * 第三段  缺卡
	 */
	int ATTENDANCE_TYPE_3_ABSENT_CARD = 3000;
	/**
	 * 第三段 正常考勤
	 */
	int ATTENDANCE_TYPE_3_NORMAL = 3001;
	/**
	 * 第三段 迟到
	 */
	int ATTENDANCE_TYPE_3_LATE = 3002;
	/**
	 * 第三段  早退
	 */
	int ATTENDANCE_TYPE_3_LEAVE = 3003;
	


	/**
	 * 第三段  旷工
	 */
	int ATTENDANCE_TYPE_3_ABSENT = 3004;
	/**
	 * 日常加班
	 */
	int ATTENDANCE_TYPE_OT  = 6005;
	/**
	 * 请假 
	 */
	int ATTENDANCE_TYPE_HOLIDAY  = 6006;
	/**
	 * 出差 
	 */
	int ATTENDANCE_TYPE_TRIP  = 6007;
	/**
	 * 休息日  缺卡
	 */
	int ATTENDANCE_TYPE_8_ABSENT_CARD = 8000;
	/**
	 *休息日  正常考勤
	 */
	int ATTENDANCE_TYPE_8_NORMAL = 8001;
	/**
	 * 休息日 迟到
	 */
	int ATTENDANCE_TYPE_8_LATE = 8002;
	/**
	 * 休息日   早退
	 */
	int ATTENDANCE_TYPE_8_LEAVE = 8003;
	
	/**
	 * 休息日  旷工
	 */
	int ATTENDANCE_TYPE_8_ABSENT = 8004;
	
	/**
	 * 休息日 加班
	 */
	int ATTENDANCE_TYPE_8_OT  = 8005;
	
	/**
	 * 节假日  缺卡
	 */
	int ATTENDANCE_TYPE_9_ABSENT_CARD = 9000;
	/**
	 *  节假日   正常考勤
	 */
	int ATTENDANCE_TYPE_9_NORMAL = 9001;
	/**
	 *  节假日   迟到
	 */
	int ATTENDANCE_TYPE_9_LATE = 9002;
	/**
	 * 节假日    早退
	 */
	int ATTENDANCE_TYPE_9_LEAVE = 9003;
	
	/**
	 * 节假日  旷工
	 */
	int ATTENDANCE_TYPE_9_ABSENT = 9004;
	
	/**
	 * 休息日 加班
	 */
	int ATTENDANCE_TYPE_9_OT  =9005;

}
