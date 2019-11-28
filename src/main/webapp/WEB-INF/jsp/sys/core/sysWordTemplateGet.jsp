
<%-- 
    Document   : [SYS_WORD_TEMPLATE【模板表】]明细页
    Created on : 2018-05-29 14:54:08
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[SYS_WORD_TEMPLATE【模板表】]明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>
        <rx:toolbar toolbarId="toolbar1"/>
        <div id="form1" class="form-outer">
             <div style="padding:5px;">
             	<table style="width:100%" class="table-detail" cellpadding="0" cellspacing="1">
                	<caption>[SYS_WORD_TEMPLATE【模板表】]基本信息</caption>
					<tr>
						<th>名称：</th>
						<td>
							${sysWordTemplate.name}
						</td>
					</tr>
					<tr>
						<th>数据源(SQL/自定义)：</th>
						<td>
							${sysWordTemplate.type}
						</td>
					</tr>
					<tr>
						<th>业务对象ID：</th>
						<td>
							${sysWordTemplate.boDefId}
						</td>
					</tr>
					<tr>
						<th>设定SQL语句，用于自定义数据源操作表单：</th>
						<td>
							${sysWordTemplate.setting}
						</td>
					</tr>
					<tr>
						<th>数据源：</th>
						<td>
							${sysWordTemplate.dsAlias}
						</td>
					</tr>
					<tr>
						<th>模板ID：</th>
						<td>
							${sysWordTemplate.templateId}
						</td>
					</tr>
					<tr>
						<th>模板名称：</th>
						<td>
							${sysWordTemplate.templateName}
						</td>
					</tr>
					<tr>
						<th>描述：</th>
						<td>
							${sysWordTemplate.description}
						</td>
					</tr>
					<tr>
						<th>租户ID：</th>
						<td>
							${sysWordTemplate.tenantId}
						</td>
					</tr>
					<tr>
						<th>创建人：</th>
						<td>
							${sysWordTemplate.createBy}
						</td>
					</tr>
					<tr>
						<th>创建时间：</th>
						<td>
							${sysWordTemplate.createTime}
						</td>
					</tr>
					<tr>
						<th>更新人：</th>
						<td>
							${sysWordTemplate.updateBy}
						</td>
					</tr>
					<tr>
						<th>更新时间：</th>
						<td>
							${sysWordTemplate.updateTime}
						</td>
					</tr>
				</table>
             </div>
    	</div>
        <rx:detailScript baseUrl="sys/core/sysWordTemplate" 
        entityName="com.redxun.sys.core.entity.SysWordTemplate"
        formId="form1"/>
        
        <script type="text/javascript">
		mini.parse();
		var form = new mini.Form("#form1");
		var pkId = '${sysWordTemplate.id}';
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/sys/core/sysWordTemplate/getJson.do",
				data:{ids:pkId},
				success:function (json) {
					form.setData(json);
				}					
			});
		})
		</script>
    </body>
</html>