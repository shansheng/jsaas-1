
<%-- 
    Document   : [系统参数]明细页
    Created on : 2017-06-21 11:22:36
    Author     : ray
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[系统参数]明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>
<%--         <rx:toolbar toolbarId="toolbar1"/> --%>
<div class="fitTop"></div>
<div class="mini-fit">
<div class="form-container">
		
        <div id="form1">
            
                   <table  class="table-detail column-four" cellpadding="0" cellspacing="1">
                   	<caption>[系统参数]基本信息</caption>
					<tr>
						<td>名　　称</td>
						<td>
							${sysProperties.name}
						</td>
						<td>别　　名</td>
						<td>
							${sysProperties.alias}
						</td>
					</tr>
					<tr>
						<td>是否全局</td>
						<td>
							${sysProperties.global}
						</td>
						<td>是否加密存储</td>
						<td>
							${sysProperties.encrypt}
						</td>
					</tr>
					<tr>
						<td>参  数  值</td>
						<td>
							${sysProperties.value}
						</td>
						<td>分　　类</td>
						<td>
							${sysProperties.category}
						</td>
					</tr>
					<tr>
						<td>描　　述</td>
						<td>
							${sysProperties.description}
						</td>
						<td>租用Id</td>
						<td>
							${sysProperties.tenantId}
						</td>
					</tr>
				</table>
               
				 <table class="table-detail column-four" cellpadding="0" cellspacing="1">
				 	<caption>更新信息</caption>
					<tr>
						<td>创  建  人</td>
						<td><rxc:userLabel userId="${sysProperties.createBy}"/></td>
						<td>创建时间</td>
						<td><fmt:formatDate value="${sysProperties.createTime}" pattern="yyyy-MM-dd HH:mm" /></td>
					</tr>
					<tr>
						<td>更  新  人</td>
						<td><rxc:userLabel userId="${sysProperties.updateBy}"/></td>
						<td>更新时间</td>
						<td><fmt:formatDate value="${sysProperties.updateTime}" pattern="yyyy-MM-dd HH:mm" /></td>
					</tr>
				</table>
	        
        </div>
        <rx:detailScript baseUrl="sys/core/sysProperties" 
        entityName="com.redxun.sys.core.entity.SysProperties"
        formId="form1"/>
  </div>
</div>
        <script type="text/javascript">
        	addBody();
        </script>
        
    </body>
</html>