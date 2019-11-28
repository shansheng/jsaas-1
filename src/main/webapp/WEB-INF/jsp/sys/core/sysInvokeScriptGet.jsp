
<%-- 
    Document   : [执行脚本配置]明细页
    Created on : 2018-10-18 11:06:29
    Author     : ray
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[执行脚本配置]明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>
        <rx:toolbar toolbarId="toolbar1"/>
		<div class="mini-fit">
   <div class="form-container">
        <div id="form1" class="form-outer">
             <div>
             	<table style="width:100%" class="table-detail" cellpadding="0" cellspacing="1">
                	<caption>[执行脚本配置]基本信息</caption>
					<tr>
						<td>分类ID：</td>
						<td>
							${sysInvokeScript.categroyId}
						</td>
					</tr>
					<tr>
						<td> 名称：</td>
						<td>
							${sysInvokeScript.name}
						</td>
					</tr>
					<tr>
						<td>别名：</td>
						<td>
							${sysInvokeScript.alias}
						</td>
					</tr>
					<tr>
						<td>脚本内容：</td>
						<td>
							${sysInvokeScript.content}
						</td>
					</tr>
					<tr>
						<td>租户ID：</td>
						<td>
							${sysInvokeScript.tenantId}
						</td>
					</tr>
					<tr>
						<td>创建人：</td>
						<td>
							${sysInvokeScript.createBy}
						</td>
					</tr>
					<tr>
						<td>更新人：</td>
						<td>
							${sysInvokeScript.updateBy}
						</td>
					</tr>
					<tr>
						<td>更新时间：</td>
						<td>
							${sysInvokeScript.updateTime}
						</td>
					</tr>
					<tr>
						<td>创建时间：</td>
						<td>
							${sysInvokeScript.createTime}
						</td>
					</tr>
				</table>
             </div>
    	</div>
        <rx:detailScript baseUrl="sys/core/sysInvokeScript" 
        entityName="com.redxun.sys.core.entity.SysInvokeScript"
        formId="form1"/>
        
        <script type="text/javascript">
		mini.parse();
		var form = new mini.Form("#form1");
		var pkId = '${sysInvokeScript.id}';
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/sys/core/sysInvokeScript/getJson.do",
				data:{ids:pkId},
				success:function (json) {
					form.setData(json);
				}					
			});
		})
		</script>
	</div>
		</div>
    </body>
</html>