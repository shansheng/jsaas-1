
<%-- 
    Document   : [微信卡券]明细页
    Created on : 2017-08-24 14:26:26
    Author     : 陈茂昌
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>[微信卡券]明细</title>
        <%@include file="/commons/get.jsp" %>
   	    <style>
	    	.text{
	    		width: 80%;
	    		font-weight: normal;
	    		font-size: 14px;
				word-break:break-all;
				word-wrap:break-word;
	    	}
	    </style>
    	
    </head>
    <body>
	<div class="topToolBar">
		<div>
			<rx:toolbar toolbarId="toolbar1"/>
		</div>
	</div>

		<div class="heightBox"></div>
        <div id="form1" class="form-container" style="margin-bottom: 40px;">
           	<table style="width:100%" class="table-detail column-two" cellpadding="0" cellspacing="1">
              	<caption>[微信卡券]基本信息</caption>
				<tr>
					<td>公众号 ID</td>
					<td>
						${wxTicket.pubId}
					</td>
				</tr>
				<tr>
					<td>卡券类型</td>
					<td>
						${wxTicket.cardType}
					</td>
				</tr>
				<tr>
					<td>卡券的商户logo</td>
					<td>
						<h1 class="text">${wxTicket.logoUrl}</h1>
					</td>
				</tr>
				<tr>
					<td>码　　型</td>
					<td>
						${wxTicket.codeType}
					</td>
				</tr>
				<tr>
					<td>商户名字</td>
					<td>
						${wxTicket.brandName}
					</td>
				</tr>
				<tr>
					<td>卡  券  名</td>
					<td>
						${wxTicket.title}
					</td>
				</tr>
				<tr>
					<td>券  颜  色</td>
					<td>
						${wxTicket.color}
					</td>
				</tr>
				<tr>
					<td>卡券使用提醒</td>
					<td>
						${wxTicket.notice}
					</td>
				</tr>
				<tr>
					<td>卡券使用说明</td>
					<td>
						${wxTicket.description}
					</td>
				</tr>
				<tr>
					<td>商品信息</td>
					<td>
						${wxTicket.sku}
					</td>
				</tr>
				<tr>
					<td>使用日期</td>
					<td>
						<h1 class=text>${wxTicket.dateInfo}</h1>
					</td>
				</tr>
				<tr>
					<td>基础非必须信息</td>
					<td>
						<h1 class="text">${wxTicket.baseInfo}</h1>
					</td>
				</tr>
				<tr>
					<td>高级非必填信息</td>
					<td>
						${wxTicket.advancedInfo}
					</td>
				</tr>
				<tr>
					<td>专用配置</td>
					<td>
						${wxTicket.specialConfig}
					</td>
				</tr>
				<tr>
					<td>租用机构ID</td>
					<td>
						${wxTicket.tenantId}
					</td>
				</tr>
				<tr>
					<td>更新时间</td>
					<td>
						${wxTicket.updateTime}
					</td>
				</tr>
				<tr>
					<td>更新人ID</td>
					<td>
						${wxTicket.updateBy}
					</td>
				</tr>
				<tr>
					<td>创建时间</td>
					<td>
						${wxTicket.createTime}
					</td>
				</tr>
				<tr>
					<td>创建人ID</td>
					<td>
						${wxTicket.createBy}
					</td>
				</tr>
		</table>
           
    	</div>
        <rx:detailScript baseUrl="wx/core/wxTicket" 
        entityName="com.redxun.wx.core.entity.WxTicket"
        formId="form1"/>
        
        <script type="text/javascript">
        addBody();
		mini.parse();
		var form = new mini.Form("#form1");
		var pkId = ${wxTicket.id};
		$(function(){
			$.ajax({
				type:'POST',
				url:"${ctxPath}/wx/core/wxTicket/getJson.do",
				data:{ids:pkId},
				success:function (json) {
					form.setData(json);
				}					
			});
		})
		</script>
    </body>
</html>