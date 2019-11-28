<%-- 
    Document   : [BpmAuthSetting]明细页
    Created on : 2015-3-28, 17:42:57
    Author     : csx
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[BpmAuthSetting]明细</title>
    <%@include file="/commons/get.jsp"%>
    </head>
    <body>
<%--         <rx:toolbar toolbarId="toolbar1"/> --%>

<!-- 		<div style="height: 1px"></div> -->
<div class="fitTop"></div>
<div class="mini-fit">
<div class="form-container">
        <div class="paddingTop">
        	<div id="form1">
	             <div>
	                    <table style="width:100%" class="table-detail column-two" cellpadding="0" cellspacing="1">
	                    	<caption>[BpmAuthSetting]基本信息</caption>
	                      	<tr>
							 		<td>
							 			授权名称
							 		</td>
		                            <td>
		                                ${bpmAuthSetting.name}
		                            </td>
							</tr>
						    <tr>
							 		<td>
							 			是否允许
							 		</td>
		                            <td>
		                                ${bpmAuthSetting.enable}
		                            </td>
							</tr>
			         </table>
	                 </div>
		            <div>
						 <table class="table-detail column-four" cellpadding="0" cellspacing="1">
						 	<caption>更新信息</caption>
							<tr>
								<td>创   建   人</td>
								<td><rxc:userLabel userId="${bpmAuthSetting.createBy}"/></td>
								<td>创建时间</td>
								<td><fmt:formatDate value="${bpmAuthSetting.createTime}" pattern="yyyy-MM-dd HH:mm" /></td>
							</tr>
							<tr>
								<td>更   新   人</td>
								<td><rxc:userLabel userId="${bpmAuthSetting.updateBy}"/></td>
								<td>更新时间</td>
								<td><fmt:formatDate value="${bpmAuthSetting.updateTime}" pattern="yyyy-MM-dd HH:mm" /></td>
							</tr>
						</table>
		        	</div>
	        	</div>
        
        
        </div>
        <rx:detailScript baseUrl="bpm/core/bpmAuthSetting" 
        entityName="com.redxun.bpm.core.entity.BpmAuthSetting"
        formId="form1"/>
</div>
</div>
        <script type="text/javascript">
        	addBody();
        </script>
        
        
    </body>
</html>