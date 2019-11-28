package com.redxun.saweb.filter;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Collection;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.DecoderException;
import org.apache.commons.codec.binary.Base64;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.codec.Hex;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.security.web.authentication.rememberme.TokenBasedRememberMeServices;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;

import com.redxun.core.util.AppBeanUtil;
import com.redxun.core.util.CookieUtil;
import com.redxun.core.util.EncryptUtil;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.saweb.util.WebAppUtil;
import com.redxun.sys.core.dao.SysMenuDao;
import com.redxun.sys.core.entity.SysInst;
import com.redxun.sys.core.manager.SysInstManager;
import com.redxun.sys.org.entity.OsUser;
import com.redxun.sys.org.manager.OsUserManager;

public class SecurityUtil {

	private static String rememberPrivateKey = "rememberPrivateKey";
	
	private static final String CAS_STATEFUL_IDENTIFIER = "_cas_stateful_";

	/**
	 * 实现单点登录
	 * @param request
	 * @param userName
	 * @param pwd
	 * @param isIgnorePwd
	 * @return
	 * @throws AuthenticationException
	 */
	public static Authentication login(HttpServletRequest request,String userName,String pwd,boolean isIgnorePwd) throws AuthenticationException{
		AuthenticationManager authenticationManager =(AuthenticationManager) WebAppUtil.getBean("authenticationManager");
		CustomPwdEncoder.setIngore(isIgnorePwd);
		
		UsernamePasswordAuthenticationToken authRequest = new UsernamePasswordAuthenticationToken(userName, pwd);
		authRequest.setDetails(new WebAuthenticationDetails(request));
		SecurityContext securityContext = SecurityContextHolder.getContext();
		Authentication auth = authenticationManager.authenticate(authRequest);
		securityContext.setAuthentication(auth);
		
		HttpSession session = request.getSession();
        session.setAttribute(HttpSessionSecurityContextRepository.SPRING_SECURITY_CONTEXT_KEY, securityContext); 
         
		return auth;
	}
	
	
	public static Authentication loginCas(final HttpServletRequest request, String st)
            throws AuthenticationException {
		AuthenticationManager authenticationManager =(AuthenticationManager) WebAppUtil.getBean("authenticationManager");
		
        final String username = CAS_STATEFUL_IDENTIFIER;
        

        final UsernamePasswordAuthenticationToken authRequest = new UsernamePasswordAuthenticationToken(username, st);

        authRequest.setDetails(new WebAuthenticationDetails(request));
        SecurityContext securityContext = SecurityContextHolder.getContext();
        Authentication auth = authenticationManager.authenticate(authRequest);
        securityContext.setAuthentication(auth);
        HttpSession session = request.getSession();
        session.setAttribute(HttpSessionSecurityContextRepository.SPRING_SECURITY_CONTEXT_KEY, SecurityContextHolder.getContext()); 
        return auth;
    }
	
	/**
	 * 判断是否有菜单的权限。
	 * 判断当前人是否有菜单ID的权限。
	 * 1.获取菜单的用户组。
	 * 2.获取当前用户的组。
	 * 3.判断菜单的组ID是否在当前人的组中。
	 * @param menuId	
	 */
	public static Boolean  hasPermission(String menuKey){
		OsUser user= (OsUser) ContextUtil.getCurrentUser();
		if(user.isSuperAdmin()) return true;
		
		SysMenuDao dao=AppBeanUtil.getBean(SysMenuDao.class);
		List groups= dao.getGroupsByKey(menuKey);
		
		Collection<? extends GrantedAuthority> authors= user.getAuthorities();
		for(GrantedAuthority auth:authors){
			String str=auth.getAuthority();
			if(groups.contains(str)) return true;
		}
		return false;
	}
	
	
	
	/**
	 * 按照 spring 提供的规则 SPRING_SECURITY_REMEMBER_ME_COOKIE。
	 * 
	 * @param request
	 * @param response
	 * @param username
	 * @param enPassword
	 * @throws DecoderException 
	 */
	public static void writeRememberMeCookie(HttpServletRequest request, HttpServletResponse response, String username, String password) throws DecoderException {
		String rememberMe = RequestUtil.getString(request, "rememberMe", "0") ;
		if (!"1".equals(rememberMe)) return;
		
		String enPassword=EncryptUtil.hexToBase64(password);
		
		long tokenValiditySeconds = 1209600; // 14 days
		long tokenExpiryTime = System.currentTimeMillis() + (tokenValiditySeconds * 1000);
		String signatureValue = makeTokenSignature(tokenExpiryTime,username,enPassword);
		String tokenValue = username + ":" + tokenExpiryTime + ":" + signatureValue;
		String tokenValueBase64 = new String(Base64.encodeBase64(tokenValue.getBytes()));
				
		CookieUtil.addCookie(TokenBasedRememberMeServices.SPRING_SECURITY_REMEMBER_ME_COOKIE_KEY, 
				tokenValueBase64,60 * 60 * 24 * 365, true, request, response);
	}
	
	/**
	 * 写入安全cookie 用于微信。
	 * @param request
	 * @param response
	 * @param username
	 * @throws DecoderException
	 */
	public static void writeRememberMeCookie(HttpServletRequest request, HttpServletResponse response, String username) throws DecoderException {
	    OsUserManager osUserManager=AppBeanUtil.getBean(OsUserManager.class);
		OsUser osUser=null;
		if(username.indexOf("|")==-1){
			osUser=osUserManager.getByUserName(username);
		}else{
			SysInstManager sysInstManager =AppBeanUtil.getBean(SysInstManager.class);
			String[] accs=username.split("[|]");
			SysInst sysInst=sysInstManager.getByCompId(accs[1]);
			if(sysInst==null){
				return;
			}
			osUser=osUserManager.getByUserName(accs[0], sysInst.getInstId());
		}
		String enPassword=osUser.getPwd();
		
		long tokenValiditySeconds = 1209600; // 14 days
		long tokenExpiryTime = System.currentTimeMillis() + (tokenValiditySeconds * 1000);
		String signatureValue = makeTokenSignature(tokenExpiryTime,username,enPassword);
		String tokenValue = username + ":" + tokenExpiryTime + ":" + signatureValue;
		String tokenValueBase64 = new String(Base64.encodeBase64(tokenValue.getBytes()));
				
		CookieUtil.addCookie(TokenBasedRememberMeServices.SPRING_SECURITY_REMEMBER_ME_COOKIE_KEY, 
				tokenValueBase64,60 * 60 * 24 * 365, true, request, response);
	}
	
	
	/**
	 * 将过期时间:用户名：密码 和 rememberPrivateKey 进行MD5签名。
	 * @param tokenExpiryTime
	 * @param username
	 * @param password
	 * @return
	 */
	private static String makeTokenSignature(long tokenExpiryTime, String username, String password) {
        String data = username + ":" + tokenExpiryTime + ":" + password + ":" + rememberPrivateKey;
        MessageDigest digest;
        try {
            digest = MessageDigest.getInstance("MD5");
        } catch (NoSuchAlgorithmException e) {
            throw new IllegalStateException("No MD5 algorithm available!");
        }
        return new String(Hex.encode(digest.digest(data.getBytes())));
	}
}
