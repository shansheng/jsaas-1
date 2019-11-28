
<%-- 
    Document   : [流程批量审批设置表]编辑页
    Created on : 2018-06-27 15:19:53
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[流程批量审批设置表]编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
	<rx:toolbar toolbarId="toolbar1" pkId="bpmBatchApproval.id" />
	<div id="p1" class="form-container">
		<form id="form1" method="post">
				<input id="pkId" name="id" class="mini-hidden" value="" />
				<table class="table-detail column-two" cellspacing="1" cellpadding="0">
					<caption>[流程批量审批设置]基本信息</caption>
					<tr>
						<td>流程方案：</td>
						<td>
							<input id="solId" name="solId" textName="solName" class="mini-buttonedit" 
								emptyText="请输入..."  onbuttonclick=selectSolution selectOnFocus="true" width="300"
								value="" text="" required="true"/>
						</td>
					</tr>
					<tr>
						<td>节点：</td>
						<td>
							
							<input id="nodeId" name="nodeId" textName="taskName" class="mini-buttonedit" 
								emptyText="请输入..."  onbuttonclick="onSelectNode" selectOnFocus="true" width="300"
								required="true"/>
						</td>
					</tr>
					<tr>
						<td>字段设置：</td>
						<td>
								<input id="fieldJson" name="fieldJson" class="mini-textboxlist" required="true"  width="90%" onvaluechanged="handAttrs"/>
								<a class="mini-button" plain="true" onclick="setting()" >设置</a>
						</td>
					</tr>
					<tr>
						<td>状态：</td>
						<td>
							<div 
								name="status"
								class="mini-radiobuttonlist" 
    							textField="text" 
    							valueField="id" value="1"
    							data="[{id:'1',text:'启用'},{id:'0',text:'禁用'}]" >
							</div>
						</td>
					</tr>
				</table>
		</form>
	</div>
	
	
	<script type="text/javascript">
	mini.parse();
	var form = new mini.Form("#form1");
	var fieldJsonObj=mini.get("fieldJson");
	
	var pkId ="${pkId}";
	var oldSolId;//流程方案ID
	var fieldJson={};//字段设置
	var actDefId;
	
	$(function(){
		initForm();
	})
	
	function initForm(){
		if(!pkId) return;
		var url=__rootPath +"/bpm/core/bpmBatchApproval/getJson.do?ids=" +pkId;
		$.get(url,function(json){
			form.setData(json);
			var attrs=eval("(" + json.fieldJson +")");
			
			var attrsObj=getAttrsObj(attrs);
			fieldJsonObj.setValue(attrsObj.vals);
			fieldJsonObj.setText(attrsObj.names);
			
			fieldJson.attrs=attrs;
			fieldJson.tableName=json.tableName;
		});
	}
	
	//字段设置
	function setting(){
		var solId=mini.get("solId").getValue();
		if(!solId){
			alert("设置前请选择流程方案");
			return;
		}
		
		
		var url=__rootPath +"/bpm/core/bpmBatchApproval/fieldSet.do?solId="+solId;
		
		_OpenWindow({
			title:"列表字段设置",
			height:450,
			width:700,
			url:url,
			onload: function(){
				var win = this.getIFrameEl().contentWindow;
				if(pkId){
					win.setData(true,fieldJson);
				}
				else{
					if(fieldJson.tableName){
						var attrs=fieldJson.attrs;
						var fields= fieldJsonObj.getValue().split(",");
						for(var i=attrs.length-1;i>=0;i--){
							var attr=attrs[i];
							var name=attr.name;
							var rtn=AryUtil.isExist(fields,name);
							if(!rtn){
								attrs.splice(i,1); 
							}
						}
						fieldJson.attrs=attrs;
					}
					win.setData(false,fieldJson);
				}
			},
			ondestroy:function(action){
				if(action!="ok") return;
				fieldJson = this.getIFrameEl().contentWindow.getJsonData();
				
				var attrs=fieldJson.attrs;
				
				var attrsObj=getAttrsObj(attrs);
				
				fieldJsonObj.setValue(attrsObj.vals);
				fieldJsonObj.setText(attrsObj.names);
				
				fieldJsonObj.doValueChanged();
				
				oldSolId = solId;
			}
		});
	}
	
	function getAttrsObj(attrs){
		var aryName=[];
		var aryShowName=[];
		for(var i=0;i<attrs.length;i++){
			var o=attrs[i];
			aryName.push(o.name);
			aryShowName.push(o.comment);
		}
		var names=aryShowName.join(",");
		var vals=aryName.join(",");
		
		return {names:names,vals:vals};
	}
	
	//选择流程方案
	function selectSolution(){
		openBpmSolutionDialog(true,function(solutions){
			var obj = solutions[0];
          	var solObj=mini.get("solId");
          	oldSolId = solObj.getValue();
          	solObj.setText(obj.name);
          	solObj.setValue(obj.solId);
          	solObj.doValueChanged();
          	actDefId=obj.actDefId;
		});
	}
	
	//选择节点
	function onSelectNode(){
		if(!actDefId || actDefId==""){
			alert("请先选择流程方案");
			return;
		}
		var conf={single:"true",end:"true"};
		openSolutionNode(actDefId,conf,function(data){
			var obj=data[0];
			var nodeId=mini.get("nodeId");
			nodeId.setText(obj.name);
			nodeId.setValue(obj.activityId);
			nodeId.doValueChanged();
		});
	}
	
	function handAttrs(){
		var val=fieldJsonObj.getValue();
		if(!val) {
			fieldJson.attrs=[];
			return;
		}
		
		var rtn=[];
		var attrs=fieldJson.attrs;
		var aryVal=val.split(",");
		for(var i=0;i<aryVal.length;i++){
			var val=aryVal[i];
			for(var j=0;j<attrs.length;j++){
				var attr=attrs[j];
				if(val==attr.name){
					rtn.push(attr);
				}
			}
		}
		fieldJson.attrs=rtn;
	}
	
	
		
	function onOk(){
		form.validate();
	    if (!form.isValid()) {
	        return;
	    }	  
	    var data=form.getData();
		if(oldSolId && data.solId!=oldSolId){
			alert("重新选择流程方案时，需重新设置字段");
			return;
		}
	 
	    data.tableName = fieldJson.tableName;
	    data.actDefId = actDefId;
	    
	    handAttrs();
	    _RemoveGridData(fieldJson.attrs);
	    data.fieldJson = mini.encode(fieldJson.attrs);
	    var url=__rootPath +"/bpm/core/bpmBatchApproval/save.do";
		var config={
        	url:url,
        	method:'POST',
        	postJson:true,
        	data:data,
        	success:function(result){
        		//如果存在自定义的函数，则回调
        		if(isExitsFunction('successCallback')){
        			successCallback.call(this,result);
        			return;	
        		}
        		
        		CloseWindow('ok');
        	}
        }
		_SubmitJson(config);
	}	

	</script>
</body>
</html>