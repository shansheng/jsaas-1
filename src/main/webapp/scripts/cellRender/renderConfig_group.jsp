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
	<div class="form-container">
		<form id="miniForm">
			<table class="table-detail column-four" cellspacing="1" cellpadding="1">
				<tr>
					<td>是否显示全路径</td>
					<td>
						<div name="showPath" class="mini-checkbox" readOnly="false" text="显示全路径"></div>
					</td>
					<td>
						<span class="starBox">
							是否显示连接<span class="star">*</span>
						</span>
					</td>
					<td>
						<div name="showLink" class="mini-checkbox" readOnly="false" text="显示连接"></div>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<script type="text/javascript">
	

		mini.parse();
		
		var form=new mini.Form('miniForm');
		
		function setData(data,fieldDts){
			form.setData(data);
		}
		
		function getData(){
			var formData=form.getData();
			return formData;
		}
	</script>				
</body>
</html>