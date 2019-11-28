
package com.redxun.sys.core.manager;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.sql.DataSource;

import org.apache.commons.compress.archivers.zip.ZipArchiveInputStream;
import org.apache.commons.compress.utils.IOUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.druid.pool.DruidDataSource;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.redxun.bpm.activiti.util.ProcessHandleHelper;
import com.redxun.core.dao.IDao;
import com.redxun.core.database.datasource.DataSourceUtil;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.util.BeanUtil;
import com.redxun.saweb.util.IdUtil;
import com.redxun.sys.core.dao.SysDataSourceDao;
import com.redxun.sys.core.entity.SysDataSource;
import com.redxun.sys.db.entity.SysSqlCustomQuery;
import com.thoughtworks.xstream.XStream;

/**
 * 
 * <pre> 
 * 描述：数据源定义管理 处理接口
 * 作者:ray
 * 日期:2017-02-07 09:03:54
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class SysDataSourceManager extends MybatisBaseManager<SysDataSource>{
	
	protected static Logger logger=LogManager.getLogger(SysDataSourceManager.class);
	
	
	@Resource
	private SysDataSourceDao sysDataSourceDao;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return sysDataSourceDao;
	}
	
	
	
	/**
	 * 判断数据源是否存在。
	 * @param dataSource
	 * @return
	 */
	public boolean isExist(SysDataSource dataSource){
		Integer rtn=sysDataSourceDao.isExist(dataSource);
		return rtn>0;
	}
	
	/**
	 * 从数据源配置加载生成数据源。
	 * @param sysDataSource
	 * @return
	 */
	public DruidDataSource getDsBySysSource(SysDataSource sysDataSource) {
		ProcessHandleHelper.initProcessMessage();
		JsonResult rtn= checkConnection(sysDataSource);
		if(!rtn.isSuccess()){
			ProcessHandleHelper.addErrorMsg(rtn.getMessage());
			return null;
		}
		
		try {
			// 获取对象
			DruidDataSource dataSource = new DruidDataSource();// 初始化对象
			// 开始set它的属性
			String settingJson = sysDataSource.getSetting();
			JSONArray ja = JSONArray.parseArray(settingJson);

			for (int i = 0; i < ja.size(); i++) {
				JSONObject jo = ja.getJSONObject(i);
				Object value = BeanUtil.convertByActType(jo.getString("type"), jo.getString("val"));
				String name=jo.getString("name");
				BeanUtil.setFieldValue(dataSource,name, value);
			}
			dataSource.setName("druid-" + sysDataSource.getAlias());
			dataSource.init(); 
			return dataSource;
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(e.getMessage());
			ProcessHandleHelper.addErrorMsg(e.getMessage());
		}

		return null;
	}
	
	/**
	 * 判断连接是否有效。
	 * @param sysDataSource
	 * @return
	 */
	public JsonResult checkConnection(SysDataSource sysDataSource) {
		String dbType=sysDataSource.getDbType();
		String json=sysDataSource.getSetting();
		JSONArray jsonAry=JSONArray.parseArray(json);
		String url=getValByName(jsonAry, "url");
		String username=getValByName(jsonAry, "username");
		String password=getValByName(jsonAry, "password");
		return  DataSourceUtil.validConn(dbType, url, username, password);
	}
	
	private String getValByName(JSONArray jsonAry,String inName){
		for(int i=0;i<jsonAry.size();i++){
			JSONObject obj=jsonAry.getJSONObject(i);
			String name=obj.getString("name");
			if(inName.equals(name)){
				return obj.getString("val");
			}
		}
		return "";
	}
	
	/**
	 * 初始化系统数据源。
	 * @return
	 */
	public Map<String, DataSource> getDataSource(){
		List<SysDataSource> list=sysDataSourceDao.getInitStart();
		Map<String, DataSource> map=new HashMap<String, DataSource>();
		for(SysDataSource source:list){
			//校验数据连接是否有有效。
			JsonResult result=checkConnection(source);
			if(!result.isSuccess()) continue;
			
			DruidDataSource dataSource=getDsBySysSource(source);
			if(dataSource==null) continue;
			map.put(source.getAlias(), dataSource);
		}
		return map;
	}
	
	public SysDataSource getByAlias(String alias){
		 return sysDataSourceDao.getByAlias(alias);
	}

	public List<SysDataSource> getSysDataSourceByIds(String[] keys) {
		List<SysDataSource> list=new ArrayList<SysDataSource>();
		for (String key : keys) {
			SysDataSource sysSeqId = getByAlias(key);
	
			if(BeanUtil.isEmpty(sysSeqId)) continue;
			list.add(sysSeqId);
		}
		return list;
	}
	
	/**
	 * 
	 * @param file
	 * @param bpmSolutionOpts
	 * @param bpmDefOpts
	 * @param bpmFormViewOpts
	 * @throws Exception
	 */
	public void doImport(MultipartFile file) throws Exception{
		
		ProcessHandleHelper.initProcessMessage();
		
		List<SysDataSource>   list=getBpmSolutionExts(file);
		for(SysDataSource sysDataSource:list){
			doImport(sysDataSource);
		}
	}
	
	/**
	 * 读取上传的对象。
	 * @param file
	 * @param bpmSolutionOpts
	 * @param bpmDefOpts
	 * @param bpmFormViewOpts
	 * @return
	 * @throws UnsupportedEncodingException
	 * @throws IOException
	 */
	private List<SysDataSource> getBpmSolutionExts(MultipartFile file) throws UnsupportedEncodingException, IOException{
		InputStream is = file.getInputStream();
		XStream xstream = new XStream();
		// 设置XML的目录的别名对应的Class名
		xstream.alias("sysSqlCustomQuery", SysSqlCustomQuery.class);
		xstream.autodetectAnnotations(true);
		// 转化为Zip的输入流
		ZipArchiveInputStream zipIs = new ZipArchiveInputStream(is, "UTF-8");
		
		List<SysDataSource> list=new ArrayList<SysDataSource>();

		while ((zipIs.getNextZipEntry()) != null) {// 读取Zip中的每个文件
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			IOUtils.copy(zipIs, baos);
			String xml = baos.toString("UTF-8");
			SysDataSource sysDataSource = (SysDataSource) xstream.fromXML(xml);
			list.add(sysDataSource);
		}
		zipIs.close();
		return list;
	
	}
	
	/**
	 * 导入
	 * @param bpmSolutionExt
	 * @param tenantId
	 * @throws Exception
	 */
	private void doImport(SysDataSource sysDataSource) throws Exception{
		
		/**
		 * 如果方案已经存在则直接退出。
		 * 这里对方案的 租户ID进行修改。
		 */
		sysDataSource.setId(IdUtil.getId());
		Boolean isExist= isExist(sysDataSource);
		if(isExist){
			ProcessHandleHelper.addErrorMsg(sysDataSource.getName() + "数据源已经存在!");
			return;
		}
		//查询
		sysDataSourceDao.create(sysDataSource);
      
	}
	
}
