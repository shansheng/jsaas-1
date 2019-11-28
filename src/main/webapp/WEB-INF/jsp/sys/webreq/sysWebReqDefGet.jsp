
<%-- 
    Document   : [流程数据绑定表]明细页
    Created on : 2018-07-24 17:46:42
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[流程数据绑定表]明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>
        <rx:toolbar toolbarId="toolbar1"/>
        <div id="form1" class="form-outer">
             <div style="padding:5px;">
             	<table style="width:100%" class="table-detail column_2" cellpadding="0" cellspacing="1">
                	<caption>[流程数据绑定表]基本信息</caption>
					<tr>
						<td>名称：</td>
						<td>
							${bpmDataBind.name}
						</td>
					</tr>
					<tr>
						<td>别名：</td>
						<td>
							${bpmDataBind.key}
						</td>
					</tr>
					<tr>
						<td>请求地址：</td>
						<td>
							${bpmDataBind.url}
						</td>
					</tr>
					<tr>
						<td>请求方式：</td>
						<td>
							${bpmDataBind.mode}
						</td>
					</tr>
					<tr>
						<td>请求类型：</td>
						<td>
							${bpmDataBind.type}
						</td>
					</tr>
					<tr>
						<td>参数配置：</td>
						<td>
							${bpmDataBind.paramsSet}
						</td>
					</tr>
					<tr>
						<td>传递数据：</td>
						<td>
							${bpmDataBind.data}
						</td>
					</tr>
					<tr>
						<td>请求报文模板：</td>
						<td>
							${bpmDataBind.temp}
						</td>
					</tr>
					<tr>
						<td>状态：</td>
						<td>
							${bpmDataBind.status}
						</td>
					</tr>
				</table>
             </div>
    	</div>
        <rx:detailScript baseUrl="bpm/bind/bpmDataBind" 
        entityName="com.redxun.bpm.bind.entity.BpmDataBind"
        formId="form1"/>
        
        <script type="text/javascript">
		mini.parse();
		var form = new mini.Form("#form1");
		var pkId = '${bpmDataBind.id}';
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/bpm/bind/bpmDataBind/getJson.do",
				data:{ids:pkId},
				success:function (json) {
					form.setData(json);
				}					
			});
		})
		</script>
    </body>
</html>