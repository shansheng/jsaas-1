
<%-- 
    Document   : [业务实体对象]明细页
    Created on : 2018-05-01 14:21:00
    Author     : ray
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[业务实体对象]明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>
    	<rx:toolbar toolbarId="toolbar1"/>
      
		<div class="Mauto">
        <div id="form1" class="form-outer">
             <div style="padding:5px;">
             	<table style="width:100%" class="table-detail" cellpadding="0" cellspacing="1">
                	<caption>[业务实体对象]基本信息</caption>
					<tr>
						<th>名称：</th>
						<td>
							${sysBoEnt.name}
						</td>
					</tr>
					<tr>
						<th>注释：</th>
						<td>
							${sysBoEnt.comment}
						</td>
					</tr>
					<tr>
						<th>表名：</th>
						<td>
							${sysBoEnt.tableName}
						</td>
					</tr>
					<tr>
						<th>数据源名称：</th>
						<td>
							${sysBoEnt.dsName}
						</td>
					</tr>
					<tr>
						<th>是否生成物理表：</th>
						<td>
							${sysBoEnt.genTable}
						</td>
					</tr>
					<tr>
						<th>租户ID：</th>
						<td>
							${sysBoEnt.tenantId}
						</td>
					</tr>
					<tr>
						<th>创建时间：</th>
						<td>
							${sysBoEnt.createBy}
						</td>
					</tr>
					<tr>
						<th>创建时间：</th>
						<td>
							${sysBoEnt.createTime}
						</td>
					</tr>
					<tr>
						<th>更新人：</th>
						<td>
							${sysBoEnt.updateBy}
						</td>
					</tr>
					<tr>
						<th>更新时间：</th>
						<td>
							${sysBoEnt.updateTime}
						</td>
					</tr>
					<tr>
						<th>EXT_JSON_：</th>
						<td>
							${sysBoEnt.extJson}
						</td>
					</tr>
					<tr>
						<th>是否树形(YES,NO)：</th>
						<td>
							${sysBoEnt.tree}
						</td>
					</tr>
				</table>
             </div>
    	</div>
        <rx:detailScript baseUrl="sys/bo/sysBoEnt" 
        entityName="com.redxun.sys.bo.entity.SysBoEnt"
        formId="form1"/>
</div>       
        <script type="text/javascript">
		mini.parse();
		var form = new mini.Form("#form1");
		var pkId = '${sysBoEnt.id}';
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/sys/bo/sysBoEnt/getJson.do",
				data:{ids:pkId},
				success:function (json) {
					form.setData(json);
				}					
			});
		})
		</script>
    </body>
</html>