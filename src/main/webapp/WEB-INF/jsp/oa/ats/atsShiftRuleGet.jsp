
<%-- 
    Document   : [轮班规则]明细页
    Created on : 2018-03-26 16:50:46
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[轮班规则]明细</title>
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
                	<caption>[轮班规则]基本信息</caption>
					<tr>
						<td>编码：</td>
						<td>
							${atsShiftRule.code}
						</td>
						<td>名称：</td>
						<td>
							${atsShiftRule.name}
						</td>
					</tr>
					<tr>
						<td>所属组织：</td>
						<td>
							${atsShiftRule.orgName}
						</td>
						<td>描述：</td>
						<td>
							${atsShiftRule.memo}
						</td>
					</tr>
				</table>
             </div>
    	</div>
	</div>
        <rx:detailScript baseUrl="oa/ats/atsShiftRule" 
        entityName="com.redxun.oa.ats.entity.AtsShiftRule"
        formId="form1"/>
        
        <script type="text/javascript">
		mini.parse();
		
		
		</script>
    </body>
</html>