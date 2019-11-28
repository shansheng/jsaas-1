package com.redxun.sys.core.manager;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.compress.archivers.zip.ZipArchiveInputStream;
import org.apache.commons.compress.utils.IOUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.redxun.bpm.activiti.util.ProcessHandleHelper;
import com.redxun.core.dao.IDao;
import com.redxun.core.manager.MybatisBaseManager;
import com.redxun.core.util.BeanUtil;
import com.redxun.core.util.DateUtil;
import com.redxun.saweb.context.ContextUtil;
import com.redxun.saweb.util.IdUtil;
import com.redxun.sys.core.dao.SysSeqIdDao;
import com.redxun.sys.core.entity.SysSeqId;
import com.redxun.sys.db.entity.SysSqlCustomQuery;
import com.thoughtworks.xstream.XStream;
/**
 * <pre> 
 * 描述：SysSeqId业务服务类
 * 构建组：miweb
 * 作者：keith
 * 邮箱: chshxuan@163.com
 * 日期:2014-2-1-上午12:52:41
 * 广州红迅软件有限公司（http://www.redxun.cn）
 * </pre>
 */
@Service
public class SysSeqIdManager extends MybatisBaseManager<SysSeqId>{
	@Resource
	private SysSeqIdDao sysSeqIdDao;
	

	
	
	@SuppressWarnings("rawtypes")
	@Override
	protected IDao getDao() {
		return sysSeqIdDao;
	}
	
	
	/**
     * 通过别名及机构Id获得流水号的设置
     * @param alias
     * @param tenantId
     * @return
     */
    public SysSeqId getByAlias(String alias,String tenantId){
    	return sysSeqIdDao.getByAlias(alias, tenantId);
    }
    
    
    public SysSeqId getByAliasForUpd(String alias,String tenantId){
    	return sysSeqIdDao.getByAliasForUpd(alias, tenantId);
    }
    
    /**
     * 检查别名是否存在
     * @param alias
     * @param tenantId
     * @return
     */
    public boolean isAliasExsist(String alias,String tenantId){
    	SysSeqId seq=sysSeqIdDao.getByAlias(alias, tenantId);
    	return seq!=null;
    }
    
    
    /**
	 * 根据流程规则别名获取得当前流水号。
	 * @param alias	 流水号规则别名。
	 * @return
	 */
	public String getCurIdByAlias(String alias,String tenantId){
		SysSeqId idSeq=getByAlias(alias,tenantId);
		if(idSeq==null) return "";
		Integer curValue=idSeq.getCurVal();
		if(curValue==null) curValue=idSeq.getInitVal();
		String val=getByRule(idSeq.getRule(),idSeq.getLen(),curValue);
		return val;
	}

	
	
	/**
	 * 根据流程规则别名获取得下一个流水号。
	 * @param alias		流水号规则别名。
	 * @return
	 */
	public   String genSequenceNo(String alias,String tenantId){
		SysSeqId identity=getByAliasForUpd(alias,tenantId);
		
		String rule=identity.getRule();
		
		String genType =identity.getGenType();
		
		Integer curValue=identity.getCurVal();
		
		if(curValue==null) curValue=identity.getInitVal();
		
		Date oldDate=(identity.getCurDate()==null)?new Date():identity.getCurDate();
		
		int curTimeVal=0;
		int oldTimeVal=0;
		if(SysSeqId.GEN_TYPE_DAY.equals(genType)){//每天产生
			curTimeVal=DateUtil.getCurDay();
			oldTimeVal=DateUtil.getDay(oldDate);
		}else if(SysSeqId.GEN_TYPE_WEEK.equals(genType)){//每周产生
			curTimeVal=DateUtil.getCurWeekOfYear();
			oldTimeVal=DateUtil.getWeekOfYear(oldDate);
		}else if(SysSeqId.GEN_TYPE_MONTH.equals(genType)){//每月产生
			curTimeVal=DateUtil.getCurMonth();
			oldTimeVal=DateUtil.getMonth(oldDate);
		}else if(SysSeqId.GEN_TYPE_YEAR.equals(genType)){//每年产生
			curTimeVal=DateUtil.getCurYear();
			oldTimeVal=DateUtil.getYear(oldDate);
		}
		if(curTimeVal!=oldTimeVal){
			oldDate=new Date();
			curValue=identity.getInitVal();
		}else{
			curValue+=identity.getStep();
		}
		identity.setNewVal(curValue);
		identity.setCurDate(oldDate);
		Result result=new Result();
		int amount=sysSeqIdDao.updateVersion(identity);
		if(amount>0){
			result.setResult(true);
			String no=getByRule(rule,identity.getLen(),curValue);
			result.setNo(no);
		}
		return result.getNo();
		
	}

	
	
	
	/**
	 * 根据规则返回需要显示的流水号。
	 * @param rule			流水号规则。
	 * @param length		流水号的长度。
	 * @param curValue		流水号的当前值。
	 * @return
	 */
	private String getByRule(String rule,int length, int curValue){
		Calendar now= Calendar.getInstance(); 
		NumberFormat nf=new DecimalFormat("00");
		int year=now.get(Calendar.YEAR);
		int month=now.get(Calendar.MONTH)+1;
		int day=now.get(Calendar.DATE);
		
		StringBuffer sb=new StringBuffer();
		for(int i=0;i<length;i++){
			sb.append("0");
		}
		SimpleDateFormat fullDateFormat=new SimpleDateFormat("yyyMMdd");
		SimpleDateFormat shortDateFormat=new SimpleDateFormat("yyyMM");
		
		NumberFormat seqFt=new DecimalFormat(sb.toString());
		
		String seqNo=seqFt.format(curValue);
		
		String rtn=rule.replace("{yyyy}", year+"")
				.replace("{yy}",String.valueOf(year).substring(2, 4))
				.replace("{MM}", nf.format(month))
				.replace("{mm}",month+"")
				.replace("{DD}", nf.format(day))
				.replace("{dd}", day+"")
				.replace("{NO}", seqNo)
				.replace("{no}", curValue+"")
				.replace("{yyyyMM}", shortDateFormat.format(now.getTime()))
				.replace("{yyyyMMdd}", fullDateFormat.format(now.getTime()));

		return rtn;
	}
	
