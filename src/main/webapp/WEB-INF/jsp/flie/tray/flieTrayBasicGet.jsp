
<%-- 
    Document   : [文件盘基本类]明细页
    Created on : 2018-06-18 17:06:18
    Author     : Tom_y
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[文件盘基本类]明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>
        <rx:toolbar toolbarId="toolbar1"/>
        <div id="form1" class="form-outer">
             <div style="padding:5px;">
             	<table style="width:100%" class="table-detail" cellpadding="0" cellspacing="1">
                	<caption>[文件盘基本类]基本信息</caption>
					<tr>
						<th>外键：</th>
						<td>
							${flieTrayBasic.refId}
						</td>
					</tr>
					<tr>
						<th>文件盘名：</th>
						<td>
							${flieTrayBasic.fileTrayName}
						</td>
					</tr>
					<tr>
						<th>排序大小ID：</th>
						<td>
							${flieTrayBasic.sn}
						</td>
					</tr>
					<tr>
						<th>排序大小：</th>
						<td>
							${flieTrayBasic.snName}
						</td>
					</tr>
					<tr>
						<th>管理员：</th>
						<td>
							${flieTrayBasic.adminName}
						</td>
					</tr>
					<tr>
						<th>管理员ID：</th>
						<td>
							${flieTrayBasic.adminId}
						</td>
					</tr>
					<tr>
						<th>流程实例ID：</th>
						<td>
							${flieTrayBasic.instId}
						</td>
					</tr>
					<tr>
						<th>状态：</th>
						<td>
							${flieTrayBasic.instStatus}
						</td>
					</tr>
					<tr>
						<th>用户ID：</th>
						<td>
							${flieTrayBasic.createUserId}
						</td>
					</tr>
					<tr>
						<th>组ID：</th>
						<td>
							${flieTrayBasic.createGroupId}
						</td>
					</tr>
					<tr>
						<th>租户ID：</th>
						<td>
							${flieTrayBasic.tenantId}
						</td>
					</tr>
					<tr>
						<th>创建时间：</th>
						<td>
							${flieTrayBasic.createTime}
						</td>
					</tr>
					<tr>
						<th>更新时间：</th>
						<td>
							${flieTrayBasic.updateTime}
						</td>
					</tr>
				</table>
             </div>
    	</div>
        <rx:detailScript baseUrl="flie/tray/flieTrayBasic" 
        entityName="com.airdrop.flie.tray.entity.FlieTrayBasic"
        formId="form1"/>
        
        <script type="text/javascript">
		mini.parse();
		var form = new mini.Form("#form1");
		var pkId = '${flieTrayBasic.id}';
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/flie/tray/flieTrayBasic/getJson.do",
				data:{ids:pkId},
				success:function (json) {
					form.setData(json);
				}					
			});
		})
		</script>
    </body>
</html>