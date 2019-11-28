
<%-- 
    Document   : [用户类型]明细页
    Created on : 2018-09-03 14:21:10
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[用户类型]明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>
        <rx:toolbar toolbarId="toolbar1"/>
		<div class="mini-fit">
			<div id="form1" class="form-container">
				 <div style="padding:5px;">
					<table style="width:100%" class="table-detail column-two" cellpadding="0" cellspacing="1">
						<caption>[用户类型]基本信息</caption>
						<tr>
							<td>编码：</td>
							<td>
								${osUserType.code}
							</td>
						</tr>
						<tr>
							<td>名称：</td>
							<td>
								${osUserType.name}
							</td>
						</tr>
						<tr>
							<td>描述：</td>
							<td>
								${osUserType.descp}
							</td>
						</tr>
						<tr>
							<td>GROUP_ID_：</td>
							<td>
								${osUserType.groupId}
							</td>
						</tr>
						<tr>
							<td>创建人ID：</td>
							<td>
								${osUserType.createBy}
							</td>
						</tr>
						<tr>
							<td>创建时间：</td>
							<td><fmt:formatDate value="${osUserType.createTime}" pattern="yyyy-MM-dd HH:mm" /></td>
						</tr>
						<tr>
							<td>机构ID：</td>
							<td>
								${osUserType.tenantId}
							</td>
						</tr>
						<tr>
							<td>更新人ID：</td>
							<td>
								${osUserType.updateBy}
							</td>
						</tr>
						<tr>
							<td>更新时间：</td>
							<td><fmt:formatDate value="${osUserType.updateTime}" pattern="yyyy-MM-dd HH:mm" /></td>
						</tr>
					</table>
				 </div>
			</div>
		</div>
        <rx:detailScript baseUrl="sys/org/osUserType" 
        entityName="com.redxun.sys.org.entity.OsUserType"
        formId="form1"/>
        
        <script type="text/javascript">
		mini.parse();
		var form = new mini.Form("#form1");
		var pkId = '${osUserType.id}';
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/sys/org/osUserType/getJson.do",
				data:{ids:pkId},
				success:function (json) {
					form.setData(json);
				}					
			});
		})
		</script>
    </body>
</html>