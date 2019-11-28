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
	<style>
		.mini-tabs-bodys{
			padding: 0;
			border: 0;
		}
	</style>
</head>
<body>
<div class="fitTop"></div>
<div class="mini-fit">
<div class="form-container">
	<div class="form-toolBox" style="background: white;">
		<span>回写数据至数据源</span><input id="dsName" name="dsName" class="mini-buttonedit" onbuttonclick="onSelDatasource" oncloseclick="_ClearButtonEdit" showClose="true" />
		<span>操作说明：</span><input id="opDescp" name="opDescp" class="mini-textbox"/> &nbsp;
		<a class="mini-button"   onclick="onAddTableMap(true)">添加表映射</a>

	</div>
	<div style="display:none">
		<input class="mini-textbox" id="textEditor">
		<input class="mini-combobox" id="mainFieldEditor"  textField="comment" valueField="name">
		<input class="mini-combobox" id="fieldEditor"  textField="comment" valueField="name">

			<input id="textboxEditor" class="mini-textbox" />
			<input id="textareaEditor" class="mini-textarea" />
			<input id="buttonEditEditor" class="mini-buttonedit" onbuttonclick="onScriptEdit"/>
			<input id="seqEditor" name="sequence" class="mini-lookup" textField="name" valueField="alias" popupWidth="auto" popup="#gridPanel" grid="#seqGrid" multiSelect="false" value="" text="" />

			<div id="gridPanel" class="mini-panel" title="header"   style="width: 480px; height: 280px;" showToolbar="true" showCloseButton="true" showHeader="false" bodyStyle="padding:0" borderStyle="border:0">
				<div property="toolbar" style="padding: 5px; padding-left: 8px; text-align: center;">
						<div style="float: left; padding-bottom: 2px;">
							<span>别名：</span> <input id="keyText" class="mini-textbox" style="width: 160px;" onenter="onSearchClick" /> 
							<a class="mini-button"   onclick="onSearchClick">查询</a>
	                    	<a class="mini-button" iconCls="icon-clear" onclick="onClearClick">清空</a>
	                    	<a class="mini-button btn-red"  plain="true" onclick="onCloseClick">关闭</a>
						</div>
				</div>
				<div id="seqGrid" class="mini-datagrid" style="width: 100%; height: 100%;" borderStyle="border:0" 
					showPageSize="false" showPageIndex="true" url="${ctxPath}/sys/core/sysSeqId/getInstAllSeq.do" multiSelect="false" pageSize="15">
					<div property="columns">
						<div type="checkcolumn"></div>
						<div field="name" width="100" headerAlign="center" allowSort="true">名称</div>
						<div field="alias" width="100" headerAlign="center" allowSort="true">别名</div>
					</div>
				</div>
			</div>
			
	</div>
	
	<div class="mini-fit">
		<div id="gridTab" class="mini-tabs" style="width:100%;height:100%">
		</div>
	</div>

</div>
</div>
<div class="bottom-toolbar">
	<a class="mini-button"   onclick="onOk()">确定</a>
	<a class="mini-button btn-red"  onclick="CloseWindow()">关闭</a>
