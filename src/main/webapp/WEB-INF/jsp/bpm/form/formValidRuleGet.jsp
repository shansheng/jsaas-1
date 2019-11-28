
<%-- 
    Document   : [FORM_VALID_RULE]明细页
    Created on : 2018-11-27 22:58:37
    Author     : ray
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[FORM_VALID_RULE]明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>
        <rx:toolbar toolbarId="toolbar1"/>
        <div id="toptoolbarBg"></div>
   <div class="Mauto">     
        <div id="form1" class="form-outer">
             <div>
             	<table style="width:100%" class="table-detail" cellpadding="0" cellspacing="1">
                	<caption>[FORM_VALID_RULE]基本信息</caption>
					<tr>
						<th>解决方案ID：</th>
						<td>
							${formValidRule.solId}
						</td>
					</tr>
					<tr>
						<th>表单KEY：</th>
						<td>
							${formValidRule.formKey}
						</td>
					</tr>
					<tr>
						<th>流程定义ID：</th>
						<td>
							${formValidRule.actDefId}
						</td>
					</tr>
					<tr>
						<th>节点ID：</th>
						<td>
							${formValidRule.nodeId}
						</td>
					</tr>
					<tr>
						<th>表单定义：</th>
						<td>
							${formValidRule.json}
						</td>
					</tr>
					<tr>
						<th>租户ID：</th>
						<td>
							${formValidRule.tenantId}
						</td>
					</tr>
					<tr>
						<th>创建人：</th>
						<td>
							${formValidRule.createBy}
						</td>
					</tr>
					<tr>
						<th>创建时间：</th>
						<td>
							${formValidRule.createTime}
						</td>
					</tr>
					<tr>
						<th>更新人：</th>
						<td>
							${formValidRule.updateBy}
						</td>
					</tr>
					<tr>
						<th>更新时间：</th>
						<td>
							${formValidRule.updateTime}
						</td>
					</tr>
				</table>
             </div>
    	</div>
        <rx:detailScript baseUrl="bpm/form/formValidRule" 
        entityName="com.redxun.bpm.form.entity.FormValidRule"
        formId="form1"/>
        
        <script type="text/javascript">
		mini.parse();
		var form = new mini.Form("#form1");
		var pkId = '${formValidRule.id}';
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/bpm/form/formValidRule/getJson.do",
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