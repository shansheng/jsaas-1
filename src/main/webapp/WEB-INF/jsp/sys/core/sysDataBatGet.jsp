
<%-- 
    Document   : [数据批量录入]明细页
    Created on : 2019-01-02 10:49:42
    Author     : ray
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[数据批量录入]明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>
        <rx:toolbar toolbarId="toolbar1"/>
        <div id="toptoolbarBg"></div>
   <div class="Mauto">     
        <div id="form1" class="form-outer">
             <div>
             	<table style="width:100%" class="table-detail" cellpadding="0" cellspacing="1">
                	<caption>[数据批量录入]基本信息</caption>
					<tr>
						<th>上传文件ID：</th>
						<td>
							${sysDataBat.uploadId}
						</td>
					</tr>
					<tr>
						<th>批次ID：</th>
						<td>
							${sysDataBat.batId}
						</td>
					</tr>
					<tr>
						<th>服务名：</th>
						<td>
							${sysDataBat.serviceName}
						</td>
					</tr>
					<tr>
						<th>子系统ID：</th>
						<td>
							${sysDataBat.appId}
						</td>
					</tr>
					<tr>
						<th>类型：</th>
						<td>
							${sysDataBat.type}
						</td>
					</tr>
					<tr>
						<th>EXCEL文件：</th>
						<td>
							${sysDataBat.excelId}
						</td>
					</tr>
					<tr>
						<th>表名：</th>
						<td>
							${sysDataBat.tableName}
						</td>
					</tr>
					<tr>
						<th>流程实例ID：</th>
						<td>
							${sysDataBat.instId}
						</td>
					</tr>
					<tr>
						<th>流程实例状态：</th>
						<td>
							${sysDataBat.instStatus}
						</td>
					</tr>
					<tr>
						<th>租户ID：</th>
						<td>
							${sysDataBat.tenantId}
						</td>
					</tr>
					<tr>
						<th>创建人：</th>
						<td>
							${sysDataBat.createBy}
						</td>
					</tr>
					<tr>
						<th>创建时间：</th>
						<td>
							${sysDataBat.createTime}
						</td>
					</tr>
					<tr>
						<th>更新人：</th>
						<td>
							${sysDataBat.updateBy}
						</td>
					</tr>
					<tr>
						<th>更新时间：</th>
						<td>
							${sysDataBat.updateTime}
						</td>
					</tr>
				</table>
             </div>
    	</div>
        <rx:detailScript baseUrl="sys/core/sysDataBat" 
        entityName="com.redxun.sys.core.entity.SysDataBat"
        formId="form1"/>
        
        <script type="text/javascript">
		mini.parse();
		var form = new mini.Form("#form1");
		var pkId = '${sysDataBat.id}';
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/sys/core/sysDataBat/getJson.do",
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