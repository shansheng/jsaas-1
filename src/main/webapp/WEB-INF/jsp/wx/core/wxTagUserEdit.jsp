
<%-- 
    Document   : [微信用户标签]编辑页
    Created on : 2017-06-29 17:55:31
    Author     : ray
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>微信标签编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
<div class="topToolBar">
	<div id="toolbar1" class="mini-toolbar topBtn">
		<a class="mini-button" plain="true" onclick="saveTheTag()">保存</a>
<!-- 		<a class="mini-button btn-red" iconCls="icon-remove" plain="true" onclick="CloseWindow('ok')">关闭</a> -->
	</div>
</div>
<div class="mini-fit">
	<div id="p1" class="form-container shadowBox90" style="padding-top: 8px;">
		<form id="form1" method="post">
			<div class="form-inner">
				<input id="id" name="id" class="mini-hidden" value="${wxTag.id}" />
				<table class="table-detail column-two" cellspacing="1" cellpadding="0">
					
					<tr>
						<td>标签名</td>
						<td>
								<input id="name" name="name" value="${wxTag.name}"
							class="mini-textbox"   style="width: 90%" />
						</td>
					</tr>
				</table>
			</div>
		</form>
	</div>
</div>
	<script type="text/javascript">
	addBody();
	function saveTheTag(){
		var data={};		
		var id=mini.get("id").getValue();
		var tagName=mini.get("name").getValue();
		var pubId='${pubId}';
		$.ajax({
			type:"post",
			url:"${ctxPath}/wx/core/wxPubApp/addTag.do",
			data:{"tagName":tagName,"pubId":pubId,"id":id},
			success:function (result){
				if(result.errcode){CloseWindow('cancel');}else {
					CloseWindow('ok');
				}
				
			}
		});
	}
	</script>
</body>
</html>