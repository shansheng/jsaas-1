<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>正则表达式</title>
	<%@include file="/commons/get.jsp"%>
	<script src="${ctxPath}/scripts/share/dialog.js?version=${static_res_version}" type="text/javascript"></script>
</head>
<body>
	<div id="p1" class="form-outer" style="height: 80%">
		<form id="form1" method="post">
			<div class="form-inner">
				<table class="table-detail" cellspacing="1" cellpadding="0">
					<tr>
						<th>正则表达式</th>
						<td>
							<div style="clear:both;width:100%;margin:4px 0px;">
								<input id="buttonEditEditor" class="mini-buttonedit" allowInput="false" onbuttonclick="onRegShow"/>	
							</div>
							<input class="mini-textarea" id="reg" required="true" name="reg" emptyText="请填写正则表达式！"
								width="90%" height="300px"
							 />
						</td>
					</tr>
				</table>
			</div>
		</form>
	</div>
	<div class="mini-toolbar" style="text-align: center;">
		<a class="mini-button"   onclick="onOk()">确定</a>
		<a class="mini-button" onclick="CloseWindow()">关闭</a>
	</div>
	
	<script type="text/javascript">
		mini.parse();
		
		var form = new mini.Form("#form1");
		
		function onRegShow(e){
			openRegDialog(0,function(data){
				mini.get("reg").setValue(data.regText);
			});
		}
		
		function onOk() {
			if(!form.validate())return;
			CloseWindow("ok");
		}
		
		function setData(data){
			form.setData({"reg":data});
		}
		
		function getData(){
			return form.getData();
		}
		
	</script>
</body>
</html>