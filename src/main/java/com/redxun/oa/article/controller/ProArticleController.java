package com.redxun.oa.article.controller;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.compress.archivers.ArchiveException;
import org.apache.commons.compress.archivers.ArchiveOutputStream;
import org.apache.commons.compress.archivers.ArchiveStreamFactory;
import org.apache.commons.compress.archivers.zip.ZipArchiveEntry;
import org.apache.commons.compress.utils.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.redxun.core.engine.FreemarkEngine;
import com.redxun.core.json.JsonResult;
import com.redxun.core.manager.ExtBaseManager;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.FileUtil;
import com.redxun.core.util.PdfUtil;
import com.redxun.core.util.StringUtil;
import com.redxun.core.util.Tree;
import com.redxun.oa.article.entity.ProArticle;
import com.redxun.oa.article.entity.ProItem;
import com.redxun.oa.article.manager.ProArticleManager;
import com.redxun.oa.article.manager.ProItemManager;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.MybatisListController;
import com.redxun.saweb.util.IdUtil;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.RequestUtil;
import com.redxun.saweb.util.WebAppUtil;
import com.redxun.sys.core.entity.SysFile;
import com.redxun.sys.core.manager.SysFileManager;
import com.redxun.sys.log.LogEnt;
import com.thoughtworks.xstream.XStream;

import freemarker.template.TemplateException;

/**
 * 文章控制器
 * 
 * @author 陈茂昌
 */
@Controller
@RequestMapping("/oa/article/proArticle/")
public class ProArticleController extends MybatisListController {
	@Resource
	ProArticleManager proArticleManager;
	@Resource
	ProItemManager proItemManager;
	@Resource
	FreemarkEngine freemarkEngine;
	@Resource
	SysFileManager sysFileManager;

	@Override
	protected QueryFilter getQueryFilter(HttpServletRequest request) {
		return QueryFilterBuilder.createQueryFilter(request);
	}

	@RequestMapping("del")
	@ResponseBody
	@LogEnt(action = "del", module = "oa", submodule = "文章")
	public JsonResult del(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String uId = RequestUtil.getString(request, "ids");
		if (StringUtils.isNotEmpty(uId)) {
			String[] ids = uId.split(",");
			for (String id : ids) {
				if (!"undefined".equals(id)) {
					proArticleManager.delete(id);
				}
			}
		}
		return new JsonResult(true, "成功删除!");
	}

