
package com.redxun.oa.info.manager;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.util.*;

import javax.annotation.Resource;

import com.redxun.bpm.activiti.util.ProcessHandleHelper;
import com.redxun.core.util.BeanUtil;
import com.redxun.saweb.util.IdUtil;
import com.redxun.sys.db.dao.SysSqlCustomQueryDao;
import com.redxun.sys.db.entity.SysSqlCustomQuery;
import com.redxun.sys.db.manager.SysSqlCustomQueryManager;
import com.redxun.sys.echarts.dao.SysEchartsCustomDao;
import com.redxun.sys.echarts.entity.SysEchartsCustom;
import com.redxun.sys.echarts.manager.SysEchartsCustomManager;
import com.thoughtworks.xstream.XStream;
import net.sf.json.JSONObject;
import org.apache.commons.compress.archivers.zip.ZipArchiveInputStream;
import org.apache.commons.compress.utils.IOUtils;
import org.apache.xalan.xslt.Process;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Service;

import com.redxun.bpm.form.entity.BpmFormView;
import com.redxun.core.dao.IDao;
import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.core.engine.FreemarkEngine;
import com.redxun.core.manager.ExtBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.script.GroovyEngine;
import com.redxun.core.util.StringUtil;
import com.redxun.oa.info.dao.InsColumnDefDao;
import com.redxun.oa.info.dao.InsColumnDefQueryDao;
import com.redxun.oa.info.entity.InsColumnDef;
import com.redxun.oa.info.entity.InsColumnEntity;
import com.redxun.saweb.context.ContextUtil;
import org.springframework.web.multipart.MultipartFile;


