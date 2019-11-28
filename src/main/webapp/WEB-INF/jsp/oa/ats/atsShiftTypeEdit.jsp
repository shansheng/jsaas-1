
<%-- 
    Document   : [班次类型]编辑页
    Created on : 2018-03-21 16:05:40
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[班次类型]编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
	<rx:toolbar toolbarId="toolbar1" pkId="atsShiftType.id" />
	<div id="p1" class="form-outer">
		<form id="form1" method="post">
			<div class="form-inner">
				<input id="pkId" name="id" class="mini-hidden" value="${atsShiftType.id}" />
				<table class="table-detail column_2" cellspacing="1" cellpadding="0">
					<caption>[班次类型]基本信息</caption>
					<tr>
						<td>编码：</td>
						<td>
							
								<input name="code" value="${atsShiftType.code}"
							class="mini-textbox"   style="width: 90%" />
						</td>
						<td>名称：</td>
						<td>
							
								<input name="name" value="${atsShiftType.name}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<td>状态：</td>
						<td>
							<input 
							class="mini-combobox" 
							name="status"
						    showNullItem="true"  
						    emptyText="请选择..."
							data="[{id:'1',text:'启用'},{id:'0',text:'禁用'}]"
							value="${atsShiftType.status}"
						/>
						</td>
						<td>描述：</td>
						<td>
							
								<input name="memo" value="${atsShiftType.memo}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
				</table>
			</div>
		</form>
	</div>
	<rx:formScript formId="form1" baseUrl="oa/ats/atsShiftType"
		entityName="com.redxun.oa.ats.entity.AtsShiftType" />
	
	<script type="text/javascript">
	mini.parse();
	
	
	

	</script>
</body>
</html>