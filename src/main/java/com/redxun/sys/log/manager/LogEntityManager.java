
package com.redxun.sys.log.manager;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.util.CookieUtil;
import com.redxun.org.api.model.IUser;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.util.IdUtil;
import com.redxun.sys.log.dao.LogEntityDao;
import com.redxun.sys.log.entity.LogEntity;
import com.redxun.sys.org.manager.OsGroupManager;

/**
 * 
 * <pre> 
 * 描述：日志实体 处理接口
 * 作者:陈茂昌
 * 日期:2017-09-21 14:43:53
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class LogEntityManager extends MybatisBaseManager<LogEntity>{
	@Resource
	private LogEntityDao logEntityDao;
	
	@Resource
	private OsGroupManager osGroupManager;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return logEntityDao;
	}
	
	
	public LogEntity getLogEntity(String uId){
		LogEntity logEntity = get(uId);
		return logEntity;
	}
	
	/**
	 * 记录登录日志
	 * @param request
	 */
	public void recordTheLog(HttpServletRequest request,HttpServletResponse response){
		String userAgent=request.getHeader("user-agent");//获取用户信息
		String ip=request.getRemoteAddr();//获取请求ip
		IUser user=ContextUtil.getCurrentUser();
		String tenantId=ContextUtil.getCurrentTenantId();
		
		Date date=new Date();
		String id=IdUtil.getId();
		CookieUtil.delCookie("logInOutId", request, response);
		
		Cookie cookie = new Cookie("logInOutId",id);//将logInOutId写入cookie中,主动注销时需要记录注销时间
		response.addCookie(cookie);//添加到cookie中
		
		
		LogEntity logEntity=new LogEntity();
		logEntity.setId(id);
		logEntity.setAction("登陆");
		logEntity.setCreateBy(user.getUserId());
		logEntity.setCreateUser(user.getFullname());
		logEntity.setMainGroupName(user.getMainGroupName());
		logEntity.setMainGroup(user.getMainGroupId());
		logEntity.setIp(ip);
		logEntity.setUserAgent(userAgent);
		logEntity.setTarget("[]");
		logEntity.setCreateTime(date);
		logEntity.setTenantId(tenantId);
		this.create(logEntity);
	}
	
	/**
	 * 记录登出日志
	 * @param request
	 * @param response
	 */
	public void recordTheLogOut(HttpServletRequest request,HttpServletResponse response){
		Cookie[] cookies=request.getCookies();
		Date date=new Date();
		/**
		 * 从cookie中读取
		 */
		for (int i = 0; i < cookies.length; i++) {
			Cookie cookie=cookies[i];
			if("logInOutId".equals(cookie.getName())){
				String logInOutId=cookie.getValue();
				LogEntity logEntity=this.get(logInOutId);
				if(logEntity!=null){
					logEntity.setUpdateTime(date);
					Date loginTime=logEntity.getCreateTime();
					logEntity.setDuration(date.getTime()-loginTime.getTime());//从cookie中记录的登录ID计算持续时间
					this.update(logEntity);//将日志模块的登出信息通过cookie中记录的Id更新至登录日志记录中
				}
				/*清除cookie*/
				cookie.setValue(null);
				cookie.setMaxAge(0);
				response.addCookie(cookie);
				break;
			}
		}
	}
}
