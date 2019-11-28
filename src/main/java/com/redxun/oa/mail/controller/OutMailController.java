package com.redxun.oa.mail.controller;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.channels.FileChannel;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;
import java.util.Set;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.annotation.Resource;
import javax.mail.BodyPart;
import javax.mail.Flags.Flag;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.Part;
import javax.mail.Session;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.redxun.core.json.JsonPageResult;
import com.redxun.core.json.JsonResult;
import com.redxun.core.mail.MailTools;
import com.redxun.core.mail.api.AttacheHandler;
import com.redxun.core.mail.model.Mail;
import com.redxun.core.mail.model.MailAttachment;
import com.redxun.core.manager.BaseManager;
import com.redxun.core.query.QueryFilter;
import com.redxun.core.query.SortParam;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.FileUtil;
import com.redxun.oa.mail.entity.MailConfig;
import com.redxun.oa.mail.entity.MailFolder;
import com.redxun.oa.mail.entity.OutMail;
import com.redxun.oa.mail.manager.MailConfigManager;
import com.redxun.oa.mail.manager.MailFolderManager;
import com.redxun.oa.mail.manager.OutMailManager;
import com.redxun.org.api.model.IUser;
import com.redxun.saweb.config.upload.FileExt;
import com.redxun.saweb.config.upload.FileUploadConfig;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.controller.TenantListController;
import com.redxun.saweb.util.IdUtil;
import com.redxun.saweb.util.QueryFilterBuilder;
import com.redxun.saweb.util.WebAppUtil;
import com.redxun.sys.core.entity.SysFile;
import com.redxun.sys.core.manager.SysFileManager;

/**
 * 外部邮件Controller
 * 
 * @author zwj 用途：处理对外部邮件相关操作的请求映射
 */
@Controller
@RequestMapping("/oa/mail/outMail/")
public class OutMailController extends TenantListController {

	@Resource(name = "iJson")
	ObjectMapper objectMapper;

	@Resource
	FileUploadConfig fileUploadConfig;

	
	@Resource
	SysFileManager sysFileManager;

	@Resource
	OutMailManager outMailManager;

	@Resource
	MailConfigManager mailConfigManager;

	@Resource
	MailFolderManager mailFolderManager;
	
	/**
	 * 根据主键删除外部邮件
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("del")
	@ResponseBody
	public JsonResult del(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String uId = request.getParameter("ids");
		if (StringUtils.isNotEmpty(uId)) {
			String[] ids = uId.split(",");
			for (String id : ids) {
				outMailManager.delete(id);
			}
		}
		return new JsonResult(true, "成功删除！");
	}

	/**
	 * 将外部邮件改为删除状态
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("delStatus")
	@ResponseBody
	public JsonResult delStatus(HttpServletRequest request) throws Exception {
		String uId = request.getParameter("ids");
		String configId = request.getParameter("configId");
		MailConfig mailConfig = mailConfigManager.get(configId);
		MailTools mailTools = geMailTools(mailConfig);
		if (StringUtils.isNotEmpty(uId)) { // 如果mailId不为空
			String[] ids = uId.split(",");
			for (String id : ids) {
				OutMail mail = outMailManager.get(id);
				mailTools.synchronization(mail.getUid(), Flag.DELETED);
				mail.setStatus(OutMail.STATUS_DELETED); // 将邮件状态改为DELETED
				outMailManager.update(mail);
			}
		}
		return new JsonResult(true, "成功删除！");
	}

	/**
	 * 根据主键查看外部邮件
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("get")
	public ModelAndView get(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String pkId = request.getParameter("pkId");
		OutMail mail = null;
		Set<SysFile> attach = null; // 外部邮件附件列表
		if (StringUtils.isNotEmpty(pkId)) {
			mail = outMailManager.get(pkId);
			attach = mail.getInfMailFiles(); // 外部邮件附件列表
			if ("0".equals(mail.getReadFlag())) {
				System.out.println("未读");
				mail.setReadFlag("1"); // 设置为已读
				outMailManager.update(mail);
			}
		} else {
			mail = new OutMail();
		}

		return getPathView(request).addObject("mail", mail).addObject("attach", attach);
	}

	/**
	 * 根据外部邮件mailId获取邮件内容
	 * 
	 * @param request
	 * @throws Exception
	 */
	@RequestMapping("getMailContentByMailId")
	public ModelAndView getMailContentByMailId(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String mailId = request.getParameter("mailId");
		String content = outMailManager.getMailContentByMailId(mailId); // 根据邮件Id获取邮件内容
		request.setAttribute("mailContent", content); // 邮件内容
		return new ModelAndView("oa/mail/mailContent.jsp");
	}

