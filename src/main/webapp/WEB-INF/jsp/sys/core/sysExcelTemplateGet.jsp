
<%-- 
    Document   : [EXCEL导入模板]明细页
    Created on : 2018-12-20 11:56:40
    Author     : ray
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[EXCEL导入模板]明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>
        <rx:toolbar toolbarId="toolbar1"/>
        <div id="toptoolbarBg"></div>
   <div class="Mauto">     
        <div id="form1" class="form-outer">
             <div>
             	<table style="width:100%" class="table-detail" cellpadding="0" cellspacing="1">
                	<caption>[EXCEL导入模板]基本信息</caption>
					<tr>
						<td>模式名称：</td>
						<td>
							${sysExcelTemplate.templateName}
						</td>
					</tr>
					<tr>
						<td>模式别名：</td>
						<td>
							${sysExcelTemplate.templateNameAlias}
						</td>
					</tr>
					<tr>
						<td>模式类型：</td>
						<td>
							${sysExcelTemplate.templateType}
						</td>
					</tr>
					<tr>
						<td>备注：</td>
						<td>
							${sysExcelTemplate.templateComment}
						</td>
					</tr>
					<tr>
						<td>配置信息：</td>
						<td>
							${sysExcelTemplate.templateConf}
						</td>
					</tr>
					<tr>
						<td>模板文件名称：</td>
						<td>
							${sysExcelTemplate.excelTemplateFile}
						</td>
					</tr>
					<tr>
						<td>租用用户Id：</td>
						<td>
							${sysExcelTemplate.tenantId}
						</td>
					</tr>
					<tr>
						<td>创建人ID：</td>
						<td>
							${sysExcelTemplate.createBy}
						</td>
					</tr>
					<tr>
						<td>创建时间：</td>
						<td>
							${sysExcelTemplate.createTime}
						</td>
					</tr>
					<tr>
						<td>更新人ID：</td>
						<td>
							${sysExcelTemplate.updateBy}
						</td>
					</tr>
					<tr>
						<td>更新时间：</td>
						<td>
							${sysExcelTemplate.updateTime}
						</td>
					</tr>
				</table>
             </div>
    	</div>
        <rx:detailScript baseUrl="sys/core/sysExcelTemplate" 
        entityName="com.redxun.sys.core.entity.SysExcelTemplate"
        formId="form1"/>
        
        <script type="text/javascript">
		mini.parse();
		var form = new mini.Form("#form1");
		var pkId = '${sysExcelTemplate.id}';
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/sys/core/sysExcelTemplate/getJson.do",
				data:{ids:pkId},
				success:function (json) {
					form.setData(json);
				}					
			});
		})
		</script>
	</div>
    </body>
</html>