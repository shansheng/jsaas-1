
<%-- 
    Document   : [ES自定义查询]明细页
    Created on : 2018-11-28 14:21:52
    Author     : ray
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[ES自定义查询]明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>
        <rx:toolbar toolbarId="toolbar1"/>
        <div id="toptoolbarBg"></div>
   <div class="Mauto">     
        <div id="form1" class="form-outer">
             <div>
             	<table style="width:100%" class="table-detail" cellpadding="0" cellspacing="1">
                	<caption>[ES自定义查询]基本信息</caption>
					<tr>
						<th>名称：</th>
						<td>
							${sysEsQuery.name}
						</td>
					</tr>
					<tr>
						<th>别名：</th>
						<td>
							${sysEsQuery.alias}
						</td>
					</tr>
					<tr>
						<th>查询类型 1.索引,2.编写SQL语句：</th>
						<td>
							${sysEsQuery.queryType}
						</td>
					</tr>
					<tr>
						<th>查询语句：</th>
						<td>
							${sysEsQuery.query}
						</td>
					</tr>
					<tr>
						<th>定义返回字段：</th>
						<td>
							${sysEsQuery.returnFields}
						</td>
					</tr>
					<tr>
						<th>条件字段定义：</th>
						<td>
							${sysEsQuery.conditionFields}
						</td>
					</tr>
					<tr>
						<th>排序字段：</th>
						<td>
							${sysEsQuery.sortFields}
						</td>
					</tr>
					<tr>
						<th>是否分页：</th>
						<td>
							${sysEsQuery.needPage}
						</td>
					</tr>
					<tr>
						<th>租户ID：</th>
						<td>
							${sysEsQuery.tenantId}
						</td>
					</tr>
					<tr>
						<th>创建人：</th>
						<td>
							${sysEsQuery.createBy}
						</td>
					</tr>
					<tr>
						<th>创建时间：</th>
						<td>
							${sysEsQuery.createTime}
						</td>
					</tr>
					<tr>
						<th>更新时间：</th>
						<td>
							${sysEsQuery.updateBy}
						</td>
					</tr>
					<tr>
						<th>更新时间：</th>
						<td>
							${sysEsQuery.updateTime}
						</td>
					</tr>
				</table>
             </div>
    	</div>
        <rx:detailScript baseUrl="sys/core/sysEsQuery" 
        entityName="com.redxun.sys.core.entity.SysEsQuery"
        formId="form1"/>
        
        <script type="text/javascript">
		mini.parse();
		var form = new mini.Form("#form1");
		var pkId = '${sysEsQuery.id}';
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/sys/core/sysEsQuery/getJson.do",
				data:{ids:pkId},
				success:function (json) {
					form.setData(json);
				}					
			});
		})
		</script>
	</div>
    </body>
</html>