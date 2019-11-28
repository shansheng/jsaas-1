package com.redxun.bpm.core.entity;

import java.util.LinkedHashSet;
import java.util.Set;

import com.redxun.bpm.form.entity.BpmFormView;
import com.thoughtworks.xstream.annotations.XStreamAlias;

/**
 * BPM的流程解决方案相关数据的导出与导入模型
 * @author mansan
 */
@XStreamAlias("bpmExportModel")
public class BpmExportModel {
	/**
	 * 新建=NEW
	 */
	public static final String EXP_OPTIONS_NEW="NEW";
	/**
	 * 在原有版本上新建版本=NEW-VERSION
	 */
	public static final String EXP_OPTIONS_NEW_VERSION="NEW-VERSION";
	/**
	 * 更新原版本，若不存在，则新建=UPDATE
	 */
	public static final String EXP_OPTIONS_UPDATE="UPDATE";
	
	//BPM流程导入的选项 NEW,NEW-VERSION,UPDTE
	private String bpmDefOpts=null;
	//BPM表单的导入视图选项 NEW,NEW-VERSION,UPDTE
	private String bpmFormViewOpts=null;
	//解决方案选项 NEW,UPDTE
	private String bpmSolutionOpts=null;
	
	//导入的解决方案
	private BpmSolutionExt bpmSolutionExt=new BpmSolutionExt();
	//导入的表单视图
	private Set<BpmFormView> bpmFormViews=new LinkedHashSet<BpmFormView>();
	

	public BpmExportModel() {
		
	}
	
	public BpmExportModel(BpmSolutionExt bpmSolutionExt,
			Set<BpmFormView> bpmFormViews){
		this.bpmSolutionExt=bpmSolutionExt;
		this.bpmFormViews=bpmFormViews;
	}
	
	
	public Set<BpmFormView> getBpmFormViews() {
		return bpmFormViews;
	}
	
	public void setBpmFormViews(Set<BpmFormView> bpmFormViews) {
		this.bpmFormViews = bpmFormViews;
	}
	
	

	public BpmSolutionExt getBpmSolutionExt() {
		return bpmSolutionExt;
	}

	public void setBpmSolutionExt(BpmSolutionExt bpmSolutionExt) {
		this.bpmSolutionExt = bpmSolutionExt;
	}

	public String getBpmDefOpts() {
		return bpmDefOpts;
	}

	public void setBpmDefOpts(String bpmDefOpts) {
		this.bpmDefOpts = bpmDefOpts;
	}

	public String getBpmFormViewOpts() {
		return bpmFormViewOpts;
	}

	public void setBpmFormViewOpts(String bpmFormViewOpts) {
		this.bpmFormViewOpts = bpmFormViewOpts;
	}

	public String getBpmSolutionOpts() {
		return bpmSolutionOpts;
	}

	public void setBpmSolutionOpts(String bpmSolutionOpts) {
		this.bpmSolutionOpts = bpmSolutionOpts;
	}

}
