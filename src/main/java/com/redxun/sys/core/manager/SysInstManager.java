package com.redxun.sys.core.manager;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.core.cache.CacheUtil;
import com.redxun.core.constants.MBoolean;
import com.redxun.core.constants.MStatus;
import com.redxun.core.dao.IDao;
import com.redxun.core.jms.IMessageProducer;
import com.redxun.core.mail.model.Mail;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.util.AppBeanUtil;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.EncryptUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.saweb.util.WebAppUtil;
import com.redxun.sys.core.dao.SysInstDao;
import com.redxun.sys.core.entity.SysInst;
import com.redxun.sys.core.entity.SysProperties;
import com.redxun.sys.core.util.SysPropertiesUtil;
import com.redxun.sys.org.entity.OsGroup;
import com.redxun.sys.org.entity.OsUser;
import com.redxun.sys.org.manager.OsDimensionManager;
import com.redxun.sys.org.manager.OsGroupManager;
import com.redxun.sys.org.manager.OsInstUsersManager;
import com.redxun.sys.org.manager.OsRelInstManager;
import com.redxun.sys.org.manager.OsRelTypeManager;
import com.redxun.sys.org.manager.OsUserManager;
/**
 * <pre> 
 * 描述：SysInst业务服务类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Service
public class SysInstManager extends MybatisBaseManager<SysInst>{
	@Resource
	private SysInstDao sysInstDao;
	@Resource
	private OsDimensionManager osDimensionManager;
	@Resource
	private OsRelTypeManager osRelTypeManager;
	@Resource
	private OsUserManager osUserManager;
	@Resource
	private OsGroupManager osGroupManager;
	@Resource
	private OsRelInstManager osRelInstManager;
	@Resource
	OsInstUsersManager osInstUsersManager;
	@Resource
	private SysPropertiesManager sysPropertiesManager;
	@Resource
	IMessageProducer messageProducer;
	
	
	private static String TENANTS="tenants_";
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return sysInstDao;
	}
	
	public SysInst getByDomain(String domain){
		return sysInstDao.getByDomain(domain);
	}


	/**
	 * 根据登陆账号ID获取用户的所有可以登陆的机构
	 */
	public List<SysInst> getByUserIdAndStatus(String userId,String status){
		return sysInstDao.getByUserIdAndStatus(userId,status);
	}

	/**
	 * 获取所有机构
	 */
	public List<SysInst> getALL(){
		return sysInstDao.getALL();
	}

	/**
	 * 根据登陆账号ID获取用户的所有机构
	 */
	public List<SysInst> getByAccountId(String accountId){
		return sysInstDao.getByAccountId(accountId);
	}

	/**
     * 根据外部公司Id查询
     * @param domain
     * @return
     */
    public SysInst getByCompId(String compId){
    	return sysInstDao.getByCompId(compId);
    }
	
	@Override
	public void delete(String id) {
		
		CacheUtil.delCache(TENANTS);
		
		initTenants();
		//先删除其对应的关联数据
		osUserManager.deleteByTenantId(id);
		osRelTypeManager.deleteByTenantId(id);
		osDimensionManager.deleteByTenantId(id);
		super.delete(id);
	}
	
	
	
	
	
	@Override
	public void create(SysInst entity) {
		initTenants();
		super.create(entity);
	}

	@Override
	public void update(SysInst entity) {
		initTenants();
		super.update(entity);
	}

	/**
	 * 获得有效的机构列表
	 * @return
	 */
	public List<SysInst> getValidSysInsts(){
		return sysInstDao.getByStatus(MStatus.ENABLED.name());
	}
	
	/**
	 * 从缓存中获取租户信息。
	 * @return
	 */
	public static List<SysInst> getTenants(){
		SysInstManager manager=AppBeanUtil.getBean(SysInstManager.class);
		List<SysInst> list= (List<SysInst>) CacheUtil.getCache(TENANTS);
		if(BeanUtil.isEmpty(list)){
			list=manager.initTenants();
		}
		return list;
	}
	
	/**
	 * 初始化租户。
	 * @return
	 */
	public List<SysInst> initTenants(){
		List<SysInst> rtnList=new ArrayList<SysInst>();
		List<SysInst> list= getValidSysInsts();
		for(SysInst origin:list){
			SysInst inst=new SysInst();
			inst.setInstId(origin.getInstId());
			inst.setNameCn(origin.getNameCn());
			inst.setDomain(origin.getDomain());
			inst.setDsName(origin.getDsName());
			inst.setDsAlias(origin.getDsAlias());
			inst.setStatus(origin.getStatus());
			inst.setInstType(origin.getInstType());
			rtnList.add(inst);
		}
		CacheUtil.addCache(TENANTS, rtnList);
		
		return rtnList;
	}
	
	/**
	 * 注册企业机构
	 * @param sysInst
	 * @return
	 */
	public boolean doRegister(SysInst sysInst){
		String account=SysPropertiesUtil.getTenantAdminAccount();
		Integer idSn = this.sysInstDao.getMaxIdSn()+1;
		sysInst.setIdSn(idSn);
		sysInst.setInstNo(StringUtil.getPinYinHeadChar(sysInst.getNameCn()));
		OsGroup mainGroup=osGroupManager.addInitPersonalGroup(sysInst);
		
		String pwd=new Integer(new Double(1000000*Math.random()).intValue()).toString();

		//创建化用户
		OsUser adminUser=osUserManager.initAdminUser(sysInst.getInstId(),account,pwd,  "管理员", sysInst.getEmail(), sysInst.getPhone(),idSn);
		//创建用户与机构的关系
		osInstUsersManager.createFormOsUser(adminUser, sysInst.getDomain());
		//初始一个行政用户组
		osRelInstManager.addBelongRelInst(mainGroup.getGroupId(), adminUser.getUserId(), MBoolean.YES.name());

		//发送邮件，通知管理该用户收到该邮件以进行激活
		sendMail(sysInst,pwd,idSn);
		
		return true;
	}
	

	public SysInst getByNameCn(String nameCn){
		return sysInstDao.getByNameCn(nameCn);
	}
	
	public SysInst getByShortNameCn(String shortNameCn){
		return sysInstDao.getByShortNameCn(shortNameCn);
	}

	private void sendMail(SysInst sysInst,String pwd,Integer idSn){
		Mail model=new Mail();
				
		model.setSubject("云端企业注册激活通知--"+ sysInst.getNameCn());
		model.setSenderAddress(WebAppUtil.getMailFrom());
		
		model.setReceiverAddresses(sysInst.getEmail());
		model.setTemplate("mail/sysInstActive.ftl");
		//TODO 产生临时的激活码,并且需要在一定的时间内激活,过期则不允许处理
		model.addVar("activeUrl", WebAppUtil.getInstallHost()+"/activeInst.do?instId="+sysInst.getInstId());
		model.addVar("loginUrl", WebAppUtil.getInstallHost()+"/login.jsp");
		String account=SysPropertiesUtil.getTenantAdminAccount();
		String adminAccount =OsUser.TADMIN.equals(account)?(Integer.toString(OsUser.IDSN+idSn)):account;
		model.addVar("adminAccount", adminAccount+ "@"+sysInst.getDomain());
		model.addVar("password", pwd);
		model.addVar("appName", WebAppUtil.getAppName());
		//把邮件放置邮件的消息队列中
		messageProducer.send(model);
	}

	//修改域名
	public void saveDomain(SysInst inst, String newDomain) {
		if(BeanUtil.isEmpty(inst) || newDomain.equals(inst.getDomain())) return;
		//修改属性表域名
		String domainPath = "org.mgr.domain";
		SysProperties properties = sysPropertiesManager.getPropertiesByName(domainPath);
		//根域名需相同才能修改
		if(properties.getValue().equals(inst.getDomain())){
			properties.setValue(newDomain);
			sysPropertiesManager.update(properties);
			//删除缓存根域名
			CacheUtil.delCache("property_"+domainPath);
			//删除缓存机构
			CacheUtil.delCache(TENANTS);
		}
		osInstUsersManager.updDomain(inst.getInstId(), newDomain);
		//修改租户表域名
		inst.setDomain(newDomain);
		update(inst);
		
	}
	
	public void syncCompany(JSONArray jsonArray) throws Exception{
		for (int i = 0; i < jsonArray.size(); i++) {
			JSONObject json=jsonArray.getJSONObject(i);
			Long companyId=json.getLong("companyId");
			String name=json.getString("name");
			String phone=json.getString("mobile");
			String status=json.getInteger("status")==1?"ENABLED":"DISABLED";
			
			Date createTime=json.getDate("createTime");
			Date updateTime=json.getDate("updateTime");
			
			SysInst inst=new SysInst();
			inst.setInstId(String.valueOf(companyId));
			inst.setNameCn(StringUtil.isEmpty(name)?inst.getInstId():name);
			inst.setStatus(status);
			inst.setDomain(inst.getInstId()+".com");
			inst.setCreateTime(createTime);
			inst.setUpdateTime(updateTime);
			inst.setPhone(phone);
			inst.setPkId(String.valueOf(companyId));
			this.saveOrUpdate(inst);
		}
	}
	
	public void syncCompanySingle(JSONArray jsonArray) throws Exception{
		for (int i = 0; i < jsonArray.size(); i++) {
			JSONObject json=jsonArray.getJSONObject(i);
			Long companyId=json.getLong("companyId");
			String name=json.getString("name");
			String phone=json.getString("mobile");
			String status=json.getInteger("status")==1?"ENABLED":"DISABLED";
			
			Date createTime=json.getDate("createTime");
			Date updateTime=json.getDate("updateTime");
			
			SysInst inst=new SysInst();
			inst.setInstId(SysInst.ADMIN_TENANT_ID);
			inst.setNameCn(StringUtil.isEmpty(name)?String.valueOf(companyId):name);
			inst.setStatus(status);
			inst.setDomain(companyId+".com");
			inst.setCreateTime(createTime);
			inst.setUpdateTime(updateTime);
			inst.setPhone(phone);
			this.saveOrUpdate(inst);
		}
	}
	
}