
package com.redxun.oa.ats.manager;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.util.BeanUtil;
import com.redxun.oa.ats.dao.AtsAttenceGroupDao;
import com.redxun.oa.ats.dao.AtsAttenceGroupDetailDao;
import com.redxun.oa.ats.entity.AtsAttenceGroup;
import com.redxun.oa.ats.entity.AtsAttenceGroupDetail;
import com.redxun.oa.ats.entity.AtsAttendanceFile;
import com.redxun.saweb.util.IdUtil;

/**
 * 
 * <pre> 
 * 描述：考勤组 处理接口
 * 作者:mansan
 * 日期:2018-03-27 11:27:43
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class AtsAttenceGroupManager extends MybatisBaseManager<AtsAttenceGroup>{
	@Resource
	private AtsAttenceGroupDao atsAttenceGroupDao;
	
	@Resource
	private AtsAttenceGroupDetailDao atsAttenceGroupDetailDao;
	@Resource
	private AtsAttendanceFileManager atsAttendanceFileManager;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return atsAttenceGroupDao;
	}
	
	
	
	public AtsAttenceGroup getAtsAttenceGroup(String uId){
		AtsAttenceGroup atsAttenceGroup = get(uId);
		List<AtsAttenceGroupDetail> atsAttenceGroupDetail= atsAttenceGroupDetailDao.getAtsAttenceGroupDetailList(uId);
		atsAttenceGroup.setAtsAttenceGroupDetails(atsAttenceGroupDetail);
		return atsAttenceGroup;
	}

	public void save(AtsAttenceGroup atsAttenceGroup) {
		atsAttenceGroupDao.create(atsAttenceGroup);
		String uId = atsAttenceGroup.getId();
		
		List<AtsAttenceGroupDetail> list = atsAttenceGroup.getAtsAttenceGroupDetails();
		for (AtsAttenceGroupDetail atsAttenceGroupDetail : list) {
			atsAttenceGroupDetail.setGroupId(uId);
			atsAttenceGroupDetail.setId(IdUtil.getId());
			AtsAttendanceFile file = atsAttendanceFileManager.getUserFile(atsAttenceGroupDetail.getUserNo());
			if(BeanUtil.isEmpty(file)) {
				atsAttendanceFileManager.saveByDefault(atsAttenceGroupDetail.getUserId());
				file = atsAttendanceFileManager.getUserFile(atsAttenceGroupDetail.getUserNo());
			}
			String fileId = file.getId();
			atsAttenceGroupDetail.setFileId(fileId);
			atsAttenceGroupDetailDao.create(atsAttenceGroupDetail);
		}
		
	}

	public void updateAttenceGroup(AtsAttenceGroup atsAttenceGroup) {
		atsAttenceGroupDao.update(atsAttenceGroup);
		String uId = atsAttenceGroup.getId();
		atsAttenceGroupDetailDao.delByMainId(uId);
		
		List<AtsAttenceGroupDetail> list = atsAttenceGroup.getAtsAttenceGroupDetails();
		for (AtsAttenceGroupDetail atsAttenceGroupDetail : list) {
			atsAttenceGroupDetail.setGroupId(uId);
			atsAttenceGroupDetail.setId(IdUtil.getId());
			AtsAttendanceFile file = atsAttendanceFileManager.getUserFile(atsAttenceGroupDetail.getUserNo());
			if(BeanUtil.isEmpty(file)) {
				atsAttendanceFileManager.saveByDefault(atsAttenceGroupDetail.getUserId());
				file = atsAttendanceFileManager.getUserFile(atsAttenceGroupDetail.getUserNo());
			}
			String fileId = file.getId();
			atsAttenceGroupDetail.setFileId(fileId);
			atsAttenceGroupDetailDao.create(atsAttenceGroupDetail);
		}
	}
	
}
