
<%-- 
    Document   : [班次设置]明细页
    Created on : 2018-03-26 13:55:50
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[班次设置]明细</title>
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
                	<caption>[班次设置]基本信息</caption>
					<tr>
						<td>编码：</td>
						<td>
							${atsShiftInfo.code}
						</td>
						<td>名称：</td>
						<td>
							${atsShiftInfo.name}
						</td>
					</tr>
					<tr>
						<td>班次类型：</td>
						<td>
							${atsShiftInfo.shiftTypeName}
						</td>
						<td>加班补偿方式：</td>
						<td>
							${atsShiftInfo.otCompens}
						</td>
					</tr>
					<tr>
						<td>所属组织：</td>
						<td>
							${atsShiftInfo.orgName}
						</td>
						<td>取卡规则：</td>
						<td>
							${atsShiftInfo.cardRuleName}
						</td>
					</tr>
					<tr>
						<td>标准工时：</td>
						<td>
							${atsShiftInfo.standardHour}
						</td>
						<td>是否默认：</td>
						<td>
							${atsShiftInfo.isDefault==1?'是':'否'}
						</td>
					</tr>
					<tr>
						<td>描述：</td>
						<td colspan="3">
							${atsShiftInfo.memo}
						</td>
					</tr>
				</table>
             </div>
    	</div>
	</div>
        <rx:detailScript baseUrl="oa/ats/atsShiftInfo" 
        entityName="com.redxun.oa.ats.entity.AtsShiftInfo"
        formId="form1"/>
        
        <script type="text/javascript">
		mini.parse();
		
		</script>
    </body>
</html>