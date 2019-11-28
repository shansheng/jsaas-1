package com.redxun.bpm.core.entity;

import java.io.Serializable;

import com.redxun.org.api.model.IGroup;
import com.redxun.org.api.model.IUser;

/**
 * 流程执行者信息。
 * @author ray
 *
 */
public class TaskExecutor  implements Serializable {
	
	/**
	 * 计算
	 */
	public final static String CALC_MODE_YES="YES";
	
	/**
	 * 不计算
	 */
	public final static String CALC_MODE_NO="NO";
	
	/**
	 * 延迟计算
	 * 这个针对会签节点。
	 */
	public final static String CALC_MODE_DELAY="DELAY";
	
	/**
	 * 具体的用户
	 */
	public final static String IDENTIFY_TYPE_USER="USER";
	/**
	 * 用户组
	 */
	public final static String IDENTIFY_TYPE_GROUP="GROUP";
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -5959548859691325445L;

	/**
	 * 类型,user,group
	 */
	private String type="";
	
	/**
	 * id
	 */
	private String id="";
	
	/**
	 * 名称。
	 */
	private String name="";
	
	/**
	 * 计算模式
	 */
	private String calcMode="";
	
	
	public TaskExecutor(){}
	
	/**
	 * 构造用户类型的执行人。
	 * @param id
	 * @param name
	 */
	public TaskExecutor(String id, String name) {
		this.type = IDENTIFY_TYPE_USER;
		this.id = id;
		this.name = name;
	}
	
	/**
	 * 构建组类型。
	 * @param id
	 * @param name
	 * @param calcMode
	 */
	
	
	public TaskExecutor(String type, String id, String name) {
		this.type = type;
		this.id = id;
		this.name = name;
	}

	/**
	 * 获取组执行人
	 * @param id
	 * @param name
	 * @return
	 */
	public static TaskExecutor getGroupExecutor(String id,String name){
		TaskExecutor executor=new TaskExecutor(IDENTIFY_TYPE_GROUP,id,name);
		return executor;
	}
	
	/**
	 * 获取用户
	 * @param id
	 * @param name
	 * @return
	 */
	public static TaskExecutor getUserExecutor(String id,String name){
		TaskExecutor executor=new TaskExecutor(IDENTIFY_TYPE_USER,id,name);
		return executor;
	}
	
	/**
	 * 根据用户获取执行人。
	 * @param user
	 * @return
	 */
	public static TaskExecutor getUserExecutor(IUser user){
		TaskExecutor executor=new TaskExecutor(IDENTIFY_TYPE_USER,user.getUserId(),user.getFullname());
		return executor;
	}
	
	/**
	 * 获取用户组。
	 * @param group
	 * @return
	 */
	public static TaskExecutor getGroupExecutor(IGroup group){
		TaskExecutor executor=new TaskExecutor(IDENTIFY_TYPE_GROUP,group.getIdentityId(),group.getIdentityName());
		return executor;
	}


	


	public String getType() {
		return type;
	}


	public void setType(String type) {
		this.type = type;
	}


	public String getId() {
		return id;
	}


	public void setId(String id) {
		this.id = id;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getCalcMode() {
		return calcMode;
	}


	public void setCalcMode(String calcMode) {
		this.calcMode = calcMode;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result + ((type == null) ? 0 : type.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj) return true;
		if (obj == null) return false;
		if (getClass() != obj.getClass())
			return false;
		TaskExecutor other = (TaskExecutor) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (type == null) {
			if (other.type != null)
				return false;
		} else if (!type.equals(other.type))
			return false;
		return true;
	}

	
	

}
