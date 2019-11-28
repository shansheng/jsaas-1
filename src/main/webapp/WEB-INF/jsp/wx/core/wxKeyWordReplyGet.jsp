
<%-- 
    Document   : [公众号关键字回复]明细页
    Created on : 2017-08-30 11:39:20
    Author     : 陈茂昌
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[公众号关键字回复]明细</title>
        <%@include file="/commons/get.jsp" %>
    </head>
    <body>
	<div class="topToolBar">
		<div>
        <rx:toolbar toolbarId="toolbar1"/>
	    </div>
	</div>
        <div id="form1" class="form-container">
             <div style="padding:5px;">
             	<table style="width:100%" class="table-detail column-two" cellpadding="0" cellspacing="1">
                	<caption>[公众号关键字回复]基本信息</caption>
					<tr>
						<td>公众号ID</td>
						<td>
							${wxKeyWordReply.pubId}
						</td>
					</tr>
					<tr>
						<td>关键字</td>
						<td>
							${wxKeyWordReply.keyWord}
						</td>
					</tr>
					<tr>
						<td>回复方式</td>
						<td>
							${wxKeyWordReply.replyType}
						</td>
					</tr>
					<tr>
						<td>回复内容</td>
						<td>
							${wxKeyWordReply.replyContent}
						</td>
					</tr>
					<tr>
						<td>创建时间</td>
						<td>
							${wxKeyWordReply.createTime}
						</td>
					</tr>
					<tr>
						<td>创建人ID</td>
						<td>
							${wxKeyWordReply.createBy}
						</td>
					</tr>
					<tr>
						<td>租用机构ID</td>
						<td>
							${wxKeyWordReply.tenantId}
						</td>
					</tr>
					<tr>
						<td>更新时间</td>
						<td>
							${wxKeyWordReply.updateTime}
						</td>
					</tr>
					<tr>
						<td>更新人ID</td>
						<td>
							${wxKeyWordReply.updateBy}
						</td>
					</tr>
				</table>
             </div>
    	</div>
        <rx:detailScript baseUrl="wx/core/wxKeyWordReply"  entityName="com.redxun.wx.core.entity.WxKeyWordReply"  formId="form1"/>
        
        <script type="text/javascript">
		mini.parse();
		
		</script>
    </body>
</html>