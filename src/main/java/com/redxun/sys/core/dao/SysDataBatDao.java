
/**
 * 
 * <pre> 
 * 描述：数据批量录入 DAO接口
 * 作者:ray
 * 日期:2019-01-02 10:49:41
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.sys.core.dao;

import java.util.List;
import com.redxun.sys.core.entity.SysDataBat;
import org.springframework.stereotype.Repository;
import com.redxun.core.dao.mybatis.BaseMybatisDao;

@Repository
public class SysDataBatDao extends BaseMybatisDao<SysDataBat> {

	@Override
	public String getNamespace() {
		return SysDataBat.class.getName();
	}
	

}

