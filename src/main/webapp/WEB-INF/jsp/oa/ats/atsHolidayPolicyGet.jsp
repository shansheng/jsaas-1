
<%-- 
    Document   : [假期制度]明细页
    Created on : 2018-03-23 17:08:22
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[假期制度]明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>
	<div class="topToolBar">
		<div>
			<rx:toolbar toolbarId="toolbar1"/>
		</div>
	</div>
        <div class="mini-fit">
        <div id="form1" class="form-container">
             <div style="padding:5px;">
             	<table style="width:100%" class="table-detail column-four" cellpadding="0" cellspacing="1">
                	<caption>[假期制度]基本信息</caption>
					<tr>
						<td>编码：</td>
						<td>
							${atsHolidayPolicy.code}
						</td>
						<td>名称：</td>
						<td>
							${atsHolidayPolicy.name}
						</td>
					</tr>
					<tr>
						<td>所属组织：</td>
						<td>
							${atsHolidayPolicy.orgName}
						</td>
						<td>是否默认：</td>
						<td>
							${atsHolidayPolicy.isDefault==1?'是':'否'}
						</td>
					</tr>
					<tr>
						<td>是否启动半天假：</td>
						<td>
							${atsHolidayPolicy.isHalfDayOff==1?'是':'否'}
						</td>
						<td>描述：</td>
						<td>
							${atsHolidayPolicy.memo}
						</td>
					</tr>
					
				</table>
             </div>
    	</div>
	</div>
        <rx:detailScript baseUrl="oa/ats/atsHolidayPolicy" 
        entityName="com.redxun.oa.ats.entity.AtsHolidayPolicy"
        formId="form1"/>
        
        <script type="text/javascript">
		mini.parse();
		
		
		</script>
    </body>
</html>