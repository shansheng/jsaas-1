
/**
 * 
 * <pre> 
 * 描述：权限转移日志表 DAO接口
 * 作者:mansan
 * 日期:2018-06-20 17:12:34
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.sys.translog.dao;

import java.util.List;
import com.redxun.sys.translog.entity.SysTransferLog;
import org.springframework.stereotype.Repository;
import com.redxun.core.dao.mybatis.BaseMybatisDao;

@Repository
public class SysTransferLogDao extends BaseMybatisDao<SysTransferLog> {

	@Override
	public String getNamespace() {
		return SysTransferLog.class.getName();
	}
	
	@Override
	public void deleteByTenantId(String tenantId) {
		this.deleteBySqlKey("delByTenantId", tenantId);
    }
}

