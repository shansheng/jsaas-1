package com.redxun.bpm.core.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Test;

import com.redxun.bpm.core.entity.BpmSolUser;
import com.redxun.bpm.core.entity.BpmSolUsergroup;
import com.redxun.saweb.util.IdUtil;
import com.redxun.test.BaseTestCase;

/**
 * <pre> 
 * 描述：BpmSolUser数据访问测试类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：广州红迅软件有限公司版权所有
 * </pre>
 */
public class BpmSolUserDaoTest extends BaseTestCase {

    @Resource
    private BpmSolUserDao bpmSolUserDao;
    @Resource
    private BpmSolUsergroupDao bpmSolUsergroupDao;
    

    @Test
    public void updUserGroup() {
       List<BpmSolUser> list=bpmSolUserDao.getEmptyGroup();
       Map<String,List<BpmSolUser>> map=new HashMap<>();
       for(BpmSolUser user:list){
    	   String key=user.getSolId() +"," + user.getActDefId() +"," + user.getNodeId();
    	   if(map.containsKey(key)){
    		   map.get(key).add(user);
    	   }
    	   else{
    		   List<BpmSolUser> tmpList=new ArrayList<>();
    		   tmpList.add(user);
    		   map.put(key, tmpList);
    	   }
       }
       for (Map.Entry<String,List<BpmSolUser>> ent : map.entrySet()) { 
    	   String key=ent.getKey();
    	   List<BpmSolUser> users=ent.getValue();
    	   String[] aryKey=key.split(",");
    	   String solId=aryKey[0];
    	   String actDefId=aryKey[1];
    	   String nodeId=aryKey[2];
    	   BpmSolUser user1=users.get(0);
    	   
    	   String groupId=IdUtil.getId();
    	   BpmSolUsergroup group=new BpmSolUsergroup();
    	   group.setId(groupId);
    	   group.setActDefId(actDefId);
    	   group.setSolId(solId);
    	   group.setNodeId(nodeId);
    	   group.setNodeName(user1.getNodeName());
    	   group.setGroupName(user1.getNodeName());
    	   group.setGroupType("task");
    	   group.setTenantId(user1.getTenantId());
    	   group.setSn(1);
    	   bpmSolUsergroupDao.create(group);
    	   
    	   for(BpmSolUser user:users){
    		   user.setGroupId(groupId);
    		   bpmSolUserDao.update(user);
    	   }
       }
    }
}