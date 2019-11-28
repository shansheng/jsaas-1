<%-- 
    Document   : [表间公式]编辑页
    Created on : 2018-08-07 09:06:53
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[表间公式]编辑</title>
<%@include file="/commons/edit.jsp"%>
</head>
<body>
	<rx:toolbar toolbarId="toolbar1" pkId="bpmTableFormula.id" />
	<div class="mini-fit">
	<div class="form-container">
			<form id="form1" method="post">
				<input id="pkId" name="id" class="mini-hidden" value="${bpmTableFormula.id}" />
				<table class="table-detail column-four" cellspacing="0" cellpadding="0">
					<caption>[表间公式 基本信息]</caption>
					<tr>
						<td>公式名称 *：</td>
						<td>
							<input name="name" class="mini-textbox" required="true" style="width: 90%" />
						</td>
						
						<td>数据模型 *:</td>
						<td colspan="3">
						<input id="boDefId" name="boDefId" class="mini-buttonedit" text="${sysBoDef.name}" oncloseclick="_ClearButtonEdit" showClose="true" 
							style="width: 50%" onbuttonclick="selBoDlg" required="true" allowInput="false"/>
						</td>

					</tr>
					<tr>
						<td>分类选择 *:</td>
						<td colspan="3">
							<%--<input id="treeId" name="treeId" class="mini-buttonedit"  oncloseclick="_ClearButtonEdit" showClose="true"
								   style="width: 50%" onbuttonclick="selBoDlg" required="true" allowInput="false"/>
