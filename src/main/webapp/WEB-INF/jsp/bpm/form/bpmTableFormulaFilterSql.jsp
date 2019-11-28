<%-- 
    Document   : [表间公式]编辑页
    Created on : 2018-08-07 09:06:53
    Author     : mansan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>[表间公式]过滤条件配置</title>
<%@include file="/commons/edit.jsp"%>
<style type="text/css">
fieldset{height: 100%;border: 1px solid silver;}
fieldset legend{font-weight: bold;}

div.operatorContainer{
	padding: 5px;
	text-align: left;
}

div.operatorContainer > div {
    border-radius: 5px;
    /*border:1px solid silver;*/
    display:inline-block;
    background: #8bb8e6;
    padding: 2px 6px;
    line-height:32px;
    text-align:center;
    margin:4px;
    min-width: 32px;
    font-size:16px;
 	color: #fff;
    height: 32px; 
    cursor: pointer;
}

div.operatorContainer > div:hover{
	background: #66b1ff;
}
	.conditionBox{
		padding:  6px;
		box-sizing: border-box;
	}
	.divBox{
		border: 1px solid #ddd;
		margin-top: 6px;
	}
	header{
		padding: 6px;
		font-size: 16px;
		border-bottom: 1px solid #ddd;
		background: #ecf5ff;
	}
textarea{
	border-color: #ddd;
}
</style>
</head>
<body>
	<div class="mini-fit" style="background: #fff">
		<div class="conditionBox">
			<div class="divBox" style="margin-top: 0">
				<header>字段条件</header>
				<p style="padding: 6px 0px 6px 4px;"><span>条件字段：</span>
					<input id="comboTableField" name="field" textField="comment" valueField="fieldName" class="mini-combobox"  />
					<span>值：</span>
					<input id="comboValueField" name="valueField" textField="comment" valueField="name" class="mini-combobox"  />
					<a class="mini-button"  onclick="onAdd">添加</a>
				</p>
			</div>
			<div  class="divBox">
				<header>运算符</header>
				<div class="operatorContainer">
					<div operator="AND">AND</div>
					<div operator="OR">OR</div>
					<div operator="()">( )</div>
				</div>
			</div>

		</div>
		<div class="mini-fit">
			<div style="padding: 2px 6px 6px;height: 100%;box-sizing: border-box" >
				<header style="border: 1px solid #ddd;border-bottom: 0;">过滤条件</header>
				<div class="mini-fit" >
					<textarea id="filterSql" style="width:100%;height:94%;box-sizing: border-box;"></textarea>
				</div>
			</div>
		</div>

	</div>
	<div class="bottom-toolbar">
		<a class="mini-button"     onclick="onOk()">确定</a>
		<a class="mini-button btn-red"    onclick="onCancel()">取消</a>
	</div>
	<%--<div id="layout1" class="mini-layout" style="width:100%;height:100%;">
		 <div title="业务视图列表" region="center" showHeader="false" showCollapseButton="false">
		 	<table style="width:100%;">
				<tr style="height:150px;">
					<td style="width: 70%;">
						<fieldset style="height:140px;">
							<legend>字段条件</legend>
							<table class="table-detail">
								<tr>
									<th>条件字段：</th>
									<td><input id="comboTableField" name="field" textField="comment" valueField="fieldName"
										class="mini-combobox"  />  </td>
								</tr>
							
								<tr>
									<th>值:</th>
									<td><input id="comboValueField" name="valueField" textField="comment" valueField="name"
										class="mini-combobox"  />
										<a class="mini-button"     onclick="onAdd">添加</a>
									</td>
								</tr>
								
							</table>
							
						</fieldset>
					</td>
					
					<td style="width: 30%;">
						<fieldset style="height:140px;">
							<legend>运算符</legend>
							<div class="operatorContainer">
			    				<div operator="AND">AND</div>
				    			<div operator="OR">OR</div>
				    			<div operator="()">()</div>
			    			</div>
						</fieldset>
					</td>
					
				</tr>
				<tr>
					<td colspan="2">
						<fieldset>
							<legend>过滤条件</legend>
							<textarea id="filterSql" style="width:100%;height:100px"></textarea>
						</fieldset>
						
					</td>
				</tr>
			</table>
		 </div>
	</div>--%>
	
	<script type="text/javascript">
	mini.parse();
	
	
	$(function(){
		handOperator("filterSql");
		loadTableFields("comboTableField","${param.tableName}","")
		
		loadBoAttrs("comboValueField","${param.boDefId}","${param.entName}",true,true);
	});
	
	
	function onAdd(e){
		var srcObj=mini.get("comboTableField");
		var targetField=mini.get("comboValueField").getValue();
		var srcField=srcObj.getValue();
		var ary=srcObj.getData();
		var isVarchar=true;
		var content=srcField +"=";
		for(var i=0;i<ary.length;i++){
			var item=ary[i];
			if(item.fieldName==srcField) continue;
			var cur="$"+"{cur.";
			content+=(item.columnType=="varchar")?"'"+cur+targetField+"}'":cur+targetField+"}";
			break;
		}
		insert(content,"filterSql");
	}
	
	function treeNodeClick(e){
		var node=e.node;
		var type=node.type;
		var isField=node.isField;
		var content="";
		if(isField){
			content=node.name;
		}
		insert(content,"filterSql");
	}
	
	
	
	function changeFields(e){
		insert(e.value,"filterSql")
	}
	
	
	
	function setData(val) {
		$("#filterSql").val(val);
	}

	/**
	*读取条件。
	*/
	function getCondition(){
		return $("#filterSql").val();
	}
	
	function onOk(){
		CloseWindow("ok");
	}
	</script>
	<script src="${ctxPath}/scripts/flow/tableformula/tableformula.js"></script>
</body>
</html>