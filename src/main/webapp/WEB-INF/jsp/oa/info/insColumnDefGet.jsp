
<%-- 
    Document   : [ins_column_def]明细页
    Created on : 2017-08-16 11:39:47
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>自定义栏目明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>
			<rx:toolbar toolbarId="toolbar1"/>
	<div class="mini-fit">
        <div id="form1" class="form-container">
			<table style="width:100%" class="table-detail column-two" cellpadding="0" cellspacing="1">
				<caption>自定义栏目基本信息</caption>
				<tr>
					<td>栏  目  名</td>
					<td>
						${insColumnDef.name}
					</td>
				</tr>
				<tr>
					<td>Key</td>
					<td>
						${insColumnDef.key}
					</td>
				</tr>
				<tr>
					<td>方法或sql</td>
					<td>
						${insColumnDef.function}
					</td>
				</tr>
				<tr>
					<td>是否为公共栏目</td>
					<td>
						${insColumnDef.isPublic==1?'是':'否'}
					</td>
				</tr>
				<tr>
					<td>租用机构ID</td>
					<td>
						${insColumnDef.tenantId}
					</td>
				</tr>
				<tr>
					<td>创建人ID</td>
					<td>
						${insColumnDef.createBy}
					</td>
				</tr>
				<tr>
					<td>创建时间</td>
					<td>
						${insColumnDef.createTime}
					</td>
				</tr>
				<tr>
					<td>更新人ID</td>
					<td>
						${insColumnDef.updateBy}
					</td>
				</tr>
				<tr>
					<td>更新时间</td>
					<td>
						${insColumnDef.updateTime}
					</td>
				</tr>
			</table>
		 </div>
	</div>
        <rx:detailScript baseUrl="oa/info/insColumnDef" 
        entityName="com.redxun.oa.info.entity.InsColumnDef"
        formId="form1"/>
        
        <script type="text/javascript">
	        addBody();
			mini.parse();
			var form = new mini.Form("#form1");
			var pkId = ${insColumnDef.colId};
			$(function(){
				$.ajax({
					type:'POST',
					url:"${ctxPath}/oa/info/insColumnDef/getJson.do",
					data:{ids:pkId},
					success:function (json) {
						form.setData(json);
					}					
				});
			})
		</script>
    </body>
</html>