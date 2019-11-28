package com.redxun.bpm.core.dao;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.redxun.core.dao.jpa.BaseJpaDao;
import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.bpm.core.entity.BpmSolCtl;
/**
 * <pre> 
 * 描述：BpmSolCtl数据访问类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：广东凯联网络科技有限公司版权所有
 * </pre>
 */
@Repository
public class BpmSolCtlDao extends BaseMybatisDao<BpmSolCtl> {

    
    /**
     * 通过solId和类型来查找模版设置的权限
     * @param solId
     * @param type
     * @return
     */
    public List<BpmSolCtl> getBySolIdAndType(String solId,String type){
    	Map<String, Object> params=new HashMap<String, Object>();
    	params.put("solId", solId);
    	params.put("type", type);
    	List<BpmSolCtl> list=this.getBySqlKey("getBySolIdAndType", params);
    	return list;
    }
    
    /**
     * 通过solId和type以及right来查找模版设置具体权限
     * @param solId
     * @param type
     * @param right
     * @return
     */
    public List<BpmSolCtl> getBySolAndTypeAndRight(String solId,String type,String right){
    	Map<String, Object> params=new HashMap<String, Object>();
    	params.put("solId", solId);
    	params.put("type", type);
    	params.put("right", right);
    	List<BpmSolCtl> list=this.getBySqlKey("getBySolAndTypeAndRight", params);
    	return list;
    }

	@Override
	public String getNamespace() {
		return BpmSolCtl.class.getName();
	}
    
}