/**
 * 
 * <pre> 
 * 描述：ins_column_def 处理接口
 * 作者:mansan
 * 日期:2017-08-16 11:39:47
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class InsColumnDefManager extends ExtBaseManager<InsColumnDef>{
	@Resource
	private InsColumnDefDao insColumnDefDao;
	@Resource
	private InsColumnDefQueryDao insColumnDefQueryDao;
	@Resource
	private GroovyEngine groovyEngine;
	@Resource
	private FreemarkEngine freemarkEngine;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return insColumnDefQueryDao;
	}
	
	@Override
	public BaseMybatisDao getMyBatisDao() {
		return insColumnDefQueryDao;
	}
	
	public InsColumnDef getInsColumnDef(String uId){
		InsColumnDef insColumnDef = get(uId);
		return insColumnDef;
	}
	
	/**
	 * 根据栏目获取数据。
	 * @param colId		栏目id
	 * @param ctxPath	上下文路径
	 * @return
	 */
	public String getColHtml(String colId,String ctxPath){
		InsColumnDef insColumnDef = getInsColumnDef(colId);
		if(insColumnDef==null) return "";
        Map<String,Object> params = new HashMap<String, Object>();
        String function = insColumnDef.getFunction();
		params.put("colId", colId);
		params.put("ctxPath", ctxPath);
		
    	
		String html="";
    	if(StringUtil.isNotEmpty(insColumnDef.getTemplet())){
			try{
				if("tabcolumn".equals(insColumnDef.getType())) {//TAB标签页
					List<InsColumnDef> list = new ArrayList<InsColumnDef>();
					if(StringUtil.isNotEmpty(insColumnDef.getTabGroups())){
		    			String[] tabs = insColumnDef.getTabGroups().split(",");
		    			for (int i = 0; i < tabs.length; i++) {
		    				InsColumnDef temp = get(tabs[i]);
		    				if(temp!=null) {
		    					Map<String,Object> tempParams = new HashMap<String, Object>();
			    		        String tempFunction = temp.getFunction();
			    		        tempParams.put("colId", temp.getColId());
			    		        tempParams.put("ctxPath", ctxPath);
			    				InsColumnEntity entity = (InsColumnEntity) groovyEngine.executeScripts(tempFunction,tempParams);		
						    	//构造HTML
			    				tempParams.put("data", entity);
								html=freemarkEngine.parseByStringTemplate(tempParams, temp.getTemplet());
								temp.setTemplet(html);
								if(entity !=null && entity.getObj() instanceof List) {
									temp.setCount(entity.getCount());
								}
		    					list.add(temp);
		    				}
						}
		    		}
					InsColumnEntity entity = new InsColumnEntity(insColumnDef.getName(), "", list.size(), list);
					//构造HTML
			    	params.put("data", entity);
					html=freemarkEngine.parseByStringTemplate(params, insColumnDef.getTemplet());
				}else {
					InsColumnEntity entity = (InsColumnEntity) groovyEngine.executeScripts(function,params);		
			    	//构造HTML
			    	params.put("data", entity);
					html=freemarkEngine.parseByStringTemplate(params, insColumnDef.getTemplet());
				}
			}catch(Exception e){
				logger.debug(e.getMessage());
			}
    	}
		return html;
	}
	
	public List<InsColumnDef> getAllByType(String type,String tenantId){
		return insColumnDefQueryDao.getAllByType(type, tenantId);
	}

	public List<InsColumnDef> getAllAndPublic() {
		QueryFilter qf = new QueryFilter();
		qf.addFieldParam("tenantId", ContextUtil.getCurrentTenantId());
		return insColumnDefQueryDao.getAllAndPublic(qf);
	}

	public boolean isKeyExist(InsColumnDef insColumnDef) {
		String tenantId=ContextUtil.getCurrentTenantId();
		//表示存在
		if(StringUtil.isNotEmpty(insColumnDef.getColId())){
			InsColumnDef oldForm= insColumnDefQueryDao.get(insColumnDef.getColId());
			if(oldForm==null || oldForm.getKey().equals(insColumnDef.getKey())){
				return false;
			}
		}
		Integer rtn= insColumnDefQueryDao.getCountByKey(tenantId, insColumnDef.getKey());
		return rtn>0;
	}

	@Resource
	private SysEchartsCustomManager chartManager;

	@Resource
	private SysSqlCustomQueryManager customQueryManager;

	/**
	 * Author ：Louis
	 * 导出时，获取相关数据：报表，自定义SQL等等
	 * @param ids 多个id
	 * @return 返回值
     */
	public List<InsColumnDef> getColumnDefExtById(String ids, Set<String> extOptions) {
		return addExtList(ids, extOptions);
	}

	private List<InsColumnDef> addExtList(String ids, Set<String> extOptions) {
		List<InsColumnDef> columnDefList = new ArrayList<>();
		for(String id : ids.split(",")) {
			InsColumnDef column = get(id);
			columnDefList.add(column);
		}
		return columnDefList;
	}

	/**
	 * Author: Louis
	 * 导入时，解析文件
	 * @param file 上传文件
	 * @throws Exception
     */
	public void doImport(MultipartFile file, String setting) throws Exception {
		List<InsColumnDef> columnDefList = getInsColumnDefExt(file);
		boolean flag = false;
		String tenantId = ContextUtil.getCurrentTenantId();
		for(InsColumnDef columnDef : columnDefList) {
			columnDef.setTenantId(tenantId);
			importInsColumnDef(columnDef, setting);
		}
	}

	/**
	 * 解析
	 * @param file 上传文件
	 * @return 返回值
	 * @throws Exception
     */
	private List<InsColumnDef> getInsColumnDefExt(MultipartFile file) throws Exception {
		List<InsColumnDef> customQueryList = new ArrayList<>();

		InputStream is = file.getInputStream();
		XStream xstream = new XStream();
		xstream.autodetectAnnotations(true);

		ZipArchiveInputStream zipIs = new ZipArchiveInputStream(is, "UTF-8");
		while ((zipIs.getNextZipEntry()) != null) {
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			IOUtils.copy(zipIs, baos);
			String xml = baos.toString("UTF-8");

			xstream.alias("insColumnDef", InsColumnDef.class);
			InsColumnDef columnDef = (InsColumnDef) xstream.fromXML(xml);
			customQueryList.add(columnDef);
		}
		return customQueryList;
	}

	/**
	 * 导入门户portal
	 */
	private void importInsColumnDef(InsColumnDef columnDef, String setting) {
		columnDef.setTenantId(ContextUtil.getCurrentTenantId());

		//key值不可以重复，先判断是否已经存在
		InsColumnDef oldColumnDef = insColumnDefQueryDao.getByKey(columnDef.getKey());
		if(BeanUtil.isEmpty(oldColumnDef)) {
			columnDef.setColId(IdUtil.getId());
			create(columnDef);
		} else {
			columnDef.setColId(oldColumnDef.getColId());
			update(columnDef);
		}
	}

    //获取自定义手机栏目
    public List<InsColumnDef> getMobileColumnDef(){
        return insColumnDefQueryDao.getMobileColumnDef();
    }

}
