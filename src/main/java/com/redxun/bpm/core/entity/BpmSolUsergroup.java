package com.redxun.bpm.core.entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.Size;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

import com.alibaba.fastjson.JSONObject;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.redxun.core.annotion.table.FieldDefine;
import com.redxun.core.annotion.table.TableDefine;
import com.redxun.core.entity.BaseTenantEntity;
import com.redxun.core.jms.MessageUtil;
import com.redxun.core.util.StringUtil;
import com.thoughtworks.xstream.annotations.XStreamAlias;

/**
 * <pre>
 *  
 * 描述：BpmSolUsergroup实体类定义
 * 流程配置用户组
 * 构建组：miweb
 * 作者：keith
 * 邮箱: keith@redxun.cn
 * 日期:2014-2-1-上午12:52:41
 * 版权：广州红迅软件有限公司版权所有
 * </pre>
 */
@Entity
@Table(name = "BPM_SOL_USERGROUP")
@TableDefine(title = "流程配置用户组")
@JsonIgnoreProperties(value={"bpmSolution"})
@XStreamAlias("bpmSolUsergroup")
public class BpmSolUsergroup extends BaseTenantEntity {
	
	public static String GROUP_TYPE_TASK="task"; 
	
	public static String GROUP_TYPE_COPY="copy"; 
	
	

	@FieldDefine(title = "PKID")
	@Id
	@Column(name = "ID_")
	protected String id;
	/* 名称 */
	@FieldDefine(title = "名称")
	@Column(name = "GROUP_NAME_")
	@Size(max = 50)
	protected String groupName;
	/* 方案ID */
	@FieldDefine(title = "方案ID")
	@Column(name = "SOL_ID_")
	@Size(max = 50)
	protected String solId;
	/* 节点ID */
	@FieldDefine(title = "流程定义Id")
	@Column(name = "ACT_DEF_ID_")
	@Size(max = 64)
	protected String actDefId;
	
	/* 分组类型(flow,copyto) */
	@FieldDefine(title = "分组类型(flow,copyto)")
	@Column(name = "GROUP_TYPE_")
	@Size(max = 50)
	protected String groupType;
	/* 节点ID */
	@FieldDefine(title = "节点ID")
	@Column(name = "NODE_ID_")
	@Size(max = 50)
	protected String nodeId;
	/* 节点名称 */
	@FieldDefine(title = "节点名称")
	@Column(name = "NODE_NAME_")
	@Size(max = 50)
	protected String nodeName;
	/* 配置 */
	@FieldDefine(title = "配置")
	@Column(name = "SETTING_")
	@Size(max = 2000)
	protected String setting;
	/* 序号 */
	@FieldDefine(title = "序号")
	@Column(name = "SN_")
	protected Integer sn;
	/**/
	@FieldDefine(title = "通知类型")
	@Column(name = "NOTIFY_TYPE_")
	@Size(max = 50)
	protected String notifyType;

	/**
	 * Default Empty Constructor for class BpmSolUsergroup
	 */
	public BpmSolUsergroup() {
		super();
	}
	/**
	 * 用户列表数据
	 */
	@Transient
	@OneToMany
	private List<BpmSolUser> userList=new ArrayList<BpmSolUser>();
	

	public String getActDefId() {
		return actDefId;
	}

	public void setActDefId(String actDefId) {
		this.actDefId = actDefId;
	}

	/**
	 * Default Key Fields Constructor for class BpmSolUsergroup
	 */
	public BpmSolUsergroup(String in_id) {
		this.setId(in_id);
	}

	/**
	 * 主键 * @return String
	 */
	public String getId() {
		return this.id;
	}

	/**
	 * 设置 主键
	 */
	public void setId(String aValue) {
		this.id = aValue;
	}

	/**
	 * 名称 * @return String
	 */
	public String getGroupName() {
		return this.groupName;
	}

	/**
	 * 设置 名称
	 */
	public void setGroupName(String aValue) {
		this.groupName = aValue;
	}

	/**
	 * 方案ID * @return String
	 */
	public String getSolId() {
		return this.solId;
	}

	/**
	 * 设置 方案ID
	 */
	public void setSolId(String aValue) {
		this.solId = aValue;
	}

	/**
	 * 分组类型(flow,copyto) * @return String
	 */
	public String getGroupType() {
		return this.groupType;
	}

	/**
	 * 设置 分组类型(flow,copyto)
	 */
	public void setGroupType(String aValue) {
		this.groupType = aValue;
	}

