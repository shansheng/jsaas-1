
/**
 * 
 * <pre> 
 * 描述：审批意见附件 DAO接口
 * 作者:ray
 * 日期:2019-01-14 09:53:47
 * 版权：广州红迅软件
 * </pre>
 */
package com.redxun.bpm.core.dao;
import java.util.List;
import com.redxun.bpm.core.entity.BpmCheckFile;
import org.springframework.stereotype.Repository;
import com.redxun.core.dao.mybatis.BaseMybatisDao;

@Repository
public class BpmCheckFileDao extends BaseMybatisDao<BpmCheckFile> {

	@Override
	public String getNamespace() {
		return BpmCheckFile.class.getName();
	}

    public List<BpmCheckFile> getByNodeId(String nodeId){
        return this.getBySqlKey("getByNodeId", nodeId);
    }

    public void removeByInst(String actInstId){
        this.deleteBySqlKey("removeByInst",actInstId);
    }

}

