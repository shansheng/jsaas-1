
/**
 * 
 * <pre> 
 * 描述：act_hi_taskinst DAO接口
 * 作者:ray
 * 日期:2019-04-02 09:26:35
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.bpm.core.dao;

import java.util.List;
import com.redxun.bpm.core.entity.ActHiTaskinst;
import org.springframework.stereotype.Repository;
import com.redxun.core.dao.mybatis.BaseMybatisDao;

@Repository
public class ActHiTaskinstDao extends BaseMybatisDao<ActHiTaskinst> {

	@Override
	public String getNamespace() {
		return ActHiTaskinst.class.getName();
	}
	

}

