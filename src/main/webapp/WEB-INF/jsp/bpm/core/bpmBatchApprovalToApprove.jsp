<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html >
<head>
<title>批量审批处理页</title>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="rxc" uri="http://www.redxun.cn/commonFun"%>
<%@include file="/commons/customForm.jsp"%>
<script src="${ctxPath }/scripts/flow/inst/opinions.js?version=${static_res_version}"></script>
<script type="text/javascript">
	var taskId='${taskId}';
</script>
<style>
	body{
		background: #f7f7f7;
	}

	
	#errorMsg{
		margin: auto; 
		width: 690px; 
		
		white-space:normal;
		/*text-overflow:ellipsis;*/
		/*overflow:hidden*/;
		color:red;
		border:solid 1px red;
		padding:5px;
	}
	
</style>
</head>
<body >
	<div id="div_toolbar1" class="topToolBar" >
		<div>
		   	 <a class="mini-button"  plain="true" onclick="doNext">审批</a>
		   	 <a class="mini-button btn-red" plain="true" onclick="onClose">关闭</a>
		</div>  
	</div>
	<div id="errorMsg" style="display:none;"></div>
		
	<div class="shadowBox90">
		<div class="details">	
			<table class="table-view"  id="taskHandle">
				<tr id="handleOpTr">
					<th style="width:15%;">处理意见</th>
					<td>
						<input name="opinionSelect"  id="opinionSelect" class="mini-combobox"  emptyText="常用处理意见..." style="width:40%;" minWidth="120" 
							url="${ctxPath}/bpm/core/bpmOpinionLib/getUserText.do" valueField="opId" textField="opText" 
						 	onvaluechanged="showOpinion()"  ondrawcell="onDrawCells" allowInput="true"/>
						<a class="mini-button" iconCls="icon-archives" onclick="saveOpinionLib()" >保存</a>
						<textarea class="mini-textarea" id="opinion" name="opinion" style="width:80%" value="" emptyText="请填写审批意见！"></textarea>
					</td>
				</tr>
			</table>
		</div>
	</div>
	

	
	<script type="text/javascript">
	
		function onClose(e){
			CloseWindow("close");
		}
	
		
		//当文字过高时调整高度
		function resizeTextArea(){
			var opinion=mini.get("opinion");
			opinion.set({style:"overflow-y:visible"});
		}
		
		function submitValidate(){
			var opinionObj=mini.get("opinion");
			var val=opinionObj.getValue();
			return  (val)?true:false;
		}
		
		function doNext(){
			
			if(!submitValidate()){
				mini.alert("请填写意见内容");
				return;
			}
			var postData={
				taskId:taskId,
				jumpType:"AGREE",
			};

			var opinion =mini.get('#opinion');
			postData.opinion=opinion.value;
            
			//填写审批意见
   			_SubmitJson({
   				url:__rootPath+'/bpm/core/bpmTask/doNextAll.do',
   				data:postData,
   				method:'POST',
   				success:function(text){
   					var objRef = window.opener;
   					
   					if(objRef){
   						if(objRef.grid){
   							objRef.grid.reload();	
   						}
   						window.setTimeout(function(){
   							window.close();	
   						},1000)
   					}
   					else{
   						_ShowTips({state: 'success',msg:"流程处理成功!"})
   						window.setTimeout(function(){
   							CloseWindow('ok');	
   						})
   					}
   				},
   				fail:function(result){
					$("#errorMsg").css('display','');
					$("#errorMsg").html(result.message);
				}
   			});	
		};
		
		
		
		
	</script>
	
</body>
</html>