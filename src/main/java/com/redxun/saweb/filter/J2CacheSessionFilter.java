package com.redxun.saweb.filter;

import java.io.IOException;
import java.util.Collections;
import java.util.Properties;
import java.util.UUID;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.redxun.core.cache.J2CacheImpl;

import net.oschina.j2cache.J2CacheConfig;
import net.oschina.j2cache.session.CacheFacade;
import net.oschina.j2cache.session.J2CacheSession;
import net.oschina.j2cache.session.SessionObject;

/**
 * 实现基于 J2Cache 的分布式的 Session 管理
 * @author Winter Lau (javayou@gmail.com)
 */
public class J2CacheSessionFilter implements Filter {

    private CacheFacade g_cache;

    private String cookieName;
    private String cookiePath;
    private String cookieDomain;
    private int cookieMaxAge;
    

    private boolean discardNonSerializable;

    @Override
    public void init(FilterConfig config) {
        this.cookieName     = config.getInitParameter("cookie.name");
        this.cookieDomain   = config.getInitParameter("cookie.domain");
        this.cookiePath     = config.getInitParameter("cookie.path");
        this.cookieMaxAge   = Integer.parseInt(config.getInitParameter("session.maxAge"));
        this.discardNonSerializable = "true".equalsIgnoreCase(config.getInitParameter("session.discardNonSerializable"));

        J2CacheConfig conf=null;
		try {
			conf = J2CacheConfig.initFromConfig(J2CacheImpl.CONFIG_FILE);
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		Properties properties= conf.getProperties();
        Properties redisConf = new Properties();
        for(Object name : Collections.list(properties.keys())) {
        	String nameStr=name.toString();
            if(nameStr.startsWith("redis.")) {
                redisConf.setProperty(nameStr.substring(6), properties.getProperty(nameStr));
            }
        }
        
        redisConf.put("channel", "session_channel");
     
        int maxSizeInMemory = Integer.parseInt(config.getInitParameter("session.maxSizeInMemory"));

        this.g_cache = new CacheFacade(maxSizeInMemory, this.cookieMaxAge, redisConf, this.discardNonSerializable);
    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest j2cacheRequest = new J2CacheRequestWrapper(req, res);
        try {
            chain.doFilter(j2cacheRequest, res);
        } finally {
            //更新 session 的有效时间
            J2CacheSession session = (J2CacheSession)j2cacheRequest.getSession(false);
            if(session != null && !session.isNew())
                g_cache.updateSessionAccessTime(session.getSessionObject());
        }
    }

    @Override
    public void destroy() {
        g_cache.close();
    }


    /*************************************************
     * request 封装，用于重新处理 session 的实现
     *************************************************/
    public class J2CacheRequestWrapper extends HttpServletRequestWrapper {

        private HttpServletResponse response;
        private J2CacheSession session;

        public J2CacheRequestWrapper(ServletRequest req, ServletResponse res) {
            super((HttpServletRequest)req);
            this.response = (HttpServletResponse)res;
        }

        @Override
        public HttpSession getSession(boolean create) {
        	if(session != null) return session;
        	
            Cookie ssnCookie = getCookie(cookieName);

            if (ssnCookie != null) {
                String session_id = ssnCookie.getValue();
                SessionObject ssnObject = g_cache.getSession(session_id);
                if(ssnObject != null) {
                	
                    session = new J2CacheSession(getServletContext(), session_id, g_cache);
                    session.setSessionObject(ssnObject);
                    session.setNew(false);
                }
            }

            if(session == null && create) {
                String session_id = UUID.randomUUID().toString().replaceAll("-", "");
                session = new J2CacheSession(getServletContext(), session_id, g_cache);
                g_cache.saveSession(session.getSessionObject());
                setCookie(cookieName, session_id);
            }
            return session;
        }

        @Override
        public HttpSession getSession() {
            return this.getSession(true);
        }

        /**
         * Get cookie object by cookie name.
         */
        private Cookie getCookie(String name) {
            Cookie[] cookies = ((HttpServletRequest) getRequest()).getCookies();
            if (cookies != null)
                for (Cookie cookie : cookies)
                    if (cookie.getName().equalsIgnoreCase(name))
                        return cookie;
            return null;
        }

        /**
         * @param name
         * @param value
         */
        private void setCookie(String name, String value) {
            Cookie cookie = new Cookie(name, value);
            cookie.setMaxAge(-1);
            cookie.setPath(cookiePath);
            if (cookieDomain != null && cookieDomain.trim().length() > 0) {
                cookie.setDomain(cookieDomain);
            }
            
            cookie.setHttpOnly(true);
            response.addCookie(cookie);
        }

    }

}