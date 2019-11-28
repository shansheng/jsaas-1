
<%-- 
    Document   : [INS_PORTAL_PERMISSION_TYPE]明细页
    Created on : 2018-06-05 18:30:18
    Author     : Tom_y
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[INS_PORTAL_PERMISSION_TYPE]明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>
        <rx:toolbar toolbarId="toolbar1"/>
        <div id="form1" class="form-outer">
             <div style="padding:5px;">
             	<table style="width:100%" class="table-detail" cellpadding="0" cellspacing="1">
                	<caption>[INS_PORTAL_PERMISSION_TYPE]基本信息</caption>
					<tr>
						<th>LAYOUT_ID_：</th>
						<td>
							${insPortalPermissionType.layoutId}
						</td>
					</tr>
					<tr>
						<th>TYPE_：</th>
						<td>
							${insPortalPermissionType.type}
						</td>
					</tr>
					<tr>
						<th>OWNER_ID_：</th>
						<td>
							${insPortalPermissionType.ownerId}
						</td>
					</tr>
					<tr>
						<th>编辑还是查看：</th>
						<td>
							${insPortalPermissionType.type2}
						</td>
					</tr>
					<tr>
						<th>流程实例ID：</th>
						<td>
							${insPortalPermissionType.updateBy}
						</td>
					</tr>
					<tr>
						<th>用户ID：</th>
						<td>
							${insPortalPermissionType.createBy}
						</td>
					</tr>
					<tr>
						<th>租户ID：</th>
						<td>
							${insPortalPermissionType.tenantId}
						</td>
					</tr>
					<tr>
						<th>创建时间：</th>
						<td>
							${insPortalPermissionType.createTime}
						</td>
					</tr>
					<tr>
						<th>更新时间：</th>
						<td>
							${insPortalPermissionType.updateTime}
						</td>
					</tr>
				</table>
             </div>
    	</div>
        <rx:detailScript baseUrl="filetray/authority/insPortalPermissionType" 
        entityName="com.airdrop.filetray.authority.entity.InsPortalPermissionType"
        formId="form1"/>
        
        <script type="text/javascript">
		mini.parse();
		var form = new mini.Form("#form1");
		var pkId = '${insPortalPermissionType.id}';
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/filetray/authority/insPortalPermissionType/getJson.do",
				data:{ids:pkId},
				success:function (json) {
					form.setData(json);
				}					
			});
		})
		</script>
    </body>
</html>