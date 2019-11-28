
<%-- 
    Document   : [日历模版]明细页
    Created on : 2018-03-22 09:49:46
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[日历模版]明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>
        <rx:toolbar toolbarId="toolbar1"/>
        <div id="form1" class="form-outer">
             <div style="padding:5px;">
             	<table style="width:100%" class="table-detail column_2" cellpadding="0" cellspacing="1">
                	<caption>[日历模版]基本信息</caption>
					<tr>
						<td>编码：</td>
						<td>
							${atsCalendarTempl.code}
						</td>
						<td>名称：</td>
						<td>
							${atsCalendarTempl.name}
						</td>
					</tr>
					<tr>
						<td>是否系统预置：</td>
						<td>
							${atsCalendarTempl.isSys==1?'是':'否'}
						</td>
						<td>状态：</td>
						<td>
							${atsCalendarTempl.status==1?'启用':'禁用'}
						</td>
					</tr>
					<tr>
						<td>描述：</td>
						<td colspan="3">
							${atsCalendarTempl.memo}
						</td>
					</tr>
				</table>
             </div>
    	</div>
    	
        <rx:detailScript baseUrl="oa/ats/atsCalendarTempl" 
        entityName="com.redxun.oa.ats.entity.AtsCalendarTempl"
        formId="form1"/>
        
        <script type="text/javascript">
		mini.parse();
		
		</script>
    </body>
</html>