+
<%-- 
    Document   : [考勤制度]明细页
    Created on : 2018-03-21 16:05:40
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[考勤制度]明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>
        <rx:toolbar toolbarId="toolbar1"/>
        <div id="form1" class="form-outer">
             <div style="padding:5px;">
             	<table style="width:100%" class="table-detail column_2" cellpadding="0" cellspacing="1">
                	<caption>[考勤制度]基本信息</caption>
					<tr>
						<td>编码：</td>
						<td>
							${atsAttencePolicy.code}
						</td>
						<td>名称：</td>
						<td>
							${atsAttencePolicy.name}
						</td>
					</tr>
					<tr>
						<td>工作日历：</td>
						<td>
							${atsAttencePolicy.workCalendar}
						</td>
						<td>考勤周期：</td>
						<td>
							${atsAttencePolicy.attenceCycle}
						</td>
					</tr>
					<tr>
						<td>所属组织：</td>
						<td>
							${atsAttencePolicy.orgId}
						</td>
						<td>是否默认：</td>
						<td>
							${atsAttencePolicy.isDefault==1?'是':'否'}
						</td>
					</tr>
					<tr>
						<td>每周工作时数(小时)：</td>
						<td>
							${atsAttencePolicy.weekHour}
						</td>
						<td>每天工作时数(小时)：</td>
						<td>
							${atsAttencePolicy.daysHour}
						</td>
					</tr>
					<tr>
						
						<td>月标准工作天数(天)：</td>
						<td>
							${atsAttencePolicy.monthDay}
						</td>
						<td>每段早退允许值(分钟)：</td>
						<td>
							${atsAttencePolicy.leaveAllow}
						</td>
					</tr>
					<tr>
						
						<td>每段迟到允许值(分钟)：</td>
						<td>
							${atsAttencePolicy.lateAllow}
						</td>
						<td>旷工起始值(分钟)：</td>
						<td>
							${atsAttencePolicy.absentAllow}
						</td>
					</tr>
					<tr>
						
						<td>加班起始值(分钟)：</td>
						<td>
							${atsAttencePolicy.otStart}
						</td>
						<td>早退起始值(分钟)：</td>
						<td>
							${atsAttencePolicy.leaveStart}
						</td>
					</tr>
					<tr>
						<td>班前无需加班单：</td>
						<td>
							${atsAttencePolicy.preNotBill==1?'是':'否'}
						</td>
						<td>班后无需加班单：</td>
						<td>
							${atsAttencePolicy.afterNotBill==1?'是':'否'}
						</td>
					</tr>
					<tr>
						<td>描述：</td>
						<td colspan="3">
							${atsAttencePolicy.memo}
						</td>
					</tr>
				</table>
             </div>
    	</div>
        <rx:detailScript baseUrl="oa/ats/atsAttencePolicy" 
        entityName="com.redxun.oa.ats.entity.AtsAttencePolicy"
        formId="form1"/>
        
        <script type="text/javascript">
		mini.parse();
		var form = new mini.Form("#form1");
		var pkId = '${atsAttencePolicy.id}';
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/oa/ats/atsAttencePolicy/getJson.do",
				data:{ids:pkId},
				success:function (json) {
					form.setData(json);
				}					
			});
		})
		</script>
    </body>
</html>