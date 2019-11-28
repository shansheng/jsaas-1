package com.redxun.bpm.listener;

import javax.annotation.Resource;

import org.activiti.engine.impl.persistence.entity.TaskEntity;
import org.springframework.context.ApplicationListener;
import org.springframework.core.Ordered;
import org.springframework.stereotype.Service;

import com.redxun.bpm.activiti.event.NoAssignEvent;
import com.redxun.bpm.core.entity.BpmSolution;
import com.redxun.bpm.core.manager.BpmSolutionManager;
import com.redxun.core.jms.IMessageProducer;
import com.redxun.core.mail.model.Mail;
import com.redxun.saweb.util.WebAppUtil;
/**
 * 当任务没有分配执行人时的事件处理。
 * @author ray
 *
 */
@Service
public class NoAssignEventListener implements ApplicationListener<NoAssignEvent>,Ordered{
	
	@Resource
	IMessageProducer messageProducer;
	@Resource
	BpmSolutionManager bpmSolutionManager;

	@Override
	public int getOrder() {
		return 1;
	}

	@Override
	public void onApplicationEvent(NoAssignEvent event) {
		TaskEntity ent=(TaskEntity) event.getSource();
		String solId=(String) ent.getVariable("solId");
		
		BpmSolution bpmSolution=bpmSolutionManager.get(solId);
		String name=bpmSolution.getName();
		String instId=(String)ent.getVariable("instId");
		String nodeName=ent.getName();
		
		Mail mail=new Mail();
		mail.setSubject("节点暂无处理人邮件通知！");
		mail.setSenderAddress(WebAppUtil.getMailFrom());
		mail.setReceiverAddresses(WebAppUtil.getMailTo()); 
		mail.setTemplate("mail/nodeNoneOfDealer.ftl");

		mail.addVar("solutionName", name);
		String installHost="";
		try {
			 installHost= WebAppUtil.getInstallHost();
		} catch (Exception e) {
			e.printStackTrace();
		}
		mail.addVar("solutionUrl", installHost+"/bpm/core/bpmSolution/mgr.do?solId="+solId);
		mail.addVar("nodeName", nodeName);
		mail.addVar("imformUrl",installHost+"/bpm/core/bpmInst/inform.do?instId="+instId+"&taskId="+ent.getId());
		//把邮件放置邮件的消息队列中
		messageProducer.send(mail);
	}

}
