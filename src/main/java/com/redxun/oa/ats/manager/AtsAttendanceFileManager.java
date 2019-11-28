
package com.redxun.oa.ats.manager;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import javax.annotation.Resource;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.ExcelUtil;
import com.redxun.core.util.MsgUtil;
import com.redxun.oa.ats.dao.AtsAttendanceFileDao;
import com.redxun.oa.ats.entity.AtsAttencePolicy;
import com.redxun.oa.ats.entity.AtsAttendanceFile;
import com.redxun.oa.ats.entity.AtsConstant;
import com.redxun.oa.ats.entity.AtsHolidayPolicy;
import com.redxun.oa.ats.entity.AtsShiftInfo;
import com.redxun.saweb.util.IdUtil;
import com.redxun.sys.org.entity.OsUser;
import com.redxun.sys.org.manager.OsUserManager;

/**
 * 
 * <pre> 
 * 描述：考勤档案 处理接口
 * 作者:mansan
 * 日期:2018-03-21 16:05:40
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class AtsAttendanceFileManager extends MybatisBaseManager<AtsAttendanceFile>{
	@Resource
	private AtsAttendanceFileDao atsAttendanceFileDao;
	@Resource
	private OsUserManager osUserManager;

	@Resource
	private AtsAttencePolicyManager atsAttencePolicyManager;
	@Resource
	private AtsHolidayPolicyManager atsHolidayPolicyManager;
	@Resource
	private AtsShiftInfoManager atsShiftInfoManager;
	@Resource
	private AtsAttenceGroupDetailManager atsAttenceGroupDetailManager;
	@Resource
	private AtsAttenceCalculateManager atsAttenceCalculateManager;
	@Resource
	private AtsScheduleShiftManager atsScheduleShiftManager;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return atsAttendanceFileDao;
	}
	
	
	
	public AtsAttendanceFile getAtsAttendanceFile(String uId){
		AtsAttendanceFile atsAttendanceFile = get(uId);
		return atsAttendanceFile;
	}

	public List<AtsAttendanceFile> getDisUserList(QueryFilter queryFilter) {
		return atsAttendanceFileDao.getDisUserList(queryFilter);
	}

	public AtsAttendanceFile getUserFile(String userNo){
		return atsAttendanceFileDao.getUserFile(userNo);
	}
	
	public AtsAttendanceFile getUserCardFile(String cardNumber){
		return atsAttendanceFileDao.getUserCardFile(cardNumber);
	}

	public List<AtsAttendanceFile> getNoneCalList(QueryFilter queryFilter) {
		return atsAttendanceFileDao.getNoneCalList(queryFilter);
	}

	public List<AtsAttendanceFile> getByAttendPolicy(String attencePolicyId) {
		
		return atsAttendanceFileDao.getByAttendPolicy(attencePolicyId);
	}

	public List<String> getAttendance() {
		return atsAttendanceFileDao.getAttendance();
	}
	
	public void importExcel(InputStream inputStream) {
		try {
			HSSFWorkbook workbook = new HSSFWorkbook(inputStream);
			for (int sheetIndex = 0; sheetIndex < workbook.getNumberOfSheets(); sheetIndex++) {
				HSSFSheet st = workbook.getSheetAt(sheetIndex);
				// 第一行为标题，不取
				for (int rowIndex = 1; rowIndex <= st.getLastRowNum(); rowIndex++) {
					HSSFRow row = st.getRow(rowIndex);
					if (row == null)
						continue;
					AtsAttendanceFile file = new AtsAttendanceFile();
					for (int columnIndex = 0; columnIndex <= row
							.getLastCellNum(); columnIndex++) {
						HSSFCell cell = row.getCell(columnIndex);
						String o = ExcelUtil.getCellFormatValue(cell).trim();
						if (o==null
								&& (columnIndex == 0 || columnIndex == 1
										|| columnIndex == 2 || columnIndex == 3|| columnIndex == 4|| columnIndex == 5)) {
							String  v = "员工编号";
							if(columnIndex == 0){
								v = "员工编号";
							}else if(columnIndex == 1){
								v = "员工姓名";
							}else if(columnIndex == 2){
								v = "打卡考勤";
							}else if(columnIndex == 3){
								v = "考勤制度";
							}else if(columnIndex == 4){
								v = "假期制度";
							}else if(columnIndex == 5){
								v = "默认班次";
							}
							file = null;
							break;
						}
						
						if (columnIndex == 0) {// 员工编号
							AtsAttendanceFile atsAttendanceFile = atsAttendanceFileDao.getUserFile(o);
							if(BeanUtil.isNotEmpty(atsAttendanceFile)) {
								file = null;
								MsgUtil.setMessage("第["+rowIndex+"]行员工编号已存在！");
								break;
							}
							
							AtsAttendanceFile tempFile = atsAttendanceFileDao.getDisUserOne(o);
							
							String cardNumber = null;//考勤卡号
							if(BeanUtil.isNotEmpty(tempFile)) {
								cardNumber = tempFile.getCardNumber();
								if(BeanUtil.isEmpty(cardNumber)){
									cardNumber = getCardNumber(tempFile.getUserId());
								}
								file.setUserId(tempFile.getUserId());
								file.setCardNumber(cardNumber.toString());
							}else {
								file = null;
								MsgUtil.setMessage("第["+rowIndex+"]行员工编号不存在！");
								break;
							}
							
							//员工姓名
							columnIndex++;
							cell = row.getCell(columnIndex);
							o = ExcelUtil.getCellFormatValue(cell).trim();
							if(!o.equals(tempFile.getUserName())) {
								file = null;
								MsgUtil.setMessage("第["+rowIndex+"]行员工姓名与编号不匹配！");
								break;
							}
						} else if (columnIndex == 2) {//打卡考勤
							if("是".equals(o)){
								file.setIsAttendance(AtsConstant.YES);
							} else {
								file.setIsAttendance(AtsConstant.NO);
							}
						} else if (columnIndex == 3) {//考勤制度
							AtsAttencePolicy atsAttencePolicy = atsAttencePolicyManager.getAttencePolicyByName(o);
							if (BeanUtil.isEmpty(atsAttencePolicy)) {
								file = null;
								MsgUtil.setMessage("第["+rowIndex+"]行考勤制度为空！");
								break;
							}
							file.setAttencePolicy(atsAttencePolicy.getId());
						} else if (columnIndex == 4) {//假期制度
							AtsHolidayPolicy atsHolidayPolicy = atsHolidayPolicyManager.getHolidayPolicyByName(o);
							if (BeanUtil.isEmpty(atsHolidayPolicy)) {
								file = null;
								MsgUtil.setMessage("第["+rowIndex+"]行假期制度为空！");
								break;
							}
							file.setHolidayPolicy(atsHolidayPolicy.getId());
						} else if (columnIndex == 5) {//默认班次
							AtsShiftInfo atsShiftInfo = atsShiftInfoManager.getByShiftName(o);
							if (BeanUtil.isEmpty(atsShiftInfo)) {
								file = null;
								MsgUtil.setMessage("第["+rowIndex+"]行默认班次为空！");
								break;
							}
							file.setDefaultShift(atsShiftInfo.getId());
						}
					}
					if (BeanUtil.isEmpty(file))
						continue;
					String id = IdUtil.getId();
					file.setId(id);
					
					//xxx
					atsAttendanceFileDao.create(file);
					MsgUtil.setMessage("第["+rowIndex+"]行保存成功！");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		} finally {
			if (inputStream != null) {
				try {
					inputStream.close();
				} catch (IOException e) {
					inputStream = null;
					e.printStackTrace();
				}
			}

		}
		
	}
	
	private String getCardNumber(String userId){
    	OsUser user = osUserManager.get(userId);
    	if(BeanUtil.isNotEmpty(user)){
    		return user.getUserNo();
    	}
    	return "";
    }

	public void saveByDefault(String userId) {
		AtsAttendanceFile atsAttendanceFile = new AtsAttendanceFile();
		atsAttendanceFile.setId(IdUtil.getId());
		atsAttendanceFile.setAttencePolicy(atsAttencePolicyManager.getDefaultAttencePolicy().getId());
		atsAttendanceFile.setHolidayPolicy(atsHolidayPolicyManager.getDefaultHolidayPolicy().getId());
		atsAttendanceFile.setDefaultShift(atsShiftInfoManager.getDefaultShiftInfo().getId());
		atsAttendanceFile.setIsAttendance((short)1);
		atsAttendanceFile.setUserId(userId);//用户ID
		atsAttendanceFile.setCardNumber(getCardNumber(userId));
		this.create(atsAttendanceFile);
	}
	
	public void save(AtsAttendanceFile atsAttendanceFile,String[] userId,String[] cardNumber) {
    	for (int i = 0; i < userId.length; i++) {
    		atsAttendanceFile.setId(IdUtil.getId());
    		atsAttendanceFile.setUserId(userId[i]);//用户ID
    		atsAttendanceFile.setCardNumber(cardNumber[i]);//考勤卡号
    		this.create(atsAttendanceFile);
    	}
	}

	public void updateFile(AtsAttendanceFile atsAttendanceFile, String[] userId,String[] cardNumber) {
		for (int i = 0; i < userId.length; i++) {
    		atsAttendanceFile.setUserId(userId[i]);//用户ID
    		atsAttendanceFile.setCardNumber(cardNumber[i]);//考勤卡号
    		this.update(atsAttendanceFile);
    	}
	}

	public void delByIds(String[] ids) {
		for (String id : ids) {
			//删除分组
			atsAttenceGroupDetailManager.delByFileId(id);
			//删除计算
			atsAttenceCalculateManager.delByFileId(id);
			//删除排班
			atsScheduleShiftManager.delByFileId(id);
			this.delete(id);
		}		
	}

	/**
	 * 获取未存在考勤档案的用户
	 * @return
	 */
	public List<String> getFileAll() {
		return atsAttendanceFileDao.getFileAll();
	}
	
	/**
	 * 获取已建立考勤档案的用户
	 * @return
	 */
	public List<String> getNotAttendance() {
		return atsAttendanceFileDao.getNotAttendance();
	}
	
	public List<AtsAttendanceFile> getByTenantId(String tenantId) {
		return atsAttendanceFileDao.getByTenantId(tenantId);
	}

}