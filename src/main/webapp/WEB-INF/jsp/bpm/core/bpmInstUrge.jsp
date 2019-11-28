<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="redxun" uri="http://www.redxun.cn/gridFun" %>
<!DOCTYPE html>
<html>
    <head>
        <title>流程催办</title>
      <%@include file="/commons/edit.jsp"%>
	</head>
<body>
<div class="topToolBar">
	<div>
		 <a class="mini-button"   plain="true" onclick="doUrge()">确定</a>
         <a class="mini-button btn-red" plain="true" onclick="CloseWindow();">关闭</a>
	</div>
</div>
<div class="mini-fit">
	<div class="form-container">
		<div class="form-outer">
			<form id="urgeForm">
				<table class="table-detail column-four" cellpadding="0" cellspacing="1" style="width:100%" >
					<tr>
						<td>意见</td>
						<td>
							<input class="mini-hidden" name="instId" value="${param.instId}">
							<textarea class="mini-textarea" name="opinion" style="width:80%"  required="true"></textarea>
						</td>
					</tr>
					<tr>
						<td>通知方式</td>
						<td>
							<div
								name="noticeTypes"
								class="mini-checkboxlist"
								textField="text"
								valueField="name"
								required="true"
								url="${ctxPath}/bpm/core/bpmConfig/getNoticeTypes.do"
							></div>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</div>
	<script type="text/javascript">
		mini.parse();
		
		var form=new mini.Form('urgeForm');
		
		function doUrge(){
			form.validate();
			if(!form.isValid()){
				return;
			}
			_SubmitJson({
				method : 'POST',
				url:__rootPath+'/bpm/core/bpmInst/doUrge.do',
				data:form.getData(),
				success:function(text){
					CloseWindow('ok');	
				}
			});
		}
		
	</script>
</body>
</html>