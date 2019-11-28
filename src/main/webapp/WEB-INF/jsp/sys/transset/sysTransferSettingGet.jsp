
<%-- 
    Document   : [权限转移设置表]明细页
    Created on : 2018-06-20 17:12:34
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[权限转移设置表]明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>
        <rx:toolbar toolbarId="toolbar1"/>
        <div id="form1" class="form-outer">
             <div style="padding:5px;">
             	<table style="width:100%" class="table-detail" cellpadding="0" cellspacing="1">
                	<caption>[权限转移设置表]基本信息</caption>
					<tr>
						<th>名称：</th>
						<td>
							${sysTransferSetting.name}
						</td>
					</tr>
					<tr>
						<th>状态：</th>
						<td>
							${sysTransferSetting.status}
						</td>
					</tr>
					<tr>
						<th>SELECTSQL语句：</th>
						<td>
							${sysTransferSetting.selectSql}
						</td>
					</tr>
					<tr>
						<th>UPDATESQL语句：</th>
						<td>
							${sysTransferSetting.updateSql}
						</td>
					</tr>
					<tr>
						<th>日志内容模板：</th>
						<td>
							${sysTransferSetting.logTemplet}
						</td>
					</tr>
					<tr>
						<th>创建人：</th>
						<td>
							${sysTransferSetting.createBy}
						</td>
					</tr>
					<tr>
						<th>创建时间：</th>
						<td>
							${sysTransferSetting.createTime}
						</td>
					</tr>
					<tr>
						<th>修改人：</th>
						<td>
							${sysTransferSetting.updateBy}
						</td>
					</tr>
					<tr>
						<th>修改时间：</th>
						<td>
							${sysTransferSetting.updateTime}
						</td>
					</tr>
					<tr>
						<th>租户ID：</th>
						<td>
							${sysTransferSetting.tenantId}
						</td>
					</tr>
				</table>
             </div>
    	</div>
        <rx:detailScript baseUrl="sys/transset/sysTransferSetting" 
        entityName="com.redxun.sys.transset.entity.SysTransferSetting"
        formId="form1"/>
        
        <script type="text/javascript">
		mini.parse();
		var form = new mini.Form("#form1");
		var pkId = '${sysTransferSetting.id}';
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/sys/transset/sysTransferSetting/getJson.do",
				data:{ids:pkId},
				success:function (json) {
					form.setData(json);
				}					
			});
		})
		</script>
    </body>
</html>