package com.redxun.oa.mail.manager;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.jms.IMessageProducer;
import com.redxun.core.manager.BaseManager;
import com.redxun.core.query.Page;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.query.SortParam;
import com.redxun.oa.info.entity.InsPortalParams;
import com.redxun.oa.mail.dao.OutMailDao;
import com.redxun.oa.mail.entity.MailFolder;
import com.redxun.oa.mail.entity.OutMail;
import com.redxun.saweb.context.ContextUtil;
/**
 * <pre> 
 * 描述：外部邮件业务服务类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：广州红迅软件有限公司版权所有
 * </pre>
 */
@Service
public class OutMailManager extends BaseManager<OutMail>{
	@Resource
	private OutMailDao outMailDao;
	
	@Resource
	IMessageProducer messageProducer;
	
    /**
     *根据文件夹folderId查询该文件夹下邮件
     * @param mailFolderId  文件夹Id
     * @return
     */
	public List<OutMail> getMailByFolderId(String mailFolderId,QueryFilter queryFilter){
		return outMailDao.getMailByFolderId(mailFolderId,queryFilter);
	}
	
    /**
     * 根据外部邮件UID查询外部邮件邮件
     * @param uid  外部邮件UID
     * @return
     */
	public List<OutMail> getMailByUID(String uId,String tenantId){
		return outMailDao.getMailByUID(uId,tenantId);
	}
	
    /**
     * 根据外部邮件mailId获取邮件内容
     * @param mailId 外部邮件Id
     * @return
     */
	public String getMailContentByMailId(String mailId){
		return outMailDao.getMailContentByMailId(mailId);
	}
	
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return outMailDao;
	}
}