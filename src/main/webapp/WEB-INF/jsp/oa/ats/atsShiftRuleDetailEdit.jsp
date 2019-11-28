
<%-- 
    Document   : [轮班规则明细]编辑页
    Created on : 2018-03-21 16:05:40
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[轮班规则明细]编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
	<rx:toolbar toolbarId="toolbar1" pkId="atsShiftRuleDetail.id" />
	<div id="p1" class="form-outer">
		<form id="form1" method="post">
			<div class="form-inner">
				<input id="pkId" name="id" class="mini-hidden" value="${atsShiftRuleDetail.id}" />
				<table class="table-detail" cellspacing="1" cellpadding="0">
					<caption>[轮班规则明细]基本信息</caption>
					<tr>
						<th>班次ID：</th>
						<td>
							
								<input name="ruleId" value="${atsShiftRuleDetail.ruleId}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>日期类型：</th>
						<td>
							
								<input name="dateType" value="${atsShiftRuleDetail.dateType}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>班次ID：</th>
						<td>
							
								<input name="shiftId" value="${atsShiftRuleDetail.shiftId}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>上下班时间：</th>
						<td>
							
								<input name="shiftTime" value="${atsShiftRuleDetail.shiftTime}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
					<tr>
						<th>排序：</th>
						<td>
							
								<input name="sn" value="${atsShiftRuleDetail.sn}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
				</table>
			</div>
		</form>
	</div>
	<rx:formScript formId="form1" baseUrl="oa/ats/atsShiftRuleDetail"
		entityName="com.redxun.oa.ats.entity.AtsShiftRuleDetail" />
	
	<script type="text/javascript">
	mini.parse();
	
	
	

	</script>
</body>
</html>