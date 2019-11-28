<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="ui" uri="http://www.redxun.cn/formUI"%>
<!DOCTYPE html>
<html>
<head>
<title>人员脚本选择器</title>
<%@include file="/commons/list.jsp" %>
<script type="text/javascript" src="${ctxPath}/scripts/common/baiduTemplate.js"></script>
<style>
	.table-detail{
		border-collapse:collapse;
	}

</style>
</head>
<body>
	<div class="topToolBar">
		<div>
    		<a id="saveButton" class="mini-button"   onclick="CloseWindow('ok')">确定</a>
    		<a class="mini-button btn-red"   onclick="CloseWindow('cancel')">取消</a>
		</div>
	</div>
	<div class="mini-fit" >
		<div 
			id="datagrid1" 
			class="mini-datagrid" 
			style="width: 100%; height:350px;" 
			allowResize="false"
			url="${ctxPath}/bpm/core/bpmGroupScript/listData.do" 
			idField="scriptId" 
			onrowclick="recordRow" 
			multiSelect="true"
			showColumnsMenu="true" 
			sizeList="[5,10]" 
			pageSize="5" 
			allowAlternating="true">
			<div property="columns">
				<div field="className" sortField="CLASS_NAME_" width="120" headerAlign="center" allowSort="true">类名</div>
				<div field="methodName" sortField="METHOD_NAME_" width="120" headerAlign="center" allowSort="true">方法名</div>
				<div field="methodDesc" sortField="METHOD_DESC_" width="120" headerAlign="center" allowSort="true">方法描述</div>
			</div>
		</div>

		<div class="shadowBox90" style="margin-top: 10px;display: none;">
			<form id="form1" method="post">
				<div id="showInfo" width="100%">
				</div>
			</form>
		</div>
	</div>
	
	<script type="text/html" charset="utf-8" id='template_1'>
		<table class="table-detail" cellspacing="0" cellpadding="0" border="0">
			<tr>
				<td style="text-align: left;">参数描述</td>
				<td style="text-align: left;">参数值</td>
			</tr>
			<#for(var i=0; i<list.length; i++){ #>
				<tr>
					<td><#= list[i].paraDesc #></td>
					<td>
						<input id="paraType<#= list[i].paraName #>"  class="mini-hidden"  value="<#= list[i].paraType #>" />

						<input class="mini-combobox" style="width:150px;" textField="text" valueField="id" id="type<#= list[i].paraName #>" valueFromSelect="false"
    						data="[{'text':'自定义','id':'self'},{'text':'来自选择器','id':'selector'},{'text':'流程变量','id':'variable'}]" value="<#= list[i].type #>" showNullItem="false" allowInput="false" onvaluechanged="changeCombox(e,'<#= list[i].paraName #>')"/>

						<a class="mini-button"  id="selector<#= list[i].paraName #>" style="display:none;" onclick="insertInto('<#= list[i].paraName #>','<#= list[i].selector #>','<#= list[i].bindField #>')">来自选择器</a>

						<input  class="mini-combobox" id="variable<#= list[i].paraName #>" url="${ctxPath}/bpm/core/bpmSolVar/getBySolIdActDefId.do?solId=<#= solId #>&actDefId=<#= actDefId #>" 
							style="display:none;"	valueField="key" textField="name"  style="width:30%;" onvaluechanged="changeVariable(e,'<#= list[i].paraName #>')" value="<#= list[i].value #>" />

						<input id="<#= list[i].paraName #>" name="<#= list[i].paraName #>" class="mini-textbox" value="<#= list[i].value #>" />
					</td>
				</tr>
			<# } #>
		</table>
	</script>
	<script type="text/javascript">
		mini.parse();
		var form =new mini.Form("#form1");
		var grid = mini.get("datagrid1");
		var config;
		var clickRecord;
		var scriptData;
		
		grid.load();
		
		function setConfig(configText){
			config = mini.decode(configText);
		}
		
		function recordRow(e) {
			var record = e.record;
			clickRecord=record;
			initHtml();
		}
		
		    
		    function initHtml(){
		    	//设置左分隔符为 <!
		        baidu.template.LEFT_DELIMITER='<#';
		        //设置右分隔符为 <!  
		        baidu.template.RIGHT_DELIMITER='#>';
		        var bt=baidu.template;
		        $("#showInfo").empty();
				$.ajax({
						type : "post",
						url : "${ctxPath}/bpm/core/bpmGroupScript/getScriptParams.do",
						data : {"scriptId" : clickRecord.scriptId},
						success : function(result) {
							var data = {"solId":"${solId}","actDefId":"${actDefId}"};
							var upperName=clickRecord.className.substring(0,1).toLocaleLowerCase()+clickRecord.className.substring(1,clickRecord.className.length);
							if(config){
								var param = config.param;
								if(clickRecord.methodName==config.script && upperName==config.className){
									for(var i=0;i<result.length;i++){
										var arg = param[result[i]["paraName"]];
										result[i].type = arg.paramCombox;
										result[i].value = arg.paramValue;
									}
								}
							}
							
							data.list=result;
							var tableHtml = bt('template_1', data);
							$("#showInfo").html(tableHtml);
							$(".shadowBox90").show();
							mini.parse();
							showCombox(result);
						}
					}); 
				}
		    
		    function insertInto(EL,selectorId,bindField){
		    	if(!selectorId) {
		    		  mini.alert("还没有配置选择器,请先配置选择器！");
		    		  return;
		    	}
		    	var argEL=mini.get(EL);
		    	var url=__rootPath+'/sys/core/sysBoList/'+selectorId+'/list.do';
		    	_OpenWindow({
					title:'人员脚本配置',
					width:750,
					url:url,
					height:500,
					onload:function(){
						var iframe = this.getIFrameEl().contentWindow;
					},
					ondestroy:function(action){
						if(action!='ok'){return;}
						var iframe = this.getIFrameEl().contentWindow;
						argEL.setValue(iframe.getData().rows[0][bindField]);
					}
				});
		    }
		    
		    function changeVariable(e,paramName){
		    	var value=e.value;
		    	var paramName=mini.get(paramName);
		    	paramName.setValue(value);
		    }
		    
		
		    function changeCombox(e,paramName){
		    	var value=e.value;
		    	var param = [];
		    	param[0] = {paraName:paramName,type:value,value:""};
		    	showCombox(param);
		    }
		    
		    function showCombox(param){
		    	for(var i=0;i<param.length;i++){
		    		var paramName = param[i].paraName;
		    		var type = param[i].type;
			    	var value = param[i].value;
		    		var self=mini.get(paramName);
			    	var selector=mini.get("selector"+paramName);
			    	var variable=mini.get("variable"+paramName);
			    	
			    	if(type=='self'){
			    		self.setValue(value);
			    		self.setAllowInput(true);
			    		selector.hide();
			    		variable.hide();
			    	}else if(type=='selector'){
			    		self.setValue(value);
			    		self.setAllowInput(false);
			    		self.setEmptyText("请通过左侧选择");
			    		selector.show();
			    		variable.hide();
			    	}else if(type=='variable'){
			    		self.setValue(value);
			    		self.setAllowInput(false);
			    		self.setEmptyText("请通过左侧选择");
			    		selector.hide();
			    		variable.show();
			    	}
		    	}
		    }
		    
		    function getScriptData(){
		    	var object={};
		    	var param={};
		    	var formData=form.getData();
		    	var params='';
		    	for(var arg in formData){
		    		var paratype=mini.get("paraType"+arg).getValue();
		    		if(paratype!="java.lang.String"){
		    			params+=formData[arg]+',';
		    		}else{
		    			params+="\""+formData[arg]+"\""+',';
		    		}
		    		var paramObj={};
		    		paramObj.paramValue=formData[arg];
		    		paramObj.paramType=mini.get("paraType"+arg).getValue();
		    		paramObj.paramCombox=mini.get("type"+arg).getValue();
		    		param[arg]=paramObj;
		    	}
		    	if(params.length>=1){
		    		params=params.substring(0,params.length-1);
		    	}
		    	var script=clickRecord.methodName+"("+params+");";
		    	var obj={"script":script};
		    	object.script=clickRecord.methodName;
		    	object.param=param;
		    	var lowerName=clickRecord.className.substring(0,1).toLocaleLowerCase()+clickRecord.className.substring(1,clickRecord.className.length);
		    	object.className=lowerName;
		    	return mini.encode(object);
		    }
		    
		    function getScriptText(){
		    	return clickRecord.methodDesc;
		    }
	</script>
</body>
</html>