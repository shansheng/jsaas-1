



package com.redxun.sys.webreq.entity;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Id;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

import com.redxun.core.annotion.table.FieldDefine;
import com.redxun.core.annotion.table.TableDefine;
import com.redxun.core.entity.BaseTenantEntity;

/**
 * <pre>
 *  
 * 描述：流程数据绑定表实体类定义
 * 作者：mansan
 * 邮箱: keitch@redxun.com
 * 日期:2018-07-24 17:46:42
 * 版权：广州红迅软件
 * </pre>
 */
@TableDefine(title = "WEB请求定义")
public class SysWebReqDef extends BaseTenantEntity {
	
	/**
	 * 请求方式 --- RESTFUL、SOAP
	 */
	public final static String MODE_ARRAY= "[{id:'RESTFUL',text:'RESTFUL'},{id:'SOAP',text:'SOAP'}]";
	
	/**
	 * 请求类型 --- POST、GET、PATCH、DELETE
	 */
	public final static String TYPE_ARRAY= "[{id:'POST',text:'POST'},{id:'GET',text:'GET'},"
										 + "{id:'DELETE',text:'DELETE'}]";

	/**
	 * 状态 --- ENABLE、DISABLE
	 */
	public final static String STATUS_ARRAY= "[{id:'1',text:'启用'},{id:'0',text:'禁用'}]";
	
	@FieldDefine(title = "主键")
	@Id
	@Column(name = "ID_")
	protected String id;

	@FieldDefine(title = "名称")
	@Column(name = "NAME_")
	protected String name; 
	@FieldDefine(title = "别名")
	@Column(name = "KEY_")
	protected String key; 
	@FieldDefine(title = "请求地址")
	@Column(name = "URL_")
	protected String url; 
	@FieldDefine(title = "请求方式")
	@Column(name = "MODE_")
	protected String mode; 
	@FieldDefine(title = "请求类型")
	@Column(name = "TYPE_")
	protected String type; 
	@FieldDefine(title = "数据类型")
	@Column(name = "DATA_TYPE_")
	protected String dataType; 
	@FieldDefine(title = "参数配置")
	@Column(name = "PARAMS_SET_")
	protected String paramsSet; 
	@FieldDefine(title = "传递数据")
	@Column(name = "DATA_")
	protected String data; 
	@FieldDefine(title = "请求报文模板")
	@Column(name = "TEMP_")
	protected String temp; 
	@FieldDefine(title = "状态")
	@Column(name = "STATUS_")
	protected String status; 
	
	
	
	
	
	public SysWebReqDef() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public SysWebReqDef(String in_id) {
		this.setPkId(in_id);
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
	
	public String getId() {
		return this.id;
	}

	
	public void setId(String aValue) {
		this.id = aValue;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	/**
	 * 返回 名称
	 * @return
	 */
	public String getName() {
		return this.name;
	}
	public void setKey(String key) {
		this.key = key;
	}
	
	/**
	 * 返回 别名
	 * @return
	 */
	public String getKey() {
		return this.key;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	
	/**
	 * 返回 请求地址
	 * @return
	 */
	public String getUrl() {
		return this.url;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	
	/**
	 * 返回 请求方式
	 * @return
	 */
	public String getMode() {
		return this.mode;
	}
	public void setType(String type) {
		this.type = type;
	}
	
	/**
	 * 返回 请求类型
	 * @return
	 */
	public String getType() {
		return this.type;
	}
	
	public void setDataType(String dataType) {
		this.dataType = dataType;
	}
	
	/**
	 * 返回 数据类型
	 * @return
	 */
	public String getDataType() {
		return dataType;
	}

	public void setParamsSet(String paramsSet) {
		this.paramsSet = paramsSet;
	}
	
	/**
	 * 返回 参数配置
	 * @return
	 */
	public String getParamsSet() {
		return this.paramsSet;
	}
	public void setData(String data) {
		this.data = data;
	}
	
	/**
	 * 返回 传递数据
	 * @return
	 */
	public String getData() {
		return this.data;
	}
	public void setTemp(String temp) {
		this.temp = temp;
	}
	
	/**
	 * 返回 请求报文模板
	 * @return
	 */
	public String getTemp() {
		return this.temp;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	/**
	 * 返回 状态
	 * @return
	 */
	public String getStatus() {
		return this.status;
	}
	
	
	
	
		

	/**
	 * @see java.lang.Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof SysWebReqDef)) {
			return false;
		}
		SysWebReqDef rhs = (SysWebReqDef) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id) 
		.append(this.name, rhs.name) 
		.append(this.key, rhs.key) 
		.append(this.url, rhs.url) 
		.append(this.mode, rhs.mode) 
		.append(this.type, rhs.type) 
		.append(this.dataType, rhs.dataType) 
		.append(this.paramsSet, rhs.paramsSet) 
		.append(this.data, rhs.data) 
		.append(this.temp, rhs.temp) 
		.append(this.status, rhs.status) 
		.isEquals();
	}

	/**
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.id) 
		.append(this.name) 
		.append(this.key) 
		.append(this.url) 
		.append(this.mode) 
		.append(this.type) 
		.append(this.dataType)
		.append(this.paramsSet) 
		.append(this.data) 
		.append(this.temp) 
		.append(this.status) 
		.toHashCode();
	}

	/**
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this)
		.append("id", this.id) 
				.append("name", this.name) 
				.append("key", this.key) 
				.append("url", this.url) 
				.append("mode", this.mode) 
				.append("type", this.type) 
				.append("paramsSet", this.paramsSet) 
				.append("data", this.data) 
				.append("temp", this.temp) 
				.append("status", this.status) 
												.toString();
	}

}