	/**
	 * 查看明细
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("get")
	public ModelAndView get(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String pkId = RequestUtil.getString(request, "pkId");
		String parentId = RequestUtil.getString(request, "parentId");
		String itemId = RequestUtil.getString(request, "itemId");
		ProArticle proArticle = null;
		if (StringUtils.isNotEmpty(pkId) && !"undefined".equals(pkId)) {
			proArticle = proArticleManager.get(pkId);
		} else {
			proArticle = new ProArticle();
			proArticle.setBelongProId(itemId);
			proArticle.setParentId(parentId);
		}
		return getPathView(request).addObject("proArticle", proArticle);
	}

	@RequestMapping("getAllByItemId")
	@ResponseBody
	public List<ProArticle> getAllByItemId(HttpServletRequest request,
			HttpServletResponse response) {
		String itemId = RequestUtil.getString(request, "itemId");
		ProItem proItem = proItemManager.get(itemId);
		List<ProArticle> proArticles = proArticleManager.getByItemId(itemId);
		ProArticle proArticle = new ProArticle();
		proArticle.setParentId("-1");
		proArticle.setId("0");
		proArticle.setTitle(proItem.getName());
		proArticle.setType("root");
		proArticle.setBelongProId(itemId);
		proArticles.add(proArticle);
		return proArticles;
	}

	@RequestMapping("view")
	public ModelAndView view(HttpServletRequest request,
			HttpServletResponse response) {
		String proId = RequestUtil.getString(request, "pkId");
		ProItem item=proItemManager.get(proId);
		return this.getPathView(request).addObject("proId", proId)
				.addObject("alias", item.getAlias());
	}

	@RequestMapping("moveArticle")
	@ResponseBody
	public JSONObject moveArticle(HttpServletRequest request,
			HttpServletResponse response) {
		String nodeId = RequestUtil.getString(request, "nodeId");
		String targetId = RequestUtil.getString(request, "targetId");
		ProArticle proArticle = proArticleManager.get(nodeId);
		proArticle.setParentId(targetId);
		JSONObject jsonObject = new JSONObject();
		try {
			proArticleManager.update(proArticle);
			jsonObject.put("success", true);
			return jsonObject;
		} catch (Exception e) {
			jsonObject.put("success", false);
			return jsonObject;
		}
	}

	@RequestMapping("edit")
	public ModelAndView edit(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String pkId = RequestUtil.getString(request, "pkId");
		String parentId = RequestUtil.getString(request, "parentId");
		String itemId = RequestUtil.getString(request, "itemId");
		ProArticle proArticle = null;
		if (StringUtils.isNotEmpty(pkId)) {
			proArticle = proArticleManager.get(pkId);
		} else {
			proArticle = new ProArticle();
			proArticle.setParentId(parentId);
			proArticle.setBelongProId(itemId);
			proArticle.setType("article");
			proArticle.setAuthor(ContextUtil.getCurrentUser().getFullname());
		}
		return getPathView(request).addObject("proArticle", proArticle);
	}

	@RequestMapping("previewHtml/{proId}")
	@ResponseBody
	public JsonResult<String> previewHtml(@PathVariable(value="proId")String proId) throws IOException {
		JsonResult<String> result=proArticleManager.genArticleByProId(proId);
		return result;
	}

	/**
	 * 将html转换成pdf文件下载
	 * @param response
	 * @param request
	 * @throws IOException
	 * @throws TemplateException
	 */
	@RequestMapping("parseHtml2Pdf")
	public void parseHtml2Pdf(HttpServletResponse response,
			HttpServletRequest request) throws IOException, TemplateException {
		String itemId = RequestUtil.getString(request, "itemId");
		String password = RequestUtil.getString(request, "password");//pdf的加密
		ProItem proItem = proItemManager.get(itemId);
		List<ProArticle> proArticles = proArticleManager.getByItemId(itemId);// 将所有文章通过项目ID取出
		proArticleManager. translate2PdfImg(proArticles);// 将文章里所有的图片转换成pdf接受的真实物理地址

		List<ProArticle> list = BeanUtil.listToTree(proArticles);// 将文章列表转换成树状结构
		setSplitPage(list);
		setArticleTitle(list, "");
		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("dto", list);
		String content=proItem.getDesc()==null ?"":proItem.getDesc();
		content=proArticleManager.translate2PdfImg(content);
		
		dataMap.put("cover",content);

		String fileName = FileUtil.getWebRootPath() + File.separator + "doc"
				+ File.separator + proItem.getName() + ".pdf";
		String pdfContent = freemarkEngine.mergeTemplateIntoString( "rqt/genPdf.ftl", dataMap);// 根据ftl生成整体html
		File file = new File(fileName);
		if (!file.getParentFile().exists()) {
			file.getParentFile().mkdirs();
		}
		pdfContent = pdfContent.replaceAll("<br.*?/>", "<br/>");//替换掉br中部合理的部分避免不被识别
		PdfUtil.parsePdf(pdfContent, fileName, password);// 将html转换成pdf

		String downloadFileName = URLEncoder.encode(file.getName(), "UTF-8");
		response.setHeader("Content-Disposition", "attachment;filename="
				+ downloadFileName);
		FileUtil.downLoad(file, response);

	}

	

