
<%-- 
    Document   : [微信网页授权]明细页
    Created on : 2017-08-18 17:05:42
    Author     : 陈茂昌
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[微信网页授权]明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>
<%--         <rx:toolbar toolbarId="toolbar1"/> --%>
		<div class="heightBox"></div>
        <div class="mini-fit">
        <div id="form1" class="form-container">
             <div style="padding:5px;">
             	<table style="width:100%" class="table-detail column-two" cellpadding="0" cellspacing="1">
                	<caption>[微信网页授权]基本信息</caption>
					<tr>
						<td>公众号ID</td>
						<td>
							${wxWebGrant.pubId}
						</td>
					</tr>
					<tr>
						<td>链　　接</td>
						<td>都
							${wxWebGrant.url}
						</td>
					</tr>
					<tr>
						<td>转换后的URL</td>
						<td>
							${wxWebGrant.transformUrl}
						</td>
					</tr>
					<tr>
						<td>配置信息</td>
						<td>
							${wxWebGrant.config}
						</td>
					</tr>
					<tr>
						<td>创建时间</td>
						<td>
							${wxWebGrant.createTime}
						</td>
					</tr>
					<tr>
						<td>创建人ID</td>
						<td>
							${wxWebGrant.createBy}
						</td>
					</tr>
					<tr>
						<td>租用机构ID</td>
						<td>
							${wxWebGrant.tenantId}
						</td>
					</tr>
					<tr>
						<td>更新时间</td>
						<td>
							${wxWebGrant.updateTime}
						</td>
					</tr>
					<tr>
						<td>更新人ID</td>
						<td>
							${wxWebGrant.updateBy}
						</td>
					</tr>
				</table>
             </div>
    	</div>
       </div>
        <rx:detailScript baseUrl="wx/core/wxWebGrant" 
        entityName="com.redxun.wx.core.entity.WxWebGrant"
        formId="form1"/>
        
        <script type="text/javascript">
			addBody();
		</script>
    </body>
</html>