--%>
							<input id="treeId" name="treeId" class="mini-treeselect" url="${ctxPath}/sys/core/sysTree/listByCatKey.do?catKey=CAT_BPM_FROM"
								   multiSelect="false" textField="name" valueField="treeId" parentField="parentId"  required="true" text="${bpmTableFormula.treeId}"
								   showFolderCheckBox="false"  expandOnLoad="true" showClose="true" oncloseclick="_ClearButtonEdit"
								   popupWidth="300" style="width:300px"/>
						</td>

					</tr>
					
					<tr>
						<td>动作时机：</td>
						<td>
							<input class="mini-radiobuttonlist" name="action" id="action" value="new"
							 data="[{id:'new',text:'新建'},{id:'upd',text:'更新'},{id:'del',text:'删除'}]"/>
						</td>
						<td>调试模式：</td>
						<td >
							<input name="isTest"
							class="mini-radiobuttonlist" value="NO"
							data="[{id:'YES',text:'是'},{id:'NO',text:'否'}]"
							style="width: 90%" />
						</td>
					</tr>
					<tr>
						<td>表间数据执行配置：</td>
						<td colspan="3">
							<div class="form-toolBox" >
						            <a class="mini-button "   plain="true" onclick="addRow">新增</a>
						            <a class="mini-button btn-red"  plain="true" onclick="removeRow">删除</a>
						            <span class="separator"></span>
						            <a class="mini-button"  plain="true" onclick="upRowGrid('fillConfGrid')">向上</a>
						            <a class="mini-button"  plain="true" onclick="downRowGrid('fillConfGrid')">向下</a> 
						            <span class="separator"></span>
						            <a class="mini-button"  plain="true" onclick="editRow">编辑</a>
							</div>
							
							<div id="fillConfGrid" class="mini-datagrid" style="width:100%;min-height:200px;" height="auto" showPager="false"
								allowCellSelect="true" allowCellEdit="true" oncellbeginedit="onChangeBoEditor" 
								allowAlternating="true" allowCellValid="true">
							    <div property="columns">
							        <div type="indexcolumn"></div>          
							        <div name="name" field="name" displayField="comment" width="120" headerAlign="center">数据映射
							        	<input  property="editor" class="mini-combobox" valueField="name" textField="comment" onvaluechanged="onFieldChanged" />
							        </div>    
							        <div field="opDescp" width="140" headerAlign="center">执行描述
							        	<input class="mini-textbox" property="editor"/>
							        </div>    
							    </div>
							</div>
						</td>
					</tr>
					<tr>
						<td>公式描述：</td>
						<td colspan="3">
							<textarea name="descp" class="mini-textarea" style="width: 98%;height:120px"></textarea>
						</td>
					</tr>
				</table>
			</form>
	</div>
	</div>
	<script type="text/javascript">
	mini.parse();
	var form = new mini.Form("#form1");
	var grid=mini.get('fillConfGrid');
	var pkId = '${bpmTableFormula.id}';
	$(function(){
		initForm();
	});
	
	function onFieldChanged(e){
		  var item=e.sender.getSelected();
		  var row=grid.getEditorOwnerRow(e.sender);
		  grid.updateRow(row,{isMain:item.isMain?"yes":"no"})
	}
	
	
	
	//添加行
	function addRow(){
		var boDefId=mini.get('boDefId').getValue();
   		if(!boDefId){
   			alert('请选择筛选业务对象模型！');
   			return;
   		}
		grid.addRow({});
	}
    
    function editRow(){
    	var row=grid.getSelected();
    	if(!row){
    		alert('请选实体表！');
    		return;
    	}
    	
   		var boDefId=mini.get('boDefId').getValue();
   		if(!boDefId){
   			alert('请选择筛选业务对象模型！');
   			return;
   		}
   		
   		var action=mini.get("action").getValue();
   		showOpWin(boDefId,row,action);
    	
    }
    
    function onChangeBoEditor(e){
		var record = e.record, field = e.field;
        var val=e.value;
        if(field=='name'){
       		var boDefId=mini.get('boDefId').getValue();
    		if(!boDefId){
    			alert('请选择筛选数据模板！');
    			return;
    		}
    		var editor=e.editor;
    		loadBoDef(boDefId,function(data){
    			editor.setData(data);
    		})
       	}
    }
	
    /**
    * config:
    {
    	name:'bo实体表名'
    	opDescp:'描述',
    	comment:"备注",
    	settings:settings
    }
    */
	function showOpWin(boDefId,config,action){
		var url=__rootPath+'/bpm/form/bpmTableFormula/dataAddNew.do?boDefId='+boDefId + '&boName='+ config.name +"&isMain=" + config.isMain +"&action=" + action;
		_OpenWindow({
			url:url,
			title:"设置映射",
			width:650,
			height:450,
			max:true,
			onload:function(){
				var win=this.getIFrameEl().contentWindow;
				var setting=config.settings;
				win.setDataConf(setting);
			},
			ondestroy:function(action) {
				if (action != "ok")  return;
				var data = this.getIFrameEl().contentWindow.getValue();
				var d=mini.clone(data);
				var selRow=grid.getSelected();
				var settings={settings:d};
				grid.updateRow(selRow,settings);
				
			}
		});
		
	}
	
	
	
	function selBoDlg(e){
		var button=e.sender;
		openBoDefDialog("",function(action,data){
			if(action!="ok") return;
			button.setValue(data.id);
			button.setText(data.name);
		},false);
	}
	
	
	var boDefAry=[];
	function initForm(){
		if(!pkId) return;
		var url="${ctxPath}/bpm/form/bpmTableFormula/getJson.do";
		$.post(url,{ids:pkId},function(json){
			
			form.setData(json);
			grid.setData(mini.decode(json.fillConf));
			
			loadBoDef(json.boDefId,function(data){
				boDefAry=data;
			})
		});
		
		
	}

		
	function onOk(){

		form.validate();
	    if (!form.isValid()) {
	        return;
	    }	        
	    var data=form.getData();
	    data.fillConf=mini.encode(grid.getData());
		var config={
        	url:"${ctxPath}/bpm/form/bpmTableFormula/save.do",
        	method:'POST',
        	postJson:true,
        	data:data,
        	success:function(result){
        		CloseWindow('ok');
        	}
        }
		_SubmitJson(config);
	}
	
	function removeRow(){
		var row=grid.getSelected();
		if(!row) return;
		grid.removeRow(row,true);
	}
	</script>
	<script src="${ctxPath}/scripts/flow/tableformula/tableformula.js"></script>
</body>
</html>