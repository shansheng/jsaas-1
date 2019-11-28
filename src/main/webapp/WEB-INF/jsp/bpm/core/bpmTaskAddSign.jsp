<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="redxun" uri="http://www.redxun.cn/gridFun" %>
<!DOCTYPE html>
<html>
    <head>
        <title>任务加签</title>
      <%@include file="/commons/edit.jsp"%>
	</head>
<body>
	<div class="topToolBar">
		<div>
            <a class="mini-button"   plain="true" onclick="doAddSign()">加签</a>
            <a class="mini-button btn-red" plain="true" onclick="CloseWindow();">关闭</a>
		</div>
	</div>
	
	<div class="form-outer"  style="padding:6px;">
		<form id="form">
			<table class="table-detail column_2_m" cellpadding="0" cellspacing="1" style="width:100%" >
				<tr>
					<th>选择</th>
					<td>
						<input  name="user" 
							class="mini-user"   
							style="width:80%;"  
							/>
						<input class="mini-hidden" name="taskId" value="${param.taskId}"/>
					</td>
				</tr>
				<tr>
					<th>通知方式</th>
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
	<script type="text/javascript">
		mini.parse();
		
		var form=new mini.Form('#form');
		
		function doAddSign(){
			form.validate();
			if(!form.isValid()){
				return;
			}
			_SubmitJson({
				method : 'POST',
				url:__rootPath+'/bpm/core/bpmTask/doAddSign.do',
				data:form.getData(),
				success:function(text){
					CloseWindow('ok');	
				}
			});
		}
		
	</script>
</body>
</html>