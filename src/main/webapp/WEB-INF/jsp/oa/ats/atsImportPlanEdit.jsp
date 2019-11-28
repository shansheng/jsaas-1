
<%-- 
    Document   : [打卡导入方案]编辑页
    Created on : 2018-03-21 16:05:40
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[打卡导入方案]编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
	<rx:toolbar toolbarId="toolbar1" pkId="atsImportPlan.id" />
	<div id="p1" class="form-container">
		<form id="form1" method="post">
			<div class="form-inner">
				<input id="pkId" name="id" class="mini-hidden" value="${atsImportPlan.id}" />
				<table class="table-detail column-four" cellspacing="1" cellpadding="0">
					<caption>[打卡导入方案]基本信息</caption>
					<tr>
						<td>编码：</td>
						<td>
							
								<input name="code" value="${atsImportPlan.code}"
							class="mini-textbox"   style="width: 90%" />
						</td>
				
						<td>名称：</td>
						<td>
							
								<input name="name" value="${atsImportPlan.name}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<td>分割符：</td>
						<td>
							<input 
								name="separate"
								class="mini-combobox" 
								value="${atsImportPlan.separate}"
								data="[{id:'0',text:'逗号'},{id:'1',text:'Tab'},{id:'2',text:'#'}]"
								style="width:90%;"/>
						</td>
					
						<td>打卡对应关系：</td>
						<td>
							
								<input name="pushCardMap" value="${atsImportPlan.pushCardMap}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<td>描述：</td>
						<td colspan="3">
								<textarea name="memo" 
							class="mini-textarea"   style="width: 90%" >${atsImportPlan.memo}</textarea>
						</td>
					</tr>
					
				</table>
			</div>
		</form>
	</div>
	<rx:formScript formId="form1" baseUrl="oa/ats/atsImportPlan"
		entityName="com.redxun.oa.ats.entity.AtsImportPlan" />
	
	<script type="text/javascript">
	mini.parse();

	</script>
</body>
</html>