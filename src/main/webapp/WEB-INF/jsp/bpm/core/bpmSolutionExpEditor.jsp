<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
<head>
	<title>公式设计器</title>
	<%@include file="/commons/edit.jsp"%>
	<link rel="stylesheet" href="${ctxPath}/scripts/codemirror/lib/codemirror.css">
	<script src="${ctxPath}/scripts/codemirror/lib/codemirror.js"></script>
	<script src="${ctxPath}/scripts/codemirror/mode/groovy/groovy.js"></script>
	<script src="${ctxPath}/scripts/codemirror/addon/edit/matchbrackets.js"></script>
</head>
<body>
	<div class="topToolBar">
		<div>
	    <a class="mini-button"   onclick="CloseWindow('ok')" plain="true">确定</a>
		</div>
	</div>
	<div class="mini-fit">
	    <div class="form-container">
	 		 	<ul id="varsMenu" class="mini-menu" style="display:none;">
	 		 		<c:forEach items="${instVars}" var="item">
	 		 			 <li  onclick="addExp('${item.key}')">${item.name}</li>
	 		 		</c:forEach>
			    </ul>
		    	<table class="table-detail column_2" cellpadding="0" cellspacing="1">
			    	<tbody>
				    	<tr id="backTaskTr">
				    		<td>流程变量表达式</td>
				    		<td>
				    			<form id="fieldForm">
					    			<input 
					    				id="varField" 
					    				class="mini-combobox" 
					    				showNullItem="true" 
					    				nullItemText="请选择变量..."  
					    				emptyText="请选择变量..."
					    				url="${ctxPath}/bpm/core/bpmNodeSet/getVars.do?solId=${param['solId']}&actDefId=${param.actDefId}&nodeId=${param['nodeId']}"
					    				valueField="key" 
					    				textField="name" 
					    				name="field" 
					    				onvaluechanged="changeVarField" 
					    				required="true"
				    				/>
					    			<input 
					    				id="varOp" 
					    				class="mini-combobox" 
					    				name="varOp" 
					    				nullItemText="请选择比较符..." 
					    				showNullItem="true" 
					    				emptyText="请选择比较符..." 
					    				required="true"
				    				/>
					    			<span id="valSpan">
					    			<input id="varVal" class="mini-textbox" name="varVal" emptyText="请输入值.." required="true" style="width:160px;"/>
					    			</span>
					    			<a class="mini-button"   onclick="addFieldExp">添加</a>
				    			</form>
				    		</td>
				    	</tr>
				    	<tr >
				    		<td width="120">上一步审批动作</td>
				    		<td >
				    			<form id="nodeForm">
					    			<input 
					    				class="mini-combobox" 
					    				name="nodeCheck" 
					    				valueField="activityId" 
					    				textField="name" 
					    				nullItemText="请选择前一审批环节..." 
					    				required="true"
					    				showNullItem="true" 
					    				emptyText="请选择前一审批环节..."
					    				id="nodeCheck" 
					    				url="${ctxPath}/bpm/core/bpmSolution/getPreNodes.do?solId=${param['solId']}&actDefId=${param.actDefId}&nodeId=${param['nodeId']}"
				    				>
					    			
					    			<input 
					    				id="nodeOp" 
					    				class="mini-combobox" 
					    				name="nodeOp"  
					    				data="[{id:'==',text:'等于'},{id:'!=',text:'不等于'}]"
					    				nullItemText="请选择比较符..." 
					    				showNullItem="true" 
					    				emptyText="请选择比较符..." 
					    				required="true"
				    				/>
					    			
					    			<div 
					    				class="mini-combobox"  
					    				name="nodeJump" 
					    				id="nodeJump" 
					    				required="true"
									    textField="text" 
									    valueField="id" 
									    value="AGREE" 
									    nullItemText="请选择审批操作..." 
									    showNullItem="true" 
									    emptyText="请选择审批操作..."
									    data="[{id:'AGREE',text:'同意'},{id:'REFUSE',text:'不同意'},{id:'BACK',text:'驳回'},{id:'BACK_TO_STARTOR',text:'驳回至发起人'}]" 
								    ></div> 
									<a class="mini-button"   onclick="addCheckExp">添加</a>
								</form>
				    			
				    		</td>
				    	</tr>
				    	<tr>
				    		<td>表单数据</td>
				    		<td>
				    			<form id="formId">
								<input id="formName"
									   class="mini-combobox"
									   name="formName"
									   url="${ctxPath}/bpm/core/bpmSolution/boDefFields.do?solId=${param.solId}"
									   onvaluechanged="onBoChanged"
									   valueField="id"
									   textField="name"
									   popupHeight="150"
									   style="width:90%;margin-bottom: 4px;"
									   required="true"/>
									<input 
					    				id="formField" 
					    				class="mini-combobox" 
					    				name="formField" 
					    				nullItemText="请选择" 
					    				showNullItem="true" 
					    				valueField="formField"
					    				textField="name"
					    				emptyText="请选择." 
					    				required="true"
				    				/>
									<input 
					    				id="formOp" 
					    				class="mini-combobox" 
					    				name="formOp"  
					    				data="[{id:'==',text:'等于'},{id:'!=',text:'不等于'}]"
					    				nullItemText="请选择比较符..." 
					    				showNullItem="true" 
					    				emptyText="请选择比较符..." 
					    				required="true"
				    				/>
					    			<input id="formVal" class="mini-textbox" name="varVal" emptyText="请输入值.." required="true" style="width:160px;"/>
					    			<a class="mini-button"   onclick="addFormExp">添加</a>
					    		</form>
				    		</td>
				    	</tr>
				    	<tr>
				    		<td width="120">函数表达式</td>
				    		<td>
				    			<a href="javascript:showScriptLibary()">插入函数脚本</a>
				    		</td>
				    	</tr>
				    	<tr>
				    		<td colspan="2" style="text-align: left">
				    			<a class="mini-button" plain="true" onclick="addExp('&&')">并且&&</a>
				    			<a class="mini-button" plain="true" onclick="addExp('||')">或||</a>
				    			<a class="mini-button" plain="true" onclick="addExp('()')">括号()</a>
				    			<a class="mini-menubutton"  plain="true"  menu="#varsMenu">插入变量</a>
				    		</td>
				    	</tr>
				    	<tr>
				    		<td colspan="2" style="padding:0 !important;">
				    			<textarea  id="formula" name="formula" style="width:90%;height:100px"></textarea>
				    		</td>
				    	</tr>
			    	</tbody>
		    	</table>
		   
		</div>
	</div>
		    <script type="text/javascript">
		    
		    	mini.parse();
		    	function getFormula(){
		    		return editor.getValue()
		    	}
		    	
		    	function addCheckExp(){
		    		var form=new mini.Form('nodeForm');
		    		form.validate();
		    		if(!form.isValid()){
		    			return;
		    		}
		    		var nodeCheck=mini.get('nodeCheck').getValue();
		    		nodeCheck=nodeCheck.split('-').join('_');
		    		var nodeOp=mini.get('nodeOp').getValue();
		    		var nodeJump=mini.get('nodeJump').getValue();
		    		
		    		var str='vars.check_'+nodeCheck+nodeOp+ '"' +nodeJump+'"';
		    		addExp(str);
		    	}
		    	
		    	//更改变量字段
		    	function changeVarField(e){
		    		var combo=e.sender;
		    		var sel=combo.getSelected();
		    		if(!sel){
		    			return;
		    		}
		    		var type=sel.type;
		    		var ops=[];
		    		var fieldVal=mini.get('varVal');
		    		var p= mini.get('varVal');
		    		if(p){
		    			p.destroy();
		    		}
		    		var valSpan=document.getElementById('valSpan');
		    		if(type=='String'){
		    			ops=[{id:'==',text:'等于'},{id:'!=',text:'不等于'}];
		            	var pl=new mini.TextBox();
		            	pl.setId('varVal');
		            	pl.setStyle('width:150px;');
		            	$(valSpan).html('');
		            	pl.render(valSpan);
		    		}else if(type=='Number'){
		    			ops=[{id:'==',text:'等于'},{id:'!=',text:'不等于'},{id:'<',text:'小于'},{id:'<=',text:'小于等于'},{id:'>',text:'大于'},{id:'>=',text:'大于等于'}];
		            	var pl=new mini.TextBox();
		            	pl.setId('varVal');
		            	pl.setRequired(true);
		            	pl.setStyle('width:150px;');
		            	pl.on('validation',onNumberValidation);
		            	$(valSpan).html('');
		            	pl.render(valSpan);	
		    		}else if(type=='Date'){
		    			ops=[{id:'==',text:'等于'},{id:'<',text:'小于'},{id:'>',text:'大于'}];
		            	var pl=new mini.DatePicker();
		            	pl.setId('varVal');
		            	pl.setRequired(true);
		            	pl.setStyle('width:150px;');
		            	pl.setFormat('yyyy-MM-dd');
		            	$(valSpan).html('');
		            	pl.render(valSpan);
		    		}
		    		mini.get('varOp').setData(ops);
		    	}
		    	
		    	var editor = CodeMirror.fromTextArea(document.getElementById("formula"), {
			        lineNumbers: true,
			        matchBrackets: true,
			        mode: "text/x-groovy"
			      });
		    	
		    	var fieldForm=new mini.Form('fieldForm');
		    	
		    	function addFieldExp(){
		    	
		    		fieldForm.validate();
		    		if(!fieldForm.isValid()){
		    			return;
		    		}
		    		var varField=mini.get('varField');
		    		var opField=mini.get('varOp');
		    		var opVal=mini.get('varVal');
		    		
		    		var varStr='';
		    		var type=varField.getSelected().type;
		    		var val="."+varField.getValue();
		    		if(val==".variables"){
		    			val="";
		    		}
		    		if(type=='String'){
		    			varStr='vars'+val+ '' +opField.getValue()+'"'+opVal.getValue()+'"';
		    		}else if(type=='Number'){
		    			varStr='vars'+val+ '' +opField.getValue()+opVal.getValue();
		    		}else if(type=='Date'){
		    			if(opField.getValue()=='=='){
		    				varStr='vars'+val +'.compareTo(com.redxun.core.util.DateUtil.parseDate(\''+opVal.getFormValue()+'\'))==0';
		    			}else if(opField.getValue=='<'){
		    				varStr='vars'+val +'.compareTo(com.redxun.core.util.DateUtil.parseDate(\''+opVal.getFormValue()+'\'))<0';
		    			}else{
		    				varStr='vars'+val +'.compareTo(com.redxun.core.util.DateUtil.parseDate(\''+opVal.getFormValue()+'\'))>0';
		    			}
		    		}
		    		addExp(varStr);
		    	}
		    	
		    	function onBoChanged(){
		    		var formName = mini.get("formName");
					var id = formName.getValue();
					var varField=mini.get('formField');
					varField.load("${ctxPath}/bpm/core/bpmSolution/modelFields.do?boDefId="+id);
				}
		    	
		    	var formId=new mini.Form('formId');
		    	
		    	function addFormExp(){
			    	
		    		formId.validate();
		    		if(!formId.isValid()){
		    			return;
		    		}
		    		var varField=mini.get('formField');
		    		var opField=mini.get('formOp');
		    		var opVal=mini.get('formVal');
		    		
		    		var varStr='vars.jsonData["'+varField.getValue()+ '"]' +opField.getValue()+'"'+opVal.getValue()+'"';
		    		addExp(varStr);
		    	}
		    	
		    	//显示脚本库
				function showScriptLibary(){
					_OpenWindow({
						title:'脚本库',
						iconCls:'icon-script',
						url:__rootPath+'/bpm/core/bpmScript/libary.do',
						height:550,
						width:1000,
						onload:function(){
						},
						ondestroy:function(action){
							if(action!='ok'){
								return;
							}
							var win=this.getIFrameEl().contentWindow;
							var row=win.getSelectedRow();
							if(row){
								//addExp(row.example);
								addExp(row);
							}
						}
					});
				}
		    	
		    	function addExp(scriptText){
		    		var doc = editor.getDoc();
	           		var cursor = doc.getCursor(); // gets the line number in the cursor position
	          		doc.replaceRange(scriptText, cursor); // adds a new line
		    	}
		    </script>
</body>
</html>