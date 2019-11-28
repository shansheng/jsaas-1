package com.redxun.bpm.script;

import com.redxun.core.annotion.cls.ClassDefine;
import com.redxun.core.annotion.cls.MethodDefine;
import com.redxun.core.annotion.cls.ParamDefine;
import com.redxun.core.script.GroovyScript;
import com.redxun.org.api.model.IUser;
import com.redxun.saweb.context.ContextUtil;

@ClassDefine(title = "脚本基础服务类")
public class ZsScript implements GroovyScript {
	
	
	
	/**
	 *params = {@ParamDefine(title = "ACT流程实例Id", varName = "actInstId")
	 * @return
	 */
	@MethodDefine(title = "更新demo",category="函数", params = {@ParamDefine(title = "主键", varName = "key")})
	public void updByKey(String key){
		System.out.println(key);
	}

}