	public List<SysSeqId> getSysSeqIdByIds(String[] keys) {
		List<SysSeqId> list=new ArrayList<SysSeqId>();
		for (String key : keys) {
			SysSeqId sysSeqId = getByAlias(key, ContextUtil.getCurrentTenantId());
	
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
		
		List<SysSeqId>   list=getBpmSolutionExts(file);
		String tenantId = ContextUtil.getCurrentTenantId();
		for(SysSeqId sysSeqId:list){
			doImport( sysSeqId, tenantId);
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
	private List<SysSeqId> getBpmSolutionExts(MultipartFile file) throws UnsupportedEncodingException, IOException{
		InputStream is = file.getInputStream();
		XStream xstream = new XStream();
		// 设置XML的目录的别名对应的Class名
		xstream.alias("sysSqlCustomQuery", SysSqlCustomQuery.class);
		xstream.autodetectAnnotations(true);
		// 转化为Zip的输入流
		ZipArchiveInputStream zipIs = new ZipArchiveInputStream(is, "UTF-8");
		
		List<SysSeqId> list=new ArrayList<SysSeqId>();

		while ((zipIs.getNextZipEntry()) != null) {// 读取Zip中的每个文件
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			IOUtils.copy(zipIs, baos);
			String xml = baos.toString("UTF-8");
			SysSeqId sysSeqId = (SysSeqId) xstream.fromXML(xml);
			list.add(sysSeqId);
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
	private void doImport(SysSeqId sysSeqId,String tenantId) throws Exception{
		
		sysSeqId.setTenantId(tenantId);
		
		/**
		 * 如果方案已经存在则直接退出。
		 * 这里对方案的 租户ID进行修改。
		 */
		sysSeqId.setSeqId(IdUtil.getId());
		Boolean isExist= isAliasExsist(sysSeqId.getAlias(),tenantId);
		if(isExist){
			ProcessHandleHelper.addErrorMsg(sysSeqId.getName() + "流水号已经存在!");
			return;
		}
		//查询
		sysSeqIdDao.create(sysSeqId);
      
	}
	
	
	public static void main(String[]args){
		
		int length=5;
		StringBuffer sb=new StringBuffer();
		for(int i=0;i<length;i++){
			sb.append("0");
		}
		NumberFormat seqFt=new DecimalFormat(sb.toString());
		for(int i=0;i<30;i++){
			String seqNo=seqFt.format(i);
			System.out.println("seqNo:"+seqNo);
		}
	}
	
	/**
	 * 返回结果
	 * @author ray
	 *
	 */
	class Result{
		private boolean result=false;
		private String no="";
		
		
		public boolean getResult() {
			return result;
		}
		public void setResult(boolean result) {
			this.result = result;
		}
		public String getNo() {
			return no;
		}
		public void setNo(String no) {
			this.no = no;
		}
		
		
	}

}