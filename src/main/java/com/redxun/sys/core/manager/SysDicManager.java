package com.redxun.sys.core.manager;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.commons.compress.archivers.zip.ZipArchiveInputStream;
import org.apache.commons.compress.utils.IOUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.redxun.bpm.activiti.util.ProcessHandleHelper;
import com.redxun.core.cache.CacheUtil;
import com.redxun.core.dao.IDao;
import com.redxun.core.manager.BaseManager;
import com.redxun.core.util.BeanUtil;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.util.IdUtil;
import com.redxun.sys.core.dao.SysDicDao;
import com.redxun.sys.core.entity.SysDic;
import com.redxun.sys.core.entity.SysTree;
import com.thoughtworks.xstream.XStream;
/**
 * <pre> 
 * 描述：SysDic业务服务类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Service
public class SysDicManager extends BaseManager<SysDic>{
	@Resource
	private SysDicDao sysDicDao;
	@Resource
	private SysTreeManager sysTreeManager;
	
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return sysDicDao;
	}
	
	/**
	 * 按目录取得当前字典及其下字典的值列表
	 * @param path
	 * @return
	 */
	public List<SysDic> getByPath(String path){
		return sysDicDao.getByPath(path);
	}
	
	 /**
     * 按分类Id获得数据字典列表
     * @param treeId
     * @return
     */
    public List<SysDic> getByTreeId(String treeId){
    	List<SysDic> list= (List<SysDic>) CacheUtil.getCache("SYS_DIC_" + treeId);
    	if(BeanUtil.isEmpty(list)){
    		List<SysDic> tmp= sysDicDao.getByTreeId(treeId);
    		CacheUtil.addCache("SYS_DIC_" + treeId, tmp);
    		return tmp;
    	}
    	else{
    		return list;
    	}
    	
    }
    
    /**
     *  按sysTree父节点和key获取数据字典
     * @param parentId sysTree父节点
     * @param dicKey 数据字典的key值
     * @return
     */
    public List<SysDic> getByParentId(String parentId,String dicKey){
    	return sysDicDao.getByParentId(parentId,dicKey);
    }
    
    /**
     * 按分类Id获得某一个节点下所有数据字典（不排序）
     * @param treeId 分类Id
     * @return
     */
    public List<SysDic> getBySysTreeId(String treeId){
    	return sysDicDao.getBySysTreeId(treeId);
    }
    

    /**
     * 按分类key和数字字典key获取数据字典
     * @param key 分类key
     * @param dicKey 数字字典key
     * @return
     */
    public SysDic getBySysTreeKeyAndDicKey(String key,String dicKey){
    	return sysDicDao.getBySysTreeKeyAndDicKey(key, dicKey);
    }
    
    /**
     * 按分类的key获取数据字典
     * @param key 分类Key
     * @return
     */
    public List<SysDic> getByTreeKey(String key){
    	return sysDicDao.getByTreeKey(key);
    }

    /**
	 * 
	 * @param file
	 * @param bpmSolutionOpts
	 * @param bpmDefOpts
	 * @param bpmFormViewOpts
	 * @throws Exception
	 */
	public void doImport(MultipartFile file,String path) throws Exception{
		
		ProcessHandleHelper.initProcessMessage();
		
		List<SysTree> list = getBpmSolutionExts(file);
		String tenantId = ContextUtil.getCurrentTenantId();
		Map<String,String> treeIds = getTreeIdsMap(list);
		for(SysTree sysTree:list){
			//获取path路径
			String paths = sysTree.getPath();
			String[] p = paths.split("\\.");
			int i = 2;
			if(!treeIds.containsKey(p[i])) {
				i++;
			}
			paths = paths.substring(paths.indexOf(p[i]));
			//旧ID替换为新ID
			sysTree.setTreeId(treeIds.get(sysTree.getTreeId()));
			Set<Entry<String, String>> set = treeIds.entrySet();
			//路径中旧ID替换为新ID
			for (Entry<String, String> entry : set) {
				paths = paths.replace(entry.getKey(), entry.getValue());
			}
			boolean flag = doImportTree(sysTree, tenantId, path+paths);
			if(flag) {
				doImportDic(sysTree, tenantId);
			}
		}
	}
	
	private Map<String, String> getTreeIdsMap(List<SysTree> list) {
		Map<String, String> map = new HashMap<String,String>();
		for (SysTree sysTree : list) {
			//新ID
			String treeId = IdUtil.getId();
			//旧ID和新ID的关系映射
			map.put(sysTree.getTreeId(), treeId);
		}
		
		return map;
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
	private List<SysTree> getBpmSolutionExts(MultipartFile file) throws UnsupportedEncodingException, IOException{
		InputStream is = file.getInputStream();
		XStream xstream = new XStream();
		// 设置XML的目录的别名对应的Class名
		xstream.alias("sysTree", SysTree.class);
		xstream.autodetectAnnotations(true);
		// 转化为Zip的输入流
		ZipArchiveInputStream zipIs = new ZipArchiveInputStream(is, "UTF-8");
		
		List<SysTree> list = new ArrayList<SysTree>();
		
		while ((zipIs.getNextZipEntry()) != null) {// 读取Zip中的每个文件
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			IOUtils.copy(zipIs, baos);
			String xml = baos.toString("UTF-8");
			SysTree sysTree = (SysTree) xstream.fromXML(xml);
			list.add(sysTree);
		}
		zipIs.close();
		return list;
	
	}
	
	/**
	 * 导入
	 * @param sysTree
	 * @param tenantId
	 * @param path
	 * @return
	 */
	private boolean doImportTree(SysTree sysTree,String tenantId,String path) {
		sysTree.setTenantId(tenantId);
		Boolean isExist= sysTreeManager.isKeyExistInCat(sysTree.getKey(), sysTree.getCatKey(), tenantId);
		if(isExist){
			ProcessHandleHelper.addErrorMsg(sysTree.getName() + "数据字典已经存在!");
			return false;
		}
		sysTree.setPath(path);
		String[] ps = path.split("\\.");
		String parentId = ps[ps.length-2];
		sysTree.setParentId(parentId);
		sysTree.setDepth(ps.length-1);
		sysTreeManager.create(sysTree);
		return true;
	}
	
	/**
	 * 导入
	 * @param bpmSolutionExt
	 * @param tenantId
	 * @throws Exception
	 */
	private void doImportDic(SysTree sysTree,String tenantId) throws Exception{
		
		Map<String,String> dicIds=getDicIdsMap(sysTree.getSysDics());
		
		for (SysDic sysDic : sysTree.getSysDics()) {
			//获取path路径
			String paths = sysDic.getPath();
			//旧ID替换为新ID
			sysDic.setDicId(dicIds.get(sysDic.getDicId()));
			Set<Entry<String, String>> set = dicIds.entrySet();
			//路径中旧ID替换为新ID
			for (Entry<String, String> entry : set) {
				paths = paths.replace(entry.getKey(), entry.getValue());
			}
			String[] p = paths.split("\\.");
			int i = 0;
			if(!dicIds.containsKey(p[i])) {
				i++;
			}
			paths = paths.substring(paths.indexOf(p[i]));
			sysDic.setPath("0."+paths);
			String parentId = p[p.length-2];
			sysDic.setParentId(parentId);
			sysDic.setTypeId(sysTree.getTreeId());
			sysDic.setTenantId(tenantId);
			sysDicDao.create(sysDic);
		}
      
	}
	
	private Map<String, String> getDicIdsMap(List<SysDic> list) {
		Map<String, String> map = new HashMap<String,String>();
		for (SysDic sysDic : list) {
			//新ID
			String dicId = IdUtil.getId();
			//旧ID和新ID的关系映射
			map.put(sysDic.getDicId(), dicId);
		}
		
		return map;
	}
	
}