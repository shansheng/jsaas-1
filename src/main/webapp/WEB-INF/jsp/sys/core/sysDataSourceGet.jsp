
<%-- 
    Document   : [数据源定义管理]明细页
    Created on : 2017-02-07 09:03:54
    Author     : ray
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[数据源定义管理]明细</title>
        <%@include file="/commons/get.jsp" %>
        <style>.form-title li{width: 25%;}</style>
    </head>
    <body>
<%--         <rx:toolbar toolbarId="toolbar1"/> --%>
        <div id="form1" class="form-outer shadowBox">
                   <table style="width:100%" class="table-detail column_2" cellpadding="0" cellspacing="1">
                   	<caption>[数据源定义管理]基本信息</caption>
					<tr>
						<td>数据源名称</td>
						<td>${sysDataSource.name}</td>
					</tr>
					<tr>
						<td>别　　名</td>
						<td>${sysDataSource.alias}</td>
					</tr>
					<tr>
						<td>是否使用</td>
						<td>${sysDataSource.enabled}</td>
					</tr>
					<tr>
						<td>数据源设定</td>
						<td>${sysDataSource.setting}</td>
					</tr>
					<tr>
						<td>数据库类型</td>
						<td>${sysDataSource.dbType}</td>
					</tr>
					<tr>
						<td>启动时初始化</td>
						<td>${sysDataSource.initOnStart}</td>
					</tr>
				</table>
        </div>
        <rx:detailScript baseUrl="sys/core/sysDataSource" 
        entityName="com.redxun.sys.core.entity.SysDataSource"
        formId="form1"/>
        
        <script type="text/javascript">
        	addBody();
        </script>
    </body>
</html>