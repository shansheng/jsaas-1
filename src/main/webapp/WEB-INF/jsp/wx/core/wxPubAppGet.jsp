
<%-- 
    Document   : [公众号管理]明细页
    Created on : 2017-06-29 16:57:29
    Author     : ray
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[公众号管理]明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>
	<div class="topToolBar">
		<div>
			<rx:toolbar toolbarId="toolbar1"/>
		</div>
	</div>

		<div class="heightBox"></div>
<div class="mini-fit">
        <div id="form1" class="form-container">
             <div>
                    <table style="width:100%" class="table-detail column-two" cellpadding="0" cellspacing="1">
                    	<caption>[公众号管理]基本信息</caption>
						<tr>
							<td>微  信  号</td>
							<td>
								${wxPubApp.wxNo}
							</td>
							<td>APP_ID_</td>
							<td>
								${wxPubApp.appId}
							</td>
						</tr>
						<tr>
							<td>密　　钥</td>
							<td>
								${wxPubApp.secret}
							</td>
							<td>类　　型</td>
							<td>
								${wxPubApp.type}
							</td>
						</tr>
						<tr>
							<td>是否认证</td>
							<td>
								${wxPubApp.authed}
							</td>
							<th>接口消息地址</th>
							<td>
								${wxPubApp.interfaceUrl}
							</td>
						</tr>
						<tr>
							<td>token</td>
							<td>
								${wxPubApp.TOKEN}
							</td>
							<td>js安全域名</td>
							<td>
								${wxPubApp.jsDomain}
							</td>
						</tr>
						<tr>
							<td>名　　称</td>
							<td>
								${wxPubApp.name}
							</td>
							<td>别　　名</td>
							<td>
								${wxPubApp.alias}
							</td>
						</tr>
						<tr>
							<td>描　　述</td>
							<td>
								${wxPubApp.description}
							</td>
							<th>租用机构ID</th>
							<td>
								${wxPubApp.tenantId}
							</td>
						</tr>
					</table>
                 </div>
	            <div>
					 <table class="table-detail column-two" cellpadding="0" cellspacing="1">
					 	<caption>更新信息</caption>
						<tr>
							<td>创  建  人</td>
							<td><rxc:userLabel userId="${wxPubApp.createBy}"/></td>
							<td>创建时间</td>
							<td><fmt:formatDate value="${wxPubApp.createTime}" pattern="yyyy-MM-dd HH:mm" /></td>
						</tr>
						<tr>
							<td>更  新  人</td>
							<td><rxc:userLabel userId="${wxPubApp.updateBy}"/></td>
							<td>更新时间</td>
							<td><fmt:formatDate value="${wxPubApp.updateTime}" pattern="yyyy-MM-dd HH:mm" /></td>
						</tr>
					</table>
	        	</div>
        	</div>
</div>
        <rx:detailScript baseUrl="wx/core/wxPubApp" 
        entityName="com.redxun.wx.core.entity.WxPubApp"
        formId="form1"/>
    </body>
</html>