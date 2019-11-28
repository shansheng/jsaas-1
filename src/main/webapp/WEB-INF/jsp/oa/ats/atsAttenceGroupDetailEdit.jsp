
<%-- 
    Document   : [考勤组明细]编辑页
    Created on : 2018-03-21 16:05:40
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[考勤组明细]编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
	<rx:toolbar toolbarId="toolbar1" pkId="atsAttenceGroupDetail.id" />
	<div id="p1" class="form-outer">
		<form id="form1" method="post">
			<div class="form-inner">
				<input id="pkId" name="id" class="mini-hidden" value="${atsAttenceGroupDetail.id}" />
				<table class="table-detail" cellspacing="1" cellpadding="0">
					<caption>[考勤组明细]基本信息</caption>
					<tr>
						<th>考勤组：</th>
						<td>
							
								<input name="groupId" value="${atsAttenceGroupDetail.groupId}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>考勤档案：</th>
						<td>
							
								<input name="fileId" value="${atsAttenceGroupDetail.fileId}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
				</table>
			</div>
		</form>
	</div>
	<rx:formScript formId="form1" baseUrl="oa/ats/atsAttenceGroupDetail"
		entityName="com.redxun.oa.ats.entity.AtsAttenceGroupDetail" />
	
	<script type="text/javascript">
	mini.parse();
	
	
	

	</script>
</body>
</html>