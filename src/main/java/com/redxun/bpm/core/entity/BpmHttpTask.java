



package com.redxun.bpm.core.entity;

import com.redxun.core.annotion.table.FieldDefine;
import com.redxun.core.annotion.table.TableDefine;
import com.redxun.core.entity.BaseTenantEntity;
import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

import javax.persistence.Column;
import javax.persistence.Id;
import java.io.Serializable;

/**
 * <pre>
 *  
 * 描述：调用任务实体类定义
 * 作者：ray
 * 邮箱: ray@redxun.com
 * 日期:2019-01-24 10:30:29
 * 版权：广州红迅软件
 * </pre>
 */
@TableDefine(title = "调用任务")
public class BpmHttpTask extends BaseTenantEntity {

	@FieldDefine(title = "主键")
	@Id
	@Column(name = "ID_")
	protected String id;

	@FieldDefine(title = "服务名称")
	@Column(name = "KEY_")
	protected String key; 
	@FieldDefine(title = "参数定义")
	@Column(name = "PARAMS_DATA_")
	protected String paramsData; 
	@FieldDefine(title = "变量")
	@Column(name = "PARAMS_")
	protected byte[] params; 
	@FieldDefine(title = "调用次数")
	@Column(name = "INVOKE_TIMES_")
	protected Integer invokeTimes; 
	@FieldDefine(title = "调用间隔")
	@Column(name = "PERIOD_")
	protected Integer period; 
	@FieldDefine(title = "调用结果")
	@Column(name = "RESULT_")
	protected Integer result; 
	@FieldDefine(title = "实际调用次数")
	@Column(name = "TIMES_")
	protected Integer times; 
	@FieldDefine(title = "是否完成")
	@Column(name = "FINISH_")
	protected Integer finish=0; 
	
	@Column(name = "SCRIPT_")
	protected String script; 
	
	
	
	public BpmHttpTask() {
	}

	/**
	 * Default Key Fields Constructor for class Orders
	 */
	public BpmHttpTask(String in_id) {
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
	
	public void setKey(String key) {
		this.key = key;
	}
	
	/**
	 * 返回 服务名称
	 * @return
	 */
	public String getKey() {
		return this.key;
	}
	public void setParamsData(String paramsData) {
		this.paramsData = paramsData;
	}
	
	/**
	 * 返回 参数定义
	 * @return
	 */
	public String getParamsData() {
		return this.paramsData;
	}
	public void setParams(byte[] params) {
		this.params = params;
	}
	
	/**
	 * 返回 变量
	 * @return
	 */
	public byte[] getParams() {
		return this.params;
	}
	public void setInvokeTimes(Integer invokeTimes) {
		this.invokeTimes = invokeTimes;
	}
	
	/**
	 * 返回 调用次数
	 * @return
	 */
	public Integer getInvokeTimes() {
		return this.invokeTimes;
	}
	public void setPeriod(Integer period) {
		this.period = period;
	}
	
	/**
	 * 返回 调用间隔
	 * @return
	 */
	public Integer getPeriod() {
		return this.period;
	}
	public void setResult(Integer result) {
		this.result = result;
	}
	
	/**
	 * 返回 调用结果
	 * @return
	 */
	public Integer getResult() {
		return this.result;
	}
	public void setTimes(Integer times) {
		this.times = times;
	}
	
	/**
	 * 返回 实际调用次数
	 * @return
	 */
	public Integer getTimes() {
		return this.times;
	}
	public void setFinish(Integer finish) {
		this.finish = finish;
	}
	
	/**
	 * 返回 是否完成
	 * @return
	 */
	public Integer getFinish() {
		return this.finish;
	}
	
	
	public String getScript() {
		return script;
	}

	public void setScript(String script) {
		this.script = script;
	}

	/**
	 * @see Object#equals(Object)
	 */
	public boolean equals(Object object) {
		if (!(object instanceof BpmHttpTask)) {
			return false;
		}
		BpmHttpTask rhs = (BpmHttpTask) object;
		return new EqualsBuilder()
		.append(this.id, rhs.id)
		.append(this.key, rhs.key)
		.append(this.paramsData, rhs.paramsData)
		.append(this.params, rhs.params)
		.append(this.invokeTimes, rhs.invokeTimes)
		.append(this.period, rhs.period)
		.append(this.result, rhs.result)
		.append(this.times, rhs.times)
		.append(this.finish, rhs.finish)
		.isEquals();
	}

	/**
	 * @see Object#hashCode()
	 */
	public int hashCode() {
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.id)
		.append(this.key)
		.append(this.paramsData)
		.append(this.params)
		.append(this.invokeTimes)
		.append(this.period)
		.append(this.result)
		.append(this.times)
		.append(this.finish)
		.toHashCode();
	}

	/**
	 * @see Object#toString()
	 */
	public String toString() {
		return new ToStringBuilder(this)
		.append("id", this.id) 
				.append("key", this.key) 
				.append("paramsData", this.paramsData) 
				.append("params", this.params) 
				.append("invokeTimes", this.invokeTimes) 
				.append("period", this.period) 
				.append("result", this.result) 
				.append("times", this.times) 
				.append("finish", this.finish) 
												.toString();
	}

}