	/**
	 * 根据folderId查询对应文件夹下的外部邮件
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */

	@RequestMapping("getMailByFolderId")
	@ResponseBody
	public JsonPageResult<OutMail> getMailByFolderId(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String mailfolderId = request.getParameter("folderId"); // 文件夹Id
		QueryFilter queryFilter = QueryFilterBuilder.createQueryFilter(request);
		queryFilter.addFieldParam("mailFolder.folderId", mailfolderId);
		queryFilter.addSortParam("sendDate", SortParam.SORT_DESC);
		queryFilter.addFieldParam("status", OutMail.STATUS_COMMEN); // 只获取正常状态的外部邮件
		List<OutMail> list = outMailManager.getAll(queryFilter);
		JsonPageResult<OutMail> result = new JsonPageResult<OutMail>(list, queryFilter.getPage().getTotalItems());
		return result;

	}

	/**
	 * 获取门户Portal的外部邮件List
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("getPortalOutMail")
	@ResponseBody
	public JsonPageResult<OutMail> getPortalOutMail(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String userId = ContextUtil.getCurrentUserId(); // 当前用户Id
		QueryFilter queryFilter = QueryFilterBuilder.createQueryFilter(request);
		queryFilter.addFieldParam("mailFolder.type", MailFolder.TYPE_RECEIVE_FOLDER);
		queryFilter.addFieldParam("mailFolder.inOut", MailFolder.FOLDER_FLAG_OUT);
		queryFilter.addFieldParam("userId", userId);
		queryFilter.addSortParam("sendDate", SortParam.SORT_DESC);
		queryFilter.addFieldParam("status", OutMail.STATUS_COMMEN); // 只获取正常状态的外部邮件
		List<OutMail> list = outMailManager.getAll(queryFilter);
		JsonPageResult<OutMail> result = new JsonPageResult<OutMail>(list, queryFilter.getPage().getTotalItems());
		return result;

	}

	/**
	 * 将外部存邮件到草稿箱
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("saveToDraft")
	@ResponseBody
	public JsonResult saveToDraft(HttpServletRequest request) throws Exception {
		String data = request.getParameter("data");
		String configId = request.getParameter("configId");
		JSONObject jsonObject = JSONObject.parseObject(data); // 转成json对象
		String fileIdsStr = jsonObject.getString("fileIds") == null ? "" : jsonObject.getString("fileIds"); // 附件ID列表
		String[] fileIds = fileIdsStr.split(",");
		OutMail mail = (OutMail) JSONObject.toJavaObject(jsonObject, OutMail.class); // 将json对象转成mail对象
		mail.setMailConfig(mailConfigManager.get(configId));
		mail.setMailFolder(mailFolderManager.getMailFolderByConfigIdAndType(configId, MailFolder.TYPE_DRAFT_FOLDER)); // 根据configId获取对应配置下的草稿箱文件夹
		if (fileIds.length > 0) { // 如果存在有附件
			if (!"".equals(fileIds[0])) {
				for (int i = 0; i < fileIds.length; i++) {
					SysFile attach = sysFileManager.get(fileIds[i]);
					mail.getInfMailFiles().add(attach); // 保存附件
				}
			}
		}
		mail.setSendDate(new Date());
		mail.setMailId(idGenerator.getSID());
		mail.setUserId(ContextUtil.getCurrentUserId());
		mail.setReadFlag("0");
		mail.setReplyFlag("0");
		mail.setStatus(OutMail.STATUS_COMMEN);
		outMailManager.create(mail);
		return new JsonResult(true, "成功保存");
	}

	/**
	 * 将外部邮件移动到垃圾箱
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("moveToDelFolder")
	@ResponseBody
	public JsonResult moveToDelFolder(HttpServletRequest request) throws Exception {
		String uId = request.getParameter("ids");
		if (StringUtils.isNotEmpty(uId)) {
			String[] ids = uId.split(",");
			for (String id : ids) {
				OutMail mail = outMailManager.get(id);
				mail.setMailFolder(mailFolderManager.getMailFolderByConfigIdAndType(mail.getConfigId(),
						MailFolder.TYPE_DEL_FOLDER)); // 根据configId获取对应配置下的垃圾箱文件夹
				MailTools mailTools = geMailTools(mail.getMailConfig());
				outMailManager.update(mail);
			}
		}
		return new JsonResult(true, "成功删除！");
	}

	/**
	 * 将外部邮件移动到指定目录
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("moveMail")
	@ResponseBody
	public JsonResult moveMail(HttpServletRequest request) throws Exception {
		String folderId = request.getParameter("to"); // 目标文件夹Id
		String uId = request.getParameter("ids"); // 需要移动的外部邮件的邮件Id列表
		if (StringUtils.isNotEmpty(uId)) {
			String[] ids = uId.split(",");
			for (String id : ids) {
				OutMail mail = outMailManager.get(id);
				MailFolder folder = mailFolderManager.get(folderId);
				mail.setMailFolder(folder); // 获取目标文件夹
				MailTools mailTools = geMailTools(mail.getMailConfig());
				Flag flag = null;
				if("DRAFT-FOLDER".equals(folder.getType())) {
					flag = Flag.DRAFT;
				}
				if("DEL-FOLDER".equals(folder.getType())) {
					flag = Flag.FLAGGED;
				}
				outMailManager.update(mail);
			}
		}
		return new JsonResult(true, "移动成功！");
	}

	/**
	 * 编辑外部邮件
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("edit")
	public ModelAndView edit(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String pkId = request.getParameter("pkId"); // 邮件Id
		String operation = request.getParameter("operation"); // 邮件操作类型
		String fileIds = request.getParameter("fileIds"); // 附件Id列表
		String configId = request.getParameter("configId");
		JSONArray files = new JSONArray();
		// 复制添加
		String forCopy = request.getParameter("forCopy");
		OutMail mail = null;
		if (StringUtils.isNotEmpty(pkId)) {
			mail = outMailManager.get(pkId);
			String senderAddrs = mail.getSenderAddrs();
			String senderAlias = mail.getSenderAlias();
			String account = mail.getMailConfig().getMailAccount();
			String oldRecAddrs = mail.getRecAddrs();
			String oldRecAlias = mail.getRecAlias();
			mail.setSenderAddrs(mail.getRecAddrs()); // 将发件人改为本账号地址
			mail.setSenderAlias(mail.getRecAlias()); // 设置发件人别名
			if (account.equals(senderAddrs)) {
				mail.setRecAddrs(oldRecAddrs);
				mail.setRecAlias(oldRecAlias);
			} else {
				mail.setRecAddrs(senderAddrs); // 将收件人改为对方账号地址
				mail.setRecAlias(senderAlias); // 设置收件人别名
			}
			for (SysFile sysFile : mail.getInfMailFiles()) { // 获取附件列表,拼接回填附件列表的Id串和文本串
				JSONObject json = new JSONObject();
				json.put("fileId", sysFile.getFileId());
				json.put("fileName", sysFile.getFileName());
				json.put("totalBytes", sysFile.getTotalBytes());
				files.add(json);
			}
			if ("true".equals(forCopy)) {
				mail.setMailId(null);
			}
			if ("reply".equals(operation)) { // 回复
				mail.setSubject("Re:" + mail.getSubject());
			}
			if ("transmit".equals(operation)) { // 转发
				mail.setRecAddrs("");
				mail.setRecAlias("");
				mail.setSubject("Fw:" + mail.getSubject());
			}
		} else {
			// 拼接字符串回显附件
			if ("mailsTransmit".equals(operation)) { // 多封邮件转发
				String[] s = fileIds.split(",");
				for (int i = 0; i < s.length; i++) { // 拼接回填的eml附件列表
					SysFile sysFile = sysFileManager.get(s[i]);
					JSONObject json = new JSONObject();
					json.put("fileId", sysFile.getFileId());
					json.put("fileName", sysFile.getFileName());
					json.put("totalBytes", sysFile.getTotalBytes());
					files.add(json);
				}
			}
			mail = new OutMail();
			MailConfig mailConfig = mailConfigManager.get(configId);
			mail.setMailConfig(mailConfig);
		}
		return getPathView(request).addObject("mail", mail).addObject("files", files.toString());
	}

	/**
	 * 发送外部邮件
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("sendMail")
	@ResponseBody
	public JsonResult sendMail(HttpServletRequest request) throws Exception {
		String data = request.getParameter("data");
		String configId = request.getParameter("configId");
		JSONObject jsonObject = JSONObject.parseObject(data); // 转成json对象
		JSONArray fileIds = jsonObject.getJSONArray("fileIds"); // 附件ID列表
		OutMail mail = (OutMail) JSONObject.toJavaObject(jsonObject, OutMail.class); // 将json对象转成mail对象
		if (StringUtils.isEmpty(mail.getMailId())) {
			mail.setMailConfig(mailConfigManager.get(configId));
			mail.setMailFolder(
					mailFolderManager.getMailFolderByConfigIdAndType(configId, MailFolder.TYPE_SENDER_FOLDER)); // 将该邮件的文件夹保存为发件箱
		} else {
			mail.setMailConfig(outMailManager.get(mail.getMailId()).getMailConfig());
			mail.setMailFolder(mailFolderManager.getMailFolderByConfigIdAndType(
					outMailManager.get(mail.getMailId()).getConfigId(), MailFolder.TYPE_SENDER_FOLDER));
		}
		if (BeanUtil.isNotEmpty(fileIds)) {
			for (Object object : fileIds) {
				SysFile attach = sysFileManager.get(((JSONObject) object).getString("fileId"));
				mail.getInfMailFiles().add(attach);
			}
		}

		mail.setSendDate(new Date());
		if (sendMail(mail)) {
			mail.setMailId(IdUtil.getId());
			mail.setUserId(ContextUtil.getCurrentUserId());
			mail.setReadFlag("1"); // 设置为已读
			mail.setReplyFlag("1"); // 设置为已回复
			mail.setStatus(OutMail.STATUS_COMMEN);
			outMailManager.create(mail);
			return new JsonResult(true, "成功发送！");
		} else {
			return new JsonResult(true, "发送失败！");
		}
		
	}

	/**
	 * 将多封邮件装成eml文件，并转发
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("mailsTransmit")
	@ResponseBody
	public JsonResult mailsTransmit(HttpServletRequest request) throws Exception {
		String uId = request.getParameter("ids"); // 邮件Id列表
		String[] ids = uId.split(",");
		List<OutMail> mails = new ArrayList<OutMail>(); // 所操作的邮件实体
		for (String id : ids) {
			mails.add(outMailManager.get(id));
		}
		Properties p = new Properties();
		p.put("mail.smtp.auth", "true");
		p.put("mail.transport.protocol", "smtp");
		p.put("mail.smtp.host", mails.get(0).getMailConfig().getSmtpHost());
		p.put("mail.smtp.port", mails.get(0).getMailConfig().getSmtpPort());
		Session session = Session.getInstance(p);
		ArrayNode arrayNode = objectMapper.createArrayNode();
		for (int i = 0; i < mails.size(); i++) { // 将每一封要转发的邮件转成eml文件
			Message msg = new MimeMessage(session); // 建立信息
			msg.setFrom(new InternetAddress(mails.get(i).getSenderAddrs())); // 设置发件人
			List<InternetAddress> rec = new ArrayList<InternetAddress>();
			String[] recs = mails.get(i).getRecAddrs().split(","); // 获取邮件收件人
			for (int j = 0; j < recs.length; j++) {
				if ("".equals(recs[j]))
					continue;
				rec.add(new InternetAddress(recs[j]));
			}
			InternetAddress[] address = (InternetAddress[]) rec.toArray(new InternetAddress[rec.size()]); // 将收件人转成InternetAddress数组
			msg.setRecipients(Message.RecipientType.TO, address); // 设置收件人
			if (StringUtils.isNotEmpty(mails.get(i).getCcAddrs())) { // 设置抄送人
				List<InternetAddress> ccs = new ArrayList<InternetAddress>();
				recs = mails.get(i).getCcAddrs().split(","); // 获取邮件抄送人
				for (int j = 0; j < recs.length; j++) {
					if ("".equals(recs[j]))
						continue;
					ccs.add(new InternetAddress(recs[j]));
				}
				address = (InternetAddress[]) ccs.toArray(new InternetAddress[ccs.size()]); // 将收件人转成InternetAddress数组
				msg.setRecipients(Message.RecipientType.CC, address); // 设置抄送人
			}
			if (StringUtils.isNotEmpty(mails.get(i).getBccAddrs())) { // 设置暗送人
				List<InternetAddress> bccs = new ArrayList<InternetAddress>();
				recs = mails.get(i).getBccAddrs().split(",");
				for (int j = 0; j < recs.length; j++) {
					if ("".equals(recs[j]))
						continue;
					bccs.add(new InternetAddress(recs[j]));
				}
				address = (InternetAddress[]) bccs.toArray(new InternetAddress[bccs.size()]); // 将收件人转成InternetAddress数组
				msg.setRecipients(Message.RecipientType.BCC, address); // 设置暗送人
			}
			msg.setSentDate(new Date()); // 发送日期
			String subject = MimeUtility.encodeText(mails.get(i).getSubject(), "utf-8", "B"); // 加密主题
			msg.setSubject(subject); // 主题

			Multipart mainPart = new MimeMultipart(); // 附件
			BodyPart bp = new MimeBodyPart();// 创建一个包含附件内容的MimeBodyPart
			// 设置HTML内容
			bp.setContent(mails.get(i).getContent(), "text/html; charset=utf-8");
			mainPart.addBodyPart(bp);

			// 添加附件
			MimeBodyPart mimeBodyPart;
			FileDataSource fileDataSource;
			Set<SysFile> set = mails.get(i).getInfMailFiles(); // 附件集合
			Iterator<SysFile> it = set.iterator();
			while (it.hasNext()) { // 遍历附件集合
				SysFile file = it.next();
				mimeBodyPart = new MimeBodyPart();
				fileDataSource = new FileDataSource(WebAppUtil.getUploadPath() + "/" + file.getPath());
				mimeBodyPart.setDataHandler(new DataHandler(fileDataSource));
				mimeBodyPart.setFileName(
						MimeUtility.encodeText(file.getFileName()).replaceAll("\n", "").replaceAll("\r", "")); // 原附件
				mainPart.addBodyPart(mimeBodyPart);
			}

			msg.setContent(mainPart); // 设置邮件内容
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM"); // 设置邮件日期
			String tempPath = sdf.format(new Date());
			// 生成eml文件保存到服务器
			IUser curUser = ContextUtil.getCurrentUser();
			String account = curUser.getUsername();
			String fullPath = WebAppUtil.getUploadPath() + "/" + account + "/" + tempPath;
			String pkId = idGenerator.getSID();
			String fileFullPath = fullPath + "/" + pkId + ".eml";
			File dirFile = new File(fullPath);
			if (!dirFile.exists()) {
				dirFile.mkdirs();
			}
			msg.writeTo(new FileOutputStream(new File(fullPath + "/" + pkId + ".eml"))); // 生成eml文件
			SysFile sysFile = new SysFile();
			String fileName = mails.get(i).getSubject();
			String filerExt = "eml";
			String relFilePath = account + "/" + tempPath;
			sysFile.setFileId(pkId);
			sysFile.setFileName(fileName + "." + filerExt);
			sysFile.setPath(relFilePath + "/" + pkId + "." + filerExt);
			sysFile.setExt("." + filerExt);
			FileExt fileExt = fileUploadConfig.getFileExtMap().get(filerExt.toLowerCase()); // 设置minetype
			if (fileExt != null) {
				sysFile.setMineType(fileExt.getMineType());
			} else {
				sysFile.setMineType("Unkown");
			}
			sysFile.setDesc(""); // 设置描述

			FileChannel fc = null; // 计算文件大小
			try {
				File f = new File(fileFullPath);
				if (f.exists() && f.isFile()) {
					FileInputStream fis = new FileInputStream(f);
					fc = fis.getChannel();
					long size = fc.size();
					sysFile.setTotalBytes(size);
					fis.close();
				} else {
					logger.debug("file not exist!");
				}
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				if (null != fc) {
					try {
						fc.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
			sysFile.setNewFname(pkId + "." + filerExt); // 新文件名字
			sysFileManager.create(sysFile);
			ObjectNode objectNode = objectMapper.createObjectNode();
			objectNode.put("fileId", sysFile.getFileId()); // 附件Id列表
			objectNode.put("fileName", sysFile.getFileName()); // 附件名称列表
			arrayNode.add(objectNode);

		}
		return new JsonResult(true, "", arrayNode);
	}

	private boolean sendMail(OutMail outMail) {
		MailTools mailTools = geMailTools(outMail.getMailConfig());
		try {
			Mail mail = new Mail();
			//设置发送日期
			mail.setSendDate(new Date());
			// 设置主题
			String subject = MimeUtility.encodeText(outMail.getSubject(), "utf-8", "B"); // 加密主题
			mail.setSubject(subject);
			//设置发送人地址
			mail.setSenderAddress(outMail.getSenderAddrs());
			// create the text for the image
			//设置收件人列表
			mail.setReceiverAddresses(outMail.getRecAddrs());
			//设置抄送人列表
			mail.setCopyToAddresses(outMail.getCcAddrs());
			//设置暗送人列表
			mail.setBcCAddresses(outMail.getBccAddrs());
			
			Multipart mainPart = new MimeMultipart();
			BodyPart bp = new MimeBodyPart();// 创建一个包含附件内容的MimeBodyPart
			// 设置HTML内容
			bp.setContent(mail.getContent(), "text/html; charset=utf-8");
			mainPart.addBodyPart(bp);
	
			// 添加附件
			Set<SysFile> set = outMail.getInfMailFiles();
			Iterator<SysFile> it = set.iterator();
			List<MailAttachment> mails = mail.getMailAttachments();
			while (it.hasNext()) { // 遍历附件集合
				SysFile file = it.next();
				byte[] bytes=FileUtil.readByte(WebAppUtil.getUploadPath() + "/" + file.getPath());
				String fileName = MimeUtility.encodeText(file.getFileName());
				MailAttachment attach = new MailAttachment(fileName,bytes);
				mails.add(attach);
			}
			mail.setContent(outMail.getContent());
			//发送
			mailTools.send(mail);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	/**
	 * 收取外部邮件
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("getMail")
	@ResponseBody
	public JsonResult getMail(HttpServletRequest request) throws Exception {
		String configId = request.getParameter("configId");
		MailConfig mailConfig = mailConfigManager.get(configId);
		try {
			long start,end;
			start = System.currentTimeMillis();
			getMail(mailConfig);
			end = System.currentTimeMillis();
			return new JsonResult(true, "收取邮件成功  Run Time:" + (end - start)+"(ms)");
		} catch (Exception e) {
			return new JsonResult(true, "收取邮件失败");
		}
	}
	
	private MailTools geMailTools(MailConfig mailConfig) {
		com.redxun.core.mail.model.MailConfig config = new com.redxun.core.mail.model.MailConfig();
		config.setSendHost(mailConfig.getSmtpHost());
		config.setSendPort(mailConfig.getSmtpPort());
		config.setReceiveHost(mailConfig.getRecpHost());
		config.setReceivePort(mailConfig.getRecpPort());
		config.setProtocal(mailConfig.getProtocol());
		config.setValidate(true);
		config.setNickName(mailConfig.getAccount());
		config.setMailAddress(mailConfig.getMailAccount());
		config.setPassword(mailConfig.getMailPwd());
		config.setSSL("true".equals(mailConfig.getSsl()) ? true : false);
		config.setIsSynchronization(true);//开启同步
		//config.setIsDeleteRemote(true);//删除服务器上的邮件
		MailTools mailTools = new MailTools(config);
		return mailTools;
	}

	/**
	 * 收取外部邮件
	 * 
	 * @param mailConfig
	 *            外部邮箱账号配置
	 * @return 
	 * @throws Exception
	 */
	private void getMail(final MailConfig mailConfig) throws Exception {
		MailTools mailTools = geMailTools(mailConfig);
		QueryFilter queryFilter = new QueryFilter();
		queryFilter.addFieldParam("mailFolder.folderId", mailFolderManager.getMailFolderByConfigIdAndType(mailConfig.getConfigId(),
				MailFolder.TYPE_RECEIVE_FOLDER).getFolderId());
		queryFilter.addSortParam("sendDate", SortParam.SORT_DESC);
		queryFilter.addFieldParam("status", OutMail.STATUS_COMMEN); // 只获取正常状态的外部邮件
		List<OutMail> list = outMailManager.getAll(queryFilter);
		String lastMessageId = "";
		if(BeanUtil.isNotEmpty(list)) {
			//获取最近一次的邮箱ID
			lastMessageId = list.get(0).getUid();
		}
		mailTools.receive(new AttacheHandler() {
			
			@Override
			public Boolean isDownlad(String messageId) {
				List<OutMail> mails = outMailManager.getMailByUID(messageId,ContextUtil.getCurrentTenantId());
				if(BeanUtil.isEmpty(mails))return true;
				for (OutMail outMail : mails) {
					outMail.setStatus(OutMail.STATUS_COMMEN); // 如果存在本地将邮件状态改为COMMEN
					outMailManager.update(outMail);
				}
				return false;
			}
			
			@Override
			public void handle(Part part, Mail mail) {
				getMailByMailConfig(part,mail,mailConfig);
			}
		},lastMessageId);
	}
	
