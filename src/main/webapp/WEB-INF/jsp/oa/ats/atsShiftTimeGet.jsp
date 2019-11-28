
<%-- 
    Document   : [班次时间设置]明细页
    Created on : 2018-03-21 16:05:40
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[班次时间设置]明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>
        <rx:toolbar toolbarId="toolbar1"/>
        <div id="form1" class="form-outer">
             <div style="padding:5px;">
             	<table style="width:100%" class="table-detail" cellpadding="0" cellspacing="1">
                	<caption>[班次时间设置]基本信息</caption>
					<tr>
						<th>班次ID：</th>
						<td>
							${atsShiftTime.shiftId}
						</td>
					</tr>
					<tr>
						<th>段次：</th>
						<td>
							${atsShiftTime.segment}
						</td>
					</tr>
					<tr>
						<th>出勤类型：</th>
						<td>
							${atsShiftTime.attendanceType}
						</td>
					</tr>
					<tr>
						<th>上班时间：</th>
						<td>
							${atsShiftTime.onTime}
						</td>
					</tr>
					<tr>
						<th>上班是否打卡：</th>
						<td>
							${atsShiftTime.onPunchCard}
						</td>
					</tr>
					<tr>
						<th>上班浮动调整值（分）：</th>
						<td>
							${atsShiftTime.onFloatAdjust}
						</td>
					</tr>
					<tr>
						<th>段内休息时间：</th>
						<td>
							${atsShiftTime.segmentRest}
						</td>
					</tr>
					<tr>
						<th>下班时间：</th>
						<td>
							${atsShiftTime.offTime}
						</td>
					</tr>
					<tr>
						<th>下班是否打卡：</th>
						<td>
							${atsShiftTime.offPunchCard}
						</td>
					</tr>
					<tr>
						<th>下班浮动调整值（分）：</th>
						<td>
							${atsShiftTime.offFloatAdjust}
						</td>
					</tr>
					<tr>
						<th>上班类型：</th>
						<td>
							${atsShiftTime.onType}
						</td>
					</tr>
					<tr>
						<th>下班类型：</th>
						<td>
							${atsShiftTime.offType}
						</td>
					</tr>
					<tr>
						<th>租用机构ID：</th>
						<td>
							${atsShiftTime.tenantId}
						</td>
					</tr>
					<tr>
						<th>创建人ID：</th>
						<td>
							${atsShiftTime.createBy}
						</td>
					</tr>
					<tr>
						<th>创建时间：</th>
						<td>
							${atsShiftTime.createTime}
						</td>
					</tr>
					<tr>
						<th>更新人ID：</th>
						<td>
							${atsShiftTime.updateBy}
						</td>
					</tr>
					<tr>
						<th>更新时间：</th>
						<td>
							${atsShiftTime.updateTime}
						</td>
					</tr>
				</table>
             </div>
    	</div>
        <rx:detailScript baseUrl="oa/ats/atsShiftTime" 
        entityName="com.redxun.oa.ats.entity.AtsShiftTime"
        formId="form1"/>
        
        <script type="text/javascript">
		mini.parse();
		var form = new mini.Form("#form1");
		var pkId = '${atsShiftTime.id}';
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/oa/ats/atsShiftTime/getJson.do",
				data:{ids:pkId},
				success:function (json) {
					form.setData(json);
				}					
			});
		})
		</script>
    </body>
</html>