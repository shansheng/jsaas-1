
<%-- 
    Document   : [栏目消息盒子表]明细页
    Created on : 2017-09-01 11:35:24
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[栏目消息盒子表]明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>
    
<%--         <rx:toolbar toolbarId="toolbar1"/> --%>
<div class="fitTop"></div>
<div class="mini-fit">
<div class="form-container">
        <div id="form1" >
             <div>
             	<table style="width:100%" class="table-detail column-two" cellpadding="0" cellspacing="1">
                	<caption>[栏目消息盒子表]基本信息</caption>
					<tr>
						<td>COL_ID_</td>
						<td>
							${insMsgboxDef.colId}
						</td>
					</tr>
					<tr>
						<td>KEY_</td>
						<td>
							${insMsgboxDef.key}
						</td>
					</tr>
					<tr>
						<td>NAME_</td>
						<td>
							${insMsgboxDef.name}
						</td>
					</tr>
					<tr>
						<td>租用机构ID</td>
						<td>
							${insMsgboxDef.tenantId}
						</td>
					</tr>
					<tr>
						<td>创建人ID</td>
						<td>
							${insMsgboxDef.createBy}
						</td>
					</tr>
					<tr>
						<td>创建时间</td>
						<td>
							${insMsgboxDef.createTime}
						</td>
					</tr>
					<tr>
						<td>更新人ID</td>
						<td>
							${insMsgboxDef.updateBy}
						</td>
					</tr>
					<tr>
						<td>更新时间</td>
						<td>
							${insMsgboxDef.updateTime}
						</td>
					</tr>
				</table>
             </div>
    	</div>
        <rx:detailScript baseUrl="oa/info/insMsgboxDef" 
        entityName="com.redxun.oa.info.entity.InsMsgboxDef"
        formId="form1"/>
</div>
</div>
        <script type="text/javascript">
	        addBody();
			mini.parse();
			var form = new mini.Form("#form1");
			var pkId = ${insMsgboxDef.boxId};
			$(function(){
				$.ajax({
					type:'POST',
					url:"${ctxPath}/oa/info/insMsgboxDef/getJson.do",
					data:{ids:pkId},
					success:function (json) {
						form.setData(json);
					}					
				});
			})
		</script>
    </body>
</html>