	private OutMail getOutMailByMail(Part p,Mail m,MailConfig mailConfig) {
		OutMail mail = new OutMail();
		
		try {
			mail.setUid(m.getMessageId());
			mail.setUserId(ContextUtil.getCurrentUserId());
			mail.setMailConfig(mailConfig);
			mail.setMailFolder(mailFolderManager.getMailFolderByConfigIdAndType(mailConfig.getConfigId(),
			MailFolder.TYPE_RECEIVE_FOLDER)); // 设置邮件的文件夹目录为收件箱
			//设置主题
			String subject = m.getSubject();
			mail.setSubject(subject);
			
			mail.setContent(m.getContent()); // 设置内容
			
			mail.setSenderAddrs(m.getSenderAddress());
			mail.setSenderAlias(m.getSenderName());
			
			mail.setRecAddrs(m.getReceiverAddresses());
			mail.setRecAlias(m.getReceiverName());
			
			mail.setCcAddrs(m.getCopyToAddresses());
			mail.setCcAlias(m.getCopyToName());
			
			mail.setBccAddrs(m.getBcCAddresses());
			mail.setBccAlias(m.getBccName());
			
	        mail.setReadFlag(m.getReadFlag());
			mail.setReplyFlag(m.getReplyFlag());
			mail.setSendDate(m.getSendDate());
			mail.setStatus(OutMail.STATUS_COMMEN);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return mail;
	}
	
	private void getMailByMailConfig(Part p,Mail m,MailConfig mailConfig) {
		try {
			OutMail mail = getOutMailByMail(p, m, mailConfig);
			handlerAttachMent(m, mail); // 保存邮件附件到本地
			outMailManager.create(mail);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 处理附件问题
	 * @param mail
	 * @param part
	 * @throws Exception
	 */
	private void handlerAttachMent(Mail mail,OutMail outMail) throws Exception {
		for (MailAttachment mailAttachment : mail.getMailAttachments()) {
			String fileName = mailAttachment.getFileName();
			SysFile sysFile = new SysFile();
			String fileId = IdUtil.getId();
			String filerExt = FileUtil.getFileExt(fileName); // 获取附件的后缀名
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
			String tempPath = sdf.format(new Date());
			IUser curUser = ContextUtil.getCurrentUser();
			String account = curUser.getUsername();
			String relFilePath = account + "/" + tempPath;
			String fullPath = WebAppUtil.getUploadPath() + "/" + relFilePath;
			String fileFullPath = fullPath + "/" + fileId + "." + filerExt;
			File dirFile = new File(fullPath);
			if (!dirFile.exists()) {
				dirFile.mkdirs();
			}
			MailTools.copy(new ByteArrayInputStream(mailAttachment.getFileBlob()), new FileOutputStream(fileFullPath)); // 将附件复制到本地
			sysFile.setFileId(fileId);
			sysFile.setFileName(fileName);
			sysFile.setPath(relFilePath + "/" + fileId + "." + filerExt);
			sysFile.setExt("." + filerExt);

			FileExt fileExt = fileUploadConfig.getFileExtMap().get(filerExt.toLowerCase()); // 设置minetype
			if (fileExt != null) {
				sysFile.setMineType(fileExt.getMineType());
			} else {
				sysFile.setMineType("Unkown");
			}
			sysFile.setDesc("");
			File file = new File(fileFullPath);
			long size=FileUtil.getSize(file);
			sysFile.setTotalBytes(size);

			sysFile.setNewFname(fileId + "." + filerExt); // 新文件名字
			sysFileManager.create(sysFile);
			outMail.getInfMailFiles().add(sysFile);
		}
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public BaseManager getBaseManager() {
		return outMailManager;
	}


}
