<%-- 
    Document   : [BpmFormTemplate]明细页
    Created on : 2015-3-28, 17:42:57
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>表单模板明细</title>
<%@include file="/commons/get.jsp"%>
</head>
<body>
	<div class="form-container">
		<div class="paddingTop">
			<div id="form1" >
				<div>
					<table style="width: 100%" class="table-detail column-two" cellpadding="0"
						cellspacing="1">
						<caption>表单模版基本信息</caption>
						<tr>
							<td>模版名称</td>
							<td>${bpmFormTemplate.name}</td>
						</tr>
						<tr>
							<td>别　　名</td>
							<td>${bpmFormTemplate.alias}</td>
						</tr>
						<tr>
							<td>模　　版</td>
							<td><c:out value="${bpmFormTemplate.template}"></c:out> </td>
						</tr>
						
						<tr>
							<td>模版类型 </td>
							<td>${bpmFormTemplate.type}</td>
						</tr>
						<tr>
							<td>初始添加的(1是,0否)</td>
							<td>${bpmFormTemplate.init==1?"系统默认":"自定义添加"}</td>
						</tr>
					</table>
				</div>
				
			</div>
		</div>
	</div>
	<rx:detailScript baseUrl="bpm/form/bpmFormTemplate"
		entityName="com.redxun.bpm.form.entity.BpmFormTemplate" formId="form1" />
		
	<script type="text/javascript">
		addBody();
	</script>
</body>
</html>