	private void setSplitPage(List proArticles) {
		int proSize = proArticles.size();
		for (int i = 0; i < proSize; i++) {
			ProArticle proArticle = (ProArticle) proArticles.get(i);
			List articles = proArticle.getChildren();// 子节点列表
			if ("index".equals(proArticle.getType())) {// 假如下个需要合页
				if (articles != null && articles.size() > 0) {// 有子节点
					ProArticle article = (ProArticle) articles.get(0);
					article.setOutLine("cross");
				} else if ((i + 1) < proSize) {// 有兄弟节点
					ProArticle article = (ProArticle) proArticles.get(i + 1);
					article.setOutLine("cross");
				}
			}
			if (articles != null && articles.size() > 0) {// 递归给子节点列表
				setSplitPage(articles);
			}
		}
	}

	/**
	 * 将文章列表挨个设置标题
	 * 
	 * @param proArticles
	 * @param prefixNum
	 */
	public void setArticleTitle(List proArticles, String prefixNum) {
		String[] fontSignal = prefixNum.split("[.]");
		int fontSize = fontSignal.length;
		for (int i = 0; i < proArticles.size(); i++) {
			ProArticle proArticle = (ProArticle) proArticles.get(i);
			proArticle.setPrefixTitle(prefixNum);
			proArticle.setTitleLevel(fontSize);
			List<Tree> subArticles = proArticle.getChildren();
			if (subArticles != null && subArticles.size() > 0) {
				setArticleTitle(subArticles, prefixNum + (i + 1) + ".");
			}
		}
	}

	/**
	 * 生成文件地址
	 */
	public void setFilesAddress() {

	}

	@SuppressWarnings("rawtypes")
	@Override
	public MybatisBaseManager getBaseManager() {
		return proArticleManager;
	}

	/**
	 * 导出为xml格式
	 * 
	 * @param response
	 * @throws IOException
	 * @throws ArchiveException
	 */
	@RequestMapping("exportZip")
	public void exportZip(HttpServletRequest request,
			HttpServletResponse response) throws ArchiveException, IOException {
		String submitNodes = RequestUtil.getString(request, "submitNodes");
		String firstNodeId = RequestUtil.getString(request, "firstNodeId");
		String[] articleIds = submitNodes.split(",");

		List<ProArticle> proArticles = proArticleManager.getByIds(articleIds);// JSONArray.parseArray(submitNodes,
																				// ProArticle.class);
		if ("0".equals(firstNodeId)) {
			ProArticle proArticle = new ProArticle();
			proArticle.setId("0");
			proArticle.setParentId("-1");
			proArticles.add(proArticle);
		}
		response.setContentType("application/zip");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String downFileName = "export-article-" + sdf.format(new Date());
		response.addHeader("Content-Disposition", "attachment; filename=\""
				+ downFileName + ".zip\"");

		ArchiveOutputStream zipOutputStream = new ArchiveStreamFactory()
				.createArchiveOutputStream(ArchiveStreamFactory.ZIP,
						response.getOutputStream());

		for (int i = 0; i < proArticles.size(); i++) {
			ProArticle ext = proArticles.get(i);
			if (firstNodeId.equals(ext.getId())) {
				ext.setPrefixTitle("first");
			}
			putArticlePictureIntoZip(ext, zipOutputStream);
			XStream xstream = new XStream();
			xstream.autodetectAnnotations(true);
			// 生成XML
			String xml = xstream.toXML(ext);

			zipOutputStream.putArchiveEntry(new ZipArchiveEntry(ext.getTitle()
					+ ext.getId() + ".xml"));
			InputStream is = new ByteArrayInputStream(xml.getBytes("UTF-8"));
			IOUtils.copy(is, zipOutputStream);
			zipOutputStream.closeArchiveEntry();
		}
		zipOutputStream.close();
	}
	/**
	 * 将文章内的文件一起存放到zip包里,原理是通过src下的fileId挨个下载图片文件再存放
	 * @param proArticle
	 * @param zipOutputStream
	 * @throws IOException
	 */
	private void putArticlePictureIntoZip(ProArticle proArticle,
			ArchiveOutputStream zipOutputStream) throws IOException {
		String content = proArticle.getContent();
		if(StringUtil.isEmpty(content)) return;

		Document document = Jsoup.parse(content);
		org.jsoup.select.Elements elements = document.select("img[src]");
		for (Element element : elements) {// 将图片由ID转换成file:/带头的绝对路径
			element.append(" ");
			String imgUrl = element.attr("src");
			if(imgUrl.indexOf("fileId=")==-1) continue;
			String[] urlArray = imgUrl.split("fileId=");
			String fileId = urlArray[1];
			SysFile sysFile = sysFileManager.get(fileId);
			String path = WebAppUtil.getUploadPath() + "/" + sysFile.getPath();
			File file = new File(path);
			ZipArchiveEntry zipArchiveEntry = new ZipArchiveEntry(file, sysFile.getFileId() + sysFile.getExt());
			zipOutputStream.putArchiveEntry(zipArchiveEntry);
			FileInputStream fileInputStream = new FileInputStream(file);
			IOUtils.copy(fileInputStream, zipOutputStream);
			zipOutputStream.closeArchiveEntry();
		}

	}

