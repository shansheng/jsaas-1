
<%-- 
    Document   : [打卡导入方案]明细页
    Created on : 2018-03-21 16:05:40
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[打卡导入方案]明细</title>
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
                	<caption>[打卡导入方案]基本信息</caption>
					<tr>
						<td>编码：</td>
						<td>
							${atsImportPlan.code}
						</td>
					</tr>
					<tr>
						<td>名称：</td>
						<td>
							${atsImportPlan.name}
						</td>
					</tr>
					<tr>
						<td>分割符：</td>
						<td>
							${atsImportPlan.separate}
						</td>
					</tr>
					<tr>
						<td>描述：</td>
						<td>
							${atsImportPlan.memo}
						</td>
					</tr>
					<tr>
						<td>打卡对应关系：</td>
						<td>
							${atsImportPlan.pushCardMap}
						</td>d
					</tr>
					<tr>
						<td>租用机构ID：</td>
						<td>
							${atsImportPlan.tenantId}
						</td>
					</tr>
					<tr>
						<td>创建人ID：</td>
						<td>
							${atsImportPlan.createBy}
						</td>
					</tr>
					<tr>
						<td>创建时间：</td>
						<td>
							${atsImportPlan.createTime}
						</td>
					</tr>
					<tr>
						<td>更新人ID：</td>
						<td>
							${atsImportPlan.updateBy}
						</td>
					</tr>
					<tr>
						<td>更新时间：</td>
						<td>
							${atsImportPlan.updateTime}
						</td>
					</tr>
				</table>
             </div>
    	</div>
	</div>
        <rx:detailScript baseUrl="oa/ats/atsImportPlan" 
        entityName="com.redxun.oa.ats.entity.AtsImportPlan"
        formId="form1"/>
        
        <script type="text/javascript">
		mini.parse();
		var form = new mini.Form("#form1");
		var pkId = '${atsImportPlan.id}';
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/oa/ats/atsImportPlan/getJson.do",
				data:{ids:pkId},
				success:function (json) {
					form.setData(json);
				}					
			});
		})
		</script>
    </body>
</html>