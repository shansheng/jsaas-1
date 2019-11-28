
/**
 * 
 * <pre> 
 * 描述：权限转移设置表 DAO接口
 * 作者:mansan
 * 日期:2018-06-20 17:12:34
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.sys.transset.dao;

import java.util.List;
import com.redxun.sys.transset.entity.SysTransferSetting;
import org.springframework.stereotype.Repository;
import com.redxun.core.dao.mybatis.BaseMybatisDao;

@Repository
public class SysTransferSettingDao extends BaseMybatisDao<SysTransferSetting> {

	@Override
	public String getNamespace() {
		return SysTransferSetting.class.getName();
	}

	public List<SysTransferSetting> getInvailAll() {
		return this.getBySqlKey("getInvailAll", "1");
	}
	

}

