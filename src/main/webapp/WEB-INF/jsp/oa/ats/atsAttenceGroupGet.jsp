
<%-- 
    Document   : [考勤组]明细页
    Created on : 2018-03-27 11:27:43
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[考勤组]明细</title>
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
                	<caption>[考勤组]基本信息</caption>
					<tr>
						<td>编码：</td>
						<td>
							${atsAttenceGroup.code}
						</td>
						<td>名称：</td>
						<td>
							${atsAttenceGroup.name}
						</td>
					</tr>
					<tr>
						<td>所属组织：</td>
						<td>
							${atsAttenceGroup.orgId}
						</td>
						<td>描述：</td>
						<td>
							${atsAttenceGroup.memo}
						</td>
					</tr>
				</table>
             </div>
    	</div>
		</div>
        <rx:detailScript baseUrl="oa/ats/atsAttenceGroup" 
        entityName="com.redxun.oa.ats.entity.AtsAttenceGroup"
        formId="form1"/>
        
        <script type="text/javascript">
		mini.parse();
		var form = new mini.Form("#form1");
		var pkId = '${atsAttenceGroup.id}';
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/oa/ats/atsAttenceGroup/getJson.do",
				data:{ids:pkId},
				success:function (json) {
					json = mini.decode(json);
					form.setData(json);
				}					
			});
		})
		</script>
    </body>
</html>