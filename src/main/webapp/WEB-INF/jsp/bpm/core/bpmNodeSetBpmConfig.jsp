<%-- 
    Document   : [表间公式]编辑页
    Created on : 2018-08-07 09:06:53
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>添加数据时保存新数据</title>
	<%@include file="/commons/edit.jsp"%>
	<link rel="stylesheet" href="${ctxPath}/scripts/codemirror/lib/codemirror.css">
	<script src="${ctxPath}/scripts/codemirror/lib/codemirror.js"></script>
	<script src="${ctxPath}/scripts/codemirror/mode/groovy/groovy.js"></script>
	<script src="${ctxPath}/scripts/codemirror/addon/edit/matchbrackets.js"></script>
</head>
<body>
<div style="display:none">
			<input class="mini-textbox" id="textEditor">
			<input class="mini-combobox" id="mainFieldEditor"  textField="comment" valueField="name">
			<input class="mini-combobox" id="fieldEditor"  textField="comment" valueField="name">
			<input class="mini-combobox" id="subFieldEditor"  textField="comment" valueField="name">
	
			<input id="textboxEditor" class="mini-textbox" />
			<input id="textareaEditor" class="mini-textarea" />
			<input id="buttonEditEditor" class="mini-buttonedit" onbuttonclick="onScriptEdit"/>
			<input id="seqEditor" name="sequence" class="mini-lookup" textField="name" valueField="alias" popupWidth="auto" popup="#gridPanel" grid="#seqGrid" multiSelect="false" value="" text="" />
		</div>
<div class="mini-fit">
	<div class="mini-tabs"  style="width:100%;height:100%">
		<div title="数据映射" region="center" 
		    	showHeader="false" 
		    	showCollapseButton="false" >
			<div id="gridTab" class="mini-tabs" style="height: 100%">

			</div>
		</div>
		<div title="变量映射" region="center" 
		    	showHeader="false" 
		    	showCollapseButton="false" >
			<div class="mini-toolbar">
					<ul class="toolBtnBox">
						<li><a class="mini-button"  plain="true" onclick="addRow()">添加</a></li>
						<li><a class="mini-button btn-red"  plain="true" onclick="removeScopeVars()">删除</a></li>
						<li><a class="mini-button"  plain="true" onclick="showFormFieldDlg()">从表单中添加</a></li>
					</ul>
			  	</div>
		    	<div class="mini-fit rx-grid-fit form-outer5">
					<div 
						id="varGrid" 
						class="mini-datagrid" 
						allowAlternating="true"
	            		allowCellEdit="true" 
	            		allowCellSelect="true"
	            		oncellvalidation="onCellValidation" 
	            		idField="varId" 
	            		multiSelect="true"
	             		url="${ctxPath}/bpm/core/bpmSolVar/getBySolIdActDefIdNodeId.do?solId=${bpmSolution.solId}&actDefId=${bpmDef.actDefId}&nodeId=_PROCESS"
						idField="Id" 
						showPager="false" 
						style="width:100%;min-height:100px;"
					>
						<div property="columns">
							<div type="indexcolumn" width="30"></div>
							<div type="checkcolumn" width="30"></div>
							<div field="name" name="name" width="80" headerAlign="center">变量名
								<input property="editor" class="mini-textbox" style="width:100%;" required="true"/>
							</div>
							<div field="formField" name="formField" width="80" headerAlign="center">表单字段
								<input property="editor" class="mini-textbox" style="width:100%;" required="true"/>
							</div>
							<div field="key" name="key" width="80" headerAlign="center">变量Key
								<input property="editor" class="mini-textbox" style="width:100%;" required="true"/>
							</div>
							<div field="type" name="type" width="80" headerAlign="center">类型
								<input 
									property="editor" 
									class="mini-combobox" 
									data="[{id:'String',text:'字符串'},{id:'Number',text:'数字'},{id:'Date',text:'日期'}]" 
									style="width:100%" 
									required="true"
								/>
							</div>
							<div field="value" name="value" width="80" headerAlign="center" >缺省值
								<input property="editor" class="mini-textbox" style="width:100%;"/>
							</div>
							<div field="express" name="express" width="120" headerAlign="center" >计算表达式
								<input property="editor" class="mini-textbox" style="width:100%;"/>
							</div>
							<div type="checkboxcolumn" field="isReq" name="isReq" trueValue="YES" falseValue="NO" width="60" headerAlign="center">是否必填</div>
							<div field="sn" name="sn" width="50" headerAlign="center" >序号
								<input property="editor" class="mini-spinner" style="width:100%" minValue="1" maxValue="200"/>
							</div>
						</div>
					</div>
		    	</div>
		</div>
	</div>