	/**
	 * 从zip包导入附件
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("importZip")
	public void importZip(MultipartHttpServletRequest request,
			HttpServletResponse response) throws Exception {
		MultipartFile f = request.getFile("zip");
		String articleId = request.getParameter("articleId");
		String itemId = request.getParameter("itemId");
		String contextRoot = FileUtil.getWebRootPath();
		String genZipFile = contextRoot + File.separator + "articleZip"
				+ File.separator + "temp.zip";
		File file = new File(genZipFile);
		if (!file.exists()) {
			file.mkdirs();
		}
		f.transferTo(file);// multipartFile转file
		List<ProArticle> proArticles = getArticlesFromZip(file, request);
		ProArticle article = null;
		for (int i = 0; i < proArticles.size(); i++) {
			ProArticle tempArticle = proArticles.get(i);
			if ("first".equals(tempArticle.getPrefixTitle())) {
				article = tempArticle;
				recursiveChangeArticleStructure(proArticles,
						article.getParentId(), articleId, itemId);
				file.delete();
				break;
			}
		}
	}

	/**
	 * 迭代加入文章结构
	 * 
	 * @param proArticles
	 * @param beforeId
	 *            修改前的Id
	 * @param afterId
	 *            修改后的Id
	 */
	private void recursiveChangeArticleStructure(List<ProArticle> proArticles,
			String beforeId, String afterId, String itemId) {
		for (int i = 0; i < proArticles.size(); i++) {
			ProArticle proArticle = proArticles.get(i);
			String proParentId = proArticle.getParentId();
			if (beforeId.equals(proParentId)) {// 查找需要更改的文章
				if (!"-1".equals(proParentId)) {// 如果不是虚拟节点
					proArticle.setParentId(afterId);
					proArticle.setBelongProId(itemId);
					String preParentId = proArticle.getId();
					proArticle.setId(IdUtil.getId());
					proArticleManager.create(proArticle);
					recursiveChangeArticleStructure(proArticles, preParentId,
							proArticle.getId(), itemId);// 往下查找并改变
				} else {
					recursiveChangeArticleStructure(proArticles,
							proArticle.getId(), afterId, itemId);
				}
			}
		}
	}

