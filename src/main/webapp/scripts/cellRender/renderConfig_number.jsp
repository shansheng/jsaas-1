<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>用户组类型的渲染</title>
<%@include file="/commons/edit.jsp"%>

</head>
<body>
	<div class="topToolBar">
		<div>
			<a class="mini-button"  onclick="CloseWindow('ok')">保存</a>
			<a class="mini-button btn-red" onclick="CloseWindow()">关闭</a>
		</div>
	</div>
	<div class="mini-fit">
		<div class="form-container">
			<form id="miniForm">
				<table class="table-detail column-two" cellspacing="1" cellpadding="1">
					<tr>
						<td>格式</td>
						<td>
							<input name="format" class="mini-textbox" /> 格式如：####.00
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	<script type="text/javascript">
	

		mini.parse();
		
		var form=new mini.Form('miniForm');
		
		function setData(data,fieldDts){
			form.setData(data);
		}
		
		function getData(){
			var formData=form.getData();
			formData.dataType="float";
			return formData;
		}
	</script>				
</body>
</html>