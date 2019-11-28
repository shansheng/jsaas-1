
<%-- 
    Document   : [人员脚本]明细页
    Created on : 2017-06-01 11:33:08
    Author     : ray
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[人员脚本]明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>
<%--         <rx:toolbar toolbarId="toolbar1"/> --%>
		<div class="heightBox"></div>
        <div id="form1" class="form-outer shadowBox90">
             <div style="padding:5px;">
                    <table style="width:100%" class="table-detail column_2_m" cellpadding="0" cellspacing="1">
                    	<caption>[人员脚本]基本信息</caption>
						<tr>
							<td>类　名</td>
							<td>
								${bpmGroupScript.className}
							</td>
							<td>类实例名</td>
							<td>
								${bpmGroupScript.classInsName}
							</td>
						</tr>
						<tr>
							<td>方法名</td>
							<td>
								${bpmGroupScript.methodName}
							</td>
							<td>方法描述</td>
							<td>
								${bpmGroupScript.methodDesc}
							</td>
						</tr>
						<tr>
							<td>返回类型</td>
							<td>
								${bpmGroupScript.returnType}
							</td>
							<td>参　　数</td>
							<td>
								${bpmGroupScript.argument}
							</td>
						</tr>
					</table>
                 </div>
        	</div>
        <rx:detailScript baseUrl="bpm/core/bpmGroupScript" 
        entityName="com.redxun.bpm.core.entity.BpmGroupScript"
        formId="form1"/>
        <script type="text/javascript">
        	addBody();
        </script>
    </body>
</html>