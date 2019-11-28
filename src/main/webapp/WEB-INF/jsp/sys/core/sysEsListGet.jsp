
<%-- 
    Document   : [SYS_ES_LIST]明细页
    Created on : 2019-01-19 15:01:59
    Author     : ray
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[SYS_ES_LIST]明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>
        <rx:toolbar toolbarId="toolbar1"/>
        <div id="toptoolbarBg"></div>
   <div class="Mauto">     
        <div id="form1" class="form-outer">
             <div>
             	<table style="width:100%" class="table-detail" cellpadding="0" cellspacing="1">
                	<caption>[SYS_ES_LIST]基本信息</caption>
					<tr>
						<th>名称：</th>
						<td>
							${sysEsList.name}
						</td>
					</tr>
					<tr>
						<th>别名：</th>
						<td>
							${sysEsList.alias}
						</td>
					</tr>
					<tr>
						<th>主键字段：</th>
						<td>
							${sysEsList.idField}
						</td>
					</tr>
					<tr>
						<th>查询类型：</th>
						<td>
							${sysEsList.queryType}
						</td>
					</tr>
					<tr>
						<th>索引：</th>
						<td>
							${sysEsList.esTable}
						</td>
					</tr>
					<tr>
						<th>查询语句：</th>
						<td>
							${sysEsList.query}
						</td>
					</tr>
					<tr>
						<th>返回字段：</th>
						<td>
							${sysEsList.returnFields}
						</td>
					</tr>
					<tr>
						<th>条件字段：</th>
						<td>
							${sysEsList.conditionFields}
						</td>
					</tr>
					<tr>
						<th>排序字段：</th>
						<td>
							${sysEsList.sortFields}
						</td>
					</tr>
					<tr>
						<th>是否分页：</th>
						<td>
							${sysEsList.isPage}
						</td>
					</tr>
					<tr>
						<th>HTML模板：</th>
						<td>
							${sysEsList.listHtml}
						</td>
					</tr>
					<tr>
						<th>分类ID：</th>
						<td>
							${sysEsList.treeId}
						</td>
					</tr>
					<tr>
						<th>TENANT_ID_：</th>
						<td>
							${sysEsList.tenantId}
						</td>
					</tr>
					<tr>
						<th>CREATE_BY_：</th>
						<td>
							${sysEsList.createBy}
						</td>
					</tr>
					<tr>
						<th>CREATE_TIME_：</th>
						<td>
							${sysEsList.createTime}
						</td>
					</tr>
					<tr>
						<th>UPDATE_BY_：</th>
						<td>
							${sysEsList.updateBy}
						</td>
					</tr>
					<tr>
						<th>UPDATE_TIME_：</th>
						<td>
							${sysEsList.updateTime}
						</td>
					</tr>
				</table>
             </div>
    	</div>
        <rx:detailScript baseUrl="sys/core/sysEsList" 
        entityName="com.redxun.sys.core.entity.SysEsList"
        formId="form1"/>
        
        <script type="text/javascript">
		mini.parse();
		var form = new mini.Form("#form1");
		var pkId = '${sysEsList.id}';
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/sys/core/sysEsList/getJson.do",
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