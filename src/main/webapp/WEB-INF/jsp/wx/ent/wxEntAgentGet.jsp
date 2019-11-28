
<%-- 
    Document   : [微信应用]明细页
    Created on : 2017-06-04 12:27:36
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[微信应用]明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>
<%--         <rx:toolbar toolbarId="toolbar1"/> --%>
<div class="fitTop"></div>
    <div class="mini-fit">
	<div id="form1" class="form-container">
		<table style="width:100%" class="table-detail column-two" cellpadding="0" cellspacing="1">
			<caption>
				[微信应用]基本信息
			</caption>
			<tr>
				<td>
					NAME_
				</td>
				<td>
					${wxEntAgent.name}
				</td>
			</tr>
			<tr>
				<td>
					DESCRIPTION_
				</td>
				<td>
					${wxEntAgent.description}
				</td>
			</tr>
			<tr>
				<td>
					信任域名
				</td>
				<td>
					${wxEntAgent.domain}
				</td>
			</tr>
			<tr>
				<td>
					HOME_URL_
				</td>
				<td>
					${wxEntAgent.homeUrl}
				</td>
			</tr>
			<tr>
				<td>
					企业主键
				</td>
				<td>
					${wxEntAgent.entId}
				</td>
			</tr>
			<tr>
				<td>
					企业 ID
				</td>
				<td>
					${wxEntAgent.corpId}
				</td>
			</tr>
			<tr>
				<td>
					应用 ID
				</td>
				<td>
					${wxEntAgent.agentId}
				</td>
			</tr>
			<tr>
				<td>
					密　　钥
				</td>
				<td>
					${wxEntAgent.secret}
				</td>
			</tr>
			<tr>
				<td>
					是否默认
				</td>
				<td>
					<c:choose>
						<c:when test="${wxEntAgent.defaultAgent==1 }">
							是
						</c:when>
						<c:otherwise>
							否
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
		</table>
	</div>
    </div>
        <rx:detailScript baseUrl="wx/ent/wxEntAgent" 
        entityName="com.redxun.wx.ent.entity.WxEntAgent"
        formId="form1"/>
        
	<script type="text/javascript">
		addBody();
	</script>
    </body>
</html>