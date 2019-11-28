
package com.airdrop.wxrepair.core.manager;

import com.airdrop.wxrepair.core.dao.PatrolQuestionnaireInfoDao;
import com.airdrop.wxrepair.core.entity.PatrolQuestionnaireInfo;
import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.saweb.util.IdUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * <pre>
 * 描述：问卷信息 处理接口
 * 作者:zpf
 * 日期:2019-10-16 10:18:37
 * 版权：麦希影业
 * </pre>
 */
@Service
public class PatrolQuestionnaireInfoManager extends MybatisBaseManager<PatrolQuestionnaireInfo> {

    @Resource
    private PatrolQuestionnaireInfoDao patrolQuestionnaireInfoDao;

    @SuppressWarnings("rawtypes")
    @Override
    protected IDao getDao() {
        return patrolQuestionnaireInfoDao;
    }


    public PatrolQuestionnaireInfo getPatrolQuestionnaireInfo(String uId) {
        PatrolQuestionnaireInfo patrolQuestionnaireInfo = get(uId);
        return patrolQuestionnaireInfo;
    }


    @Override
    public void create(PatrolQuestionnaireInfo entity) {
        entity.setId(IdUtil.getId());
        super.create(entity);

    }

    @Override
    public void update(PatrolQuestionnaireInfo entity) {
        super.update(entity);


    }

    public List<PatrolQuestionnaireInfo> getAllQuestionnaire() {
        return patrolQuestionnaireInfoDao.getAllQuestionnaire();
    }
}
