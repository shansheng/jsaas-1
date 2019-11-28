
package com.airdrop.wxrepair.core.manager;

import com.airdrop.wxrepair.core.dao.PatrolQuestionInfoDao;
import com.airdrop.wxrepair.core.dao.PatrolQuestionOptionDao;
import com.airdrop.wxrepair.core.entity.PatrolQuestionInfo;
import com.airdrop.wxrepair.core.entity.PatrolQuestionOption;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.saweb.util.IdUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * <pre>
 * 描述：问题信息 处理接口
 * 作者:zpf
 * 日期:2019-10-10 16:51:08
 * 版权：麦希影业
 * </pre>
 */
@Service
public class PatrolQuestionInfoManager extends MybatisBaseManager<PatrolQuestionInfo> {

    @Resource
    private PatrolQuestionInfoDao patrolQuestionInfoDao;

    @Resource
    private PatrolQuestionOptionDao patrolQuestionOptionDao;

    @SuppressWarnings("rawtypes")
    @Override
    protected IDao getDao() {
        return patrolQuestionInfoDao;
    }


    public PatrolQuestionInfo getPatrolQuestionInfo(String uId) {
        PatrolQuestionInfo patrolQuestionInfo = get(uId);
        return patrolQuestionInfo;
    }


    @Override
    public void create(PatrolQuestionInfo entity) {
        entity.setId(IdUtil.getId());
        super.create(entity);

    }

    @Override
    public void update(PatrolQuestionInfo entity) {
        super.update(entity);


    }

    public List<Map> getQuestionByNaire(String nId) {
        List<Map> list = patrolQuestionInfoDao.getQuestionByNaire(nId);
        for (Map m : list
        ) {
            Object type = m.get("F_QUESTION_TYPE");
            if ( type != null && type.equals("002") ) {
                List<PatrolQuestionOption> options = getQuestionOption(m.get("ID_"));
                m.put("options", options);
            }
        }
        return list;
    }

    public List<PatrolQuestionOption> getQuestionOption(Object qid) {
        return patrolQuestionOptionDao.getQuestionOption(qid);
    }

    public boolean saveQuestion(List<JSONObject> jsonObjects, String nid) {
        boolean flag = true;
        try {
            for (int i = 0; i < jsonObjects.size(); i++) {
                JSONObject json = jsonObjects.get(i);
                String id = json.getString("id") != null ? json.getString("id") : "";
                String state = json.getString("_state") != null ? json.getString("_state") : "";
                String questionType = json.getString("questionType");
                JSONArray options = json.getJSONArray("options");
                String questionTypeName = "";
                if ( questionType.equals("001") ) {
                    questionTypeName = "简答";
                } else if ( questionType.equals("002") ) {
                    questionTypeName = "选择";
                } else if ( questionType.equals("003") ) {
                    questionTypeName = "判断";
                } else if ( questionType.equals("004") ) {
                    questionTypeName = "上传";
                }
                String questionContent = json.getString("questionContent");
                int sequence = json.getIntValue("sequence");
                PatrolQuestionInfo patrolQuestionInfo = new PatrolQuestionInfo();
                //atrolQuestionInfo bean = JsonUtils.json2Bean(json.toString(), PatrolQuestionInfo.class);
                if ( id.equals("") || state.equals("added") ) {
                    patrolQuestionInfo.setQuestionType(questionType);
                    patrolQuestionInfo.setQuestionTypeName(questionTypeName);
                    patrolQuestionInfo.setQuestionContent(questionContent);
                    patrolQuestionInfo.setSequence(sequence);
                    patrolQuestionInfo.setRefId(nid);
                    create(patrolQuestionInfo);
                } else if ( state.equals("removed") || state.equals("deleted") ) {
                    delete(id);
                } else if ( state.equals("modified") || state.equals("") ) {
                    patrolQuestionInfo.setQuestionType(questionType);
                    patrolQuestionInfo.setQuestionTypeName(questionTypeName);
                    patrolQuestionInfo.setQuestionContent(questionContent);
                    patrolQuestionInfo.setSequence(sequence);
                    patrolQuestionInfo.setId(id);
                    patrolQuestionInfo.setRefId(nid);
                    update(patrolQuestionInfo);
                }
                if ( options != null && options.size() > 0 ) {
                    for (int j = 0; j < options.size(); j++) {
                        JSONObject jsonObject = options.getJSONObject(j);
                        String optionid = jsonObject.getString("id") != null ? jsonObject.getString("id") : "";
                        String optionstate = jsonObject.getString("_state") != null ? jsonObject.getString("_state") : "";
                        String optionCode = jsonObject.getString("optionCode");
                        String optionContent = jsonObject.getString("optionContent");
                        PatrolQuestionOption patrolQuestionOption = new PatrolQuestionOption();
                        patrolQuestionOption.setOptionCode(optionCode);
                        patrolQuestionOption.setOptionContent(optionContent);
                        patrolQuestionOption.setRefId(patrolQuestionInfo.getId());
                        if ( optionid.equals("") || optionstate.equals("added") ) {
                            patrolQuestionOption.setId(IdUtil.getId());
                            patrolQuestionOptionDao.create(patrolQuestionOption);
                        } else if ( optionstate.equals("removed") || optionstate.equals("deleted") ) {
                            patrolQuestionOptionDao.delete(optionid);
                        } else if ( optionstate.equals("modified") || optionstate.equals("") ) {
                            patrolQuestionOption.setId(optionid);
                            patrolQuestionOptionDao.update(patrolQuestionOption);
                        }
                    }
                }
            }
        } catch (Exception e) {
            flag = false;
            e.printStackTrace();
        }
        return flag;
    }
}