	/**
	 * 从ZIP文件中读取proArticle
	 * 
	 * @param file
	 * @return
	 * @throws Exception
	 */
	private List<ProArticle> getArticlesFromZip(File file,
			HttpServletRequest request) throws Exception {
		List<ProArticle> list = new ArrayList<ProArticle>();
		String contextRoot = FileUtil.getWebRootPath();
		String unzipPath = contextRoot + File.separator + "articleUnzip"
				+ File.separator + "temp";//临时生成一个目录,读取完毕将要删除
		FileUtil.unzip(file.getPath(), unzipPath, false);//将读取的zip解压至临时目录
		File[] files = FileUtil.getFiles(unzipPath);//遍历获取所有文件
		XStream xstream = new XStream();
		xstream.alias("proArticle", ProArticle.class);
		xstream.autodetectAnnotations(true);//使用xstream自动读取java注解
		for (int i = 0; i < files.length; i++) {
			File pFile = files[i];
			String pFileName = pFile.getName();//获取zip里面的文件名
			if (pFileName.lastIndexOf(".xml") != -1) {// 如果是xml格式
				InputStream is = new FileInputStream(pFile);
				ByteArrayOutputStream baos = new ByteArrayOutputStream();
				IOUtils.copy(is, baos);//文件流转字节流
				String xml = baos.toString("UTF-8");
				ProArticle proArticle = (ProArticle) xstream.fromXML(xml);
				dealWithImageSrc(proArticle, request);//处理文件夹内的图片对应到富文本内
				list.add(proArticle);
				is.close();
				baos.close();
			} else {
				uploadLocalImage(pFile);
			}
		}
		File redyDelete = new File(unzipPath);
		FileUtil.deleteDir(redyDelete);
		return list;

	}

	/**
	 * 将文件富文本内容中本地图片地址转换成fileId
	 * (同时上传)
	 * @param proArticle
	 * @param request
	 */
	private void dealWithImageSrc(ProArticle proArticle,
			HttpServletRequest request) {
		String content = proArticle.getContent();
		if (StringUtils.isNotBlank(content)) {
			Document document = Jsoup.parse(content);
			Elements elements = document.select("img[src]");//选中带有src的img标签
			for (Element element : elements) {// 将图片由ID转换成file:/带头的绝对路径
				element.append(" ");
				String imgUrl = element.attr("src");
				String[] urlArray = imgUrl.split("fileId=");
				if(urlArray.length<2) return;
				String fileId = urlArray[1];
				element.attr("src", request.getContextPath()
						+ "/sys/core/file/previewFile.do?fileId=" + fileId);//将src写的物理地址换成资源请求地址
			}
			proArticle.setContent(document.toString());
		}
	}

	/**
	 * 
	 * @param image
	 * @throws IOException
	 */
	private void uploadLocalImage(File image) throws IOException {
		String[] structureName = image.getName().split("[.]");
		String userId = ContextUtil.getCurrentUserId();
		String fileId = structureName[0];
		String ext = structureName[1];
		SysFile sysFile = sysFileManager.get(fileId);
		if (sysFile == null) {// 如果没有该文件,则重新上传,并置为该ID
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
			String tempPath = sdf.format(new Date());
			String relFilePath = userId + "/" + tempPath;
			String fullPath = WebAppUtil.getUploadPath() + "/" + relFilePath
					+ "/" + image.getName();
			String fullDir = WebAppUtil.getUploadPath() + "/" + relFilePath ;
			File dir = new File(fullDir);
			if (!dir.exists()) { dir.mkdirs(); }
			
			SysFile newFile = new SysFile();
			newFile.setFileId(fileId);
			newFile.setFileName(image.getName());
			newFile.setNewFname(image.getName());
			newFile.setExt("." + ext);
			newFile.setMineType(SysFile.MINE_TYPE_IMAGE);
			newFile.setCreateBy(userId);
			newFile.setCreateTime(new Date());
			newFile.setFrom("UEDITOR");
			newFile.setDelStatus("undeleted");
			newFile.setPath(relFilePath + "/" + image.getName());
			newFile.setTotalBytes(image.getTotalSpace());
			newFile.setTenantId(ContextUtil.getCurrentTenantId());
			sysFileManager.create(newFile);
			
			FileUtil.copyFile(image.getPath(), fullPath);
			// FileUtil.copyFileUsingFileChannels(image, dirFile);
		}
	}

	
}
