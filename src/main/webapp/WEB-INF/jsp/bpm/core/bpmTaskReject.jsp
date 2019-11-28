<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="redxun" uri="http://www.redxun.cn/gridFun" %>
<!DOCTYPE html>
<html>
    <head>
        <title>任务驳回</title>
      <%@include file="/commons/edit.jsp"%>
	</head>
<body>
	<div class="topToolBar">
		<div>
            <a class="mini-button"   plain="true" onclick="reject()">确定</a>
            <a class="mini-button btn-red" plain="true" onclick="CloseWindow();">关闭</a>
		</div>
	</div>
	<div class="mini-fit">
		<div class="form-container" >
			<form id="rejectForm">
				<table class="table-detail column-two" cellpadding="0" cellspacing="1" style="width:100%" >
					<tr>
						<td>
							类型
						</td>
						<td>
							<input class="mini-radiobuttonlist"  name="jumpType" id="jumpType" required="true" value=""
									textField="text" valueField="id"  data=''
									repeatLayout="flow" repeatDirection="vertical"
									onvaluechanged="changeJumpType"/>
						</td>
					</tr>
					<tr >
							<td>回退任务完成后</td>
							<td>
								<input class="mini-hidden" name="taskId" value="${task.id}"/>
								<input class="mini-radiobuttonlist" id="nextJumpType" name="nextJumpType" value="normal" data="[{id:'normal',text:'正常执行'},{id:'orgPathReturn',text:'原路返回'}]" required="true"/>
							</td>
					</tr>

					<tr style="display:none" id="trSpecNode">
							<td>指定节点</td>
							<td>
								<input class="mini-combobox" id="destNodeId" name="destNodeId" textField="nodeName" valueField="nodeId"
								 url="${ctxPath}/bpm/core/bpmRuPath/getBackNodes/${task.procInstId}/${task.taskDefKey}.do" required="true"/>
							</td>
					</tr>

					<tr>
						<td>意见</td>
						<td>
							<textarea class="mini-textarea" name="opinion" style="width:80%"></textarea>
						</td>
					</tr>
					<tr>
						<td>附件</td>
						<td>
							<div id="opFiles" name="opFiles" class="upload-panel"  style="width:auto;" isDown="false" isPrint="false"  readOnly="false" ></div>
						</td>
					</tr>

				</table>
			</form>
		</div>
	</div>
	<script type="text/javascript">
		mini.parse();
		
		var form=new mini.Form('rejectForm');
		var jumpTypeConfig = '${jumpTypes}';
		
		$(function(){
			var config = mini.decode(jumpTypeConfig);
			var jumpType = mini.get("jumpType");
			if(config.length>1){
				jumpType.setData(config);
			}else{
				$("#jumpType").after(config[0].text);
				jumpType.setValue(config[0].id);
				changeJumpType({value:config[0].id});
			}
		})
		
		function changeJumpType(e){
			var val=e.value;
			var obj=$("#trSpecNode");
			if(val=="BACK_SPEC"){
				obj.show();
			}
			else{
				obj.hide();
			}
		}
		
		function reject(){
			form.validate();
			if(!form.isValid()){
				return;
			}
			var jumpType=mini.get("jumpType").getValue();
			
			if(jumpType=="BACK_SPEC"){
				var destNodeId=	mini.get("destNodeId").getValue();
				if(!destNodeId){
					mini.alert("没有选择驳回节点", "提示信息");
					return;
				}
			}
			mini.confirm("确认驳回吗?", "提示信息", function(action){
				if(action!="ok") return;
				
				_SubmitJson({
					method : 'POST',
					url:__rootPath+'/bpm/core/bpmTask/doNext.do',
					data:form.getData(),
					success:function(text){
						CloseWindow('ok');	
					}
				});	
			});
		}
	</script>
</body>
</html>