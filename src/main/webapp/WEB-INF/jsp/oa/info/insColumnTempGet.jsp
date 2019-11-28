
<%-- 
    Document   : [栏目模板管理表]明细页
    Created on : 2018-08-30 09:50:56
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[栏目模板管理表]明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>
  		<div id="toptoolbar">
   	     <rx:toolbar toolbarId="toolbar1"/>
        </div>
		<div id="toptoolbarBg"></div>
<div class="Mauto">		
        <div id="form1" class="form-outer">
             <div style="padding:5px;">
             	<table style="width:100%" class="table-detail" cellpadding="0" cellspacing="1">
                	<caption>[栏目模板管理表]基本信息</caption>
					<tr>
						<th>名称：</th>
						<td>
							${insColumnTemp.name}
						</td>
					</tr>
					<tr>
						<th>标识键：</th>
						<td>
							${insColumnTemp.key}
						</td>
					</tr>
					<tr>
						<th>是否系统预设：</th>
						<td>
							${insColumnTemp.isSys=='1'?'是':'否'}
						</td>
					</tr>
					<tr>
						<th>状态：</th>
						<td>
							${insColumnTemp.status=='1'?'启用':'禁用'}
						</td>
					</tr>
					<tr>
						<th>创建人：</th>
						<td>
							<rxc:userLabel userId="${insColumnTemp.createBy}"></rxc:userLabel>
						</td>
					</tr>
					<tr>
						<th>创建时间：</th>
						<td>
							<fmt:formatDate type="both" value="${insColumnTemp.createTime}" />
						</td>
					</tr>
					<tr>
						<th>修改人：</th>
						<td>
							<rxc:userLabel userId="${insColumnTemp.updateBy}"></rxc:userLabel>
						</td>
					</tr>
					<tr>
						<th>修改时间：</th>
						<td>
							<fmt:formatDate type="both" value="${insColumnTemp.updateTime}" />
						</td>
					</tr>
				</table>
             </div>
    	</div>
        <rx:detailScript baseUrl="oa/info/insColumnTemp" 
        entityName="com.redxun.oa.info.entity.InsColumnTemp"
        formId="form1"/>
</div>        
        <script type="text/javascript">
		mini.parse();
		var form = new mini.Form("#form1");
		var pkId = '${insColumnTemp.id}';
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/oa/info/insColumnTemp/getJson.do",
				data:{ids:pkId},
				success:function (json) {
					form.setData(json);
				}					
			});
		})
		</script>
    </body>
</html>