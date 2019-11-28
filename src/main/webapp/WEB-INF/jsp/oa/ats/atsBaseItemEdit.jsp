
<%-- 
    Document   : [基础数据]编辑页
    Created on : 2018-03-21 16:05:40
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[基础数据]编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
	<rx:toolbar toolbarId="toolbar1" pkId="atsBaseItem.id" />
	<div id="p1" class="form-container">
		<form id="form1" method="post">
			<div class="form-inner">
				<input id="pkId" name="id" class="mini-hidden" value="${atsBaseItem.id}" />
				<table class="table-detail column-four" cellspacing="1" cellpadding="0">
					<caption>[基础数据]基本信息</caption>
					<tr>
						<td>编码：</td>
						<td>
							<input name="code" value="${atsBaseItem.code}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					
						<td>名称：</td>
						<td>
							
								<input name="name" value="${atsBaseItem.name}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<td>地址：</td>
						<td colspan="3">
							
								<input name="url" value="${atsBaseItem.url}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<td>描述：</td>
						<td colspan="3">
							
								<textarea name="memo" 
							class="mini-textarea"   style="width: 90%">${atsBaseItem.memo}</textarea>
						</td>
					</tr>
				</table>
			</div>
		</form>
	</div>
	<rx:formScript formId="form1" baseUrl="oa/ats/atsBaseItem"
		entityName="com.redxun.oa.ats.entity.AtsBaseItem" />
	
	<script type="text/javascript">
	mini.parse();
	
	
	

	</script>
</body>
</html>