</div>
	<div class="mini-toolbar" style="text-align: center;padding:5px;">
		<a class="mini-button"  onclick="onOk()">确定</a>
		&nbsp;
		<a class="mini-button btn-red"  onclick="CloseWindow()">关闭</a>
		
	</div>
	<script type="text/javascript">
	mini.parse();
	
	var boDefId="${param.boDefId}";
	var entName="${param.boName}";
	var isMain="${param.isMain}";
	var action="${param.action}";
	
	var gridTab=mini.get('gridTab');
	var varGrid=mini.get('varGrid');
	var seqGrid=mini.get('seqGrid');
	
	$(function(){
		loadBoAttrs("mainFieldEditor",boDefId,"_main",false,true);
		loadBoAttrs("fieldEditor",boDefId,entName,false,true);
	});
	
	function addRow(){				
		varGrid.addRow({});
	}
	
	function removeScopeVars(){
		
		var ids=[];
		var selRows=varGrid.getSelecteds();
		for(var i=0;i<selRows.length;i++){
			if(selRows[i].varId){
				ids.push(selRows[i].varId);
			}
		}
		varGrid.removeRows(selRows);
	}
	
	function showFormFieldDlg(){
		var nodeId='_PROCESS';
		openFieldDialog({
			nodeId:nodeId,
			actDefId:'${param.actDefId}',
			solId:'${param.solId}',
			callback:function(fields){
				var rowCounts=varGrid.getTotalCount();
				for(var i=0;i<fields.length;i++){
			 	  var isFound=false;
				  for(var j=0;j<rowCounts.length;j++){
					var row=varGrid.getRow(j);
					if(row.key==fields[i].fieldName){
				        isFound=true;
						break;
				    }
				  }
				  if(!isFound){
					  varGrid.addRow(fields[i]);
				  }
				}
			}
		})
	}
	
	function onSearchClick(e) {
		var keyText = mini.get("keyText");
		seqGrid.load({
            key: keyText.value
        });
    }
    function onCloseClick(e) {
        var sequence = mini.get("seqEditor");
        sequence.hidePopup();
    }
    function onClearClick(e) {
        var sequence = mini.get("seqEditor");
        sequence.deselectAll();
        seqGrid.load();
    }
	
	
	function onOk(){
		var result=getResult();
		
		if(!result.success){
			alert(result.msg);
			return;
		}
		CloseWindow('ok');
	}

	/**{
		dsName:"",
		opDescp:"",
		setting:[{
		condition:"",
		filterSql:"",
		operator:"",
		primaryKey:"",
		//字段映射
		fieldMapping:[]
		}]	
	}
	*/
	function getValue(){
		var result=getResult();
		return result;
	}
	
	
	/**
	[{
		condition:"",
		filterSql:"",
		operator:"",
		primaryKey:"",
		//字段映射
		gridData:[]
	}]
	*/
	function getResult(){
		var ary=$(".table-detail");
		var aryRtn=[];
		var result={success:true,data:{},msg:""};
		var subList=[];
		ary.each(function(i){
			var id=$(this).attr("id");	
			var tableName=$(this).attr("table");	
			var form=new mini.Form("#" +id );
			var data=form.getData();
			var grid=getDataGrid(this);
			var gridData=grid.getData();
			//获取子表数据。
			var rtnGrid=getGridData(gridData);
			if(!rtnGrid.success){
				result.success=false;
				result.msg=rtnGrid.msg;
				return false;
			}
			data.gridData=rtnGrid.data;
			data.tableName=tableName;
			subList.push(data);
		});
		result.data.subList=subList;
		result.data.mainList=results;
		result.varData=varGrid.getData();
		return result;
	}
	
	
	function getGridData(data,action){
		var result={success:true,data:[],msg:""};
		for(var i=0;i<data.length;i++){
			var row=data[i];
			var mapType=row.mapType;
			var fieldObj=fieldEditorMap[mapType];
			var mapValue=row.mapValue;
			//数据验证
			/* if(!row.isNull){
				if( !row.mapType || (fieldObj.hasValue && !mapValue) ){
					result.success=false;
					result.msg="必填必须设置!";
					break;	
				}
			} */
			//选择了editor必须填写。
			if(fieldObj && fieldObj.hasValue && !mapValue){
				result.success=false;
				result.msg="映射类型必须填值!";
				break;
			}
		}
		result.data=data;
		
		return result;
	}
	
	/**
	{
		dsName:"",
		opDescp:"",
		setting:[{
		condition:"",
		filterSql:"",
		operator:"",
		primaryKey:"",
		//字段映射
		gridData:[]
		}]	
	}*/
	var results;
	function setDataConf(result){
		var data = result.data;
		if(data.subList){
			results = data.mainList;
			results.splice(0,1);
			for(var i=0;i<data.subList.length;i++){
				var item=data.subList[i];
				item.results=results;
				addTableTab(item);
			}
		}
		if(result.varData){
			varGrid.setData(result.varData);
		}
	}
	
	function openFilterSql(e){
		var btn=e.sender;
		var url=__rootPath+"/bpm/core/bpmNodeSet/filterSql.do?boDefId="+btn.boDefId +"&entName="+btn.entName +"&tableName=" +btn.tableName;
		mini.open({
			url : url,
			title : "设置过滤条件",
			width : 750,
			height : 420,
			onload:function(){
				var win=this.getIFrameEl().contentWindow;
				var obj= getCtlByByName(btn,"filterSql");
				win.setData(obj.getValue());
			},
			ondestroy : function(action) {
				if(action != "ok") return;
				var iframe = this.getIFrameEl();
				var filterSql = iframe.contentWindow.getCondition();
				var ctl=getCtlByByName(btn,"filterSql");
				if(ctl){
					ctl.setValue(filterSql);
				}
			}
		});
	}
	
	
	function onScriptEdit(e){
		var row=curGrid.getSelected();
		curGrid.cancelEdit();
		var btn=e.sender;
		var url=__rootPath+"/bpm/form/bpmTableFormula/setFieldMap.do?fieldName="+row.fieldName +"&boDefId=${param.boDefId}&entName=${param.boName}&isMain=${param.isMain}";
		mini.open({
			url : url,
			title : "设置字段映射",
			width : 750,
			height : 420,
			onload:function(){
				var win=this.getIFrameEl().contentWindow;
				var val=row.mapValue;
				win.setData(val);
			},
			ondestroy : function(action) {
				if(action != "ok") return;
				var iframe = this.getIFrameEl();
				var rtn = iframe.contentWindow.getData();
				var obj={"mapValue":rtn};
				curGrid.updateRow(row,obj);
			}
		});
		
	}
	var curGrid,curOperator;
	
	function mappingGridBeginEdit(e){
		curGrid=e.sender;
		curOperator=getCtlByByName(curGrid,"operator").getValue();
	}
	
	function userSubTable(e){
		var btn = e.sender;
		var filterSql = mini.getByName("filterSql_"+btn.id.split("_")[1]);
		for(var i=0;i<btn.data.length;i++){
			var data = btn.data[i];
			if(data.id==btn.getValue()){
				filterSql.boDefId=data.boDefId;
				break;
			}
		}
		filterSql.entName=btn.getText();
		loadBoAttrs("subFieldEditor",filterSql.boDefId,filterSql.entName,false,true);
	}
	
	
	</script>
	
	<script id="formulaSettingTemplate"  type="text/html">
		<table id="mapping_<#=tableName#>_<#=num#>" table="<#=tableName#>" class="table-detail" style="height:650px" cellspacing="0" cellpadding="0">
			<tr>
				<td>选择子表</td>
				<td>
					<input name="relationType" class="mini-hidden" value="<#=relationType#>" />
					<input id="userSubTable_<#=num#>" name="userSubTable" class="mini-combobox" emptyText="请选择..." onvaluechanged="userSubTable"
						showNullItem="true" valueField="id" textField="name" value="<#=userSubTable#>"/>
				</td>
			</tr>
			<tr style="display:none;">
				<td>过滤条件</td>
				<td>
					<div name="filterSql" class="mini-textbox" style="width:80%" value="<#=filterSql#>" ></div>
					<a style="margin-left:6px;" name="filterSql_<#=num#>" class="mini-button"  onclick="openFilterSql" data-options="{tableName:'<#=tableName#>'}">设计</a>
				</td>
			</tr>
			<tr style="height:100%;">
				<td>目标表映射</td>
				<td class="mappingContainer">
					<div class="mini-fit">
						<div data-options="{tableName:'<#=tableName#>'}" class="mini-datagrid" style="width:100%;height:100%;" 
    				 		allowResize="true" showPager="false" allowCellSelect="true" allowCellEdit="true"
							allowAlternating="true" allowCellValid="true" oncellvalidation="onCellValidation">
    						<div property="columns">
        						<div type="indexcolumn" ></div>
        						<div field="fieldName" width="120" headerAlign="center" >字段</div>
								<div field="comment" width="120" headerAlign="center" >备注</div>
        						<div field="columnType" width="80" renderer="dataRender" headerAlign="center"  >数据类型</div>                            
    	    					<div field="isNull" width="60"  align="center" headerAlign="center" renderer="emptyRender">是否可空</div>
	        					<div field="mapType" displayField='mapTypeName' align="right" width="80" >值来源
									<input property="editor" class="mini-combobox" valueField='mapType' textField='mapTypeName' data="fieldEditors"/>      
								</div>                                
        						<div field="mapValue" name="mapValue" width="120" >值</div>
    						</div>
						</div>
					</div>   
				</td>
			</tr>
		</table>
	</script>
	
	<script src="${ctxPath}/scripts/flow/tableformula/bpmConfig.js"></script>
</body>
</html>