package com.redxun.sys.core.manager;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.manager.BaseManager;
import com.redxun.core.query.Page;
import com.redxun.core.util.FileUtil;
import com.redxun.saweb.util.IdUtil;
import com.redxun.sys.core.dao.SysFileDao;
import com.redxun.sys.core.entity.FileModel;
import com.redxun.sys.core.entity.SysFile;
import com.redxun.sys.core.util.SysPropertiesUtil;

import java.util.List;

/**
 * <pre>
 * 描述：SysFile业务服务类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Service
public class SysFileManager extends BaseManager<SysFile> {

    @Resource
    private SysFileDao sysFileDao;
    

    @SuppressWarnings("rawtypes")
    @Override
    protected IDao getDao() {
        return sysFileDao;
    }

    /**
     * 返回某模块下某记录的所有附件
     *
     * @param entityName
     * @param recordId
     * @param fileName
     * @param ext
     * @param page
     * @return
     */
    public List<SysFile> getRecordFiles(String entityName, String recordId, String fileName, String ext, Page page) {
        return sysFileDao.getByEntityNameRecordIdFileNameExt(entityName, recordId, fileName, ext, page);
    }

    /**
     * 取得某模块某记录下的所有文件列表
     *
     * @param moduleName 模块名称
     * @param recordId 记录Id
     * @return
     */
    public List<SysFile> getByModelNameRecordId(String moduleName, String recordId) {
        return sysFileDao.getByModelNameRecordId(moduleName, recordId);
    }
    /**
     * 取得应用的图片文件列表
     * @return
     */
    public List<SysFile> getAppImages(){
    	return sysFileDao.getByFromMineType(SysFile.FROM_APP, SysFile.MINE_TYPE_IMAGE);
    }
    /**
     * 通过来源获得个人的图片或应用级下的图片
     * @param from
     * @param userId 图片归属的用户Id
     * @return
     */
    public List<SysFile> getImagesByFrom(String from,String userId){
    	return sysFileDao.getByFromMineType(from,SysFile.MINE_TYPE_IMAGE,userId);
    }

    /**
     * 通过来源获得个人的图片或应用级下的图片
     * @param from
     * @param mineType
     * @param userId
     * @return
     */
    public List<SysFile> getImagesByFrom(String from,String userId,Page page){
        return sysFileDao.getByFromMineType(from,SysFile.MINE_TYPE_IMAGE,userId,page);
    }
    /**
     * 通过来源获得个人的图片或应用级下的图片
     * @param from
     * @param fileName
     * @param userId
     * @return
     */
    public List<SysFile> getImagesByFrom(String from,String userId,String fileName,Page page){
        return sysFileDao.getByFromMineTypeFileName(from,SysFile.MINE_TYPE_IMAGE,userId,fileName,page);
    }


    /**
     * 按来源及媒体类型及用户来源获得图片类型
     * @param from
     * @param mineType
     * @param userId
     * @param fileName 可不传入
     * @param page
     * @return
     */
    public List<SysFile> getByFromMineTypeFileName(String from,String mineType,String userId,String fileName,Page page){
        return sysFileDao.getByFromMineTypeFileName(from,mineType,userId,fileName,page);
    }

    /**
     * 取得应用的图标的列表
     * @return
     */
    public List<SysFile> getAppIcons(){
    	return sysFileDao.getByFromMineType(SysFile.FROM_APP, SysFile.MINE_TYPE_ICON);
    }
    /**
     * 取得应用的图标的列表
     * @param page 分页返回
     * @return
     */
    public List<SysFile> getAppIcons(Page page){
    	return sysFileDao.getByFromMineType(SysFile.FROM_APP, SysFile.MINE_TYPE_ICON ,page);
    }
    
    
    public SysFile createFile(String fileName,byte[] bytes,String from){
		
    	String fileSystem=SysPropertiesUtil.getGlobalProperty("fileSystem","file");
		IFileOperator operator=FileOperatorFactory.getByType(fileSystem);
		
		String fileId = IdUtil.getId();
		
		SysFile file = new SysFile();
		file.setFileId(fileId);
		
		String oriFileName = fileName;

		String extName = FileUtil.getFileExt(oriFileName);
		// 新文件名
		String newFileName = fileId + "." + extName;
		
		FileModel fileModel=operator.createFile(newFileName, bytes);
		file.setPath(fileModel.getRelPath());
		
		file.setFileSystem(fileSystem);
		file.setFileName(oriFileName);
		// 设置新的文件名
		file.setNewFname(newFileName);

		// 设置其来源
		file.setFrom(from);
		file.setExt(extName);
		// 设置上传文件的MINE TYPE
		file.setTotalBytes((long) bytes.length);
		file.setDelStatus("undeleted");
			
		create(file);
		
		file.setFileContent(bytes);
		
		return file;
    }
    
   
    
}
