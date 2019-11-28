
package com.redxun.oa.article.manager;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Service;

import com.redxun.core.dao.IDao;
import com.redxun.core.dao.mybatis.BaseMybatisDao;
import com.redxun.core.engine.FreemakerUtil;
import com.redxun.core.engine.FreemarkEngine;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.ExceptionUtil;
import com.redxun.core.util.FileUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.oa.article.dao.ProArticleDao;
import com.redxun.oa.article.entity.ProArticle;
import com.redxun.oa.article.entity.ProItem;
import com.redxun.saweb.util.WebAppUtil;
import com.redxun.sys.core.entity.SysFile;
import com.redxun.sys.core.manager.SysFileManager;

import freemarker.template.TemplateHashModel;

/**
 * 
 * <pre> 
 * 描述：文章 处理接口
 * 作者:陈茂昌
 * 日期:2017-09-29 14:39:26
 * 版权：广州红迅软件
 * </pre>
 */
@Service
public class ProArticleManager extends MybatisBaseManager<ProArticle>{
	@Resource
	private ProArticleDao proArticleDao;
	
	@Resource
	ProItemManager proItemManager;
	@Resource
	FreemarkEngine freemarkEngine;
	
	@Resource
	SysFileManager sysFileManager;
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return proArticleDao;
	}
	
	
	
	public ProArticle getProArticle(String uId){
		ProArticle proArticle = get(uId);
		return proArticle;
	}
	public List<ProArticle> getByItemId(String itemId){
		return proArticleDao.getByItemId(itemId);
	}
	public List<ProArticle> getByIds(String[] ids){
		return proArticleDao.getByIds(ids);
	}
	
	/**
	 * 将服务器版文件转换成本地html,顺带把图片都存到本地
	 * @param content
	 * @param targetSrc
	 * @return
	 * @throws Exception
	 */
	public String translate2LocalHtml(String content,String targetSrc) throws Exception{
		if(StringUtil.isEmpty(content)) return "";
		
		Document document=Jsoup.parse(content);
 		Elements elements=document.select("img[src]");
		for (Element element : elements) {
	        String imgUrl = element.attr("src");
	        String[] urlArray=imgUrl.split("fileId=");
	        String fileId=urlArray[1];
	        SysFile sysFile=sysFileManager.get(fileId);	
	        if(sysFile==null) continue;
	        String suffix=sysFile.getExt();
	        String path=WebAppUtil.getUploadPath()+ File.separator +sysFile.getPath();
	        File sourceFile=new File(path);
	        if(!sourceFile.exists()) continue;
	        File targetFile=new File(targetSrc+File.separator+"img"+File.separator+fileId+suffix);
	        if (!targetFile.getParentFile().exists()) {
	        	targetFile.getParentFile().mkdirs();
			}
	        FileUtil.copyFileUsingFileChannels(sourceFile, targetFile);
	        element.attr("src", "../img/"+targetFile.getName());
	      }
		Element element=document.getElementsByTag("body").first();
		return element.toString();
	}
	
	/**
	 * 将html里的图片转换成文件系统格式文件地址(真实物理地址)
	 * 
	 * @param proArticles
	 */
	public void translate2PdfImg(List<ProArticle> proArticles) {
		for (ProArticle proArticle : proArticles) {// 遍历所有文章
			String content = proArticle.getContent();
			// 不为空则进行操作
			if (StringUtil.isEmpty(content)) continue;
			String newContent=translate2PdfImg(content);
			proArticle.setContent(newContent);
		}
	}
	
	/**
	 * 将文章的内容进行替换。
	 * @param content
	 * @return
	 */
	public String translate2PdfImg(String content){
		if(StringUtil.isEmpty(content)) return content;
		Document document = Jsoup.parse(content);
		Elements elements = document.select("img[src]");
		for (Element element : elements) {// 将图片由ID转换成file:/带头的绝对路径
			element.append(" ");
			String imgUrl = element.attr("src");
			String[] urlArray = imgUrl.split("fileId=");
			if(urlArray.length<2)continue;
			String fileId = urlArray[1];
			SysFile sysFile = sysFileManager.get(fileId);
			if(sysFile==null)continue;
			String path = WebAppUtil.getUploadPath() + "/" + sysFile.getPath();
			//是windows 的情况
			if(File.separator.equals("\\")){
				path="file:/" + path;
			}
			element.attr("src", path);
			try {
				if (FileUtil.getImageWidth(path) > 690) {
					element.attr("style", "width:690px;");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		Element element = document.getElementsByTag("body").first();
		String newContent = element.children().toString();
		newContent = newContent.replace("<br>", "<br/>");// 将没有结束符的回车修改成有结束符的回车
		return newContent;
	}
	
	/**
	 * 生成项目的HTML
	 * @param proId
	 * @return
	 * @throws IOException
	 */
	public JsonResult<String> genArticleByProId(String proId) throws IOException{
		JsonResult<String> result=new JsonResult<String>(true,"生成项目文档成功!");
		ProItem proItem = proItemManager.get(proId);
		String contextRoot = FileUtil.getWebRootPath();//获取生成文档项目的目录
		List<ProArticle> proArticles = this.getByItemId(proId);
		String genSrc = contextRoot + File.separator + "doc" + File.separator + proItem.getAlias() ;
		genSrc=genSrc.replace("/", File.separator);
		
		result.setData(genSrc);//将目录信息传回前端
		
		List<ProArticle> list = BeanUtil.listToTree(proArticles);// 构建树形结构数据

		try {
			TemplateHashModel util=FreemakerUtil.getTemplateModel(StringUtil.class);
			Map<String, Object> dataMap = new HashMap<String, Object>();
			dataMap.put("dto", list);
			dataMap.put("proItemName", proItem.getName());
			dataMap.put("util", util);
			
			String indexContent = freemarkEngine.mergeTemplateIntoString("rqt/articleIndex.ftl", dataMap);//使用模板将内容填充进去生成HTML
			FileUtil.writeFile(genSrc + File.separator + "index.html",indexContent);
			
			Map<String, Object> porjectMap = new HashMap<String, Object>();
			porjectMap.put("content", proItem.getDesc());//填充项目概述
			porjectMap.put("name", proItem.getName());
			
			String homeContent = freemarkEngine.mergeTemplateIntoString("rqt/home.ftl", porjectMap);
			FileUtil.writeFile(genSrc + File.separator + "home.html",homeContent);
			
			
			for (ProArticle proArticle : proArticles) {// 遍历每篇文章内容
				String content = proArticle.getContent();// 原始content
				if(StringUtil.isEmpty(content) ) continue;
				
				String	newContent = this.translate2LocalHtml(content, genSrc);// 转换后的content
				Map<String, Object> articleMap = new HashMap<String, Object>();
				articleMap.put("title", proArticle.getTitle());
				articleMap.put("content", newContent);
				
				String articleContent = freemarkEngine.mergeTemplateIntoString("rqt/article.ftl", articleMap);
								
				String newFileName = genSrc + File.separator + "html" + File.separator + proArticle.getId() + ".html";// 生成的文件名
				
				FileUtil.writeFile(newFileName, articleContent);

			}

		} catch (Exception e) {
			result.setSuccess(false);
			result.setMessage(ExceptionUtil.getExceptionMessage(e));
		}
		return result;
	}
}
