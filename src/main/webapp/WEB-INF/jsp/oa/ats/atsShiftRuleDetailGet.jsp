
<%-- 
    Document   : [轮班规则明细]明细页
    Created on : 2018-03-21 16:05:40
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[轮班规则明细]明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>
        <rx:toolbar toolbarId="toolbar1"/>
        <div id="form1" class="form-outer">
             <div style="padding:5px;">
             	<table style="width:100%" class="table-detail" cellpadding="0" cellspacing="1">
                	<caption>[轮班规则明细]基本信息</caption>
					<tr>
						<th>班次ID：</th>
						<td>
							${atsShiftRuleDetail.ruleId}
						</td>
					</tr>
					<tr>
						<th>日期类型：</th>
						<td>
							${atsShiftRuleDetail.dateType}
						</td>
					</tr>
					<tr>
						<th>班次ID：</th>
						<td>
							${atsShiftRuleDetail.shiftId}
						</td>
					</tr>
					<tr>
						<th>上下班时间：</th>
						<td>
							${atsShiftRuleDetail.shiftTime}
						</td>
					</tr>
					<tr>
						<th>排序：</th>
						<td>
							${atsShiftRuleDetail.sn}
						</td>
					</tr>
					<tr>
						<th>租用机构ID：</th>
						<td>
							${atsShiftRuleDetail.tenantId}
						</td>
					</tr>
					<tr>
						<th>创建人ID：</th>
						<td>
							${atsShiftRuleDetail.createBy}
						</td>
					</tr>
					<tr>
						<th>创建时间：</th>
						<td>
							${atsShiftRuleDetail.createTime}
						</td>
					</tr>
					<tr>
						<th>更新人ID：</th>
						<td>
							${atsShiftRuleDetail.updateBy}
						</td>
					</tr>
					<tr>
						<th>更新时间：</th>
						<td>
							${atsShiftRuleDetail.updateTime}
						</td>
					</tr>
				</table>
             </div>
    	</div>
        <rx:detailScript baseUrl="oa/ats/atsShiftRuleDetail" 
        entityName="com.redxun.oa.ats.entity.AtsShiftRuleDetail"
        formId="form1"/>
        
        <script type="text/javascript">
		mini.parse();
		var form = new mini.Form("#form1");
		var pkId = '${atsShiftRuleDetail.id}';
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/oa/ats/atsShiftRuleDetail/getJson.do",
				data:{ids:pkId},
				success:function (json) {
					form.setData(json);
				}					
			});
		})
		</script>
    </body>
</html>