<%-- 
    Document   : [微信企业配置]编辑页
    Created on : 2017-06-04 12:27:36
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<title>[微信企业配置]编辑</title>
		<%@include file="/commons/edit.jsp" %>   
	</head>
	<body>
		<div class="topToolBar">
			<div>
				<a class="mini-button" plain="true" onclick="onSave('form1');">保存</a>
			</div>
		</div>
	<div class="mini-fit">
	<div class="form-container">
		<div id="p1" >
			<form id="form1" method="post" action="/wx/ent/wxEntCorp/save.do">
					<input id="pkId" name="id" class="mini-hidden" value="${wxEntCorp.id}" />
					<table class="table-detail column-two" cellspacing="1" cellpadding="0">
						<caption>[微信企业配置]基本信息</caption>
						<tr>
							<td>企业ID</td>
							<td>
								<input name="corpId" value="${wxEntCorp.corpId}" class="mini-textbox"   style="width: 90%" />
							</td>
						</tr>
						<tr>
							<td>通讯录密钥</td>
							<td>
								<input name="secret" value="${wxEntCorp.secret}" class="mini-textbox"   style="width: 90%" />
							</td>
						</tr>
						<tr>
							<td>是否启用企业微信</td>
							<td>
								<div  name="enable" class="mini-checkbox" readOnly="false" text="启用" trueValue="1" falseValue="0" value="${wxEntCorp.enable}"></div>
							</td>
						</tr>
					</table>
			</form>
		</div>
		<rx:formScript formId="form1" baseUrl="wx/ent/wxEntCorp"
			entityName="com.redxun.wx.ent.entity.WxEntCorp" />
		</div>
	</div>
		<script type="text/javascript">
			addBody();
			indentBody();
			function successCallback(){
				location.href=location.href;
			}
		</script>
	</body>
</html>