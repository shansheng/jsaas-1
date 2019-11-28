<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="redxun" uri="http://www.redxun.cn/gridFun" %>
<!DOCTYPE html>
<html>
    <head>
        <title>任务转发</title>
      <%@include file="/commons/edit.jsp"%>
	</head>
<body>
  
	<div class="topToolBar">
		<div>
			<a class="mini-button"   plain="true" onclick="transferTasks()">确定</a>
			<a class="mini-button btn-red" plain="true" onclick="CloseWindow();">关闭</a>
		</div>
	</div>
<div class="mini-fit">
	<div class="form-container" >
		<form id="transferForm">
			<table class="table-detail column-two" cellpadding="0" cellspacing="1" style="width:100%" >
				<tr>
					<td>转发的任务</td>
					<td>
						<input class="mini-textboxlist" id="taskIds" name="taskIds"  required="true" style="width:90%;" text="${taskNames}" value="${taskIds}" readOnly="true"/>
					</td>
				</tr>
				<tr>
					<td>
						转交给
					</td>
					<td>
						<input id="userId" name="userId" class="mini-user"    style="width:auto;"   single="true" required="true"/>
					</td>
				</tr>
				<tr>
					<td>意见</td>
					<td>
						<textarea class="mini-textarea" name="remark" style="width:80%"></textarea>
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
		
		var form=new mini.Form('transferForm');
		
		function transferTasks(){
			form.validate();
			if(!form.isValid()){
				return;
			}
			_SubmitJson({
				method : 'POST',
				url:__rootPath+'/bpm/core/bpmTask/transferTask.do',
				data:form.getData(),
				success:function(text){
					CloseWindow('ok');	
				}
			});
		}
		
		
	</script>
</body>
</html>