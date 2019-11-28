package com.redxun.bpm.script.config;

import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.redxun.core.annotion.cls.ClassDefine;
import com.redxun.core.annotion.cls.MethodDefine;
import com.redxun.core.annotion.cls.ParamDefine;

/**
 * 脚本服务类
 * 
 * @author csx
 *  @Email: chshxuan@163.com
 * @Copyright (c) 2014-2016 广州红迅软件有限公司（http://www.redxun.cn）
 * 本源代码受软件著作法保护，请在授权允许范围内使用。
 */
@JsonIgnoreProperties("methods")
public class ScriptServiceClass implements ScriptLabel{
	/**
	 * 包名
	 */
	private String packageName;
	/**
	 * 类名
	 */
	private String className;
	/**
	 * 类描述
	 */
	private String classTitle;
	/**
	 * 方法列表
	 */
	private List<ScriptMethod> methods=new ArrayList<ScriptMethod>();
	
	/**
	 * Spring Bean 的变量名
	 */
	private String beanName;
	/**
	 * id
	 */
	private String id;
	
	private Class<?> beanClass;

	
	public String getShortClsName(){
		return beanClass.getSimpleName();
	}
	
	public ScriptServiceClass() {
		
	}

	public ScriptServiceClass(Object bean,String beanName){
		int idIndex=ScriptServiceConfig.getServiceClasses().size()+1;
		this.id=String.valueOf(idIndex);
		
		this.beanName=beanName;
		this.beanClass=bean.getClass();
		this.className=beanClass.getName();
		//若该实例类为代理模式，则获得其原始类名
		int cIndex=this.className.indexOf("$$");
		if(cIndex!=-1){
			this.className=this.className.substring(0,cIndex);
			try{
				this.beanClass=Class.forName(this.className);
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		
		packageName=beanClass.getPackage().getName();
		ClassDefine classDef=this.beanClass.getAnnotation(ClassDefine.class);
		if(classDef!=null){
			this.classTitle=classDef.title();
		}
		//获得类的当前方法
		Method[] classMethods=this.beanClass.getMethods();
		int index=1;
		for(Method method:classMethods){
			String modify=Modifier.toString(method.getModifiers());
			MethodDefine methDef=method.getAnnotation(MethodDefine.class);
			if(modify.indexOf("public")!=-1 && methDef!=null){
				ScriptMethod scriptMethod=new ScriptMethod();
				scriptMethod.setId(String.valueOf(idIndex*10+index));
				index++;
				scriptMethod.setMethodName(method.getName());
				scriptMethod.setTitle(methDef.title());
				scriptMethod.setCategory(methDef.category());
				scriptMethod.setScriptClass(this);
				//获得其输入参数
				Class<?>[] parameterTypes = method.getParameterTypes();
				ParamDefine[] paramDefines=methDef.params();
				int i=0;
				for(Class<?> t:parameterTypes){
					if(i<paramDefines.length){
						String varName=paramDefines[i].varName();
						String title=paramDefines[i].title();
						ScriptParam param=new ScriptParam(t.getName(),varName,title);
						scriptMethod.getInputParams().add(param);
					}
					i++;
				}
				//获得其输出参数
				scriptMethod.setReturnType(method.getReturnType().getName());
				methods.add(scriptMethod);
			}
		}
		
	}

	public String getPackageName() {
		return packageName;
	}

	public void setPackageName(String packageName) {
		this.packageName = packageName;
	}

	public String getClassName() {
		return className;
	}

	public void setClassName(String className) {
		this.className = className;
	}

	public String getClassTitle() {
		return classTitle;
	}

	public void setClassTitle(String classTitle) {
		this.classTitle = classTitle;
	}

	public String getBeanName() {
		return beanName;
	}

	public void setBeanName(String beanName) {
		this.beanName = beanName;
	}

	public List<ScriptMethod> getMethods() {
		return methods;
	}

	public void setMethods(List<ScriptMethod> methods) {
		this.methods = methods;
	}



	@Override
	public String getName() {
		return className;
	}



	@Override
	public String getTitle() {
		return "("+this.beanClass.getSimpleName()+")"+this.classTitle;
	}



	@Override
	public String getExample() {
		return "";
	}
	
	@Override
	public String getType() {
		return "class";
	}

	@Override
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@Override
	public String getParentId() {
		return "0";
	}
	
	@Override
	public String getIconCls() {
		return "icon-libary";
	}
	
	/*
	public static void main(String[] args){
		ProcessScript s=new ProcessScript();
		ScriptServiceClass cls=new ScriptServiceClass(s,"processScript");
		System.out.println(cls.toString());
	}*/
	
	
}
