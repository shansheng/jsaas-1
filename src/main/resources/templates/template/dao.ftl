/**
 * 
 * <pre> 
 * 描述：${model.upperName} DAO接口
 <#if vars.developer?exists>
 * 作者:${vars.developer}
 </#if>
 * 日期:${date?string("yyyy-MM-dd HH:mm:ss")}
 * 版权：${vars.company}
 * </pre>
 */
package ${vars.domain}.${moduleName}.${packageName}.dao;

import ${vars.domain}.${moduleName}.${packageName}.entity.${model.upperName};
import org.springframework.stereotype.Repository;
import com.redxun.core.dao.jpa.BaseJpaDao;

@Repository
public class ${model.upperName}Dao extends BaseJpaDao<${model.upperName}> {


	@Override
	protected Class getEntityClass() {
		return ${model.upperName}.class;
	}

}

