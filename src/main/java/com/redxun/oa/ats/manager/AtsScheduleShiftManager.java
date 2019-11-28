
package com.redxun.oa.ats.manager;
import java.io.InputStream;
import java.lang.reflect.InvocationTargetException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.DateFormatUtil;
import com.redxun.core.util.DateUtil;
import com.redxun.core.util.ExcelUtil;
import com.redxun.core.util.MsgUtil;
import com.redxun.oa.ats.dao.AtsScheduleShiftDao;
import com.redxun.oa.ats.entity.AtsAttendanceFile;
import com.redxun.oa.ats.entity.AtsConstant;
import com.redxun.oa.ats.entity.AtsScheduleShift;
import com.redxun.oa.ats.entity.AtsShiftInfo;
import com.redxun.saweb.util.IdUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * 
 * <pre> 
 * 描述：排班列表 处理接口
 * 作者:mansan
 * 日期:2018-03-21 16:05:40
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class AtsScheduleShiftManager extends MybatisBaseManager<AtsScheduleShift>{
	@Resource
	private AtsScheduleShiftDao atsScheduleShiftDao;
	@Resource
	private AtsShiftInfoManager atsShiftInfoManager;
	@Resource
	private AtsAttendanceFileManager atsAttendanceFileManager;
	@Resource
	private AtsLegalHolidayDetailManager atsLegalHolidayDetailManager;
	@Resource
	private AtsShiftTypeManager atsShiftTypeManager;
	@Resource
	private AtsAttencePolicyManager atsAttencePolicyManager;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return atsScheduleShiftDao;
	}
	
	
	
	public AtsScheduleShift getAtsScheduleShift(String uId){
		AtsScheduleShift atsScheduleShift = get(uId);
		return atsScheduleShift;
	}

	public List<AtsScheduleShift> save(JSONArray userJsonAry,
			JSONArray listRowDatasJson,
			Short shiftType) throws Exception{
		List<AtsScheduleShift> list = new ArrayList<AtsScheduleShift>();
		
		if (shiftType == 1) { // 日历排班
			this.saveCalendar(userJsonAry, listRowDatasJson, list);
		} else { // 列表排班
			this.saveList(userJsonAry, listRowDatasJson, list);
		}
		
		return list;
	}

	/**
	 * 保存日历
	 * 
	 * @param userJsonAry
	 * @param listRowDatasJson
	 * @param attencePolicyName
	 * @param list
	 * @throws Exception
	 */
	private void saveCalendar(JSONArray userJsonAry, JSONArray listRowDatasJson, List<AtsScheduleShift> list) throws Exception {
		for (Object userObj : userJsonAry) {
			JSONObject userJson = (JSONObject) userObj;
			for (Object eventObj : listRowDatasJson) {
				JSONObject eventJson = (JSONObject) eventObj;
				this.saveAtsScheduleShift(eventJson, userJson, list);
			}
		}
	}
	
	/**
	 * 保存列表
	 * 
	 * @param userJsonAry
	 * @param listRowDatasJson
	 * @param attencePolicyName
	 * @param list
	 * @throws Exception
	 */
	private void saveList(JSONArray userJsonAry, JSONArray listRowDatasJson, List<AtsScheduleShift> list) throws Exception {
		Map<String, JSONObject> map = new HashMap<String, JSONObject>();

		for (Object userObj : userJsonAry) {
			JSONObject json = (JSONObject) userObj;
			Object id = json.get("id");
			map.put(id.toString(), json);
		}

		for (Object listObj : listRowDatasJson) {
			JSONObject listJson = (JSONObject) listObj;
			Object fileId = listJson.get("fileId");
			JSONObject userJson = map.get(fileId.toString());
			if (userJson==null) continue;
			Iterator<?> it = listJson.keys();
			while (it.hasNext()) {
				String key = (String) it.next();
				if (key.equals("account") || key.equals("userName") || key.equals("fileId")||key.equals("_id")||key.equals("_uid")||key.equals("index"))
					continue;
				JSONObject json = (JSONObject) listJson.get(key);
				this.saveAtsScheduleShift(json, userJson, list);
			}
		}
	}
	
	/**
	 * 保存编排的数据
	 * 
	 * @param json
	 * @param userJson
	 * @param attencePolicyName
	 * @param list
	 * @throws ParseException
	 */
	private void saveAtsScheduleShift(JSONObject json, JSONObject userJson, List<AtsScheduleShift> list) throws Exception {
		Object obj = userJson.get("fileId");
		String fileId = obj.toString();

		Object start = json.get("start");
		Object dateType = json.get("dateType");
		if (BeanUtil.isEmpty(start) || BeanUtil.isEmpty(dateType))
			return;
		Date attenceTime = DateFormatUtil.parseDate(start.toString());
		Short dateType1 = 2;
		if (BeanUtil.isNotEmpty(dateType.toString()))
			dateType1 = Short.valueOf(dateType.toString());
		Object shiftId = json.get("shiftId");

		AtsScheduleShift atsScheduleShift = new AtsScheduleShift();

		atsScheduleShift.setFileId(fileId);
		atsScheduleShift.setDateType(dateType1);
		atsScheduleShift.setAttenceTime(attenceTime);
		String shiftId1 = null;
		if (BeanUtil.isNotEmpty(shiftId) ) {
			if (!shiftId.equals("null"))
				shiftId1 = shiftId.toString();
		}

		if (dateType1 == 3) { // 节假日
			String holidayName = (String) json.get("holidayName");
			atsScheduleShift.setTitle(holidayName);
		}
		atsScheduleShift.setShiftId(shiftId1);
		this.saveData(atsScheduleShift);

		// 处理返回页面展示
		handerList(list, atsScheduleShift, userJson);

	}
	
	/**
	 * 保存编排的数据
	 * 
	 * @param atsScheduleShift
	 * @throws InvocationTargetException 
	 * @throws IllegalAccessException 
	 */
	private void saveData(AtsScheduleShift atsScheduleShift) throws Exception {
		AtsScheduleShift ass = atsScheduleShiftDao.getByFileIdAttenceTime(atsScheduleShift.getFileId(), atsScheduleShift.getAttenceTime());
		if (BeanUtil.isEmpty(ass)) {
			atsScheduleShift.setId(IdUtil.getId());
			atsScheduleShiftDao.create(atsScheduleShift);
			atsScheduleShift.setId(null);
		} else {
			BeanUtil.copyNotNullProperties(ass, atsScheduleShift);
			if (BeanUtil.isEmpty(atsScheduleShift.getShiftId()))
				ass.setShiftId(null);
			atsScheduleShiftDao.update(ass);
		}
	}
	
	/**
	 * 处理返回页面展示
	 * 
	 * @param list
	 * @param atsScheduleShift
	 * @param userJson
	 * @param attencePolicyName
	 */
	private void handerList(List<AtsScheduleShift> list, AtsScheduleShift atsScheduleShift, JSONObject userJson) {
		Object userName = userJson.get("fullName");
		Object orgName = userJson.get("orgName");
		Object cardNumber = userJson.get("userNo");

		if (BeanUtil.isNotEmpty(userName))
			atsScheduleShift.setFullName(userName.toString());
		if (BeanUtil.isNotEmpty(orgName))
			atsScheduleShift.setOrgName(orgName.toString());
		if (BeanUtil.isNotEmpty(cardNumber))
			atsScheduleShift.setCardNumber(cardNumber.toString());
		
		String attencePolicyName = atsAttencePolicyManager.getAtsAttencePolicyName(userName);
		
		atsScheduleShift.setAttencePolicyName(attencePolicyName);
		list.add(atsScheduleShift);

	}

	public Map<String, AtsScheduleShift> getByFileIdStartEndTimeMap(
			String fileId, Date startTime, Date endTime) {
		List<AtsScheduleShift> list = atsScheduleShiftDao.getByFileIdStartEndTime(fileId, startTime, endTime);
		Map<String, AtsScheduleShift> map = new HashMap<String, AtsScheduleShift>();
		for (AtsScheduleShift atsScheduleShift : list) {
			// 取到排班信息
			if (BeanUtil.isNotEmpty(atsScheduleShift.getShiftId()) ) {
				AtsShiftInfo atsShiftInfo = atsShiftInfoManager.get(atsScheduleShift.getShiftId());
				atsScheduleShift.setAtsShiftInfo(atsShiftInfo);
			}
			map.put(DateFormatUtil.formatDate(atsScheduleShift.getAttenceTime()), atsScheduleShift);
		}
		return map;
	}

	public AtsScheduleShift getByFileIdAttenceTime(String fileId, Date attenceTime) {
		return atsScheduleShiftDao.getByFileIdAttenceTime(fileId, attenceTime);
	}

	public void importExcel(InputStream inputStream, String fileExt, int template) throws Exception {
		Workbook workbook = null;
		if (fileExt.equalsIgnoreCase(".xls")) {// 针对2003版本
			workbook = new HSSFWorkbook(new POIFSFileSystem(inputStream));
		} else {
			workbook = new XSSFWorkbook(inputStream); // 针对2007版本
		}
		HSSFSheet st = (HSSFSheet) workbook.getSheetAt(0);
		
		if (template == 1)//列表模式
			handrimportExceltemplate1(st);
		else//日历模式
			handrimportExceltemplate2(st);

	}
	
	private void handrimportExceltemplate2(HSSFSheet st) throws Exception {
		HSSFRow row0 = st.getRow(0);
		String startTimeStr = ExcelUtil.getCellFormatValue(row0.getCell(1)).trim();
		String endTimeStr = ExcelUtil.getCellFormatValue(row0.getCell(2)).trim();
		if (BeanUtil.isEmpty(startTimeStr) || BeanUtil.isEmpty(endTimeStr)) {
			return;
		}
		Date startTime = DateFormatUtil.parseDate(startTimeStr);
		Date endTime = DateFormatUtil.parseDate(endTimeStr);
		int betweenDays = DateUtil.daysBetween(startTime, endTime);
		int count = 0;
		for (int rowIndex = 2; rowIndex <= st.getLastRowNum(); rowIndex++) {
			HSSFRow row = st.getRow(rowIndex);
			if (row == null)
				continue;
			AtsScheduleShift atsScheduleShift = new AtsScheduleShift();

			HSSFCell cell0 = row.getCell(0);
			if(cell0==null)continue;
			cell0.setCellType(Cell.CELL_TYPE_STRING);
			String account = cell0.getStringCellValue().trim();
			if (BeanUtil.isEmpty(account)) {
				String v = "员工编号";
				continue;
			}
			AtsAttendanceFile file = atsAttendanceFileManager.getUserCardFile(account);
			if (BeanUtil.isEmpty(file)) {
				MsgUtil.setMessage("第["+rowIndex+"]行此员工没有考勤档案！");
				continue;
			}
			
			//员工姓名
			cell0 = row.getCell(1);
			String userName = ExcelUtil.getCellFormatValue(cell0).trim();
			if (BeanUtil.isEmpty(userName)) {
				String v = "员工姓名";
				continue;
			}
			if(!userName.equals(file.getUserName())) {
				atsScheduleShift = null;
				MsgUtil.setMessage("第["+rowIndex+"]行员工姓名与编号不匹配！");
				break;
			}
			
			atsScheduleShift.setFileId(file.getId());
			atsScheduleShift.setAttencePolicy(file.getAttencePolicy());
			for (int i = 0; i <= betweenDays; i++) {
				Date date = DateUtil.addDay(startTime, i);
				String day = DateFormatUtil.format(date, "d");
				HSSFCell cell = row.getCell(i + 3);
				String v = ExcelUtil.getCellFormatValue(cell).trim();
				if (BeanUtil.isEmpty(v)) {
					continue;
				}

				Short dateType = AtsConstant.DATE_TYPE_WORKDAY;
				if (v.equalsIgnoreCase("休息日")) {
					dateType = AtsConstant.DATE_TYPE_DAYOFF;
				} else if (v.equalsIgnoreCase("节假日")) {
					dateType = AtsConstant.DATE_TYPE_HOLIDAY;
				} else {
					AtsShiftInfo atsShiftInfo = atsShiftInfoManager.getByShiftName(v);
					if (BeanUtil.isEmpty(atsShiftInfo)) {
						MsgUtil.setMessage("第["+rowIndex+"]行第["+i+"]列班次设置不存在！");
						break;
					}
					atsScheduleShift.setShiftId(atsShiftInfo.getId());
				}
				
				atsScheduleShift.setDateType(dateType);
				atsScheduleShift.setAttenceTime(date);
				//
				this.holidayHandle(atsScheduleShift, "");

				
				this.saveData(atsScheduleShift);
				count++;
			}
		}
		String msg = MsgUtil.getMessage();
		if("".equals(msg)) {
			MsgUtil.setMessage("上传排版记录成功，记录数："+count);
		}else {
			MsgUtil.setMessage(msg);
		}
	}
	
	private void handrimportExceltemplate1(HSSFSheet st) throws Exception {
		// 第一行为标题，不取
		int count = 0;
		for (int rowIndex = 1; rowIndex <= st.getLastRowNum(); rowIndex++) {
			HSSFRow row = st.getRow(rowIndex);
			if (row == null)
				continue;
			AtsScheduleShift atsScheduleShift = new AtsScheduleShift();

			String holidayName = "";
			for (int columnIndex = 0; columnIndex <= row.getLastCellNum(); columnIndex++) {
				HSSFCell cell = row.getCell(columnIndex);
				String o = ExcelUtil.getCellFormatValue(cell).trim();
				if (BeanUtil.isEmpty(o) && (columnIndex == 0 || columnIndex == 3)) {
					String v = "员工编号";
					if (columnIndex == 0) {
						v = "员工编号";
					} else if (columnIndex == 3) {
						v = "考勤日期";
					}
					atsScheduleShift = null;
					break;
				}
				if (columnIndex == 0) {// 姓名
					AtsAttendanceFile file = atsAttendanceFileManager.getUserCardFile(o);
					if (BeanUtil.isEmpty(file)) {
						atsScheduleShift = null;
						MsgUtil.setMessage("第["+rowIndex+"]行此员工没有考勤档案！");
						break;
					}
					//员工姓名
					columnIndex++;
					cell = row.getCell(columnIndex);
					o = ExcelUtil.getCellFormatValue(cell).trim();
					if(!o.equals(file.getUserName())) {
						atsScheduleShift = null;
						MsgUtil.setMessage("第["+rowIndex+"]行员工姓名与编号不匹配！");
						break;
					}
					atsScheduleShift.setFileId(file.getId());
					atsScheduleShift.setAttencePolicy(file.getAttencePolicy());
				} else if (columnIndex == 2) {// 班次
					if (BeanUtil.isEmpty(o))
						continue;
					AtsShiftInfo atsShiftInfo = atsShiftInfoManager.getByShiftName(o);
					if (BeanUtil.isEmpty(atsShiftInfo)) {
						atsScheduleShift = null;
						MsgUtil.setMessage("第["+rowIndex+"]行班次设置不存在！");
						break;
					}
					atsScheduleShift.setShiftId(atsShiftInfo.getId());
					Short dateType = AtsConstant.DATE_TYPE_WORKDAY;
					String type = atsShiftInfo.getShiftType();
					if(BeanUtil.isNotEmpty(type)){
						dateType = Short.parseShort(type);
						atsScheduleShift.setDateType(dateType);
					}
				} else if (columnIndex == 3) {// 考勤日期
					atsScheduleShift.setAttenceTime(DateFormatUtil.parseDate(o));
				}

			}
			if (BeanUtil.isEmpty(atsScheduleShift))
				continue;
			Short dateType = atsScheduleShift.getDateType();
			if (dateType.shortValue() == AtsConstant.DATE_TYPE_WORKDAY && BeanUtil.isEmpty(atsScheduleShift.getShiftId())) {
				continue;
			}

			this.holidayHandle(atsScheduleShift, holidayName);
			this.saveData(atsScheduleShift);
			count++;
		}
		String msg = MsgUtil.getMessage();
		if("".equals(msg)) {
			MsgUtil.setMessage("上传排版记录成功，记录数："+count);
		}else {
			MsgUtil.setMessage(msg);
		}
	}
	
	/**
	 * 节假日处理
	 * 
	 * @param atsScheduleShift
	 * @param holidayHandle
	 * @param holidayName
	 */
	private void holidayHandle(AtsScheduleShift atsScheduleShift, String holidayName) {
			holidayName = this.getHoliday(atsScheduleShift.getAttencePolicy(), atsScheduleShift.getAttenceTime());
		if (BeanUtil.isNotEmpty(holidayName)) {
			atsScheduleShift.setDateType(AtsConstant.DATE_TYPE_HOLIDAY);
			atsScheduleShift.setTitle(holidayName);
		}
	}
	
	private String getHoliday(String attencePolicy, Date attenceTime) {
		Map<String, String> map = atsLegalHolidayDetailManager.getHolidayMap(attencePolicy);
		return map.get(DateFormatUtil.formatDate(attenceTime));
	}

	public void delByFileId(String id) {
		atsScheduleShiftDao.delByFileId(id);
	}

}
