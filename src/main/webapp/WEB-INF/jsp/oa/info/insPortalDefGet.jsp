
<%-- 
    Document   : [ins_portal_def]明细页
    Created on : 2017-08-15 16:07:14
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>自定义门户明细</title>
        <%@include file="/commons/get.jsp" %>
		<style>
			body{
				border-top: 1px solid transparent;
			}
		</style>
    </head>

    <body>
<%--         <rx:toolbar toolbarId="toolbar1"/> --%>
<div class="fitTop"></div>
        <div class="mini-fit">
        	<div id="form1" class="form-container" >
             	<table style="width:100%" class="table-detail column-two" cellpadding="0" cellspacing="1">
                	<caption>自定义门户基本信息</caption>
					<tr>
						<td>门  户  名</td>
						<td>
							${insPortalDef.name}
						</td>
					</tr>
					<tr>
						<td>Key</td>
						<td>
							${insPortalDef.key}
						</td>
					</tr>
					<tr>
						<td>是否默认</td>
						<td>
							${insPortalDef.isDefault}
						</td>
					</tr>
					<tr>
						<td>优  先  级</td>
						<td>
							${insPortalDef.priority}
						</td>
					</tr>
					<tr>
						<td>
							${insPortalDef.tenantId}
						</td>
					</tr>
					<tr>
						<th>是否手机门户</th>
						<td>
							${empty insPortalDef.isMobile ? "否" : "是"}
						</td>
					</tr>
					<tr>
						<td>创建人ID</td>
						<td>
							${insPortalDef.createBy}
						</td>
					</tr>
					<tr>
						<td>创建时间</td>
						<td>
							${insPortalDef.createTime}
						</td>
					</tr>
					<tr>
						<td>更新人ID</td>
						<td>
							${insPortalDef.updateBy}
						</td>
					</tr>
					<tr>
						<td>更新时间</td>
						<td>
							${insPortalDef.updateTime}
						</td>
					</tr>
				</table>
    		</div>
        </div>
        <rx:detailScript baseUrl="oa/info/insPortalDef" 
        entityName="com.redxun.oa.info.entity.InsPortalDef"
        formId="form1"/>
        
        <script type="text/javascript">
        addBody();
		mini.parse();
		var form = new mini.Form("#form1");
		var pkId = '${insPortalDef.portId}';
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/oa/info/insPortalDef/getJson.do",
				data:{ids:pkId},
				success:function (json) {
					form.setData(json);
				}					
			});
		})
		</script>
    </body>
</html>