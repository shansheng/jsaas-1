
<%-- 
    Document   : [基础数据]明细页
    Created on : 2018-03-21 16:05:40
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[基础数据]明细</title>
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
             	<table style="width:100%" class="table-detail column-two" cellpadding="0" cellspacing="1">
                	<caption>[基础数据]基本信息</caption>
					<tr>
						<td>编码：</td>
						<td>
							${atsBaseItem.code}
						</td>
					</tr>
					<tr>
						<td>名称：</td>
						<td>
							${atsBaseItem.name}
						</td>
					</tr>
					<tr>
						<td>地址：</td>
						<td>
							${atsBaseItem.url}
						</td>
					</tr>
					<tr>
						<td>是否系统预置：</td>
						<td>
							${atsBaseItem.isSys==1?'是':'否'}
						</td>
					</tr>
					<tr>
						<td>描述：</td>
						<td>
							${atsBaseItem.memo}
						</td>
					</tr>
				</table>
             </div>
    	</div>
	</div>
        <rx:detailScript baseUrl="oa/ats/atsBaseItem" 
        entityName="com.redxun.oa.ats.entity.AtsBaseItem"
        formId="form1"/>
        
        <script type="text/javascript">
		mini.parse();
		var form = new mini.Form("#form1");
		var pkId = '${atsBaseItem.id}';
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/oa/ats/atsBaseItem/getJson.do",
				data:{ids:pkId},
				success:function (json) {
					form.setData(json);
				}					
			});
		})
		</script>
    </body>
</html>