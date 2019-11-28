
<%-- 
    Document   : [模板文件管理表]明细页
    Created on : 2018-11-01 16:22:40
    Author     : ray
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[模板文件管理表]明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>
        <rx:toolbar toolbarId="toolbar1"/>
        <div id="toptoolbarBg"></div>
   <div class="Mauto">     
        <div id="form1" class="form-outer">
             <div>
             	<table style="width:100%" class="table-detail" cellpadding="0" cellspacing="1">
                	<caption>[模板文件管理表]基本信息</caption>
					<tr>
						<th>名称：</th>
						<td>
							${sysCodeTemp.name}
						</td>
					</tr>
					<tr>
						<th>别名：</th>
						<td>
							${sysCodeTemp.alias}
						</td>
					</tr>
					<tr>
						<th>文件路径：</th>
						<td>
							${sysCodeTemp.path}
						</td>
					</tr>
					<tr>
						<th>创建人：</th>
						<td>
							${sysCodeTemp.createBy}
						</td>
					</tr>
					<tr>
						<th>创建时间：</th>
						<td>
							${sysCodeTemp.createTime}
						</td>
					</tr>
					<tr>
						<th>修改人：</th>
						<td>
							${sysCodeTemp.updateBy}
						</td>
					</tr>
					<tr>
						<th>修改时间：</th>
						<td>
							${sysCodeTemp.updateTime}
						</td>
					</tr>
					<tr>
						<th>租户ID：</th>
						<td>
							${sysCodeTemp.tenantId}
						</td>
					</tr>
				</table>
             </div>
    	</div>
        <rx:detailScript baseUrl="sys/code/sysCodeTemp" 
        entityName="com.redxun.sys.code.entity.SysCodeTemp"
        formId="form1"/>
        
        <script type="text/javascript">
		mini.parse();
		var form = new mini.Form("#form1");
		var pkId = '${sysCodeTemp.id}';
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/sys/code/sysCodeTemp/getJson.do",
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