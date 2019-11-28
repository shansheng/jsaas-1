
package com.redxun.oa.ats.manager;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

import javax.annotation.Resource;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.DateFormatUtil;
import com.redxun.core.util.DateUtil;
import com.redxun.core.util.ExcelUtil;
import com.redxun.core.util.MsgUtil;
import com.redxun.oa.ats.dao.AtsCardRecordDao;
import com.redxun.oa.ats.entity.AtsAttendanceFile;
import com.redxun.oa.ats.entity.AtsCardRecord;
import com.redxun.oa.ats.entity.AtsCardRecord.CardResoureType;
import com.redxun.saweb.util.IdUtil;
import com.redxun.sys.org.manager.OsUserManager;

/**
 * 
 * <pre> 
 * 描述：打卡记录 处理接口
 * 作者:mansan
 * 日期:2018-03-21 16:05:40
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class AtsCardRecordManager extends MybatisBaseManager<AtsCardRecord>{
	@Resource
	private AtsCardRecordDao atsCardRecordDao;
	@Resource
	private AtsAttendanceFileManager atsAttendanceFileManager;
	@Resource
	private OsUserManager osUserManager;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return atsCardRecordDao;
	}
	
	
	
	public AtsCardRecord getAtsCardRecord(String uId){
		AtsCardRecord atsCardRecord = get(uId);
		return atsCardRecord;
	}

	public Set<Date> getByCardNumberSet(String cardNumber, Date startTime,
			Date endTime) {
		List<AtsCardRecord> list = atsCardRecordDao.getByCardNumberCardDate(cardNumber, startTime, endTime);
		Set<Date> set = new TreeSet<Date>();
		for (AtsCardRecord atsCardRecord : list) {
			set.add(atsCardRecord.getCardDate());
		}
		return set;
	}

	public void save(JSONObject obj) {
		
		String userid = obj.getString("userid");//考勤卡号
		String checkin_time = obj.getString("checkin_time");//打卡时间
		String location_detail = obj.getString("location_detail");//打卡地址
		String exception_type = obj.getString("exception_type");//是否异常
		if("未打卡".equals(exception_type) || "".equals(location_detail)) return;
		AtsCardRecord cardRecord = new AtsCardRecord(IdUtil.getId());
		
		cardRecord.setCardDate(DateUtil.timeStamp2Date(checkin_time));
		cardRecord.setCardNumber(userid);
		cardRecord.setCardSource(CardResoureType.WEIXIN);//打卡来源  1:微信
		cardRecord.setCardPlace(location_detail);
		if(getValildDate(cardRecord.getCardNumber(), cardRecord.getCardDate())){
			return;
		}
		create(cardRecord);//保存记录	
	}
	
	public boolean getValildDate(String cardNumber,Date startTime){
		return atsCardRecordDao.getValildDate(cardNumber, startTime) != null ? true : false;
	}
	
	//导入Excel文档
	public void importExcel(InputStream is,boolean isXls) throws Exception {
		try {
			Workbook workbook = null;  
            if (isXls) {// 当excel是2003时,创建excel2003  
            	workbook = new HSSFWorkbook(is);  
            } else {// 当excel是2007时,创建excel2007  
            	workbook = new XSSFWorkbook(is);  
            }
			for (int sheetIndex = 0; sheetIndex < workbook.getNumberOfSheets(); sheetIndex++) {
				Sheet st = workbook.getSheetAt(sheetIndex);
				// 第一行为标题，不取
				for (int rowIndex = 2; rowIndex <= st.getLastRowNum(); rowIndex++) {
					Row row = st.getRow(rowIndex);
					if (row == null)
						continue;
					AtsCardRecord atsCardRecord = new AtsCardRecord();
					for (int columnIndex = 0; columnIndex <= row.getLastCellNum(); columnIndex++) {
						Cell cell = row.getCell(columnIndex);
						String o = ExcelUtil.getCellFormatValue(cell).trim();
						if (columnIndex == 0) {// 员工编号
							cell.setCellType(Cell.CELL_TYPE_STRING);
							o = ExcelUtil.getCellFormatValue(cell).trim();
							if (BeanUtil.isEmpty(o)) {
								MsgUtil.setMessage("第["+rowIndex+"]行员工编号为空！");
								break;
							}
							AtsAttendanceFile file = atsAttendanceFileManager.getUserFile(o);
							if (BeanUtil.isEmpty(file)) {
								MsgUtil.setMessage("第["+rowIndex+"]行此员工没有考勤档案！");
								break;
							}
							atsCardRecord.setCardNumber(file.getCardNumber());
						} else if (columnIndex == 1) {// 打卡日期
							atsCardRecord.setCardDate(DateFormatUtil.parse(o));
						} else if (columnIndex == 2) {// 打卡时间
							Date d = DateUtil.getTime(atsCardRecord.getCardDate(), DateFormatUtil.parseTime(o));
							atsCardRecord.setCardDate(d);
						} else if (columnIndex == 3) {// 打卡位置
							atsCardRecord.setCardPlace(o);
						}
					}
					if (BeanUtil.isEmpty(atsCardRecord.getCardNumber()))
						continue;

					atsCardRecord.setId(IdUtil.getId());
					atsCardRecord.setCardSource(CardResoureType.EXECL);
					if(getValildDate(atsCardRecord.getCardNumber(),atsCardRecord.getCardDate())){
						continue;
					}
					atsCardRecordDao.create(atsCardRecord);
					MsgUtil.setMessage("第["+rowIndex+"]行保存成功！");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		} finally {
			if (is != null) {
				try {
					is.close();
				} catch (IOException e) {
					is = null;
					e.printStackTrace();
				}
			}

		}
	}

	/**
	 * 无效打卡记录
	 * @return
	 */
	public List<AtsCardRecord> getByInvalidRecord(){
		return atsCardRecordDao.getByInvalidRecord();
	}
	
	/**
	 * 有效打卡记录
	 * @return
	 */
	public List<AtsCardRecord> getByNotInvalidRecord(){
		return atsCardRecordDao.getByNotInvalidRecord();
	}
	
	/**
	 * 打卡数据维护
	 */
	public void clear() {
		List<AtsCardRecord> list = getByInvalidRecord();
		for (AtsCardRecord atsCardRecord : list) {
			atsCardRecordDao.delete(atsCardRecord.getId());
		}
	}

	public List<AtsCardRecord> getDataAll(QueryFilter queryFilter) {
		return atsCardRecordDao.getDataAll(queryFilter);
	}
}
