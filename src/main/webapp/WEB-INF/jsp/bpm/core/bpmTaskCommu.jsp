<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="redxun" uri="http://www.redxun.cn/gridFun" %>
<!DOCTYPE html>
<html>
    <head>
        <title>任务沟通</title>
      <%@include file="/commons/edit.jsp"%>
	</head>
<body>
<div class="topToolBar">
	<div>
		 <a class="mini-button"   plain="true" onclick="doCommmu()">确定</a>
         <a class="mini-button btn-red" plain="true" onclick="CloseWindow();">关闭</a>
	</div>
</div>
<div class="mini-fit">
	<div class="form-container" >
		<form id="commuForm">
			<table class="table-detail column-two" cellpadding="0" cellspacing="1" style="width:100%" >
				<tr>
					<td>
						沟通人
					</td>
					<td>
						<input id="communicateUserId" name="communicateUserId" class="mini-user" single="false" required="true" style="width:80%"/>
						<input class="mini-hidden" name="taskId" value="${param.taskId}"/>
					</td>
				</tr>
				<tr>
					<td>意见</td>
					<td>
						<textarea class="mini-textarea" name="opinion" style="width:80%"  required="true"></textarea>
					</td>
				</tr>
				<tr>
					<td>附件</td>
					<td>
						<div id="opFiles" name="opFiles" class="upload-panel"  style="width:auto;" isDown="false" isPrint="false"  readOnly="false" ></div> 
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
	              			url="${ctxPath}/bpm/core/bpmConfig/getNoticeTypes.do" 
              			></div>
					</td>
				</tr>
			</table>
		</form>
	</div>
</div>
	<script type="text/javascript">
		mini.parse();
		
		var form=new mini.Form('commuForm');
		
		function doCommmu(){
			form.validate();
			if(!form.isValid()){
				return;
			}
			_SubmitJson({
				method : 'POST',
				url:__rootPath+'/bpm/core/bpmTask/doCommu.do',
				data:form.getData(),
				success:function(text){
					CloseWindow('ok');	
				}
			});
		}
		
	</script>
</body>
</html>