	/**
	 * 节点ID * @return String
	 */
	public String getNodeId() {
		return this.nodeId;
	}

	/**
	 * 设置 节点ID
	 */
	public void setNodeId(String aValue) {
		this.nodeId = aValue;
	}

	/**
	 * 节点名称 * @return String
	 */
	public String getNodeName() {
		return this.nodeName;
	}

	/**
	 * 设置 节点名称
	 */
	public void setNodeName(String aValue) {
		this.nodeName = aValue;
	}

	/**
	 * 配置 * @return String
	 */
	public String getSetting() {
		return this.setting;
	}

	/**
	 * 设置 配置
	 */
	public void setSetting(String aValue) {
		this.setting = aValue;
	}

	/**
	 * 序号 * @return Integer
	 */
	public Integer getSn() {
		return this.sn;
	}

	/**
	 * 设置 序号
	 */
	public void setSn(Integer aValue) {
		this.sn = aValue;
	}

	/**
	 * * @return String
	 */
	public String getNotifyType() {
		return this.notifyType;
	}
	
	public String getDisplayNotifyType() {
		if(StringUtil.isEmpty(this.notifyType)) return "";
		Map<String,String> map= MessageUtil.getMapMsgType();
		String[] aryType=this.notifyType.split(",");
		String str="";
		for(int i=0;i<aryType.length;i++){
			String type=aryType[i];
			if(i==0){
				str+=map.get(type);
			}
			else{
				str+="," +map.get(type);
			}
		}
		return str;
	}

	/**
	 * 设置
	 * 
	 */
	public void setNotifyType(String aValue) {
		this.notifyType = aValue;
	}

	@Override
	public String getIdentifyLabel() {
		return this.id;
	}

	@Override
	public Serializable getPkId() {
		return this.id;
	}

	@Override
	public void setPkId(Serializable pkId) {
		this.id = (String) pkId;
	}
	
	public String getUserListString() {
		StringBuffer sb = new StringBuffer();
		for (BpmSolUser bpmSolUser : userList) {
			sb.append(bpmSolUser.getConfigDescp()+",");
		}
		sb.deleteCharAt(sb.length()-1);
		return sb.toString();
	}

	public List<BpmSolUser> getUserList() {
		return userList;
	}

	public void setUserList(List<BpmSolUser> userList) {
		this.userList = userList;
	}

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof BpmSolUsergroup)) {
			return false;
		}
		BpmSolUsergroup rhs = (BpmSolUsergroup) object;
		return new EqualsBuilder().append(this.id, rhs.id).append(this.groupName, rhs.groupName)
				.append(this.solId, rhs.solId).append(this.groupType, rhs.groupType).append(this.nodeId, rhs.nodeId)
				.append(this.nodeName, rhs.nodeName).append(this.tenantId, rhs.tenantId)
				.append(this.setting, rhs.setting).append(this.sn, rhs.sn).append(this.notifyType, rhs.notifyType)
				.append(this.createBy, rhs.createBy).append(this.createTime, rhs.createTime)
				.append(this.updateBy, rhs.updateBy).append(this.updateTime, rhs.updateTime).isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973).append(this.id).append(this.groupName).append(this.solId)
				.append(this.groupType).append(this.nodeId).append(this.nodeName).append(this.tenantId)
				.append(this.setting).append(this.sn).append(this.notifyType).append(this.createBy)
				.append(this.createTime).append(this.updateBy).append(this.updateTime).toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this).append("id", this.id).append("groupName", this.groupName)
				.append("solId", this.solId).append("groupType", this.groupType).append("nodeId", this.nodeId)
				.append("nodeName", this.nodeName).append("tenantId", this.tenantId).append("setting", this.setting)
				.append("sn", this.sn).append("notifyType", this.notifyType).append("createBy", this.createBy)
				.append("createTime", this.createTime).append("updateBy", this.updateBy)
				.append("updateTime", this.updateTime).toString();
	}
	
	public static void main(String[] args) {
		BpmSolUsergroup group=new BpmSolUsergroup();
		group.setId("11");
		group.setGroupName("分组名称");
		group.setGroupType("copy");
		
		List<BpmSolUser> list=new ArrayList<BpmSolUser>();
		
		BpmSolUser user=new BpmSolUser();
		user.setConfig("123");
		user.setUserType("User");
		
		list.add(user);
		
		user=new BpmSolUser();
		user.setConfig("12333");
		user.setUserType("User");
		
		list.add(user);
		
		group.setUserList(list);
		
		String str= JSONObject.toJSONString(group);
		System.out.println(str);
		
	}

}
