
<%-- 
    Document   : [日志实体]明细页
    Created on : 2017-09-25 14:27:06
    Author     : 陈茂昌
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[日志实体]明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>

<%--         <rx:toolbar toolbarId="toolbar1"/> --%>
		<div class="topToolBar">
			<div>
				<a class="mini-button btn-red" onclick="CloseWindow('ok');" >关闭</a>
			</div>
		</div>
        <div class="mini-fit">
        <div id="form1" class="form-container">
             	<table style="width:100%" class="table-detail column-four" cellpadding="0" cellspacing="1">
                	<caption>[日志实体]基本信息</caption>
					<tr>
						<td>所属模块</td>
						<td>
							${logEntity.module}
						</td>
					
						<td>功　　能</td>
						<td>
							${logEntity.subModule}
						</td>
					</tr>
					<tr>
						<td>操  作  名</td>
						<td>
							${logEntity.action}
						</td>
					
						<td>操作 IP</td>
						<td>
							${logEntity.ip}
						</td>
					</tr>
					<tr>
						<td>操作目标</td>
						<td colspan="3">
							${logEntity.target}
						</td>
					</tr>
					<tr>
						<td>创建时间</td>
						<td>
							<fmt:formatDate value="${logEntity.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/> 
						</td>
					
						<td>创建人</td>
						<td>
							<rxc:userLabel userId="${logEntity.createBy}"/>
						</td>
					</tr>
				</table>
    	</div>
        </div>
        <rx:detailScript baseUrl="sys/log/logEntity" 
        entityName="com.redxun.sys.log.entity.LogEntity"
        formId="form1"/>
      
        <script type="text/javascript">
        addBody();
		mini.parse();
		var form = new mini.Form("#form1");
		var pkId = ${logEntity.id};
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/sys/log/logEntity/getJson.do",
				data:{ids:pkId},
				success:function (json) {
					form.setData(json);
				}					
			});
		})
		</script>
    </body>
</html>