package com.redxun.bpm.script.config;

/**
 * 脚本配置行标签
 * @author mansan
 * @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
public interface ScriptLabel {
	/**
	 * 脚本标签类型
	 * @return
	 */
	public String getType();
	/**
	 * 脚本名称
	 * @return
	 */
	public String getName();
	/**
	 * 脚本标题
	 * @return
	 */
	public String getTitle();
	/**
	 * 脚本示例
	 * @return
	 */
	public String getExample();
	/**
	 * 当前标签ID
	 * @return
	 */
	public String getId();
	/**
	 * 当前父标签ID
	 * @return
	 */
	public String getParentId();
	/**
	 * 图标显示样式
	 * @return
	 */
	public String getIconCls();
}