</div>
	<script type="text/javascript">
	mini.parse();
	
	var boDefId="${param.boDefId}";
	var entName="${param.boName}";
	var isMain="${param.isMain}";
	var action="${param.action}";
	
	var gridTab=mini.get('gridTab');
	var seqGrid=mini.get('seqGrid');
	
	$(function(){
		loadBoAttrs("mainFieldEditor",boDefId,"_main",false,true);
		loadBoAttrs("fieldEditor",boDefId,entName,false,true);
	});
	
	
	//添加主从表映射
	function onAddTableMap(){
		var dsName = mini.get("dsName").getValue();
		openTableDialog(dsName,function(data){
			var conf={tableName:	data.tableName,gridData:"",operator:"new",condition:"",action:action,num:new Date().getTime()}
		    addTableTab(conf);
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
		var obj={};
		obj.opDescp=mini.get("opDescp").getValue();
		obj.dsName=mini.get("dsName").getValue();
		obj.setting=result.data;
		return obj;
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
		var result={success:true,data:[],msg:""};
		ary.each(function(i){
			var id=$(this).attr("id");	
			var form=new mini.Form("#" +id );
			var data=form.getData();
			var grid=getDataGrid(this);
			var gridData=grid.getData();
			if(data.operator!='new' && !data.filterSql){
				result.success=false;
				result.msg="过滤条件必填!";
				return false;
			}
			//获取子表数据。
			var rtnGrid=getGridData(gridData,data.operator);
			if(!rtnGrid.success){
				result.success=false;
				result.msg=rtnGrid.msg;
				return false;
			}
			data.gridData=rtnGrid.data;
			result.data.push(data);
		});
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
			if(!row.isNull && action=="new"){
				if( !row.mapType || (fieldObj.hasValue && !mapValue) ){
					result.success=false;
					result.msg="必填必须设置!";
					break;	
				}
			}
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
	function setDataConf(conf){
		if(!conf) return;
		
		mini.get("dsName").setValue(conf.dsName);
		mini.get("opDescp").setValue(conf.opDescp);
		
		
		if(!conf.setting || conf.setting.length==0) return;
		for(var i=0;i<conf.setting.length;i++){
			var item=conf.setting[i];
			
			addTableTab(item);
		}
	}
	
	function openCondition(e){
		var btn=e.sender;
		var url=__rootPath+"/bpm/form/bpmTableFormula/condition.do?boDefId="+boDefId +"&entName="+entName +"&isMain="+isMain +"&action=" + action +"&tableName=" +btn.tableName;
		mini.open({
			url : url,
			title : "设置执行条件",
			width : 850,
			height : 600,
			onload:function(){
				var win=this.getIFrameEl().contentWindow;
				var obj= getCtlByByName(btn,"condition");
				win.setData(obj.getValue());
			},
			ondestroy : function(action) {
				if(action != "ok") return;
				var iframe = this.getIFrameEl();
				var condition = iframe.contentWindow.getCondition();
				var ctl=getCtlByByName(btn,"condition");
				if(ctl){
					ctl.setValue(condition);
				}
			}
		});
	}
	
	function openFilterSql(e){
		var btn=e.sender;
		var url=__rootPath+"/bpm/form/bpmTableFormula/filterSql.do?boDefId="+boDefId +"&entName="+entName +"&tableName=" +btn.tableName;
		mini.open({
			url : url,
			title : "设置过滤条件",
			width : 850,
			height : 450,
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
		var url=__rootPath+"/bpm/form/bpmTableFormula/setFieldMap.do?fieldName="+row.fieldName +"&action="+curOperator 
				+"&boDefId=${param.boDefId}&entName=${param.boName}&isMain=${param.isMain}";
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
	
	
	</script>
	
	<script id="formulaSettingTemplate"  type="text/html">
		<table id="mapping_<#=tableName#>_<#=num#>" class="table-detail" style="height:100%" cellspacing="0" cellpadding="0">
			<tr>
				<td>执行条件</td>
				<td>
					<textarea name="condition" class="mini-textarea" emptyText="请输入执行条件" style="width:80%"><#=condition#></textarea>
					<div name="tableName" class="mini-hidden" value="<#=tableName#>" ></div>
					<a style="margin-left:6px;" class="mini-button" onclick="openCondition" data-options="{tableName:'<#=tableName#>'}">设计</a>
				</td>
			</tr>
			<tr>
				<td>操作类型</td>
				<td>
					<div id="operator" name="operator" class="mini-radiobuttonlist"   textField="value" valueField="id" value="<#=operator#>"
					    data="[{id:'new',value:'新增'},{id:'upd',value:'更新'},{id:'del',value:'删除'}]" 
						onvaluechanged="changeOperator" >
					</div>
				</td>
			</tr>
			
			<tr class="filterSql" <#if(operator=="new"){#> style="display:none" <#}#> >
				<td>过滤语句</td>
				<td>
					<div name="filterSql" class="mini-textbox" style="width:80%" value="<#=filterSql#>" ></div>
					<a style="margin-left:6px;" class="mini-button"  onclick="openFilterSql" data-options="{tableName:'<#=tableName#>'}">设计</a>
				</td>
			</tr>
			
		
			<tr style="height:100%">
				<td>目标表映射</td>
				<td class="mappingContainer">
					<div class="mini-fit">
						<div data-options="{tableName:'<#=tableName#>'}" class="mini-datagrid" style="width:100%;height:100%;" 
    				 		allowResize="true" showPager="false" allowCellSelect="true" allowCellEdit="true"
							allowAlternating="true" allowCellValid="true" oncellvalidation="onCellValidation" oncellclick="mappingGridBeginEdit">
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
	
	<script src="${ctxPath}/scripts/flow/tableformula/tableformula.js"></script>
</body>
</html>